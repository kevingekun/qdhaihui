<?php
/**
 * 售后模块
 * User: leehwui
 * Date: 2015/10/21 17:09
 * Email: leehwui@163.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;

class WorkcardController extends AdminController
{
    public function index()
    {
        // 分页参数
        $page = intval(isset($_GET['p']) ? $_GET['p'] : 0);
        $pageSize = C('PAGE_SIZE') ?: 25;

        $map = array();
        C('TOKEN_ON', false);
        if (!empty($_GET['order_number'])) {
            $map['o.order_number'] = array('like', I('get.order_number', '', 'trim'));
        }
        if (!empty($_GET['contact_name'])) {
            $map['w.contact_name'] = array('like', I('get.contact_name', '', 'trim'));
        }
        if (!empty($_GET['from'])) {
            $from = strtotime(I('get.from'));
        }
        if (!empty($_GET['to'])) {
            $to = strtotime(I('get.to'));
        }
        if ($from && $to) {
            if ($from > $to) {
                $this->error('起始时间不能大于结束时间');
            }
            $map['w.need_time'] = array('between', array($from, $to));
        }

        $workcard = M('mall_workcard');

        $list = $workcard
            ->alias('w')
            ->field('o.id as oid, o.order_number as order_number, o.cart_data as cart_data,w.id as id, w.contact_name as contact_name,w.address as address,w.create_at as create_at,w.type as type,w.sub_type as sub_type,w.need_time as need_time,w.note as note, w.ecp_get as ecp_get, w.is_proved as is_proved, w.progress')
            ->where($map)
            ->join('hx_mall_order as o on o.id = w.order_id')
            ->order('w.id DESC')
            ->page($page . ',' . $pageSize)
            ->select();
        $count = $workcard
            ->alias('w')
            ->where($map)
            ->join('hx_mall_order as o on o.id = w.order_id')
            ->order('w.id DESC')
            ->page($page . ',' . $pageSize)
            ->count();

//        $count = $workcard->where($map)->count();


        // 循环数组 替换订单状态
        $status = C('ORDER_STATUS');
        $type = C('DELIVERY_TYPE');
        for ($i = 0; $i < count($list); $i++) {
            $list[$i]['order_status'] = $status[$list[$i]['order_status']];
            $list[$i]['delivery_type'] = $type[$list[$i]['delivery_type']];
        }

        foreach ($list AS $key => $value) {
            $cart_data_list = json_decode($value['cart_data'], true);
            $cart_data = array();
            foreach ($cart_data_list AS $key2 => $value2) {
                $cart_data[$key2] = get_good_data($value2['id']);
            }
            $value['cart_data_list'] = $cart_data;
            $list[$key] = $value;
        }
        $map = I('get.');

        $show = parent::page($count, $map, $pageSize); // 实例化分页类 传入总记录数和每页显示的记录数

        $this->assign("result", $list);
        $this->assign("page", $show); // 赋值分页输出
        $this->display();
    }

    public function prove($id)
    {
        if (empty($id)) {
            $this->error('无工单编号');
        }

        $workcard = M('mall_workcard');
        $map['id'] = array('eq', $id);

        $data['is_proved'] = 1;
        $data['progress'] =4;
        $data['proved_at'] = time();
        $res = $workcard->where($map)->save($data);
        if ($res) {

            $info = M('mall_workcard')->where(array('id' => $id))->find();
            $openid = M('user')->where(array('uid' => $info['user_id']))->getField('openid');

            $lx = "wechat";
            $temp_arr = array(
                'wechat' => 'TM00254'
            );
            $user_arr = array(
                'wechat' => $openid
            );

            $type = array('install' => '安装', 'repair' => '维修');

            $msg_arr = array(
                'wechat' => array(
                    'url' => HOME_URL . U('Mall/Ucenter/progress'),
                    'data' => array(
                        'first' => array('value' => '您好，您的售后单' . $info['order_number'] . '有新的客服回复'),
                        'HandleType' => array('value' => $type[$info['type']], 'color' => '#173177'),
                        'Status' => array('value' => '已受理', 'color' => '#173177'),
                        'RowCreateDate' => array('value' => date('Y-m-d H:i:s'), 'color' => '#173177'),
                        'LogType' => array('value' => '您的工单已受理，请等待工作人员与您取得联系', 'color' => '#173177'),
                        'remark' => array('value' => '点击“详情”查看详细处理结果')
                    )
                )
            );

            addMessengerQueue($lx, $temp_arr, $user_arr, $msg_arr);

            $this->success('已同意该工单申请', '/Admin/Workcard/index');
        } else {
            $this->error('未能改变工单状态，请联系技术人员');
        }


    }

    public function close()
    {
        $id = I('get.id', 0, 'intval');
        $map['id'] = array('eq', $id);

        $workcard = M('mall_workcard');
        $data['progress'] = 9;
        $data['updated_at'] = time();
        $data['closed_at'] = time();

        $res = $workcard->where($map)->save($data);

        if ($res) {
            $info = M('mall_workcard')->where(array('id' => $id))->find();
            $openid = M('user')->where(array('uid' => $info['user_id']))->getField('openid');

            $lx = "wechat";
            $temp_arr = array(
                'wechat' => 'TM00254'
            );
            $user_arr = array(
                'wechat' => $openid
            );

            $type = array('install' => '安装', 'repair' => '维修');

            $msg_arr = array(
                'wechat' => array(
                    'url' => HOME_URL . U('Mall/Ucenter/progress'),
                    'data' => array(
                        'first' => array('value' => '您好，您的售后单' . $info['order_number'] . '有新的客服回复'),
                        'HandleType' => array('value' => $type[$info['type']], 'color' => '#173177'),
                        'Status' => array('value' => '已受理', 'color' => '#173177'),
                        'RowCreateDate' => array('value' => date('Y-m-d H:i:s'), 'color' => '#173177'),
                        'LogType' => array('value' => '您的工单已受理受完毕,感谢您选用产品', 'color' => '#173177'),
                        'remark' => array('value' => '点击“详情”查看详细处理结果')
                    )
                )
            );

            addMessengerQueue($lx, $temp_arr, $user_arr, $msg_arr);

            $this->success('已关闭工单', '/Admin/Workcard/index');
        } else {
            $this->error('工单关闭失败，请联系技术人员');
        }
    }

    public function del($id)
    {
        if (empty($id)) {
            $this->error('无工单编号');
        }

        $workcard = M('mall_workcard');
        $map['id'] = array('eq', $id);
        operate_log($id, 'mall_workcard', 3);
        if ($workcard->where($map)->delete()) {
            $this->success('已删除工单', '/Admin/Workcard/index');
        } else {
            $this->error('未能删除工单，请联系技术人员');
        }
    }

}
