<?php
/**
 * 商品模型
 * User: gaorenhua
 * Date: 2015/10/27 11:58
 * Email: 597170962@qq.com
 */

namespace Admin\Model;
use Common\Model\MallModel;

class GoodsModel extends MallModel
{
    // 重定义表
    protected $tableName = 'mall_good';

    /**
     * 自动验证
     */
    protected $_validate = array(
        array('menu_id','require','商品分类不能为空！'), //默认情况下用正则进行验证
        array('name','require','商品名称不能为空！'), //默认情况下用正则进行验证
        //array('price','^(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?$','商品价格不符合规范！'), //默认情况下用正则进行验证
        //array('old_price','^(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?$','商品原价不符合规范！'), //默认情况下用正则进行验证
        //array('stock','^[1-9]\d*$','商品库存不符合规范！'), //默认情况下用正则进行验证
    );

    /**
     * 自动完成
     */
    protected $_auto = array(
        array('shelves_time', 'time', 1, 'function'),
        array('create_time', 'time', 1, 'function')
    );
}