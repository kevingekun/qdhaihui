<?php
namespace Admin\Controller;

use Common\Controller\AdminController;

/**
 * 订单管理控制器
 * User: leehwui
 * Date: 2015/10/21 17:09
 * Email: leehwui@163.com
 */
class RefundController extends AdminController
{
    public function index()
    {
        // 分页参数
        $page = $this->page;
        $pageSize = $this->pageSize;

        $map = array();
        C('TOKEN_ON', false);

        $model = new \Think\Model();
        $sql = "select status, count(id) as num from " . __PREFIX__mall_refund . " group by status";
        $status_num = $model->query($sql);

        foreach ($status_num as $item) {
            $StatusNum[$item['status']] = $item['num'];
            $StatusNum['all'] += $item['num'];
        }

        $status = I('get.s', 0, 'intval');
        $status ? $map['status'] = $status : NULL;

        $search = I('search', 0, 'intval');

        if ($search) {
            $order_number = I('post.order_number');
            if (!empty($order_number)) {
                $map['o.order_number'] = array('like', I('post.order_number', '', 'trim'));
            }
            $user_name = I('post.user_name');
            if (!empty($user_name)) {
                $map['r.user_name'] = array('like', I('post.user_name', '', 'trim'));
            }

            $post_from = I('post.from');
            $from = empty($post_from) ? 1 : strtotime(I('post.from'));
            $post_to = I('post.to');
            $to = empty($post_to) ? time() : strtotime(I('post.to'));

            if ($from && $to) {
                if ($from > $to) {
                    $this->error('起始时间不能大于结束时间');
                }
                if ($from == $to) {
                    $to += 60 * 60 * 24;
                }
                $map['r.create_at'] = array('between', array($from, $to));
            }

            $post_type = I('post.type');
            if (!empty($post_type)) {
                $map['r.type'] = I('post.type');
            }
        }

        $refund = M('mall_refund');

        $list = $refund
            ->alias('r')
            ->field('o.order_number as order_number, o.cart_data as cart_data,r.id as id,r.openid, r.user_name as user_name,r.type as type,
                    r.good_id,r.good_status as good_status,r.reason as reason,r.first_money,r.second_money,r.third_money,r.first_note,r.second_note,r.third_note,
                    r.create_at as create_at,r.status as status')
            ->where($map)
            ->join('__MALL_ORDER__ as o on o.order_number = r.order_number')
            ->order('r.create_at DESC')
            ->page($page, $pageSize)
            ->select();

        $count = $refund
            ->alias('r')
            ->where($map)
            ->join('__MALL_ORDER__ as o on o.order_number = r.order_number')
            ->order('r.create_at DESC')
            ->count();

//        $count = $refund->where($map)->count();

        // 导出excel
        if (I('get.action') == 'export') {
            $exportData = $refund
                ->alias('r')
                ->field('o.order_number as order_number, o.cart_data as cart_data,r.id as id, r.user_name as user_name,r.type as type,
                          r.good_status as good_status,r.reason as reason,r.first_note,r.second_note,r.third_note,
                          r.create_at as create_at,r.status as status')
                ->where($map)
                ->join('__MALL_ORDER__ as o on o.order_number = r.order_number')
                ->order('r.create_at DESC')
                ->select();
            foreach ($exportData as $key => $val) {
                $exportData[$key]['label_id'] = $val['id'];
                $exportData[$key]['user_id'] = $val['user_id'];
                $exportData[$key]['user_name'] = $val['user_name'];
                $exportData[$key]['mobile'] = $val['mobile'];
                $exportData[$key]['order_number'] = $val['order_number'];
                $exportData[$key]['sku_id'] = $val['sku_id'];
                $exportData[$key]['type'] = $val['type'];
                $exportData[$key]['good_status'] = $val['good_status'];
                $exportData[$key]['reason'] = $val['reason'];
                $exportData[$key]['first_at'] = $val['first_at'];
                $exportData[$key]['first_note'] = $val['first_note'];
                $exportData[$key]['first_money'] = $val['first_money'];
                $exportData[$key]['first_admin_note'] = $val['first_admin_note'];
                $exportData[$key]['second_at'] = $val['second_at'];
                $exportData[$key]['second_note'] = $val['second_note'];
                $exportData[$key]['second_money'] = $val['second_money'];
                $exportData[$key]['second_admin_note'] = $val['second_admin_note'];
                $exportData[$key]['third_at'] = $val['third_at'];
                $exportData[$key]['third_note'] = $val['third_note'];
                $exportData[$key]['third_money'] = $val['third_money'];
                $exportData[$key]['third_admin_note'] = $val['third_admin_note'];
                $exportData[$key]['step_status'] = $val['step_status'];
                $exportData[$key]['over_time'] = $val['over_time'];
                $exportData[$key]['check_username'] = $val['check_username'];
                $exportData[$key]['admin_note'] = $val['admin_note'];
                $exportData[$key]['status'] = $val['status'];
                $exportData[$key]['create_at'] = $val['create_at'];
                $exportData[$key]['check_at'] = $val['check_at'];
                $exportData[$key]['refond_num'] = $val['refond_num'];
                $exportData[$key]['updated_at'] = $val['updated_at'];
            }
            $info = array(
                'id' => 'ID',
                'user_id' => '用户ID',
                'user_name' => '用户名',
                'mobile' => '手机',
                'order_number' => '订单号',
                'sku_id' => 'SKU码',
                'type' => '分组',
                'good_status' => '商品状态',
                'reason' => '退货原因',
                'first_at' => '首次申请时间',
                'first_note' => '首次申请说明',
                'first_money' => '首次申请金额',
                'first_admin_note' => '首次客服回复',
                'second_at' => '二次申请时间',
                'second_note' => '二次申请说明',
                'second_money' => '二次申请金额',
                'second_admin_note' => '二次客服回复',
                'third_at' => '三次申请时间',
                'third_note' => '三次申请说明',
                'third_money' => '三次申请金额',
                'third_admin_note' => '三次客服回复',
                'step_status' => '步进状态',
                'over_time' => '完成时间',
                'check_username' => '注册时间',
                'admin_note' => '商家留言',
                'status' => '状态',
                'create_at' => '记录生成时间',
                'check_at' => '审核时间',
                'refond_num' => '退款数量',
                'updated_at' => '更新时间'
            );
            $this->export($exportData, $info);
        }


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

            $cart_data[0] = get_good_data($value['good_id']);
            $value['cart_data_list'] = $cart_data;
            $value['good_price'] = $cart_data[0]['price'];

            if ($value['third_money']) {
                $value['refund_amount'] = $value['third_money'];
            } elseif ($value['second_money']) {
                $value['refund_amount'] = $value['second_money'];
            } else {
                $value['refund_amount'] = $value['first_money'];
            }

            if ($value['third_note']) {
                $value['refund_reason'] = $value['third_note'];
            } elseif ($value['second_note']) {
                $value['refund_reason'] = $value['second_note'];
            } else {
                $value['refund_reason'] = $value['first_note'];
            }

            $list[$key] = $value;
        }
        $map = array();

        $show = parent::page($count, $map, $pageSize); // 实例化分页类 传入总记录数和每页显示的记录数

        $this->assign('StatusNum', $StatusNum);
        $this->assign("result", $list);
        $this->assign("page", $show); // 赋值分页输出
        $this->display();
    }

    /**
     * 退款详情
     * @param $id
     */
    public function detail($id)
    {
        if (empty($id)) $this->error('无退款申请编号');

        $refund = M('mall_refund')
            ->alias('r')
            ->field('o.order_number as order_number, o.cart_data as cart_data,r.id as id, r.user_name as user_name,r.type as type,
                           r.good_id, r.good_status as good_status,r.reason as reason,r.first_note,r.second_note,r.third_note,
                            r.create_at as create_at,r.status as status,r.first_money,r.second_money,r.third_money,r.admin_note')
            ->where(array('r.id' => $id))
            ->join('__MALL_ORDER__ as o on o.order_number = r.order_number')
            ->order('r.create_at DESC')
            ->find();

        $cart_data_list = json_decode($refund['cart_data'], true);
        $good_data = get_good_data($refund['good_id']);

        $cart_data = array();
        $order_info = array();
        foreach ($cart_data_list AS $key2 => $value2) {
            if ($value2['id'] == $refund['good_id']) {
                $cart_data[$key2] = get_good_data($value2['id']);
                foreach ($value2 as $k => $v) {
                    $cart_data[$key2][$k] = $v;
                }
            }
        }

        //dump($cart_data); exit;
        if ($refund['third_money']) {
            $refund['refund_amount'] = $refund['third_money'];
        } elseif ($refund['second_money']) {
            $refund['refund_amount'] = $refund['second_money'];
        } else {
            $refund['refund_amount'] = $refund['first_money'];
        }
        unset($refund['third_money']);
        unset($refund['second_money']);
        unset($refund['first_money']);

        if ($refund['third_note']) {
            $refund['refund_reason'] = $refund['third_note'];
        } elseif ($refund['second_note']) {
            $refund['refund_reason'] = $refund['second_note'];
        } else {
            $refund['refund_reason'] = $refund['first_note'];
        }
        unset($refund['third_note']);
        unset($refund['second_note']);
        unset($refund['first_note']);

        $this->assign('cart_data', $cart_data);
        $this->assign('refund', $refund);
        $this->display();
    }

    /**
     * 退款审核
     */
    public function prove()
    {
        if (IS_POST) {
            if (I('post.status') == 0) $this->error("请选择审核操作");
            $id = I('post.id');
            $id = trim($id, ',');
            if ($id == '') $this->error('无退款申请编号');

            $idArr = explode(',', $id);
            $data['status'] = I('post.status', 0, 'intval');
            $data['admin_note'] = I('post.admin_note');
            $data['proved_at'] = $data['status'] == 4 ? time() : 0; 

            $res = M('mall_refund')->where(array('id' => array('IN', $idArr)))->save($data);
            $openid = I('post.openid');

            if ($data['status'] == 4) {
                $msg_type = "wechat";
                $temp_arr = array('wechat' => 'TM00254');
                $user_arr = array('wechat' => $openid);
                $msg_arr = array(
                    'wechat' => array(
                        'url' => '',
                        'data' => array(
                            'first' => array('value' => '尊敬的客户'),
                            'HandleType' => array('value' => '退款申请'),
                            'Status' => array('value' => '退款申请通过'),
                            'RowCreateDate' => array('value' => date('Y-m-d H:i:s', time())),
                            'LogType' => array('value' => '卖家已同意退款'),
                            'remark' => array('value' => '请耐心等待')
                        )
                    )
                );
                addMessengerQueue($msg_type, $temp_arr, $user_arr, $msg_arr);
            } elseif ($data['status'] == 1) {
                $msg_type = "wechat";
                $temp_arr = array('wechat' => 'TM00254');
                $user_arr = array('wechat' => $openid);
                $msg_arr = array(
                    'wechat' => array(
                        'url' => '',
                        'data' => array(
                            'first' => array('value' => '尊敬的客户'),
                            'HandleType' => array('value' => '退款申请'),
                            'Status' => array('value' => '退款申请通过'),
                            'RowCreateDate' => array('value' => date('Y-m-d H:i:s', time())),
                            'LogType' => array('value' => '卖家已同意退款'),
                            'remark' => array('value' => '请耐心等待')
                        )
                    )
                );
                addMessengerQueue($msg_type, $temp_arr, $user_arr, $msg_arr);
                
            }
            if ($res !== false) {
                $this->success('操作成功', '/Admin/Refund/index');
            } else {
                $this->error('未能改变申请状态，请联系技术人员');
            }
        }
    }

    /**
     * 删除退款申请
     * @param $id 订单id
     */
    public function del($id)
    {
        if (empty($id)) {
            $this->error('无申请编号');
        }

        $refund = M('mall_refund');
        $map['id'] = array('eq', $id);

        operate_log($id, 'mall_refund', 3);
        if ($refund->where($map)->delete()) {
            $this->success('已删除退款申请', '/Admin/Refund/index');
        } else {
            $this->error('未能删除退款申请，请联系技术人员');
        }
    }

    public function confirm()
    {
        if (IS_AJAX) {
            $id = I('post.id');
            $openid = I('post.openid');
            $map['id'] = array('eq', $id);

            $action = I('post.action');

            if ($action == 'receipt') {
                $data = array('status' => 5, 'returned_at' => time());//1:买家提出申请4:卖家同意退款5:卖家收到退货9:卖家已退款
            } elseif ($action == 'refund') {
                $data = array('status' => 9, 'paid_at' => time());
            }

            $refund = M('mall_refund');

            $res = $refund->where($map)->setField($data);

            if ($res) {
                if ($data['status'] == 9) {
                    $msg_type = "wechat";
                    $temp_arr = array('wechat' => 'TM00254');
                    $user_arr = array('wechat' => $openid);
                    $msg_arr = array(
                        'wechat' => array(
                            'url' => '',
                            'data' => array(
                                'first' => array('value' => '尊敬的客户'),
                                'HandleType' => array('value' => '退款申请'),
                                'Status' => array('value' => '退款完成'),
                                'RowCreateDate' => array('value' => date('Y-m-d H:i:s', time())),
                                'LogType' => array('value' => '卖家已打款'),
                                'remark' => array('value' => '请注意查收')
                            )
                        )
                    );
                    addMessengerQueue($msg_type, $temp_arr, $user_arr, $msg_arr);
                }
                $this->ajaxReturn(array('code' => 0, 'msg' => 'Changed status'));
            } else {
                $this->ajaxReturn(array('code' => 1, 'msg' => 'Modify status failed'));
            }
            exit;
        }
        exit;
    }

}
