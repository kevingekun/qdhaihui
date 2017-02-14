<?php
/**
 * 订单管理控制器
 * User: gaorenhua
 * Date: 2015/10/21 17:09
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;
use Common\Model\MallModel;

class LogisticsController extends AdminController
{
    /**
     * 物流信息列表
     */
    public function index()
    {
        $mailno_orderno = I('get.mailno_orderno');
        $map_order['o.order_status'] = array('IN', array(
            MallModel::ORDER_STATUS_WAIT_DELIVER,
            MallModel::ORDER_STATUS_WAIT_RECEIVE,
            MallModel::ORDER_STATUS_FINISH,
        ));

        if ($mailno_orderno) {
            $map_order['o.order_number|s.way_bill_no'] = array('LIKE', '%' . $mailno_orderno . '%');
        }

        $order = M('mall_order');
        $list = $order->alias('o')
            ->field('o.*,s.id as shipping_id,s.way_bill_no,s.logistics_id,s.last_route,s.created_at as logistics_create_at,s.updated_at')
            ->join('__SHIPPING_ROUTE__ AS s on o.order_number=s.order_number', 'left')
            ->order('s.created_at DESC')
            ->where($map_order)
            ->page($this->page, $this->pageSize)
            ->select();
        $count = $order->alias('o')
            ->field('o.*,s.id as shipping_id,s.way_bill_no,s.logistics_id,s.last_route,s.created_at as logistics_create_at,s.updated_at')
            ->join('__SHIPPING_ROUTE__ as s on o.order_number=s.order_number', 'left')
            ->order('s.created_at DESC')
            ->where($map_order)
            ->count();

        $status = C('ORDER_STATUS');
        //$type = C('DELIVERY_TYPE');
        foreach ($list AS $key => $value) {
            $value['order_status_text'] = order_status($value['order_status'], true);//$status[$value['order_status']];
            $value['delivery_type_text'] = $status[$value['delivery_type']];
            $shippingAddress = getAddressDataArrayWithAddressID($value['address_id']);
            $value['address_data'] = $shippingAddress;
            $value['last_route_text'] = json_decode($value['last_route'], true);
            $cart_data_list = json_decode($value['cart_data'], true);
            $cart_data = array();
            foreach ($cart_data_list AS $key2 => $value2) {
                $cart_data[$key2] = get_good_data($value2['id']);
            }
            $value['cart_data_list'] = $cart_data;
            $list[$key] = $value;
        }

        $map = array('mailno_orderno' => $mailno_orderno);
        $map = array_filter($map);
        $page = $this->page($count, $map); // 实例化分页类 传入总记录数和每页显示的记录数

        //dump($list);die;

        $this->assign('map', $map);
        $this->assign('result', $list);
        $this->assign('page', $page); // 赋值分页输出
        $this->display();
    }

    public function del()
    {
//        $result = R ( "Api/Api/delorder", array (
//            $_GET ['id'],
//        ) );
//        $this->success ( "操作成功" );
    }

    /**
     * 手工标记发货
     * @return [type] [description]
     */
    public function manual()
    {
        $OrderID = I('post.order_id');

        $courier_list = array(
            'csn' => array('name' => '菜鸟物流', 'id' => 'CSN'),
            'sf' => array('name' => '顺丰速运', 'id' => 'SFExpress')
        );

        $courier_name = $courier_list[I('post.logistics')]['name'];
        $courier_id = $courier_list[I('post.logistics')]['id'];

        $Model_MallOrder = M("MallOrder");
        $Model_ShippingRoute = M("ShippingRoute");


        if (IS_POST) {
            $OrderData = $Model_MallOrder->find($OrderID);
            if(!$OrderData) $this->error('该订单不存在!');

            if(is_refund($OrderData['order_number'])) $this->error('该订单已在退款流程中, 不能标记发货!');

            $SaveData = array();
            $SaveData['order_number'] = $OrderData['order_number'];
            $SaveData['order_id'] = $OrderData['id'];
            $SaveData['logistics_id'] = $courier_id;
            $SaveData['created_at'] = time();
            $SaveData['ecp_body'] = json_encode($_POST);
            $SaveData['way_bill_no'] = I('post.way_bill_no');
            $Model_ShippingRoute->data($SaveData)->add();

            // 该订单状态 为 待收货  更新卖家发货时间
            $upData = array('order_status' => '3', 'delivery_time' => time());

            $Model_MallOrder->where(array('id' => $OrderData['id']))->setField($upData);
            //发送发货模板消息
            $user_info = M('user')->where(array('uid' => $OrderData['user_id']))->find();

            $lx = "both";
            $temp_arr = array(
                'msg' => 'deliver_msg',
                'wechat' => 'OPENTM200565259'
            );
            $user_arr = array(
                'msg' => $user_info['phone'],
                'wechat' => $user_info['openid']
            );
            $msg_arr = array(
                'msg' => array(
                    'data' => array(
                        'order_num' => $OrderData['order_number'],
                        'express' => $courier_name,
                        'express_num' => trim($SaveData['way_bill_no'])
                    )
                ),
                'wechat' => array(
                    'url' => U('Mall/Index/detail', array('id' => $OrderData['id']), true, true),
                    'data' => array(
                        'first' => array('value' => '尊敬的用户，您的商品已发货'),
                        'keyword1' => array('value' => $OrderData['order_number'], 'color' => '#173177'),
                        'keyword2' => array('value' => $courier_name, 'color' => '#173177'),
                        'keyword3' => array('value' => trim($SaveData['way_bill_no']), 'color' => '#173177'),
                        'remark' => array('value' => '请注意查收')
                    )
                )
            );

            addMessengerQueue($lx, $temp_arr, $user_arr, $msg_arr);
            $this->success("增加成功", U('Admin/Logistics/index'));
        } else {
            $this->assign('order_id', $OrderID);
            $this->display();
        }
    }

    /**
     * 手动标记付款
     */
    public function payComplete($id)
    {
        $Model_MallOrder = M('MallOrder');
        $rs = $Model_MallOrder->where(array('id' => intval($id)))->setField(array('pay_status' => '1', 'pay_time' => time()));
        if(false !== $rs){
            operate_log(intval($id), 'mall_order', 2);
            $this->success("操作成功");
        } else {
            $this->error("操作失败");
        }

    }

    /**
     * 设为已签收
     */
    public function signFor()
    {
        // 获取代签收的订单id
        $id = I('get.id', 0, 'intval');

        $Model_MallOrder = M("MallOrder");
        $result = $Model_MallOrder->where(array('id' => $id))->setField(array('order_status' => MallModel::ORDER_STATUS_FINISH, 'complete_time' => time()));
        if (false !== $result) {
            operate_log($id, 'mall_order', 2);
            $this->success("操作成功");
        } else {
            $this->success("操作失败");
        }
    }
}
