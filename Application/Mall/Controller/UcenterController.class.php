<?php
namespace Mall\Controller;

use Common\Controller\WmallController;
use Common\Model\MallModel;
use Common\Model\UserModel;
use Think\Exception;
use Think\Controller;


/**
 * 用户中心
 * @author: yanhuaitang
 * @date: 2015/11/6 11:38
 */
class UcenterController extends WmallController
{
    public function _initialize()
    {
        parent::_initialize();
    }

    /**
     * 查看物流单细节
     */
    public function showLogisticsPage()
    {
        $_order_id = I('order_id');
        $uid = session('uid');
        if (empty($_order_id)) $this->error('错误的订单号');

        $Model_Shipping_Route = M("ShippingRoute");
        $LogisticsData = $Model_Shipping_Route->where(array('order_number' => $_order_id))->find();
        $LogisticsData['routes'] = json_decode($LogisticsData['routes'], true);
        $this->assign('LogisticsData', $LogisticsData);
        $this->display();
    }

    /**
     * 个人中心首页
     */
    public function index()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();

        //待付款数量
        $waitForPayCount = M('mall_order')->where(array('user_id' => $uid, 'order_status' => MallModel::ORDER_STATUS_WAIT_PAY))->count();

        statistics(array('openid'=>session('openid'),'action'=>'ucenter'));
        $this->assign('waitForPayCount', $waitForPayCount);
        $this->assign('user', $user);
        $this->display();
    }

    /**
     * 完善个人资料
     */
    public function profile()
    {
        $uid = session('uid');
        if (IS_AJAX) {
            $realname = I('post.realname');
            $phone = I('post.phone');
            $code = I('post.code');
            if (!is_chinese($realname) && !is_english($realname)) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '请正确填写真实姓名'));
            }
            if (!is_mobile($phone)) {
                $this->ajaxReturn(array('code' => 2, 'msg' => '请正确填写手机'));
            }
            if ($code != '') {
                $ct = M('code_telephone')->where(array('telephone' => $phone, 'code' => $code, 'code_style' => 'update_profile'))->order('id DESC')->find();
                if ($ct) {
                    if (($ct['create_time'] + 60 * 5) < time()) {
                        $this->ajaxReturn(array('code' => 7, 'msg' => '短信验证码已过期'));
                    }
                } else {
                    $this->ajaxReturn(array('code' => 7, 'msg' => '验证码错误'));
                }
            } else {
                $this->ajaxReturn(array('code' => 7, 'msg' => '请填写验证码'));
            }
            $data = array(
                'uid' => $uid,
                'realname' => $realname,
                'phone' => $phone
            );
            $res = M('user')->data($data)->save();
            if ($res) {
                $this->ajaxReturn(array('code' => 0, 'msg' => '完善资料成功', 'url' => U('Mall/Ucenter/index')));
            } else {
                $this->ajaxReturn(array('code' => 1, 'msg' => '完善资料失败'));
            }

        } else {
            $user = M('user')->where('uid=' . $uid)->find();
            $this->assign('user', $user);
            $this->display();
        }
    }

    /**
     * 全部订单
     */
    public function orders()
    {
        $uid = session('uid');
        $this->pageSize = 10;
        $StatusToListDefinedArray = array(MallModel::ORDER_STATUS_WAIT_PAY, MallModel::ORDER_STATUS_CLOSE, MallModel::ORDER_STATUS_WAIT_DELIVER, MallModel::ORDER_STATUS_WAIT_RECEIVE, MallModel::ORDER_STATUS_FINISH);
        if (IS_AJAX) {
            $page = I('post.p', 0, 'intval');
            $end = true;
            $list = $this->getOrdersListWithStatus($StatusToListDefinedArray, $uid, array('page' => $page, 'size' => $this->pageSize));
            if ($list) $end = false;
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            $where = array(
                'order_status' => array('in', "'" . implode(',', $StatusToListDefinedArray) . "'"),
                'uid' => $uid
            );
            $count = M('mall_order')->where($where)->count();

            $this->assign('count', $count);
            $this->assign('pageSize', $this->pageSize);
            $this->display();
        }
    }

    /**
     * 待付款
     */
    public function waitForPay()
    {
        $uid = session('uid');
        $this->pageSize = 10;
        if (IS_AJAX) {
            $page = I('post.p', 0, 'intval');
            $end = true;
            $list = $this->getOrdersListWithStatus(MallModel::ORDER_STATUS_WAIT_PAY, $uid, array('page' => $page, 'size' => $this->pageSize));
            if ($list) $end = false;
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            $where = array(
                'order_status' => MallModel::ORDER_STATUS_WAIT_PAY,
                'uid' => $uid
            );
            $count = M('mall_order')->where($where)->count();
            //dump($count);die;
            $this->assign('count', $count);
            $this->assign('pageSize', $this->pageSize);
            $this->display();
        }
    }

    /**
     * 待收货
     */
    public function waitForReceive()
    {
        $uid = session('uid');
        $this->pageSize = 10;
        if (IS_AJAX) {
            $page = I('post.p', 0, 'intval');
            $end = true;
            $list = $this->getOrdersListWithStatus(MallModel::ORDER_STATUS_WAIT_RECEIVE, $uid, array('page' => $page, 'size' => $this->pageSize));
            if ($list) $end = false;
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            $where = array(
                'order_status' => MallModel::ORDER_STATUS_WAIT_RECEIVE,
                'uid' => $uid
            );
            $count = M('mall_order')->where($where)->count();
            $this->assign('count', $count);
            $this->assign('pageSize', $this->pageSize);
            $this->display();
        }
    }

    /**
     * 删除订单
     */
    public function delOrder()
    {
        $uid = session('uid');
        $id = I('post.id', 0, 'intval');
        $where = array(
            'user_id' => $uid,
            'id' => $id
        );
        $order = M('mall_order')->where($where)->find();

        $map = array(
            'order_number' => $order['order_number'],
        );
        M('mall_order_shop')->where($map)->delete();
        if ($order) {
            if ($order['order_status'] == MallModel::ORDER_STATUS_WAIT_PAY) {
                $order_status = MallModel::ORDER_STATUS_NO_PAY;
            } elseif ($order['order_status'] == MallModel::ORDER_STATUS_WAIT_RECEIVE
                || $order['order_status'] == MallModel::ORDER_STATUS_WAIT_DELIVER
                || $order['order_status'] == MallModel::ORDER_STATUS_FINISH
            ) {
                $order_status = MallModel::ORDER_STATUS_YET_PAY;
            } else {
                $this->ajaxReturn(array('code' => 2, 'msg' => '订单状态错误'));
            }
            $data = array(
                'id' => $id,
                'user_id' => $uid,
                'order_status' => $order_status
            );
            $res = M('mall_order')->data($data)->save();
            if ($res) {
                $this->ajaxReturn(array('code' => 0, 'msg' => '订单已删除'));
            } else {
                $this->ajaxReturn(array('code' => 3, 'msg' => '订单删除失败'));
            }
        } else {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单不存在'));
        }
    }

    /**
     * 确认收货
     */
    public function confirmReceive()
    {
        $uid = session('uid');
        $id = I('post.id', 0, 'intval');
        $where = array(
            'user_id' => $uid,
            'id' => $id,
            'order_status' => MallModel::ORDER_STATUS_WAIT_RECEIVE
        );

        $res = M('mall_order')
            ->where($where)
            ->data(array('order_status' => MallModel::ORDER_STATUS_FINISH))
            ->save();

        if ($res !== false) {
            $this->ajaxReturn(array('code' => 0, 'msg' => '操作成功'));
        } else {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单不存在'));
        }
    }

    /**
     * 催发货
     */
    public function urge()
    {
        $uid = session('uid');
        $_OrderID = I('post.id');
        $Model_MallOrder = M("MallOrder");
        $optionsWhere = array('user_id' => $uid, 'order_status' => MallModel::ORDER_STATUS_WAIT_DELIVER, 'id' => $_OrderID);
//        file_put_contents('./log/urge.log',var_export($OrderData,true)."\r\n",FILE_APPEND);
        //判断订单归属和状态
        $OrderData = $Model_MallOrder->where($optionsWhere)->find();
//file_put_contents('./log/urge.log',var_export($OrderData,true)."\r\n",FILE_APPEND);
        if ($OrderData != NULL) {
            $Model_MallOrder->where($optionsWhere)->setField('urge_time', time());
//            file_put_contents('./log/urge.log',var_export($OrderData,true)."\r\n",FILE_APPEND);
            $this->ajaxReturn(array('code' => 0, 'msg' => '提醒卖家发货成功'));
        } else {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单不存在'));
        }

    }

    /**
     * 售后
     */
    public function service()
    {
        $uid = session('uid');
        $this->pageSize = 10;
        $StatusToListDefinedArray = array(MallModel::ORDER_STATUS_WAIT_DELIVER, MallModel::ORDER_STATUS_WAIT_RECEIVE, MallModel::ORDER_STATUS_FINISH);
        if (IS_AJAX) {
            $page = I('post.p', 0, 'intval');
            $end = true;
            $list = $this->getOrdersListWithStatus(MallModel::ORDER_STATUS_FINISH, $uid, array('page' => $page, 'size' => $this->pageSize));
            if ($list) $end = false;
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            $where = array(
                'order_status' => array('in', "'" . implode(',', $StatusToListDefinedArray) . "'"),
                'uid' => $uid
            );
            $count = M('mall_order')->where($where)->count();
            $this->assign('count', $count);
            $this->assign('pageSize', $this->pageSize);
            $this->display();
        }
    }

    public function progress()
    {
        header('Content-type: text/html; charset=utf-8');
        $uid = session('uid');

        if ($uid) {
            $service_list = array();
            $refund = D('mall_refund');
            $refunds = $refund->applicationList($uid);

            if ($refunds) $service_list = array_merge($service_list, $refunds);

            $workcard = D('mall_workcard');
            $installations_and_repairations = $workcard->applicationList($uid);
            if ($installations_and_repairations) $service_list = array_merge($service_list, $installations_and_repairations);

            $create_time = array();
            foreach ($service_list as $service) {
                $create_at[] = $service['create_at'];
            }

            array_multisort($create_at, SORT_DESC, $service_list);
//            dump($service_list); exit;

            $this->assign('service_list', $service_list);
            $this->display();
        }
    }

    /**
     * 优惠券
     */
    public function coupon()
    {
        $uid = session('uid');

        $where_ids['end_time'] = array('GT', time());
        $ids1 = M('mall_coupon')->where($where_ids)->getField('id', true);

        if (!empty($ids1)) {
            $where['uid'] = $uid;
            $where['coupon_id'] = array('in', $ids1);
            $where['used'] = 0;
            $count_unuse = M('mall_coupon_record')->where($where)->count();

            $ids_unuse = M('mall_coupon_record')->where($where)->getField('coupon_id', true);
        }

        if (!empty($ids_unuse)) {
            $where_unuse['id'] = array('in', $ids_unuse);
            $list_unuse = M('mall_coupon')->where($where_unuse)->select();
        }

        $where_ids['end_time'] = array('LT', time());
        $ids = M('mall_coupon')->where($where_ids)->getField('id', true);

        if (!empty($ids)) {
            $where1['uid'] = $uid;
            $where1['coupon_id'] = array('in', $ids);
            $where1['used'] = 0;
            $count_used = M('mall_coupon_record')->where($where1)->count();
            $ids_used = M('mall_coupon_record')->where($where1)->getField('coupon_id', true);
        }

        //$where1['used'] = 1;

        if (!empty($ids_used)) {
            $where_used['id'] = array('in', $ids_used);
            $where_used['end_time'] = array('LT', time());
            $list_used = M('mall_coupon')->where($where_used)->select();
        }

        $this->assign('list_unuse', $list_unuse);
        $this->assign('list_used', $list_used);
        $this->assign('count_unuse', $count_unuse);
        $this->assign('count_used', $count_used);
        $this->display();
    }

    /**
     * 粉丝福利
     */
    public function welfare()
    {
        $coupon = M("mall_coupon");
        $where['status'] = 1;
        $where['start_time'] = array('ELT', time());
        $where['end_time'] = array('EGT', time());
        $coupon_list = $coupon->where($where)->select();

        foreach ($coupon_list as $key => $value) {
            $new_array[$key] = $value;
            $new_array[$key]['status'] = $this->getCouponStatus(session('uid'), $value['id']);
        }

        $coupon_list = $new_array;
        $this->assign('list', $coupon_list);
        $this->display();
    }

    /**
     * 优惠券是否可以再领取的状态,
     * @param $uid
     * @param $id
     * @return int 0-可再领取, 1-不可再领取
     */
    private function getCouponStatus($uid, $id)
    {
        $where['coupon_id'] = $id;
        $where['uid'] = $uid;

        $coupon = M('mall_coupon')->where(array('id'=>$id, 'status'=>1))->find();
        if(!$coupon) return 1; // 该优惠券不可用或不存在返回1

        $record = M('mall_coupon_record')->where($where)->order('used ASC')->find();
        if(!$record) return 0;// 如果没检测到领取优惠券记录, 则返回0

        if($record['used'] == 0) return 1;// 如果已领取过, 且没用过, 则返回1

        // 优惠券已经使用过了, 这时需要再判断该优惠券的可领取数量
        if($record['used'] == 1){
            $recordCount = M('mall_coupon_record')->where($where)->count();// 已领取优惠券的数量
            if(intval($coupon['per_num']) > intval($recordCount)) {
                return 0;// 优惠券可领取数量 > 领取的数量
            } else {
                return 1;
            }
        }
    }

    /**
     * 领取优惠券
     */
    public function getCoupon()
    {
        $id = $_POST['id'];
        $uid = session('uid');

        $coupon_info = M("mall_coupon")->where(array('id' => $id))->find();
        if ($coupon_info['start_time'] > time() || $coupon_info['end_time'] < time() || $coupon_info['status'] == 0) {
            $data['status'] = '0';
            $data['msg'] = '活动未开始或已结束';
            $this->ajaxReturn($data);
            exit;
        }

        $max = $coupon_info['per_num'];
        $count = M("mall_coupon_record")->where(array('coupon_id' => $id, 'uid' => $uid))->count();

        if ($count >= $max) {
            $data['status'] = '0';
            $data['msg'] = '您已经领取过该优惠券！';
            $this->ajaxReturn($data);
            exit;
        }

        $data['coupon_id'] = $id;
        $data['uid'] = $uid;
        $data['used'] = 0;
        $data['deleted'] = 0;
        $data['create_time'] = time();
        $data['update_time'] = time();
        M("mall_coupon_record")->add($data);

        $data['status'] = '1';
        $data['msg'] = '领取成功，快去购物吧';
        $this->ajaxReturn($data);
        exit;

    }

    /**
     * 收货地址管理
     */
    public function address()
    {
        $uid = session('uid');
        $referrer = I('get.referrer', '');

        if (IS_AJAX) {
            $id = I('post.id', 0, 'intval');
            $map = array(
                'id' => $id,
                'user_id' => $uid,
                'status' => MallModel::ADDRESS_STATUS_YES,
            );
            $model = M('mall_address');
            M()->startTrans();
            $res1 = $model->where($map)->data(array('default' => MallModel::ADDRESS_DEFAULT_YES, 'update_time' => time()))->save();
            if ($res1) {
                $res2 = $model->where(array('user_id' => $uid, 'id' => array('neq', $id)))->data(array('default' => MallModel::ADDRESS_DEFAULT_NO, 'update_time' => time()))->save();
            }
            if ($res1 && $res2) {
                M()->commit();
                $this->ajaxReturn(array('code' => 0, 'msg' => '成功设置默认地址', 'url' => base_decode($referrer)));
            } else {
                M()->rollback();
                $this->ajaxReturn(array('code' => 1, 'msg' => '设置默认地址失败', 'url' => base_decode($referrer)));
            }
        } else {
            $map = array(
                'user_id' => $uid,
                'status' => MallModel::ADDRESS_STATUS_YES,
            );
            $list = M('mall_address')->where($map)->order('update_time DESC')->select();

            foreach ($list as $key => $value) {
                $list[$key]['region'] = get_region_row($value['region_id']);
            }

            $this->assign('referrer', $referrer);
            $this->assign('list', $list);
            $this->display();
        }
        exit();
    }

    /**
     * 添加收货地址
     */
    public function addAddress()
    {
        $uid = session('uid');
        $referrer = I('get.referrer', '');
        if (IS_AJAX) {
            $data = I('post.');
            if (strlen($data['name']) == 0) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '请填写姓名'));
            }
            if (!is_mobile($data['mobile'])) {
                $this->ajaxReturn(array('code' => 2, 'msg' => '请正确填写手机'));
            }
            if (strlen($data['pcc']) == 0) {
                $this->ajaxReturn(array('code' => 4, 'msg' => '请选择省市'));
            }
            if (strlen($data['full_address']) == 0) {
                $this->ajaxReturn(array('code' => 5, 'msg' => '请先写详细街道地址'));
            }
            $model = M('mall_address');
            $count = $model->where('user_id=' . $uid)->count();
            $data['user_id'] = $uid;
            list($province, $city, $county) = explode(' ', $data['pcc']);
            $data['region_id'] = get_region_id($data['pcc']);
            $data['province'] = $province;
            $data['city'] = $city;
            $data['county'] = $county;
            $data['create_at'] = $data['update_time'] = time();
            if ($count == 0) {
                $data['default'] = 1;
            }
            $res = $model->add($data);
            if ($res) {
                $this->ajaxReturn(array('code' => 0, 'msg' => '添加成功', 'data' => json_encode($data)));
            } else {
                $this->ajaxReturn(array('code' => 6, 'msg' => '添加失败'));
            }
        } else {
            $this->assign('referrer', $referrer);
            $this->display();
        }
    }

    /**
     * 帮助中心
     */
    public function help($cid = 0)
    {
        $cid = intval($cid);
        $category = M('attribute')->where(array('type' => 'help_category', 'status' => 0))->select();
        $ids = array();
        $currentCategory = array();
        foreach ($category as $key => $value) {
            $ids[] = $value['id'];
            if ($cid == $value['id']) {
                $currentCategory = $value;
            }
        }
        if (!in_array($cid, $ids)) {
            $this->assign('category', $category);
            $this->display();
        } else {
            $list = M('help')->where(array('category' => $cid))->order('id ASC')->select();
            $this->assign('category', $currentCategory);
            $this->assign('list', $list);
            $this->display('helpList');
        }
    }

    /**
     * 帮助详情
     * @param $id
     * @throws Exception
     */
    public function helpDetail($id)
    {
        $id = intval($id);
        $help = M('help')->where(array('id' => $id))->find();
        if (!$help) {
            throw new Exception('找不到该条帮助');
        }
        $category = M('attribute')->where('id=' . $help['category'])->find();
        $this->assign('category', $category);
        $this->assign('help', $help);
        $this->display();
    }

    /**
     * 申请服务
     */
    public function serviceList()
    {
        $uid = session('uid');
        $order_id = I('get.order_id', 0, 'intval');
        $good_id = I('get.good_id', 0, 'intval');
        $where = array(
            'order_status' => array('IN', array(
                MallModel::ORDER_STATUS_FINISH,
                MallModel::ORDER_STATUS_WAIT_DELIVER,
                MallModel::ORDER_STATUS_WAIT_RECEIVE,
            )),
        );
        $order = get_order($order_id, $uid, $where);

        if(!$order) $this->error('该订单不符合申请售后的条件');

        $data = array();

        $refund = D('mall_refund');
        $data['refund_status'] = $refund->refundStatus($order['order_number'], $good_id);

        $workcard = D('mall_workcard');
        $data['installation_status'] = $workcard->installationStatus($order_id);
        $data['applicationUnderProcessing'] = $workcard->applicationUnderProcessing($order_id, 'repair');
        $data['order_id'] = $order_id;
        $data['good_id'] = $good_id;
        $total = I('get.total', 0, 'intval');
        $data['total'] = $total;

        $this->assign('data', $data);
        $this->assign('order_id', $order_id);
        $this->display();
    }

    /**
     * 申请上门安装
     */
    public function serviceInstall()
    {
        $uid = session('uid');
        if (IS_AJAX) {
            $post = I('post.');
            $data = array(
                'user_id' => $uid,
                'create_at' => time(),
                'type' => 'install'
            );
            if (!$post['order_id']) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '订单号不能为空'));
            }
            if (!is_date($post['need_time'])) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '上门安装日期不能为空'));
            }
            if (!in_array($post['sub_type'], array(1, 2))) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '请正确选择安装方式'));
            }
            if ($post['radio2'] == 1) {
                if ($post['address'] == '') {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '地址不能为空'));
                }
                $data['address'] = $post['address'];
            } elseif ($post['radio2'] == 0) {
                if (!is_chinese($post['address_name']) && !is_english($post['address_name'])) {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请正确填写姓名'));
                }
                if (!is_mobile($post['address_mobile'])) {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请正确填写手机'));
                }
                if ($post['address_pcc'] == '') {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请选择收货地址'));
                }
                if ($post['address_full_address'] == '') {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请填写详细地址'));
                }
                $data['address'] = $post['pcc'] . $post['address_full_address'];
            }
            if ($post['note'] == '') {
                $this->ajaxReturn(array('code' => 1, 'msg' => '请填写安装服务描述'));
            }

            $data['region_id'] = get_region_id($post['address_pcc']);
            $data['order_number'] = $post['order_number'];
            $data['order_id'] = $post['order_id'];
            $data['need_time'] = strtotime($post['need_time']);
            $data['sub_type'] = $post['sub_type'];
            $data['note'] = $post['note'];

            $res = M('mall_workcard')->add($data);
            if ($res) {
                $this->ajaxReturn(array(
                    'code' => 0,
                    'msg' => '提交成功',
                    'url' => U('Mall/Ucenter/index')
                ));
            } else {
                $this->ajaxReturn(array('code' => 1, 'msg' => '提交失败'));
            }

            $this->ajaxReturn(array('code' => 0, 'msg' => '', 'data' => $post));
        } else {
            $order_id = I('get.order_id', 0, 'intval');
            $where = array(
                'order_status' => array('IN', array(
                    MallModel::ORDER_STATUS_FINISH,
                    MallModel::ORDER_STATUS_WAIT_DELIVER,
                    MallModel::ORDER_STATUS_WAIT_RECEIVE,
                )),
            );
            $order = get_order($order_id, $uid, $where);
            if (!$order) $this->error('该订单不能申请上门安装');

            $service_application = D('mall_workcard');
            if ($service_application->hasAppliedService($order_id, 'install')) {
                $this->error('已经申请过安装服务');
            }
            $address = get_address($uid);
            $this->assign('address', $address);
            $this->assign('order', $order);
            $this->display();
        }
    }

    /**
     * 上门维修
     */
    public function serviceRepair()
    {
        $uid = session('uid');

        if (IS_AJAX) {
            $post = I('post.');
            $data = array(
                'user_id' => $uid,
                'create_at' => time(),
                'type' => 'repair'
            );
            if (!$post['order_id']) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '订单号不能为空'));
            }
            if (!is_date($post['need_time'])) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '上门安装日期不能为空'));
            }

            if ($post['radio2'] == 1) {
                if ($post['address'] == '') {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '地址不能为空'));
                }
                $data['address'] = $post['address'];
            } elseif ($post['radio2'] == 0) {
                if (!is_chinese($post['address_name']) && !is_english($post['address_name'])) {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请正确填写姓名'));
                }
                if (!is_mobile($post['address_mobile'])) {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请正确填写手机'));
                }
                if ($post['address_pcc'] == '') {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请选择收货地址'));
                }
                if ($post['address_full_address'] == '') {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请填写详细地址'));
                }
                $data['address'] = $post['address_pcc'] . $post['address_full_address'];
            }
            if ($post['note'] == '') {
                $this->ajaxReturn(array('code' => 1, 'msg' => '请填写维修服务描述'));
            }

            $data['region_id'] = get_region_id($post['address_pcc']);
            $data['order_number'] = $post['order_number'];
            $data['order_id'] = $post['order_id'];
            $data['need_time'] = strtotime($post['need_time']);
            $data['note'] = $post['note'];

            $res = M('mall_workcard')->add($data);
            if ($res) {
                $this->ajaxReturn(array(
                    'code' => 0,
                    'msg' => '提交成功',
                    'url' => U('Mall/Ucenter/progress'),
                ));
            } else {
                $this->ajaxReturn(array('code' => 1, 'msg' => '提交失败'));
            }
            $this->ajaxReturn(array('code' => 0, 'msg' => '', 'data' => $post));
        } else {
            $id = I('get.order_id', 0, 'intval');

            $order = get_order($id, $uid, array('order_status' => MallModel::ORDER_STATUS_FINISH));
            if (!$order) $this->error('该订单暂时无法申请维修服务');
            $address = get_address($uid);

            $this->assign('address', $address);
            $this->assign('order', $order);
            $this->display();
        }
    }

    /**
     * 申请退款
     */
    public function serviceReturn()
    {
        $uid = session('uid');
        $good_id = I('get.good_id', '', 'intval');

        if (IS_AJAX) {
            $post = I('post.');

            $refund = D('mall_refund');
            $times_applied = $refund->checkSequence($post['order_number'], $post['good_id']);

            if ($times_applied >= 3) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '申请次数已超过三次，请联系客服'));
            }

            if ($post['type'] == 1) {
                if ($post['good_status'] == 0) {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '请选择货物状态'));
                }
            }

            if ($post['reason'] == 0) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '请选择退款原因'));
            }

            if (!is_number($post['money_amount']) && !is_decimal($post['money_amount'])) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '请输入正确的退款金额'));
            }

            if (!$post['note']) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '退款说明不能为空'));
            }

            $order = M('mall_order')->where(array('order_number'=>$post['order_number']))->find();
            if(!$order) $this->ajaxReturn(array('code' => 1, 'msg' => '订单不存在'));

            // 如果填写的退款金额>订单金额, 则不通过
