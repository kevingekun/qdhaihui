<?php

/**
 * 商城相关函数
 * @author: yanhuaitang
 * @date: 2015/11/8 11:41
 */


/*
 * 获取区域id
 * @param string $pcc_str
 * @return mixed 成功返回地区id,失败返回false
 */
function get_region_id($pcc_str)
{
    $pcc_arr = explode(' ', $pcc_str);

    // 四个直辖市
    $specialCity = array('北京', '天津', '上海', '重庆');

    if (in_array($pcc_arr[0], $specialCity)) {
        $map['province_name'] = array('like', $pcc_arr[0]);
        $map['city_name'] = array('like', $pcc_arr[0] . '市');
        $map['district_name'] = array('like', $pcc_arr[1]);
    } else {
        $map['province_name'] = array('like', $pcc_arr[0]);
        $map['city_name'] = array('like', $pcc_arr[1]);
        $map['district_name'] = array('like', $pcc_arr[2]);
    }

    $result = M('ecp_base_region')->where($map)->find();
    return $result ? intval($result['region_id']) : false;
}


/**
 * 获取商品信息
 * @param int good_id
 * @return array
 */
function get_good_data($_Good_ID, $_Field = array('menu_id', 'sku_id', 'tags', 'group_id', 'name', 'description', 'price', 'image'))
{

    $_Good_ID = intval($_Good_ID);
    $Model_MallGood = M("MallGood");
    $SecureFieldListDefinedArray = $Model_MallGood->getDbFields();
    $SecureFieldResultArray = array_intersect($_Field, $SecureFieldListDefinedArray);
    $ReturnResult = $Model_MallGood->where(array('id' => $_Good_ID))->field($SecureFieldResultArray)->find();
    if ($ReturnResult['image']) {
        $ReturnResult['image'] = HOME_URL . '/uploads/' . $ReturnResult['image'];
    }
    if ($ReturnResult['price']) {
        $ReturnResult['price'] = convert_money($ReturnResult['price']);
    }

    return $ReturnResult;

}

/**
 * 订单状态
 * @param bool|false $key
 * @return array
 */
function order_status($key = false, $color = false)
{
    $data = array(
        Common\Model\MallModel::ORDER_STATUS_WAIT_PAY => '待付款',
        Common\Model\MallModel::ORDER_STATUS_WAIT_DELIVER => '待发货',
        Common\Model\MallModel::ORDER_STATUS_WAIT_RECEIVE => '待收货',
        Common\Model\MallModel::ORDER_STATUS_CLOSE => '已关闭',
        Common\Model\MallModel::ORDER_STATUS_NO_PAY => '未付款删除',
        Common\Model\MallModel::ORDER_STATUS_YET_PAY => '已付款删除',
        Common\Model\MallModel::ORDER_STATUS_FINISH => '交易完成'
    );

    if ($color === false) {
        $data = array(
            Common\Model\MallModel::ORDER_STATUS_WAIT_PAY => '<font color="#ff8c00">待付款</font>',
            Common\Model\MallModel::ORDER_STATUS_WAIT_DELIVER => '<font color="#6495ed">待发货</font>',
            Common\Model\MallModel::ORDER_STATUS_WAIT_RECEIVE => '<font color="#006400">待收货</font>',
            Common\Model\MallModel::ORDER_STATUS_CLOSE => '<font color="red">已关闭</font>',
            Common\Model\MallModel::ORDER_STATUS_NO_PAY => '<font color="#dc143c">未付款删除</font>',
            Common\Model\MallModel::ORDER_STATUS_YET_PAY => '<font color="#dc143c">已付款删除</font>',
            Common\Model\MallModel::ORDER_STATUS_FINISH => '<font color="green">交易完成</font>'
        );
    }

    if (is_numeric($key) && isset($data[$key])) {
        return $data[$key];
    }
    return $data;
}

/**
 * 根据库中缩略图字段生成商品缩略图url
 * @param $image
 * @return string
 */
function create_goods_thumb_url($image)
{
    $filePath = '/uploads/' . ltrim($image, '/');
    if (file_exists(ROOT_PATH . $filePath)) {
        $url =  '/' . ltrim(ltrim($filePath, '.'), '/');
    } else {
        $url =  '/uploads/no-exist.jpg';
    }
    return $url;
}

/**
 * 订单信息
 * @param $id 订单id
 * @param int $uid 用户id
 * @param array $where 附加的where条件
 * @return mixed
 */
