<?php
/**
 * 商品模型
 * User: gaorenhua
 * Date: 2015/10/27 11:58
 * Email: 597170962@qq.com
 */

namespace Admin\Model;
use Common\Model\MallModel;

class CouponModel extends MallModel
{
    // 重定义表
    protected $tableName = 'mall_coupon';

    /**
     * 自动验证
     */
    protected $_validate = array(
        array('coupon_name','require','优惠券名称不能为空！'), //默认情况下用正则进行验证
        array('money_cut','/^\d+$/','优惠券面值必须为正整数！'), //默认情况下用正则进行验证
        array('total_num','/^\d+$/','优惠券张数必须为正整数！'), //默认情况下用正则进行验证
        array('per_num','/^\d+$/','每人限领张数必须为正整数'), //默认情况下用正则进行验证
        //array('price','^(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?$','商品价格不符合规范！'), //默认情况下用正则进行验证
        //array('old_price','^(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?$','商品原价不符合规范！'), //默认情况下用正则进行验证
        //array('stock','^[1-9]\d*$','商品库存不符合规范！'), //默认情况下用正则进行验证
    );

}