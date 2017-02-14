<?php

/**
 * 商城相关函数
 * @author: yanhuaitang
 * @date: 2015/11/8 11:41
 */
/**
 * 获取商品信息
 * @param int good_id
 * @return array
 */
function get_good_data($_Good_ID,$_Field=array('menu_id','sku_id','name','price','image')){

    $_Good_ID = intval($_Good_ID);
    $Model_MallGood = M("MallGood");
    $SecureFieldListDefinedArray=$Model_MallGood->getDbFields();
    $SecureFieldResultArray = array_intersect($_Field,$SecureFieldListDefinedArray);
    $ReturnResult = $Model_MallGood->where(array('id'=>$_Good_ID))->field($SecureFieldResultArray)->find();
    if ($ReturnResult['image']){
        $ReturnResult['image'] = HOME_URL . '/uploads/' . $ReturnResult['image'];
    }
    if ($ReturnResult['price']){
        $ReturnResult['price'] = convert_money($ReturnResult['price']);
    }

    return $ReturnResult;

}
/**
 * 订单状态
 * @param bool|false $key
 * @return array
 */
function order_status($key = false)
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
    $filePath = './uploads/' . ltrim($image, '/');
    if (file_exists($filePath)) {
        $url = HOME_URL . '/' . ltrim(ltrim($filePath, '.'), '/');
    } else {
        $url = HOME_URL . '/uploads/no-exist.jpg';
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
    $key = md5('order_id_' . $id);
    $order = S($key);
    if (!$order) {
        $order = M('mall_order')->where($map)->find();
        $order ? S($key, $order, 60) : false;
    }
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