function get_order($id, $uid = 0, $where = array())
{
    $map['id'] = $id;
    if ($uid) $map['user_id'] = $uid;
    $map = $where ? array_merge($where, $map) : $map;
    $order = M('mall_order')->where($map)->find();
    return $order;
}

/**
 * 返回用户的收货地址
 * @param $uid 用户id
 * @param string $type single 返回默认地址
 * @return mixed
 */
function get_address($uid, $type = 'single')
{
    if ($type == 'single') {
        $where = array(
            'user_id' => $uid,
            'default' => \Common\Model\MallModel::ADDRESS_DEFAULT_YES,
            'status' => \Common\Model\MallModel::ADDRESS_STATUS_YES
        );
        $key = md5('address_uid_' . $uid . '_single');
        $address = S($key);
        if (!$address) {
            $address = M('mall_address')->where($where)->find();
            $address ? S($key, $address, 300) : false;
        }
    } else {
        $where = array(
            'user_id' => $uid,
            'status' => \Common\Model\MallModel::ADDRESS_STATUS_YES
        );
        $key = md5('address_uid_' . $uid . '_all');
        $address = S($key);
        if (!$address) {
            $address = M('mall_address')->where($where)->select();
            $address ? S($key, $address, 300) : false;
        }
    }

    return $address;
}

/**
 * 商品无限分类
 * @param int $pid
 * @param int $level
 * @return string
 */
function get_goods_category($id = 0, $pid = 0, $level = 1)
{
    static $result;
    $data = M('mall_menu')->where(array('pid' => $pid))->select();
    $str = '--';
    if ($data) {
        foreach ($data as $key => $value) {
            $selected = $id == $value['id'] ? 'selected' : '';
            $result .= '<option value="' . $value['id'] . '" ' . $selected . ' >|' . str_repeat($str, $level) . $value['name'] . '</option>';
            get_goods_category($id, $value['id'], $level + 1);
        }
    }

    return $result;
}

/**
 * 分类名称
 * @param $id 分类id
 * @return mixed
 */
function get_category_name($id)
{
    return M('mall_menu')->where('id=' . intval($id))->getField('name');
}

/**
 * 商品状态
 * @return array
 */
function get_goods_status()
{
    return array(
        \Common\Model\MallModel::GOODS_STATUS_SOLDOUT => '下架',
        \Common\Model\MallModel::GOODS_STATUS_SELLING => '售卖',
        \Common\Model\MallModel::GOODS_STATUS_DELETE => '删除',
    );
}

/**
 * @param int $couponId 优惠券ID
 * @param array $cartData 购物车数据
 * @return array
 */
function check_coupon($couponId, array $cartData)
{
    $uid = session('uid');

    if (empty($cartData)) {
        return array('code' => 13, 'msg' => '订单中的商品信息出错, 请重新下单');
    }

    $couponRecord = M('mall_coupon_record')->where(array(
        'uid' => $uid, // 用户ID
        'coupon_id' => $couponId, // 优惠券ID
        'deleted' => 0, // 未删除
        'used' => 0, // 未使用
    ))->find();

    if (!$couponRecord) {
        return array('code' => 9, 'msg' => '该优惠券不可用');
    }

    // 优惠券信息
    $coupon = M('mall_coupon')->where(array('id' => $couponId))->find();

    // 优惠券不存在
    if (!$coupon) {
        return array('code' => 1, 'msg' => '该优惠券不存在');
    }

    // 优惠券不可用
    if ($coupon['status'] != \Common\Model\MallModel::COUPON_STATUS_START) {
        return array('code' => 2, 'msg' => '该优惠券状态为不可用');
    }

    // 优惠券开始时间 > 当前时间, 不可用
    if ($coupon['start_time'] > 0 && $coupon['start_time'] > time()) {
        return array('code' => 3, 'msg' => '该优惠券不在可用时间范围内');
    }

    // 优惠券结束时间 < 当前时间, 不可用
    if ($coupon['end_time'] > 0 && $coupon['end_time'] < time()) {
        return array('code' => 4, 'msg' => '该优惠券已过期');
    }

    // 若优惠券限制商品
    if ($coupon['sku_ids'] != '') {
        $couponSkuIds = explode(',', $coupon['sku_ids']);
        $flag = false;
        foreach ($cartData as $k => $v) {
            $goods = M('mall_good')->where(array('id' => $v['id']))->find();
            if (in_array($goods['sku_id'], $couponSkuIds) && $goods['price'] * $v['num'] > $coupon['money_cut']) { // 商品价格 > 优惠券面值
                $flag = true;
                break;
            }
        }
        if (false === $flag) {
            return array('code' => 8, 'msg' => '订单中的商品不在该优惠券限制范围', 'data' => $goods);
        }
    }

    // 若优惠券限制分类
    if ($coupon['allow_class_id'] != '') {
        $allowClassId = explode(',', $coupon['allow_class_id']);
        if ($coupon['sku_ids'] == '') {
            $flag = false;
            // 商品总分类id或具体分类id, 有一个在优惠券允许的分类列表中, 就可使用
            foreach ($cartData as $k => $v) {
                $goods = M('mall_good')->where(array('id' => $v['id']))->find();
                if (in_array($goods['menu_id'], $allowClassId) || in_array($goods['pid'], $allowClassId)) {
                    if ($goods['price'] * $v['num'] > $coupon['money_cut']) { // 商品价格 > 优惠券面值
                        $flag = true;
                        break;
                    }
                }
            }

            if (false === $flag) {
                return array('code' => 10, 'msg' => '商品所在分类不在该优惠券限制分类范围', 'data' => $goods);
            }
        }
    } else {
        // 不限制分类
        $flag = false;
        foreach ($cartData as $k => $v) {
            $goods = M('mall_good')->where(array('id' => $v['id']))->find();
            if ($goods['price'] * $v['num'] > $coupon['money_cut']) { // 商品价格 > 优惠券面值
                $flag = true;
                break;
            }
        }

        if (false === $flag) {
            return array('code' => 11, 'msg' => '该优惠券在这里不可用', 'data' => $goods);
        }
    }

    return array('code' => 0, 'msg' => '请放心使用');
}

