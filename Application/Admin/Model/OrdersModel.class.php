<?php
/**
 * Created by PhpStorm.
 * User: gaorenhua
 * Date: 2015/10/21 18:01
 * Email: 597170962@qq.com
 */

namespace Admin\Model;

use Think\Model\ViewModel;

class OrdersModel extends ViewModel
{
    public $viewFields = array(
        'orders' => array(
            'id' => 'order_id', 'user_id', 'order_number', 'total_price', 'pay_style', 'pay_status', 'order_status', 'create_time', 'cart_data', 'delivery_type', 'is_elec', 'is_normal', 'activity_id', 'update_time', 'pay_time', 'return_order', 'invoice', 'delivery_time',
            'note', 'sellers_note', 'complete_time', 'need_invoice', 'address_id', 'commission_status', 'commission', 'coupon_id', 'is_coupon', 'real_price', 'urge_time', 'remark','order_type','action_id',
            '_table' => 'hx_mall_order',
            '_type' => 'INNER'
        ),
        'user' => array(
            'nickname', 'realname',
            '_table' => 'hx_user',
            '_on' => 'orders.user_id = user.uid',
            '_type' => 'LEFT'
        ),
        'address' => array(
            'id', 'user_id' => 'add_uid', 'name', 'mobile', 'full_address',
            '_table' => 'hx_mall_address',
            '_on' => 'orders.address_id = address.id'
        )
    );
}
