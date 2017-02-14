<?php
/**
 * 活动管理控制器
 * User: gaorenhua
 * Email: gaorenhua0812@gmail.com
 * Date: 2016/1/14 11:54
 */

namespace Mall\Controller;
use Common\Controller\WmallController;
use Common\Model\MallModel;

class ActivityController extends WmallController
{
    //==============秒杀活动==========================================================================================//

    /**
     *
     */


    //==============团购活动==========================================================================================//

    /**
     * 获取进行中的所有团购活动
     */
    public function group()
    {
        // 实例化
        $GroupModel = M('activity_group_action');

        //条件
        $map = array(
            'is_finished' => array('LT', MallModel::GROUP_STATUS_OVER),
        );
        $list = $GroupModel->where($map)->order('act_id desc')->select();
        // 处理阶梯价格
        foreach ($list as $k => $v) {
            $list[$k]['ext_info'] = unserialize($v['ext_info']);
            $list[$k]['goods_info'] = get_good_data($v['goods_id']);
        }

        //dump($list);die;

        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 活动预约
     */
    public function bespoke()
    {
        // 实例化
        $GroupModel = M('activity_group_action');
        $BespokeModel = M('activity_group_bespoke');

        if (IS_POST) {
            // 提取GET数据
            $data['act_id'] = I('get.aid', 0, 'intval');
            $data['goods_id'] = I('get.id', 0, 'intval');

            // 验证规则
            $rules = array(
                array('act_id', 'require', '活动不存在或已结束！'), //默认情况下用正则进行验证
                array('goods_id', 'require', '商品已下架或已删除！'), //默认情况下用正则进行验证
                //array('mobile', '/^1[34578]\d{9}$/', '手机号码格式不正确', 0), // 正则表达式验证手机号码
            );

            // 创建数据集
            if (!$data = $BespokeModel->validate($rules)->create($data)) {
                $this->ajaxReturn(array('code' => 1, 'msg'=>$BespokeModel->getError()));
            }

            // 附加数据
            $data['create_time'] = $_SERVER['REQUEST_TIME'];
            $data['openid'] = session('openid');

            // 防止重复预约
            $map = array('act_id' => $data['act_id'], 'openid' => $data['openid']);
            if ($BespokeModel->where($map)->find()) {
                $this->ajaxReturn(array('code' => 1, 'msg'=>'您已经预约, 无需再次预约'));
            }

            if ($id = $BespokeModel->add($data)) {
                $this->ajaxReturn(array('code' => 0, 'msg'=>'预约成功', 'url'=> U('bespokeform', array('id'=>$id, 'aid'=>$data['act_id']))));
            } else {
                $this->ajaxReturn(array('code' => 1, 'msg'=>'预约失败'));
            }
        } else {
            // 提取GET数据
            $act_id = I('get.aid', 0, 'intval');
            $info = $GroupModel->find($act_id);

            // 处理商品卖点
            $info['goods_tags'] = unserialize($info['goods_tags']);

            // 处理阶梯价格
            $info['ext_info'] = unserialize($info['ext_info']);
            //dump($info);die;

            // 获取商品信息
            $info['goods_info'] = get_good_data($info['goods_id']);

            // 获取预约人数
            $count = $BespokeModel->where(array('act_id'=>$act_id))->Count('openid');


            // 判断活动
            if (empty($info) || $info['is_finished'] == MallModel::GROUP_STATUS_OVER) {
                $this->error('该活动已结束', U('Mall/Index/index', '', true, true), 2);
            }

            $this->assign('info', $info);
            $this->assign('count', $count);
            $this->display();
        }
    }

    /**
     * 活动预约
     */
    public function bespokeform()
    {
        // 实例化
        $GroupModel = M('activity_group_action');
        $BespokeModel = M('activity_group_bespoke');

        if (IS_POST) {
            // 验证规则
            $rules = array(
                array('act_id', 'require', '活动不存在或已结束！'), //默认情况下用正则进行验证
                array('mobile', '/^1[34578]\d{9}$/', '手机号码格式不正确', 0), // 正则表达式验证手机号码
            );

            // 创建数据集
            if (!$data = $BespokeModel->validate($rules)->create()) {
                $this->error($BespokeModel->getError());
            }

            if ($BespokeModel->save($data)) {
                $this->success('预约成功');
            } else {
                $this->error('预约失败');
            }
        } else {
            // 提取GET数据
            $act_id = I('get.aid', 0, 'intval');
            $info = $GroupModel->find($act_id);

            // 处理商品卖点
            $info['goods_tags'] = unserialize($info['goods_tags']);

            // 获取商品信息
            $info['goods_info'] = get_good_data($info['goods_id']);

            $this->assign('info', $info);
            $this->display();
        }
    }

    /**
     * 团购活动详情
     */
    public function groupDetails()
    {
        // 提取get数据
        $goods_id = I('get.id', 0, 'intval');
        $act_id = I('get.aid', 0, 'intval');

        // 判断团购
        $array = $this->checkGroup($act_id, $goods_id);
        $action_info = $array['act_info'];
        $info = $array['good_info'];

        // 获取活动预约人数  处理阶梯价格
        $map = array('act_id' => $act_id);
        $count = M('activity_group_bespoke')->where($map)->Count('openid');
        $ext_info = unserialize($action_info['ext_info']);
        foreach ($ext_info as $v) {
            // 根据预约人数 获取对应的阶梯价格
            if ($count >= $v['num']) {
                $info['price'] = $v['price'];
            } else {
                continue;
            }
        }

        //取库存警戒值
        $StockLimit = getAttributeWithType('stock');

        if ($destination = session('hx_mall_good_mail_to')) {
            if ($region_id = get_region_id($destination)) {
                $RegionDataArray = get_region_row($region_id);
            } else {
                $this->error('未能获取地址的区域编码');
            }
            $StockControlData['province_name'] = $RegionDataArray['province_name'];
        } else {
            //取用户所在地记忆
            if (session('default_region_id')) {
                $RegionDataArray = get_region_row(session('default_region_id'));
            } else {
                //取用户微信登记地址所在地对应Region行
                $RegionDataArray = R('Mall/Index/getRegionRowArrayWithUid', array(session('uid')));
            }
            $StockControlData['province_name'] = $RegionDataArray['province_name'];
        }

        if ($info['is_ecp'] != '1') {
            if (($info['stock'] - $StockLimit['value']) >= '1') {
                $StockControlData['flag'] = 'success';
                $StockControlData['stock'] = $info['stock'];
            } else {
                $StockControlData['flag'] = 'failure';
            }
        } else {
            $ProductCountArray = getStockRowArray($info['sku_id'], $RegionDataArray['warehouse_code']);
            if (($ProductCountArray['product_count'] - $StockLimit['value']) >= '1') {
                $StockControlData['flag'] = 'success';
                $StockControlData['stock'] = $ProductCountArray['product_count'];
            } else {
                $StockControlData['flag'] = 'failure';
            }
        }
        $this->assign('StockControlData', $StockControlData);
        $info['show_images'] = json_decode($info['show_images'], true);

        $this->assign('aid', $action_info['act_id']);
        $this->assign('info', $info);

        $this->display();
    }

    /**
     * 团购订单确认
     */
    public function groupComfirmOrder()
    {
        //        cookie('invoice',null);
        $invoice = cookie('invoice');
        $invoice = json_decode($invoice, true);

        if ($invoice['style'] === NULL) {
            $invoice['style'] = 1;
            $invoice['plain_title'] = '个人';
            $code = json_encode($invoice);
            cookie('invoice', $code);
        }

        $userInfo = $this->getUserBasicInfo();
        $openid = session('openid');
        if (empty($openid)) {
            session('openid', $this->openid);
        }

        $invoice_style = (int)$invoice['style'];

        $this->assign('invoice_style', $invoice_style);

        $goods_list = cookie('goods');
        $goods = json_decode($goods_list, true);

        //dump($goods);die;

        if (empty($goods)) {
            $this->error('购买商品出错, 请重新购买', U('Mall/Index/index', '', true, true), 2);
        }

        //dump($goods);die;

        // 判断商品是否下架 或 团购活动是否结束
        $goods_id = $goods[0]['id'];
        $action_id = $goods[0]['aid'];

        $this->checkGroup($action_id, $goods_id);

        $with_invoice_result = M('mall_good')->where(array('id' => $goods_id))->getField('with_invoice');

        if (!$with_invoice_result) {
            $with_invoice = 0;
        } else {
            $with_invoice = 1;
        }
        cookie('with_invoice', $with_invoice);
        $this->assign('with_invoice', $with_invoice);

        // 查询当前用户的所有有效地址
        $where['user_id'] = session('uid');
        $where['status'] = 0;
        $address = M('mall_address')->where($where)->order('`default` DESC')->find();
        if ($address) {
            $address['region'] = get_region_row($address['region_id']);
        }

        $this->assign('aid', $action_id);
        $this->assign('address', $address);
        $this->display();
    }

    /**
     * 获取秒杀订单信息
     */
    public function groupGetOrderInfo()
    {
        // 判断提交方式
        if (!IS_GET) {
            $this->ajaxReturn('请求非法');
        }

        // 提取POST数据
        $data = json_decode(I('get.data', '', 'stripcslashes'), true);
        // 遍历查询商品信息 重新组合数组
        $array = array();
        foreach ($data as $v) {
            $act_id = $v['aid'];
            $goods_id = $v['id'];

            // 判断团购
            $array = $this->checkGroup($act_id, $goods_id);
            $action_info = $array['act_info'];
            $info = $array['good_info'];
            $info['old_price'] = convert_money($info['price']);

            // 获取活动预约人数  处理阶梯价格
            $map = array('act_id' => $act_id);
            $count = M('activity_group_bespoke')->where($map)->Count('openid');
            $ext_info = unserialize($action_info['ext_info']);
            foreach ($ext_info as $value) {
                // 根据预约人数 获取对应的阶梯价格
                if ($count >= $value['num']) {
                    $info['price'] = $value['price'];
                } else {
                    continue;
                }
            }

            $info['num'] = $v['num'];
            $info['price'] = convert_money($info['price']);
            $info['image'] = create_goods_thumb_url($info['image']);
            $array[] = $info;
        }
        unset($array['act_info']);
        unset($array['good_info']);
        $this->ajaxReturn($array);
    }

    /**
     * 确认商品 生成订单
     */
    public function groupAddOrder()
    {
        if (!IS_AJAX) {
            E('该页面不存在', 404);
        }

        // 控制支付开启与关闭
        switch_pay();

        // 获取订单用户相关信息  姓名 手机 地址等
        $order_info = I('data');

        $address_id = I('address_id', 0, 'intval');
        $address = M('mall_address')->where('id=' . $address_id)->find();
        if (!$address) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '请选择或添加收货地址'));
        }

        // 分析购物车数据 处理佣金
        $cart_data = json_decode(I('cartData', '', 'stripcslashes'), true);

        // 获取优惠券金额
        if ($order_info[1]['name'] == 'is_coupon') {
            $is_coupon = intval($order_info[1]['value'] ? $order_info[1]['value'] : 0);
            $coupon_id = intval($order_info[2]['value']);
            $checkCouponResult = check_coupon($coupon_id, $cart_data);
            if($checkCouponResult['code'] != 0){
                $this->ajaxReturn($checkCouponResult);
            }
        } else {
            $coupon_id = 0;
            $is_coupon = 0;
        }

        // 判断购物车数据 防止cookie丢失造成空数据提交
        if (empty($cart_data)) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单信息出错, 请重新下单'));
        }

        // 获取库存预警线数量
        $where['type'] = 'stock';
        $last_stock = M('attribute')->where($where)->getField('value');


        // 查询单品库存和佣金
        $goods_id = $cart_data[0]['id'];
        $action_id = $cart_data[0]['aid'];
        $num = $cart_data[0]['num'];
        $goods = M('mall_good')->field('stock,commission,sku_id,is_ecp')->where('id=' . $goods_id)->find();
        if (empty($goods)) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '该商品已下架或已删除, 无法下单'));
        }

        if ($goods['is_ecp'] == '1') {
            $warehouse_code = M('ecp_base_region')->where('region_id=' . $address['region_id'])->getField('warehouse_code');// 仓库代码
            $product_count = M('ecp_inventory')->where(array('sku_id' => $goods['sku_id'], 'warehouse_code' => $warehouse_code))->getField('product_count');// 库存
            if (intval($product_count) - $num <= intval($last_stock)) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '该商品所在区域库存不足, 无法下单'));
            }
        } else {
            if (intval($goods['stock']) - $num <= 0) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '该商品库存不足, 无法下单'));
            }
        }

        // 判断团购
        $array = $this->checkGroup($action_id, $goods_id);
        $action_info = $array['act_info'];
        $info = $array['good_info'];

        // 获取活动预约人数  处理阶梯价格
        $map = array('act_id' => $action_id);
        $count = M('activity_group_bespoke')->where($map)->Count('openid');
        $ext_info = unserialize($action_info['ext_info']);
        foreach ($ext_info as $value) {
            // 根据预约人数 获取对应的阶梯价格
            if ($count >= $value['num']) {
                $info['price'] = $value['price'];
            } else {
                continue;
            }
        }

        $cart_data[0]['commission'] = $goods['commission'] * $num;
        $cart_data[0]['price'] = $info['price'];


        $coupon_price = M('mall_coupon')->where(array('id' => $coupon_id))->getField('money_cut');
        $coupon_price ? $coupon_price : $coupon_price = 0;

        // 定义空数组 存储订单数据
        $data = array();

        $data['commission'] = $cart_data[0]['commission'];
        $data['total_price'] = $cart_data[0]['price'] * $num;  // 获取单品购买总价
        $data['user_id'] = session('uid');
        $data["order_number"] = create_order_number();
        $data["real_price"] = $data['total_price'] - $coupon_price;
        $data["pay_style"] = '0';
        $data["pay_status"] = "0";
        $data["address_id"] = I('address_id', 0, 'intval');
        $data["note"] = $order_info[0]['value'];
        $data["is_coupon"] = $is_coupon;
        $data["coupon_id"] = $coupon_id;
        $data["order_status"] = '1';
        $data["create_time"] = $_SERVER['REQUEST_TIME'];
        $data["cart_data"] = json_encode($cart_data);
        $data['order_type'] = MallModel::ACTIVITY_TYPE_GROUP;  // 活动类型  秒杀 抢购 团购等 暂定型为 秒杀
        $data['action_id'] = $action_id;

        // 插入订单数据
        if ($id = M('mall_order')->add($data)) {
            // 订单提交成功需要减商品库存
            foreach($cart_data as $value){
                if($value['is_ecp'] == 1 && $value['warehouse_code'] != ''){
                    $rs = M('ecp_inventory')
                        ->where(array('sku_id'=>$value['sku_id'], 'warehouse_code'=>$value['warehouse_code']))
                        ->setDec('product_count', $value['num']);
                } else {
                    M('mall_good')->where(array('id'=>$value['id']))->setDec('stock', $value['num']);
                }
            }
            $order_number = $data["order_number"];
            //M('mall_order')->where('id=' . $id)->setField('order_number', $order_number);  // 更新订单号

            if ($order_info[1]['value'] == 1) {
                $where3['coupon_id'] = $coupon_id;
                $where3['uid'] = session('uid');
                $data3['used'] = 1;
                $data3['use_time'] = time();
                $data3['order_num'] = $order_number;

                M('mall_coupon_record')->where($where3)->save($data3);
            }

            $with_invoice = cookie('with_invoice');

            if ($with_invoice == 0) {
                //填入发票信息
                $invoice = cookie('invoice');
                $invoice = (array)json_decode($invoice);

                $data_invoice['order_number'] = $order_number;
                $data_invoice['user_id'] = session('uid');
                $data_invoice['invoice_type'] = $invoice['style'] ? $invoice['style'] : '1';
                $data_invoice['plain_title'] = $invoice['company'] ? $invoice['company'] : $invoice['plain_title'];
                $data_invoice['vat_taxpaper_ident'] = $invoice['num'] ? $invoice['num'] : '';
                $data_invoice['vat_registered_address'] = $invoice['address'] ? $invoice['address'] : '';
                $data_invoice['vat_registered_phone'] = $invoice['telephone'] ? $invoice['telephone'] : '';
                $data_invoice['vat_deposit_bank'] = $invoice['bank'] ? $invoice['bank'] : '';
                $data_invoice['vat_bank_account'] = $invoice['account'] ? $invoice['account'] : '';
                $data_invoice['normal_title'] = $invoice['normal_title'] ? $invoice['normal_title'] : $invoice['plain_title'];

                M('mall_invoice')->add($data_invoice);

                $data_update['need_invoice'] = 1;

                //更新信息
                $data_update['pay_style'] = 1;

                if ($data_invoice['invoice_type'] == 0) {
                    $data_update['is_normal'] = 1;
                    $data_update['is_elec'] = 0;
                } else {
                    $data_update['is_elec'] = 1;
                }

                M('mall_order')->where(array('order_number' => $order_number))->save($data_update);

            }
            $this->ajaxReturn(array('code' => 0, 'msg' => $order_number));
        } else {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单提交失败,请重新下单'));
        }

    }

    /**
     * 判断团购活动是否符合条件
     * @param $act_id 活动id
     * @param $goods_id 商品id
     * @return array 团购信息 和 商品信息
     */
    protected function checkGroup($act_id, $goods_id)
    {
        // 实例化
        $GroupModel = M('activity_group_action');
        $GoodsModel = M('mall_good');

        // 判断商品是否下架
        $goods_info = $GoodsModel->find($goods_id);
        $goods_info['status'] == MallModel::GOODS_STATUS_SELLING ? '' : $this->error('商品已下架或已删除', U('Mall/Index/index', '', true, true), 2);

        // 判断活动状态
        $act_info = $GroupModel->find($act_id);
        $act_info['is_finished'] == 3 ? $this->error('该活动已结束', U('Mall/Index/index', '', true, true), 2) : '';
        $act_info['is_finished'] == 0 ? $this->error('该活动正在预约', U('Mall/Index/group', '', true, true), 2) : '';

        // 判断活动时间
        //$act_info['start_time'] >= $_SERVER['REQUEST_TIME'] ? $this->error('该活动还未开始', U('Mall/Index/index', '', true, true), 2) : '';

        // 判断活动商品是否正确
        $act_info['goods_id'] == $goods_id ? '' : $this->error('该商品未参与团购', U('Mall/Index/index', '', true, true), 2);

        // 返回值
        return $data = array('act_info' => $act_info, 'good_info' => $goods_info);
    }

    //==============团购活动==========================================================================================//

    /**
     * 获取进行中的所有团购活动
     */
    public function booking()
    {
        // 实例化
        $GroupModel = M('activity_booking_action');

        //条件
        $map = array(
            'is_finished' => array('LT', MallModel::BOOKING_STATUS_OVER),
        );
        $list = $GroupModel->where($map)->order('act_id desc')->select();
        // 获取商品详情
        foreach ($list as $k => $v) {
            $list[$k]['goods_info'] = get_good_data($v['goods_id']);
        }

        //dump($list);die;

        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 活动预约
     */
    public function bookingBespoke()
    {
        // 实例化
        $GroupModel = M('activity_booking_action');
        $BespokeModel = M('activity_booking_bespoke');

        if (IS_POST) {
            // 提取GET数据
            $data['act_id'] = I('get.aid', 0, 'intval');
            $data['goods_id'] = I('get.id', 0, 'intval');

            // 验证规则
            $rules = array(
                array('act_id', 'require', '活动不存在或已结束！'), //默认情况下用正则进行验证
                array('goods_id', 'require', '商品已下架或已删除！'), //默认情况下用正则进行验证
                //array('mobile', '/^1[34578]\d{9}$/', '手机号码格式不正确', 0), // 正则表达式验证手机号码
            );

            // 创建数据集
            if (!$data = $BespokeModel->validate($rules)->create($data)) {
                $this->ajaxReturn(array('code' => 1, 'msg'=>$BespokeModel->getError()));
            }

            // 附加数据
            $data['create_time'] = $_SERVER['REQUEST_TIME'];
            $data['openid'] = session('openid');

            // 防止重复预约
            $map = array('act_id' => $data['act_id'], 'openid' => $data['openid']);
            if ($BespokeModel->where($map)->find()) {
                $this->ajaxReturn(array('code' => 1, 'msg'=>'您已经预约, 无需再次预约'));
            }

            if ($id = $BespokeModel->add($data)) {
                $this->ajaxReturn(array('code' => 0, 'msg'=>'预约成功', 'url'=> U('bookingBespokeform', array('id'=>$id, 'aid'=>$data['act_id']))));
            } else {
                $this->ajaxReturn(array('code' => 1, 'msg'=>'预约失败'));
            }
        } else {
            // 提取GET数据
            $act_id = I('get.aid', 0, 'intval');
            $info = $GroupModel->find($act_id);

            // 处理商品卖点
            $info['goods_tags'] = unserialize($info['goods_tags']);

            // 处理阶梯价格
            $info['ext_info'] = unserialize($info['ext_info']);
            //dump($info);die;

            // 获取商品信息
            $info['goods_info'] = get_good_data($info['goods_id']);

            // 获取预约人数
            $count = $BespokeModel->where(array('act_id'=>$act_id))->Count('openid');


            // 判断活动
            if (empty($info) || $info['is_finished'] == MallModel::GROUP_STATUS_OVER) {
                $this->error('该活动已结束', U('Mall/Index/index', '', true, true), 2);
            }

            $this->assign('info', $info);
            $this->assign('count', $count);
            $this->display();
        }
    }

    /**
     * 活动预约
     */
    public function bookingBespokeform()
    {
        // 实例化
        $GroupModel = M('activity_booking_action');
        $BespokeModel = M('activity_booking_bespoke');

        if (IS_POST) {
            // 验证规则
            $rules = array(
                array('act_id', 'require', '活动不存在或已结束！'), //默认情况下用正则进行验证
                array('mobile', '/^1[34578]\d{9}$/', '手机号码格式不正确', 0), // 正则表达式验证手机号码
            );

            // 创建数据集
            if (!$data = $BespokeModel->validate($rules)->create()) {
                $this->error($BespokeModel->getError());
            }

            if ($BespokeModel->save($data)) {
                $this->success('预约成功');
            } else {
                $this->error('预约失败');
            }
        } else {
            // 提取GET数据
            $act_id = I('get.aid', 0, 'intval');
            $info = $GroupModel->find($act_id);

            // 处理商品卖点
            $info['goods_tags'] = unserialize($info['goods_tags']);

            // 获取商品信息
            $info['goods_info'] = get_good_data($info['goods_id']);

            $this->assign('info', $info);
            $this->display();
        }
    }

    /**
     * 团购活动详情
     */
    public function bookingDetails()
    {
        // 提取get数据
        $goods_id = I('get.id', 0, 'intval');
        $act_id = I('get.aid', 0, 'intval');

        // 判断团购
        $array = $this->checkBooking($act_id, $goods_id);
        $action_info = $array['act_info'];
        $info = $array['good_info'];
        $info['price'] = $action_info['price'];

        //dump($action_info);die;

        //取库存警戒值
        $StockLimit = getAttributeWithType('stock');

        if ($destination = session('hx_mall_good_mail_to')) {
            if ($region_id = get_region_id($destination)) {
                $RegionDataArray = get_region_row($region_id);
            } else {
                $this->error('未能获取地址的区域编码');
            }
            $StockControlData['province_name'] = $RegionDataArray['province_name'];
        } else {
            //取用户所在地记忆
            if (session('default_region_id')) {
                $RegionDataArray = get_region_row(session('default_region_id'));
            } else {
                //取用户微信登记地址所在地对应Region行
                $RegionDataArray = R('Mall/Index/getRegionRowArrayWithUid', array(session('uid')));
            }
            $StockControlData['province_name'] = $RegionDataArray['province_name'];
        }

        if ($info['is_ecp'] != '1') {
            if (($info['stock'] - $StockLimit['value']) >= '1') {
                $StockControlData['flag'] = 'success';
                $StockControlData['stock'] = $info['stock'];
            } else {
                $StockControlData['flag'] = 'failure';
            }
        } else {
            $ProductCountArray = getStockRowArray($info['sku_id'], $RegionDataArray['warehouse_code']);
            if (($ProductCountArray['product_count'] - $StockLimit['value']) >= '1') {
                $StockControlData['flag'] = 'success';
                $StockControlData['stock'] = $ProductCountArray['product_count'];
            } else {
                $StockControlData['flag'] = 'failure';
            }
        }
        $this->assign('StockControlData', $StockControlData);
        $info['show_images'] = json_decode($info['show_images'], true);

        $this->assign('aid', $action_info['act_id']);
        $this->assign('info', $info);

        $this->display();
    }

    /**
     * 团购订单确认
     */
    public function bookingComfirmOrder()
    {
        //        cookie('invoice',null);
        $invoice = cookie('invoice');
        $invoice = json_decode($invoice, true);

        if ($invoice['style'] === NULL) {
            $invoice['style'] = 1;
            $invoice['plain_title'] = '个人';
            $code = json_encode($invoice);
            cookie('invoice', $code);
        }

        $userInfo = $this->getUserBasicInfo();
        $openid = session('openid');
        if (empty($openid)) {
            session('openid', $this->openid);
        }

        $invoice_style = (int)$invoice['style'];

        $this->assign('invoice_style', $invoice_style);

        $goods_list = cookie('goods');
        $goods = json_decode($goods_list, true);

        //dump($goods);die;

        if (empty($goods)) {
            $this->error('购买商品出错, 请重新购买', U('Mall/Index/index', '', true, true), 2);
        }

        //dump($goods);die;

        // 判断商品是否下架 或 团购活动是否结束
        $goods_id = $goods[0]['id'];
        $action_id = $goods[0]['aid'];

        $this->checkBooking($action_id, $goods_id);

        $with_invoice_result = M('mall_good')->where(array('id' => $goods_id))->getField('with_invoice');

        if (!$with_invoice_result) {
            $with_invoice = 0;
        } else {
            $with_invoice = 1;
        }
        cookie('with_invoice', $with_invoice);
        $this->assign('with_invoice', $with_invoice);

        // 查询当前用户的所有有效地址
        $where['user_id'] = session('uid');
        $where['status'] = 0;
        $address = M('mall_address')->where($where)->order('`default` DESC')->find();
        if ($address) {
            $address['region'] = get_region_row($address['region_id']);
        }

        $this->assign('aid', $action_id);
        $this->assign('address', $address);
        $this->display();
    }

    /**
     * 获取秒杀订单信息
     */
    public function bookingGetOrderInfo()
    {
        // 判断提交方式
        if (!IS_GET) {
            $this->ajaxReturn('请求非法');
        }

        // 提取POST数据
        $data = json_decode(I('get.data', '', 'stripcslashes'), true);
        // 遍历查询商品信息 重新组合数组
        $array = array();
        foreach ($data as $v) {
            $act_id = $v['aid'];
            $goods_id = $v['id'];

            // 判断团购
            $array = $this->checkBooking($act_id, $goods_id);
            $action_info = $array['act_info'];
            $info = $array['good_info'];

            $info['num'] = $v['num'];
            $info['old_price'] = convert_money($info['price']);
            $info['price'] = convert_money($action_info['price']);
            $info['image'] = create_goods_thumb_url($info['image']);
            $array[] = $info;
        }
        unset($array['act_info']);
        unset($array['good_info']);
        $this->ajaxReturn($array);
    }

    /**
     * 确认商品 生成订单
     */
    public function bookingAddOrder()
    {
        if (!IS_AJAX) {
            E('该页面不存在', 404);
        }

        // 控制支付开启与关闭
        switch_pay();

        // 获取订单用户相关信息  姓名 手机 地址等
        $order_info = I('data');

        $address_id = I('address_id', 0, 'intval');
        $address = M('mall_address')->where('id=' . $address_id)->find();
        if (!$address) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '请选择或添加收货地址'));
        }

        // 分析购物车数据 处理佣金
        $cart_data = json_decode(I('cartData', '', 'stripcslashes'), true);

        // 获取优惠券金额
        if ($order_info[1]['name'] == 'is_coupon') {
            $is_coupon = intval($order_info[1]['value'] ? $order_info[1]['value'] : 0);
            $coupon_id = intval($order_info[2]['value']);
            $checkCouponResult = check_coupon($coupon_id, $cart_data);
            if($checkCouponResult['code'] != 0){
                $this->ajaxReturn($checkCouponResult);
            }
        } else {
            $coupon_id = 0;
            $is_coupon = 0;
        }

        // 判断购物车数据 防止cookie丢失造成空数据提交
        if (empty($cart_data)) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单信息出错, 请重新下单'));
        }

        // 获取库存预警线数量
        $where['type'] = 'stock';
        $last_stock = M('attribute')->where($where)->getField('value');


        // 查询单品库存和佣金
        $goods_id = $cart_data[0]['id'];
        $action_id = $cart_data[0]['aid'];
        $num = $cart_data[0]['num'];
        $goods = M('mall_good')->field('stock,commission,sku_id,is_ecp')->where('id=' . $goods_id)->find();
        if (empty($goods)) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '该商品已下架或已删除, 无法下单'));
        }

        if ($goods['is_ecp'] == '1') {
            $warehouse_code = M('ecp_base_region')->where('region_id=' . $address['region_id'])->getField('warehouse_code');// 仓库代码
            $product_count = M('ecp_inventory')->where(array('sku_id' => $goods['sku_id'], 'warehouse_code' => $warehouse_code))->getField('product_count');// 库存
            if (intval($product_count) - $num <= intval($last_stock)) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '该商品所在区域库存不足, 无法下单'));
            }
        } else {
            if (intval($goods['stock']) - $num <= 0) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '该商品库存不足, 无法下单'));
            }
        }

        // 判断团购
        $array = $this->checkBooking($action_id, $goods_id);
        $action_info = $array['act_info'];
        $info = $array['good_info'];

        $cart_data[0]['commission'] = $goods['commission'] * $num;
        $cart_data[0]['price'] = $action_info['price'];


        $coupon_price = M('mall_coupon')->where(array('id' => $coupon_id))->getField('money_cut');
        $coupon_price ? $coupon_price : $coupon_price = 0;

        // 定义空数组 存储订单数据
        $data = array();

        $data['commission'] = $cart_data[0]['commission'];
        $data['total_price'] = $cart_data[0]['price'] * $num;  // 获取单品购买总价
        $data['user_id'] = session('uid');
        $data["order_number"] = create_order_number();
        $data["real_price"] = $data['total_price'] - $coupon_price;
        $data["pay_style"] = '0';
        $data["pay_status"] = "0";
        $data["address_id"] = I('address_id', 0, 'intval');
        $data["note"] = $order_info[0]['value'];
        $data["is_coupon"] = $is_coupon;
        $data["coupon_id"] = $coupon_id;
        $data["order_status"] = '1';
        $data["create_time"] = $_SERVER['REQUEST_TIME'];
        $data["cart_data"] = json_encode($cart_data);
        $data['order_type'] = MallModel::ACTIVITY_TYPE_BOOKING;  // 活动类型  秒杀 抢购 团购等 暂定型为 秒杀
        $data['action_id'] = $action_id;

        // 插入订单数据
        if ($id = M('mall_order')->add($data)) {
            // 订单提交成功需要减商品库存
            foreach($cart_data as $value){
                if($value['is_ecp'] == 1 && $value['warehouse_code'] != ''){
                    $rs = M('ecp_inventory')
                        ->where(array('sku_id'=>$value['sku_id'], 'warehouse_code'=>$value['warehouse_code']))
                        ->setDec('product_count', $value['num']);
                } else {
                    M('mall_good')->where(array('id'=>$value['id']))->setDec('stock', $value['num']);
                }
            }
            $order_number = $data["order_number"];
            //M('mall_order')->where('id=' . $id)->setField('order_number', $order_number);  // 更新订单号

            if ($order_info[1]['value'] == 1) {
                $where3['coupon_id'] = $coupon_id;
                $where3['uid'] = session('uid');
                $data3['used'] = 1;
                $data3['use_time'] = time();
                $data3['order_num'] = $order_number;

                M('mall_coupon_record')->where($where3)->save($data3);
            }

            $with_invoice = cookie('with_invoice');

            if ($with_invoice == 0) {
                //填入发票信息
                $invoice = cookie('invoice');
                $invoice = (array)json_decode($invoice);

                $data_invoice['order_number'] = $order_number;
                $data_invoice['user_id'] = session('uid');
                $data_invoice['invoice_type'] = $invoice['style'] ? $invoice['style'] : '1';
                $data_invoice['plain_title'] = $invoice['company'] ? $invoice['company'] : $invoice['plain_title'];
                $data_invoice['vat_taxpaper_ident'] = $invoice['num'] ? $invoice['num'] : '';
                $data_invoice['vat_registered_address'] = $invoice['address'] ? $invoice['address'] : '';
                $data_invoice['vat_registered_phone'] = $invoice['telephone'] ? $invoice['telephone'] : '';
                $data_invoice['vat_deposit_bank'] = $invoice['bank'] ? $invoice['bank'] : '';
                $data_invoice['vat_bank_account'] = $invoice['account'] ? $invoice['account'] : '';
                $data_invoice['normal_title'] = $invoice['normal_title'] ? $invoice['normal_title'] : $invoice['plain_title'];

                M('mall_invoice')->add($data_invoice);

                $data_update['need_invoice'] = 1;

                //更新信息
                $data_update['pay_style'] = 1;

                if ($data_invoice['invoice_type'] == 0) {
                    $data_update['is_normal'] = 1;
                    $data_update['is_elec'] = 0;
                } else {
                    $data_update['is_elec'] = 1;
                }

                M('mall_order')->where(array('order_number' => $order_number))->save($data_update);

            }
            $this->ajaxReturn(array('code' => 0, 'msg' => $order_number));
        } else {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单提交失败,请重新下单'));
        }

    }

    /**
     * 判断团购活动是否符合条件
     * @param $act_id 活动id
     * @param $goods_id 商品id
     * @return array 团购信息 和 商品信息
     */
    protected function checkBooking($act_id, $goods_id)
    {
        // 实例化
        $GroupModel = M('activity_booking_action');
        $GoodsModel = M('mall_good');

        // 判断商品是否下架
        $goods_info = $GoodsModel->find($goods_id);
        $goods_info['status'] == MallModel::GOODS_STATUS_SELLING ? '' : $this->error('商品已下架或已删除', U('Mall/Index/index', '', true, true), 2);

        // 判断活动状态
        $act_info = $GroupModel->find($act_id);
        $act_info['is_finished'] == 3 ? $this->error('该活动已结束', U('Mall/Index/index', '', true, true), 2) : '';
        $act_info['is_finished'] == 0 ? $this->error('该活动正在预约', U('Mall/Index/group', '', true, true), 2) : '';

        // 判断活动时间
        //$act_info['start_time'] >= $_SERVER['REQUEST_TIME'] ? $this->error('该活动还未开始', U('Mall/Index/index', '', true, true), 2) : '';

        // 判断活动商品是否正确
        $act_info['goods_id'] == $goods_id ? '' : $this->error('该商品未参与预售', U('Mall/Index/index', '', true, true), 2);

        // 返回值
        return $data = array('act_info' => $act_info, 'good_info' => $goods_info);
    }
}