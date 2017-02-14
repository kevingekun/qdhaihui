<?php
/**
 * 订单管理控制器
 * User: gaorenhua
 * Date: 2015/10/21 17:09
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;
use Common\Model\MallModel;
use Org\Pay\WechatPay;

class OrdersController extends AdminController
{
    public function index()
    {
        // 分页参数
        $page = $this->page;
        $pageSize = $this->pageSize;
        // 实例化一下model对象
        $model = new \Think\Model();

        //计算各状态数
        $Temp_data = D('Orders')->field('order_status,count(orders.id) as num')->group('order_status')->select();
        // dump($Temp_data);die;
        foreach ($Temp_data as $key => $value) {
            $StatusNum[$value['order_status']] = $value['num'];
            $StatusNum['all'] = $StatusNum['all'] + $value['num'];
        }

        // 查询条件
        $where = array();

        // 提取GET数据  订单的状态值
        $status = I('get.s', 0, 'intval');
        // $status ? $where['order_status'] = $status : $where['_string'] = '1=1';
        $status ? $where['order_status'] = $status : '';

        // 判断是否是搜索
        $search = I('search', 0, 'intval');
        if ($search) {
            // 提取搜索时的POST数据
            $mobile_orderno = I('mobile_orderno');    // 收货人 订单号 手机号
            $pay_type = I('pay_type', 0, 'intval');   // 支付方式
            $start_create_time = I('start_create_time', '', 'strtotime');  // 订单创建时间
            $end_create_time = I('end_create_time', '', 'strtotime');  // 订单结束时间
            $goods_name = I('goods_name');

            if ($mobile_orderno) {
                $where['address.mobile|orders.order_number|address.name|user.nickname'] = $mobile_orderno;
            }

            if ($pay_type) {
                $where['orders.pay_style'] = $pay_type;
            }

            if (!empty($start_create_time) && !empty($end_create_time)) {
                $where['create_time'] = array('between', array($start_create_time, $end_create_time));
            }

            if (!empty($start_create_time) && empty($end_create_time)) {
                $where['create_time'] = array('between', array($start_create_time, $_SERVER['REQUEST_TIME']));
            }

            if (empty($start_create_time) && !empty($end_create_time)) {
                $where['create_time'] = array('between', array(0, $end_create_time));
            }

            if ($goods_name) {
                $goods_name = str_replace('\\', '\\\\', trim(json_encode($goods_name), '"'));
                $where['cart_data'] = array('LIKE', '%' . $goods_name . '%');
            }
        }

        $map = I('post.');
        // 循环数组 替换订单状态
        $status = C('ORDER_STATUS');
        $type = C('DELIVERY_TYPE');
        $pay = C('PAY_STYLE');

        if ($_GET['action'] == 'export') {
            $this->exportOrders($where);
        }

        $count = D('Orders')->where($where)->count('order_number');
        $list = D('Orders')->where($where)->order('orders.id desc')->page($page, $pageSize)->select();

        for ($i = 0; $i < count($list); $i++) {
            $list[$i]['order_status_id'] = $list[$i]['order_status'];
            $list[$i]['order_status_text'] = $status[$list[$i]['order_status']];
            $list[$i]['delivery_type'] = $type[$list[$i]['delivery_type']];
            $list[$i]['pay_style'] = $pay[$list[$i]['pay_style']];
        }

        foreach ($list AS $key => $value) {
            $cart_data_list = json_decode($value['cart_data'], true);
            $cart_data = array();
            foreach ($cart_data_list AS $key2 => $value2) {
                $cart_data[$key2] = get_good_data($value2['id']);
                $cart_data[$key2]['num'] = $value2['num'];  // 获取用户购买的数量
                // 获取参加秒杀活动的订单商品 秒杀价
                get_seckill_orders_mark($value['order_number']) ? $cart_data[$key2]['price'] = get_seckill_orders_mark($value['order_number']) : '';

            }
            $value['cart_data_list'] = $cart_data;
            $list[$key] = $value;
        }

        unset($map['__hash__']);
        unset($map['agent_rank_id2']);

        $show = $this->page($count, $map, $pageSize); // 实例化分页类 传入总记录数和每页显示的记录数

        $this->assign('StatusNum', $StatusNum);
        $this->assign('map', $map);
        $this->assign('result', $list);
        $this->assign('page', $show); // 赋值分页输出

        $this->display('index_new');
    }

    /**
     * 导出订单
     * @param $where
     */
    protected function exportOrders($where)
    {
        $status = C('ORDER_STATUS');
        $type = C('DELIVERY_TYPE');
        $pay = C('PAY_STYLE');

        $exportData = D('Orders')->where($where)->order('orders.id desc')->select();
        foreach ($exportData as $key => $value) {
            $exportData[$key]['delivery_type'] = $value['delivery_type'] == 1 ? '只工作日送货(双休日、节假日不送)' : '任意时间';
            $exportData[$key]['pay_status'] = $value['pay_status'] ? '已支付' : '未支付';
            $exportData[$key]['order_status'] = $status[$value['order_status']];
            $exportData[$key]['total_price'] = convert_money($value['total_price']);
            $exportData[$key]['real_price'] = convert_money($value['real_price']);
            $exportData[$key]['pay_style'] = $pay[$value['pay_style']];
            $exportData[$key]['is_elec'] = $value['is_elec'] == 0 ? '纸质发票' : '电子发票';

            $exportData[$key]['user_type'] = get_user_partner_type($value['user_id']);
            $couponInfo = get_coupon_info($value['coupon_id']);
            $exportData[$key]['coupon_name'] = $couponInfo['coupon_name'];
            $exportData[$key]['coupon_price'] = convert_money($couponInfo['money_cut']);

            $exportData[$key]['is_normal'] = $value['is_normal'] == 0 ? '普通' : '增值税';
            $exportData[$key]['return_order'] = $value['return_order'] == 0 ? '否' : '是';
            $exportData[$key]['invoice'] = $value['invoice'] == 1 ? '是' : '否';
            $exportData[$key]['need_invoice'] = $value['need_invoice'] == 1 ? '是' : '否';

            $exportData[$key]['is_coupon'] = $value['is_coupon'] == 1 ? '是' : '否';
            $exportData[$key]['pay_time'] = format_date($value['pay_time'], 'Y-m-d H:i:s');
            $exportData[$key]['urge_time'] = format_date($value['urge_time'], 'Y-m-d H:i:s');

            $exportData[$key]['create_time'] = format_date($value['create_time'], 'Y-m-d H:i:s');

            // 生成完整地址
            $address = getAddressDataArrayWithAddressID($value['address_id']);
            if ($address) {
                $province_name = isset($address['province_name']) ? $address['province_name'] : '';
                $city_name = isset($address['city_name']) ? $address['city_name'] : '';
                $district_name = isset($address['district_name']) ? $address['district_name'] : '';
                $exportData[$key]['address'] = $province_name . $city_name . $district_name . $address['full_address'];
            } else {
                $exportData[$key]['address'] = '';
            }

            $cart_data_list = json_decode($value['cart_data'], true);
            $cart_data = array();
            $n = 1;
            foreach ($cart_data_list AS $key2 => $value2) {
                $cart_data[$key2] = get_good_data($value2['id']);
                if ($n == 1) {
                    $exportData[$key]['num'] = $cart_data_list[$key2]['num'];
                    $exportData[$key]['name'] = $cart_data[$key2]['name'];
                    $exportData[$key]['price'] = $cart_data[$key2]['price'];
                    $exportData[$key]['sku_id'] = $cart_data[$key2]['sku_id'];
                    $exportData[$key]['group'] = get_group_name($cart_data[$key2]['group_id']);
                    $exportData[$key]['tags'] = $cart_data[$key2]['tags'];
                } else {
                    $value['num'] = $cart_data_list[$key2]['num'];
                    $value['name'] = $cart_data[$key2]['name'];
                    $value['price'] = $cart_data[$key2]['price'];
                    $value['sku_id'] = $cart_data[$key2]['sku_id'];
                    $value['group'] = get_group_name($cart_data[$key2]['group_id']);
                    $value['tags'] = $cart_data[$key2]['tags'];
                    array_push($exportData, $value);
                }
                $n++;
            }
        }
        $info = array(
            'nickname' => '微信昵称',
            'order_number' => '订单编号',
            'name' => '商品名称',
            'sku_id' => '商品SKU',
            'num' => '数量',
            'price' => '价格',
            'group' => '分组',
            'tags' => '标签',

            'user_type' => '用户类型',
            'is_integral' => '是否使用积分',
            'integral_price' => '积分抵现金额',
            'is_coupon' => '是否使用优惠券',
            'coupon_name' => '优惠券类型',
            'coupon_price' => '优惠券金额',

            'total_price' => '订单总金额',
            'real_price' => '用户实际支付金额',
            'pay_status' => '支付状态',
            'pay_style' => '支付方式',

            'activity_id' => '活动编号',
            'is_elec' => '发票类型',
            'is_normal' => '纸质发票类型',
            'delivery_type' => '送货类型',
            'return_order' => '是否换货',
            'invoice' => '是否已开发票',
            'need_invoice' => '是否需要发票',

            'mobile' => '电话',
            'address' => '收货地址',
            'note' => '买家备注信息',
            'sellers_note' => '卖家备注信息',
            'remark' => '商家备注',


            'urge_time' => '提醒发货时间',
            'delivery_time' => '发货时间',
            'order_status' => '订单状态',
            'pay_time' => '付款时间',
            'create_time' => '订单生成时间',
        );
        $this->export($exportData, $info);
    }

    /**
     * 订单详情
     * @return [type] [description]
     */
    public function orderDetails()
    {
        // 判断提交方式
        if (!IS_GET) {
            $this->error('请求不存在');
        }

        // 提取GET数据
        $where['orders.id'] = I('get.id', 0, 'intval');

        $info = D('Orders')->where($where)->find();

        //替换订单状态
        $status = C('ORDER_STATUS');
        $type = C('DELIVERY_TYPE');
        $pay = C('PAY_STYLE');

        $info['order_status_id'] = $info['order_status'];
        $info['order_status'] = $status[$info['order_status']];
        $info['delivery_type'] = $type[$info['delivery_type']];
        $info['pay_style'] = $pay[$info['pay_style']];

        $cart_data_list = json_decode($info['cart_data'], true);
        $cart_data = array();
        foreach ($cart_data_list AS $key => $value) {
            $cart_data[$key] = get_good_data($value['id']);
            $cart_data[$key]['num'] = $value['num'];  // 获取用户购买的数量

            // 获取参加秒杀活动的订单商品 秒杀价
            get_seckill_orders_mark($info['order_number']) ? $cart_data[$key]['price'] = get_seckill_orders_mark($info['order_number']) : '';
        }
        $info['cart_data_list'] = $cart_data;
        $info['address'] = getAddressDataArrayWithAddressID($info['address_id']);

        $this->assign('info', $info);
        $this->display('details');
    }

    /**
     * 删除 这个地方分为已付款删除  和 未付款删除
     * @return [type] [description]
     */
    public function del()
    {
        // 判断提交方式
        if (!IS_GET) $this->error('请求不存在');

        // 提取GET数据
        $id = I('get.id', 0, 'intval');
        $order = M('mall_order')->where(array('id' => $id))->find();
        if (!$order) $this->error('订单不存在');

        // 已付款状态
        $yetPayStatusArr = array(MallModel::ORDER_STATUS_WAIT_RECEIVE, MallModel::ORDER_STATUS_WAIT_DELIVER, MallModel::ORDER_STATUS_CLOSE);

        if ($order['order_status'] == MallModel::ORDER_STATUS_WAIT_PAY) {
            $order_status = MallModel::ORDER_STATUS_NO_PAY;
        } elseif (in_array($order['order_status'], $yetPayStatusArr)) {
            $order_status = MallModel::ORDER_STATUS_YET_PAY;
        }

        $res = M('mall_order')->where(array('id' => $id))->setField('order_status', $order_status);
        if ($res !== false) {
            operate_log($id, 'mall_order', 3);
            $this->success('操作成功');
        } else {
            $this->error('操作失败');
        }

    }

    /**
     * [publish description]
     * @param  [type] $id [description]
     * @return [type]     [description]
     */
    public function publish($id)
    {
        // 判断提交方式
        if (!IS_GET) {
            $this->error('请求不存在');
        }

        // 提取GET数据
        $id = I('get.id', 0, 'intval');

        $rs = M('mall_order')->where(array('id' => $id))->setField('order_status', 3);
        if (false !== $rs) {
            operate_log($id, 'mall_order', 2);
            $this->success('操作成功');
        } else {
            $this->error('操作失败');
        }
    }

    /**
     * 支付完成
     * @param  [type] $id [description]
     * @return [type]     [description]
     */
    public function payComplete($id)
    {
        $Model_MallOrder = M('MallOrder');
        $rs = $Model_MallOrder->where(array('id' => intval($id)))->setField(array('pay_status' => '1', 'pay_time' => time()));
        if (false !== $rs) {
            operate_log($rs, 'mall_order', 2);
            $this->success("操作成功");
        } else {
            $this->error("操作失败");
        }
    }

    /**
     * 商家添加商品备注
     */
    public function addRemarks()
    {
        // 提交方式
        if (IS_POST) {
            $id = I('post.order_id', 0, 'intval');
            $data = array(
                'id' => $id,
                'remark' => I('post.remark')
            );

            //更新数据
            $res = M('mall_order')->save($data);
            if ($res !== false) {
                operate_log($id, 'mall_order', 2);
                $this->success('修改成功!');
            } else {
                $this->error('修改失败!');
            }
        } else {
            $id = I('get.id', 0, 'intval');
            $remark = M('mall_order')->where(array('id' => $id))->getField('remark');

            $remark ? $remark = htmlspecialchars_decode($remark) : $remark = "您还没有添加商品备注!";
            $this->ajaxReturn($remark);
        }
    }

    /**
     * 修改订单价格
     */
    public function updatePrice()
    {
        if (IS_POST) {
            $id = I('post.order_id', 0, 'intval');
            $real_price = I('post.real_price', 0, 'floatval');
            $real_price = round($real_price, 2);
            if ($real_price <= 0) $this->error('价格不能小于等于零');

            $order = M('mall_order')->where(array('id' => $id))->find();

            if (!$order) $this->error('该订单不存在');
            if ($order['order_status'] != MallModel::ORDER_STATUS_WAIT_PAY) $this->error('该订单不是待付款订单, 不能修改价格');

            $data = array(
                'id' => $id,
                'real_price' => convert_money($real_price, '*')
            );
            $res = M('mall_order')->save($data);
            if ($res !== false) {
                operate_log($id, 'mall_order', 2);
                $this->success('修改成功!');
            } else {
                $this->error('修改失败!');
            }
        }
    }

    /**
     * 设为已支付
     */
    public function setPayComplete()
    {
        if (!IS_GET) {
            $this->error('请求错误');
        }

        // 提取get数据
        $id = I('get.id', 0, 'intval');

        $order = M('mall_order')->where(array('id' => $id, 'order_status' => MallModel::ORDER_STATUS_WAIT_PAY))->find();
        if (!$order) $this->error('操作出错, 请确认无误后再操作');

        // 组合更新数据
        $data['id'] = $id;
        $data['pay_status'] = 1;
        $data['pay_time'] = $_SERVER['REQUEST_TIME'];
        $data['order_status'] = MallModel::ORDER_STATUS_WAIT_DELIVER;

        // 更新
        $res = M('mall_order')->save($data);
        if (false !== $res) {
            operate_log($id, 'mall_order', 2);
            $this->success('标记成功');
        } else {
            $this->error('标记失败');
        }
    }

    /**
     * 改价操作
     * 修改订单的real_price
     */
    public function changeRealPrice()
    {
        if (IS_POST) {
            $id = I('post.order_id', 0, 'intval');
            $order = M('mall_order')->where(array('id' => $id, 'order_status' => MallModel::ORDER_STATUS_WAIT_PAY, 'order_type' => MallModel::ACTIVITY_NOT))->find();
            if (!$order) $this->error('该订单不能改价, 请重新操作');

            $newRealPrice = I('post.real_price', convert_money($order['real_price']), 'floatval');
            if ($newRealPrice <= 0) $this->error('新价格不能小于等于0');

            $newRealPrice = convert_money($newRealPrice, '*');
            $newOrderNumber = create_order_number();
            $res = M('mall_order')->where(array('id' => $id))->save(array('real_price' => $newRealPrice, 'order_number' => $newOrderNumber));

            if (false !== $res) {
                operate_log($id, 'mall_order', 2);
                $openid = M('user')->where(array('uid' => $order['user_id']))->getField('openid');
                $options = array(
                    'appid' => C('APP_ID'),
                    'appsecret' => C('APP_SECRET'),
                    'mchid' => C('MCH_id'),
                    'key' => C('KEY'),
                    'notify' => C('NOTIFY_URL'),
                );
                $pay = new WechatPay($options);

                $data1['body'] = '在线商城购物订单';
                $data1['attach'] = '订单号：' . $newOrderNumber;
                $data1['total_fee'] = $newRealPrice;
                $data1['goods_tag'] = '在线商城购物订单';
                $data1['openid'] = $openid;
                $data1['out_trade_no'] = $newOrderNumber;

                $result = $pay->unifiedOrder($data1);
                if (isset($result['return_code']) && $result['return_code'] === 'SUCCESS') {
                    $cartData = json_decode($order['cart_data'], true);
                    $goodsName = M('mall_good')->where(array('id'=>$cartData[0]['id']))->getField('name');
                    $temp_arr = array('wechat' => 'OPENTM203998003');
                    $user_arr = array('wechat' => $openid);
                    $msg_arr = array(
                        'wechat' => array(
                            'url' => U('Mall/Ucenter/orders'),
                            'data' => array(
                                'first' => array('value' => '您好，您有一笔订单价格已调整为' . convert_money($newRealPrice) . '元，请尽快支付。'),
                                'keyword1' => array('value' => $newOrderNumber),
                                'keyword2' => array('value' => $goodsName),
                                'keyword3' => array('value' => date('Y-m-d H:i', $order['create_time'])),
                                'keyword4' => array('value' => convert_money($newRealPrice) . '元'),
                                'keyword5' => array('value' => '等待支付'),
                                'remark' => array('value' => '请您尽快支付！')
                            )
                        )
                    );
                    addMessengerQueue('wechat', $temp_arr, $user_arr, $msg_arr);
                    $this->success('改价成功, 请及时通知用户刷新页面进行付款!', U('Admin/Orders/index', array(), true, true));
                } else {
                    $this->error('改价失败, 请重新操作');
                }
            } else {
                $this->error('改价失败, 请重新操作');
            }
        }
    }
}
