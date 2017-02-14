<?php
/**
 * Created by PhpStorm.
 * User: gaorenhua
 * Date: 2015/10/16 14:20
 * Email: 597170962@qq.com
 */

namespace Common\Model;


class MallModel extends BaseModel
{
    //订单状态 1-待付款  2-待发货  3-待收货  4-已关闭  5-未付款删除  6-已付款删除  9-交易完成
    const ORDER_STATUS_WAIT_PAY = 1; // 待付款
    const ORDER_STATUS_WAIT_DELIVER = 2; // 待发货
    const ORDER_STATUS_WAIT_RECEIVE = 3; // 待收货
    const ORDER_STATUS_CLOSE = 4; // 已关闭
    const ORDER_STATUS_NO_PAY = 5; // 未付款删除
    const ORDER_STATUS_YET_PAY = 6; // 已付款删除
    const ORDER_STATUS_FINISH = 9; // 交易完成

    const COMMISSION_STATUS_NO = 0; // 产品佣金未处理
    const COMMISSION_STATUS_YES = 1; // 产品佣金已处理


    // 收货地址管理
    const ADDRESS_STATUS_YES = 0; //正常
    const ADDRESS_STATUS_NO = 1; //弃用
    const ADDRESS_DEFAULT_YES = 1; //默认地址
    const ADDRESS_DEFAULT_NO = 0; //非默认地址

    const GOODS_STATUS_SELLING = 1;//在售
    const GOODS_STATUS_SOLDOUT = 0;//下架
    const GOODS_STATUS_DELETE = 2;//删除

    // 支付方式管理
    const PAY_STYLE_ARRIVED = 0;  // 货到付款/到店付款
    const PAY_STYLE_WECHAT = 1;   // 微信安全支付
    const PAY_STYLE_BANKCARD = 2;  // 银行卡支付
    const PAY_STYLE_ANOTHER = 3;  // 找人代付

    // 优惠券状态
    const COUPON_STATUS_NOT_START = 0; // 未投放
    const COUPON_STATUS_START = 1; // 已投放
    const COUPON_STATUS_END = 2; // 已结束

    // 活动类型管理
    const ACTIVITY_NOT = 0; // 不是活动的订单
    const ACTIVITY_TYPE_SECKILL = 1; // 秒杀
    const ACTIVITY_TYPE_GROUP = 2; // 团购
    const ACTIVITY_TYPE_SNAP = 3; // 抢购
    const ACTIVITY_TYPE_BOOKING = 4; // 预售

    // 团购活动状态
    const GROUP_STATUS_BESPOKE = 0;
    const GROUP_STATUS_SELLING = 1;
    const GROUP_STATUS_OVER = 2;

    // 预售活动状态
    const BOOKING_STATUS_BESPOKE = 0;
    const BOOKING_STATUS_SELLING = 1;
    const BOOKING_STATUS_OVER = 2;


}