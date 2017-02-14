<?php
namespace Crontab\Controller;

use Common\Controller\CrontabController;

class OrderQueueController extends CrontabController
{

    public function _initialize()
    {
        parent::_initialize();

    }

    public function payRemind()
    {

        $pay_remind = S('pay_remind');
        if (!empty($pay_remind)) {
            echo "pay remind task is running";
            exit;

        }
        S('pay_remind', 'running');

        $pay_remind = C('PAY_REMIND');
        $time = time() - $pay_remind * 60;
        $where['pay_remind'] = 0;
        $where['pay_status'] = 0;
        $where['create_time'] = array('ELT', $time);

        $list = M('mall_order')->where($where)->select();

        foreach ($list as $info) {


            $openid = M('user')->where(array('uid' => $info['user_id']))->getField('openid');
            $addressid = $info['address_id'];
            $full_address = M('mall_address')->where(array('id' => $addressid))->getField('full_address');

            $lx = "wechat";
            $temp_arr = array(
                'wechat' => 'TM00427'
            );
            $user_arr = array(
                'wechat' => $openid
            );
            $msg_arr = array(
                'wechat' => array(
                    'url' => HOME_URL . U('Mall/Ucenter/orders'),
                    'data' => array(
                        'first' => array('value' => '你好，您的商品还未支付'),
                        'orderProductPrice' => array('value' => convert_money($info['real_price']) . '元', 'color' => '#173177'),
                        'orderProductName' => array('value' => '商城在线支付', 'color' => '#173177'),
                        'orderAddress' => array('value' => $full_address, 'color' => '#173177'),
                        'orderName' => array('value' => $info['order_number'], 'color' => '#173177'),
                        'remark' => array('value' => '请尽快支付')
                    )
                )
            );

            addMessengerQueue($lx, $temp_arr, $user_arr, $msg_arr);


            $id = $info['id'];

            $data['pay_remind'] = 1;
            M('mall_order')->where(array('id' => $id))->save($data);

        }
        S('pay_remind', NULL);
        exit;

    }

    public function couponRemind()
    {
        $coupon_expire_remind = S('coupon_expire_remind');
        if (!empty($coupon_expire_remind)) {
            echo "coupon expire remind task is running";
            exit;
        }
        S('coupon_expire_remind', 'running');

        //获取今日起止时间
        $coupon_expire_remind = C('COUPON_EXPIRE_REMIND');
        $remind_time = mktime(0, 0, 0, date('m'), date('d') - $coupon_expire_remind, date('Y'));
        $where['end_time'] = array('EGT', $remind_time);

        $ids = M('mall_coupon')->where($where)->getField('id', true);

        $where_coupon['coupon_id'] = array('in', $ids);
        $where_coupon['used'] = 0;
        $where_coupon['expire_remind'] = 0;

        $coupon_record = M('coupon_record')->where($where_coupon)->select();

        foreach ($coupon_record as $info) {
            $telephone = M('user')->where(array('uid' => $info['uid']))->getField('phone');
            $coupon_info = M('coupon')->where(array('id' => $info['coupon_id']))->find();

            $lx = "sms";
            $temp_arr = array(
                'msg' => 'coupon_expire',
            );
            $user_arr = array(
                'msg' => $telephone,
            );
            $msg_arr = array(
                'msg' => array(
                    'data' => array(
                        'coupon' => $coupon_info['coupon_name'],
                        'expire_time' => date('Y-m-d H:i:s', $coupon_info['end_time'])
                    )
                ),

            );
            addMessengerQueue($lx, $temp_arr, $user_arr, $msg_arr);
            $id = $info['id'];
            $data['expire_remind'] = 1;
            M('mall_coupon_record')->where(array('id' => $id))->save($data);
        }
        S('mall_coupon_record', NULL);
    }


}