//            if(convert_money($post['money_amount'], '*') > intval($order['total_price'])){
//                $this->ajaxReturn(array('code' => 1, 'msg' => '退款金额不能大于' . convert_money($order['total_price'])));
//            }
            
            $max_refund = convert_money($order['real_price']);;
            if($post['money_amount'] > $max_refund){
                $this->ajaxReturn(array('code' => 1, 'msg' => '退款金额不能大于' . $max_refund));
            }

            $post['openid'] = get_user_field($uid, 'openid');
            $post['status'] = 1;
            switch ($times_applied) {
                case 0:
                    $post['create_at'] = $post['first_at'] = time();
                    $post['first_note'] = $post['note'];
                    unset($post['note']);
                    $post['first_money'] = convert_money($post['money_amount'], '*');
                    unset($post['money_amount']);
                    $post['step_status'] = 'first';
                    $result = $refund->add($post);
                    break;
                case 1:
                    $post['second_at'] = time();
                    $post['second_note'] = $post['note'];
                    unset($post['note']);
                    $post['second_money'] = convert_money($post['money_amount'], '*');
                    unset($post['money_amount']);
                    $post['step_status'] = 'second';
                    $result = $refund->where(array('order_number' => array('like', $post['order_number'])))->save($post);
                    break;
                case 2:
                    $post['third_at'] = time();
                    $post['third_note'] = $post['note'];
                    unset($post['note']);
                    $post['third_money'] = convert_money($post['money_amount'], '*');
                    unset($post['money_amount']);
                    $post['step_status'] = 'third';
                    $result = $refund->where(array('order_number' => array('like', $post['order_number'])))->save($post);
                    break;
            }

            if ($result) {
                $this->ajaxReturn(array(
                    'code' => 0,
                    'msg' => '提交成功',
                    'url' => U('Mall/Ucenter/progress', '', true, true),
                ));
            } else {
                $this->ajaxReturn(array('code' => 1, 'msg' => '提交失败'));
            }
        }

        $order_id = I('get.order_id', 0, 'intval');
        //$order = get_order($id, $uid, array('order_status' => MallModel::ORDER_STATUS_FINISH));
        $order = get_order($order_id, $uid);
        $good_data = $this->getGoodData($good_id);
        $good_data['id'] = $good_id;
        $max_refund = convert_money($order['real_price']);

        $user = M('user');
        $user_info = $user->field('uid, phone, realname')->where('uid=' . $uid)->find();

        $this->assign('good_data', $good_data);
        $this->assign('max_refund', $max_refund);
        $this->assign('order', $order);
        $this->assign('user', $user_info);
        $this->display(); 
    }

    public function detailAddress()
    {
        $referrer = I('get.referrer', '');
        if (IS_POST) {
            session('hx_mall_good_mail_to', I('post.pcc'));
            //$this->redirect();
            redirect(base_decode($referrer));
        }

        $id = I('get.id', '', 'intval');
        $this->assign('referrer', $referrer);
        $this->assign('id', $id);
        $this->display();
    }

    public function deleteAddress()
    {
        $id = I('get.id', '', 'intval');
        $referrer = I('get.referrer', '');
        $map['id'] = array('eq', $id);

        $address = M('mall_address');

        if (!$address->where($map)->delete()) {
            $this->error('删除失败，请联系技术人员');
        }

        $this->redirect('Mall/Ucenter/address', array('referrer' => $referrer));
    }


    public function getRule()
    {
        $id = $_POST['id'];
        $result = M('mall_coupon')->where(array('id' => $id))->find();
        echo htmlspecialchars_decode($result['use_rule']);
    }

    /**
     * 订单详情
     */
    public function orderDetail()
    {
        $order_id = I('get.order_id', '', 'intval');
        $good_id = I('get.good_id', '', 'intval');

        if (!$order_id) $this->error('未能获取订单id');

        $map_order['id'] = array('eq', $order_id);

        $order = M('mall_order');
        $res_order = $order->where($map_order)->find();

        if (!$res_order) $this->error('未能获取订单信息');

        $goods_data = json_decode($res_order['cart_data'], true);

        foreach($goods_data as $item) {
            if($item['id'] == $good_id) {
                $good_data = $item;
            }
        }

        //$good_id = (int)$good_data[0]['id'];

        if (!$good_id) $this->error('未能获取商品id');

        $map['o.id'] = array('eq', $order_id);
        $res = $order
            ->alias('o')
            ->field('o.order_number as order_number,o.is_normal as type_invoice,o.total_price as total_price,
            o.pay_style as pay_style,o.create_time as create_time,o.cart_data as cart_data,
            o.real_price as real_price,o.invoice as invoice_status,o.yb_brand,o.yb_model,
            o.yb_category,o.yb_sn,o.yb_buydate,o.yb_price,
            u.realname as name,u.phone as phone,
            a.region_id as region_id,a.full_address as full_address,a.mobile as mobile,
            c.money_cut as money_cut,
            g.image as image,
            g.name as good_name,g.price as price,
            i.plain_title as title,i.vat_taxpaper_ident as payer_indet,i.vat_deposit_bank as bank,i.vat_bank_account as bank_account,
            s.routes as routes')
            ->join('hx_user as u on o.user_id=u.uid', 'left')
            ->join('hx_mall_address as a on a.id=o.address_id', 'left')
            ->join('hx_mall_coupon as c on c.id=o.coupon_id', 'left')
            ->join('hx_mall_good as g on g.id=' . $good_id, 'left')
            ->join('hx_mall_invoice as i on o.order_number=i.order_number', 'left')
            ->join('hx_shipping_route as s on s.order_number=o.order_number', 'left')
            ->where($map)
            ->select();

        $routes = json_decode($res[0]['routes']);
        $list = $res[0];
        $cart_datas = json_decode($list['cart_data'], true);
        foreach($cart_datas as $item) {
            if ($item['id'] == $good_id) {
                $cart_data = $item;
            }

        }

        $list['quantity'] = $cart_data['num'];
        $list['routes'] = $routes;
        $list['order_id'] = $order_id;
        $list['good_id'] = $good_id;
        $list['total'] = convert_money($cart_data['num'] * $cart_data['price']);
        

        $region_row = get_region_row($list['region_id']);

        $list['address'] = $region_row['province_name'] . $region_row['city_name'] . $region_row['district_name'] . $list['full_address'];

        $this->assign('list', $list);
        $this->display();
    }
}
