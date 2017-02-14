<?php
/**
 * 商城相关的定时程序
 * @author: yanhuaitang
 * @date: 2016/1/5 16:33
 */
namespace Crontab\Controller;

use Common\Controller\CrontabController;
use Common\Model\MallModel;

class MallController extends CrontabController
{
    /**
     * 关闭未付款的订单
     * 条件: 1. 未付款 2.不走ecp的库存, 要把库存加回来 3.参与活动的要加以区分
     * 目标: 1. 正常的商品48小时后, 自动关闭未付款的订单 2.参与活动的未付款的订单, 30分钟后自动关闭
     */
    public function closeOrder()
    {
        // 所有未付款的订单
        $orders = M('mall_order')->where(array('order_status' => MallModel::ORDER_STATUS_WAIT_PAY))->select();

        foreach ($orders as $key => $value) {
            // 不参加活动的订单 且 超过48小时未付款
            if (trim($value['activity_id']) == '' && NOW_TIME - 60 * 60 * 48 > $value['create_time']) {
                // 关闭该订单
                $res1 = M('mall_order')->where(array('id' => $value['id']))->setField('order_status', MallModel::ORDER_STATUS_CLOSE);
                if (false !== $res1) {
                    $cartData = json_decode($value['cart_data'], true);
                    foreach ($cartData as $k => $v) {
                        $goods = M('mall_good')->where(array('id' => $v['id']))->find();
                        if ($goods) {
                            // 商品不走ecp的, 需要释放回去库存
                            if ($goods['is_ecp'] == 0) {
                                $num = intval($v['num']);
                                $res2 = M('mall_good')->where(array('id' => $v['id']))->setInc('stock', $num);
                                if (false !== $res2) {
                                    echo sprintf("%s 释放商品sku_id: %s 的库存成功, 对应的订单号为: %s \n", date('Y-m-d H:i:s'), $goods['sku_id'], $value['order_number']);
                                } else {
                                    echo sprintf("%s 释放商品sku_id: %s 的库存失败, 对应的订单号为: %s \n", date('Y-m-d H:i:s'), $goods['sku_id'], $value['order_number']);
                                }
                            } else {
                                //这里ecp的库存就不释放回去了, 因为无法判断哪里的分仓
                            }
                        } else {
                            echo sprintf("%s 没有对应的商品 \n", date('Y-m-d H:i:s'));
                        }
                    }
                } else {
                    echo sprintf("%s 关闭订单失败, 订单号为: %s \n", date('Y-m-d H:i:s'), $value['order_number']);
                }
            } elseif (trim($value['activity_id']) != '' && NOW_TIME - 60 * 30 > $value['create_time']) {
                // 参加活动, 且30分钟未付款
                $res1 = M('mall_order')->where(array('id' => $value['id']))->setField('order_status', MallModel::ORDER_STATUS_CLOSE);
                $this->releaseActivityStock($value);
            }
        }
    }

    /**
     * 释放活动库存
     * @param array $order 一条订单记录
     */
    private function releaseActivityStock($order)
    {
        switch ($order['activity_id']) {
            case MallModel::ACTIVITY_TYPE_SECKILL: // 秒杀
                $actionId = $order['action_id'];
                $cartData = json_decode($order['cart_data'], true);
                $res = M('activity_seckill_action')->where(array('action_id' => $actionId))->setField('seckill_nums', $cartData[0]['num']);
                if (false !== $res) {
                    echo sprintf("%s 释放秒杀活动id: %d, 商品id: %d 的库存成功, 对应的订单号为: %s \n", date('Y-m-d H:i:s'), $order['action_id'], $cartData[0]['id'], $order['order_number']);
                } else {
                    echo sprintf("%s 释放秒杀活动id: %d, 商品id: %d 的库存失败, 对应的订单号为: %s \n", date('Y-m-d H:i:s'), $order['action_id'], $cartData[0]['id'], $order['order_number']);
                }
                break;
            case MallModel::ACTIVITY_TYPE_BOOKING: // 预售

                break;
            case MallModel::ACTIVITY_TYPE_GROUP: // 团购

                break;
            case MallModel::ACTIVITY_TYPE_SNAP: // 抢购

                break;
        }

    }

    /**
     * 提醒付款(下单30分钟后没付款的, 推送消息提示付款)
     */
    public function remindPay()
    {
        $orders = M('mall_order')->where(array('order_status' => MallModel::ORDER_STATUS_WAIT_PAY))->select();
        foreach ($orders as $key => $value) {
            $openid = get_user_field($value['user_id'], 'openid');
            $address = M('mall_address')->where(array('id' => $value['address_id']))->getField('full_address');
            $time = NOW_TIME - $value['create_time'];
            if ($time >= 60 * 30 && $time < 60 * 31) {
                $lx = "wechat";
                $temp_arr = array('wechat' => 'TM00427');
                $user_arr = array('wechat' => $openid);
                $msg_arr = array(
                    'wechat' => array(
                        'url' => U('Mall/Ucenter/orders', array(), true, true),
                        'data' => array(
                            'first' => array(
                                'value' => '您好，您的订单: '.$value['order_number'].'已经可以正式付款了',
                                'color' => '#173177'
                            ),
                            'orderProductPrice' => array(
                                'value' => convert_money($value['real_price']) . '元',
                                'color' => '#173177'
                            ),
                            'orderProductName' => array('value' => '商城在线支付', 'color' => '#173177'),
                            'orderAddress' => array('value' => $address, 'color' => '#173177'),
                            'orderName' => array('value' => $value['order_number'], 'color' => '#173177'),
                            'remark' => array('value' => '请尽快支付')
                        )
                    )
                );
                addMessengerQueue($lx, $temp_arr, $user_arr, $msg_arr);
            }
        }
    }
}