/**
 * 根据sku_id,仓库代码 获取分仓库存信息
 * @param $sku_id 商品sku码
 * @param $warehouse_code 仓库代码
 * @return mixed 对应仓库信息
 */
function getStockRowArray($sku_id, $warehouse_code)
{
    $optionsWhere = array();
    $optionsWhere['sku_id'] = $sku_id;
    $optionsWhere['warehouse_code'] = $warehouse_code;
    $ReturnArray = M("EcpInventory")->where($optionsWhere)->find();

    return $ReturnArray;
}

/**
 * 判断订单是否在退款流程中
 * @param string $orderNumber
 * @return bool 在退款中-true, 不在-false
 */
function is_refund($orderNumber)
{
    $refundOrder = M('mall_refund')->where(array(
        'order_number' => $orderNumber,
        'status' => array('IN', array(1, 4, 5, 9))
    ))->find();
    return $refundOrder ? true : false;
}

/**
 * 通过where条件可获得优惠券相关的记录的数量
 * @param array $where 条件
 * @return int 数量
 */
function get_coupon_record_num($where = array())
{
    $count = M('mall_coupon_record')->where($where)->count();
    return intval($count);
}

/**
 * 根据条件获取订单总额
 * @param array $where 条件
 * @return float 订单总额
 */
function get_order_total_amount($where=array())
{
    $data = M('mall_order')
        ->field('sum(real_price) AS amount')
        ->where($where)
        ->find();
    return $data ? convert_money($data['amount']) : 0;
}

/**
 * 生成佣金, 根据设定的比例
 * @param $amount 订单金额
 * @return int 佣金金额
 */
function create_commission($amount)
{
    $uid = intval(session('uid'));
    $amount = floatval($amount);
    $user = M('user')->find($uid);
    if(!$user) return 0;

    $commission_ratio = floatval($user['commission_ratio']);
    if($commission_ratio > 0){
        $commission = intval($amount * $commission_ratio / 100);
    } else {
        $commission_top = floatval(M('attribute')->where(array('type'=>'commission_top'))->getField('value'));
        $commission_second = floatval(M('attribute')->where(array('type'=>'commission_second'))->getField('value'));

        if($user['is_top'] == 1){
            $commission = intval($amount * $commission_ratio / 100);
        } else {
            $commission = intval($amount * $commission_ratio / 100);
        }
    }
    return $commission;
}

/**
 * 开启关闭商城
 */
function switch_mall()
{
    $closeMall = M('attribute')->where(array('type' => 'close_mall'))->getField('value');
    if ($closeMall == 1) {
        header("Content-type: text/html; charset=utf-8");
        echo '由于系统升级，商城暂停营业一天，明天重新开启';
        die;
    }
}

/**
 * 开启关闭支付功能
 */
function switch_pay()
{
    $closePay = M('attribute')->where(array('type' => 'close_pay'))->getField('value');
    if ($closePay == 1) {
        header('Content-Type:application/json; charset=utf-8');
        $data = json_encode(array('code' => 19, 'msg' => '库存不足！'));
        exit($data);
    }
}