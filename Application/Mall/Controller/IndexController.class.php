<?php
/**
 * Created by PhpStorm.
 * User: gaorenhua
 * Date: 2015/10/19 9:06
 * Email: 597170962@qq.com
 */

namespace Mall\Controller;

use Api\Controller\MessageController;
use Common\Controller\WmallController;
use Common\Model\MallModel;
use Org\Pay\WechatPay;
use Org\Pay\WxPayNotify;

class IndexController extends WmallController
{
    /**
     * @var openid 微信公众号 关注用户对应的 唯一标识
     */
    public $openid;

    public function _initialize()
    {
        switch_mall();
        parent::_initialize();
    }

    /**
     * 商品首页
     */
    public function index()
    {
        statistics(array('openid' => session('openid'), 'action' => 'home'));
        // 轮播Banner
        $banner = M('mall_banner')->field('banner,url,title')->where(array('status' => 1))->order('id desc')->select();
        $this->assign('banner', $banner);

        $notice = M('mall_notice')->field('content')->order('id desc')->limit(5)->select();
        $this->assign('notice', $notice);

        // 商品状态
        // $where['status'] = array('eq', MallModel::GOODS_STATUS_SELLING);
        $status = MallModel::GOODS_STATUS_SELLING;

        // 查询商品 每个分类查询 4个商品
        $model = new \Think\Model();

        $order = "a.top desc, a.sort desc, a.id desc";

        // 商品数据写入缓存
        if (!S('goods')) {
            $num = C('DISPLAY_NUMBERS');
            $goods = $model->query("SELECT * FROM __PREFIX__mall_good AS a
                                         WHERE (SELECT COUNT(id) FROM __PREFIX__mall_good WHERE pid = a.pid
                                         AND id > a.id AND status = $status ) < $num AND a.status = $status
                                         ORDER BY $order;");
            S('goods', $goods, 60);
        }

        $goods_list = S('goods');




        // 商品分类
        $menu_list = M('mall_menu')->select();
        $menu_list = node_merge($menu_list);
        /**所有商品归类 拆分二级分类 合并到一级分类 重组数组
         */

        $list = array();
        foreach ($menu_list as $k => $v) {
            $list[$k]['id'] = $v['id'];
            $list[$k]['name'] = $v['name'];
            foreach ($goods_list as $g) {
                if ($v['id'] == $g['menu_id']) {
                    $list[$k]['child'][] = $g;
                }
            }
            foreach ($v['child'] as $i) {
                foreach ($goods_list as $j) {
                    if ($i['id'] == $j['menu_id']) {
                        $list[$k]['child'][] = $j;
                    }
                }
                foreach ($i['child'] as $m){
                    //三级分类的遍历
                    foreach ($goods_list as $s) {
                        if ($m['id'] == $s['menu_id']) {
                            $list[$k]['child'][] = $s;
                        }
                    }
                }
            }
        }

        $this->assign("list", $list);
        $this->display();
    }

    /**
     * 商品分类
     */
    public function category()
    {
        statistics(array('openid' => session('openid'), 'action' => 'category'));
        if (!IS_GET) {
            $this->error('请求方式不正确');
        }

        $this->assign("menu", findMenu());
        $this->display();
    }

    /**
     * 默认收货地选择
     *
     * */
    public function defaultAddress()
    {
        if (IS_POST) {

        }
        $this->display();

    }

    /**
     * 商品详情
     */
    public function detail()
    {
        if (!IS_GET) {
            $this->error('请求方式不正确');
        }

        // 获取GET数据
        $id = I('get.id', 0, 'intval');

        statistics(array('openid' => session('openid'), 'action' => 'show_good', 'good_id' => $id,));

        // 查看商品详情
        $info = M('mall_good')->find($id);

        // 下架商品不能打开
        if (empty($info['status']) || $info['status'] == 2) {
            $this->error('商品已下架或已删除', U('Mall/Index/index', '', true, true), 2);
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
                $RegionDataArray = $this->getRegionRowArrayWithUid(session('uid'));
            }
            $StockControlData['province_name'] = $RegionDataArray['province_name'];
        }

        if ($info['is_ecp'] != '1') {
            if ($info['stock'] >= '1') {
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
        $this->assign('info', $info);

        // 计算页面点击量
        M('mall_good')->where(array('id' => $id))->setInc('click');

        // 调用广告列表
        if (!empty($info['ad_ids'])) {
            $adList = M('mall_advert')->field('title,image,url')->where(array('id' => array('in', $info['ad_ids'])))->select();
            $this->assign('adlist', $adList);
        }
        //判断是否为延保调用延保价格信息
        if($info['iswrrany'] ==1){
            $warrany = json_decode($info['warrany'],true);
            $this->assign('iswrrany',$info['iswrrany']);
            $this->assign('warrany',$warrany);
        }else{
        	$this->assign('iswrrany',0);
        }
        $this->display();
    }

    /**
     * 取用户默认所在地名称及对应仓库
     */
    public function getRegionRowArrayWithUid($Uid)
    {
        $UserInfo = $this->getUserBasicInfo();
        if ($UserInfo['province'] != '' AND $UserInfo['city'] != '') {
            $optionsWhere = array();
            $optionsWhere['city_name'] = array('like', $UserInfo['city'] . '%');
            $optionsWhere['province_name'] = array('like', $UserInfo['province'] . '%');
            $optionsWhere['status'] = 'A';
            $optionsWhere['region_type'] = '2';
            $ReturnArray = M("EcpBaseRegion")->where($optionsWhere)->find();
        } else {
            $ReturnArray = M("EcpBaseRegion")->where(array('region_id' => '102492'))->find();
        }

        return $ReturnArray;

    }

    /**
     * 获取订单信息
     */
    public function checkCoupon()
    {
        // 判断提交方式
        if (!IS_GET) {
            $this->ajaxReturn('请求非法');
        }

        $allow_nums = 0;
        $allow_max_money = 0;
        $allow_max_id = 0;

        $sku_ids = array();
        $money = 0;

        // 提取POST数据
        $data = json_decode(I('get.data', '', 'stripcslashes'), true);
//        $data = json_decode('[{"id":"13","num":"2"},{"id":"12","num":"1"}]', true);
//        $data = json_decode('[{"id":"8","num":"1"}]', true);
        //$data = json_decode('[{"id":"9","num":"1"}]', true);

        // 遍历查询商品信息 重新组合数组
        $array = array();
        foreach ($data as $v) {
            $info = M('mall_good')->field('id,name,image,price,old_price,menu_id,sku_id')->find($v['id']);
            $array['class'][$info['menu_id']] += $info['price'] * $v['num'];
            $array['good'][$info['sku_id']] += $info['price'] * $v['num'];
            $sku_ids[] = $info['sku_id'];
        }

        //获取购物车商品分类ID数组 调试优惠券
        $menu_id_array = $array['class'];

        foreach ($array['class'] as $value) {
            $money += $value;
        }

        $total_money = $money; // 总价

        $where1['uid'] = session('uid');
        $where1['used'] = 0;
        $where1['deleted'] = 0;

        // 领取记录
        $ids = M('mall_coupon_record')->where($where1)->getField('coupon_id', true);

        if (!empty($ids)) {
            $where2['id'] = array('in', $ids);
            $where2['status'] = 1;
            $where2['start_time'] = array('ELT', time());
            $where2['end_time'] = array('EGT', time());
            $coupon = M('mall_coupon')->where($where2)->select(); // 商城现有的可用的优惠券
            if (!empty($coupon)) {
                foreach ($coupon as $key => $value1) {
                    // 订单总价 >= 优惠券面值
                    if ($total_money >= $value1['money_cut']) {
                        if ($value1['allow_class_id'] == '') {// 不限制分类的
                            if (trim($value1['sku_ids']) == '') { // 不限制商品
                                if ($total_money >= $value1['money_over']) {
                                    $allow_nums++;
                                    if ($value1['money_cut'] > $allow_max_money) { // 取最大的优惠券
                                        $allow_max_money = $value1['money_cut'];
                                        $allow_max_id = $value1['id'];
                                    }
                                }
                            } else {
                                $sku_ids_array = explode(',', $value1['sku_ids']);
                                foreach ($sku_ids as $v) {
                                    if (in_array($v, $sku_ids_array)) {
                                        $allow_nums++;
                                        if ($value1['money_cut'] > $allow_max_money) { // 取最大的优惠券
                                            $allow_max_money = $value1['money_cut'];
                                            $allow_max_id = $value1['id'];
                                        }
                                    }
                                }
                            }
                        } else {// 限制分类的
                            $allow_class_id_array = explode(',', $value1['allow_class_id']);
                            foreach ($allow_class_id_array as $class) {
                                if ($menu_id_array[$class] >= $value1['money_over']) {
                                    if (trim($value1['sku_ids']) == '') {
                                        $allow_nums++;
                                        if ($value1['money_cut'] >= $allow_max_money) {
                                            $allow_max_money = $value1['money_cut'];
                                            $allow_max_id = $value1['id'];
                                        }
                                    } else {
                                        $sku_ids_array = explode(',', $value1['sku_ids']);
                                        foreach ($sku_ids as $v) {
                                            if (in_array($v, $sku_ids_array)) {
                                                $allow_nums++;
                                                if ($value1['money_cut'] > $allow_max_money) {
                                                    $allow_max_money = $value1['money_cut'];
                                                    $allow_max_id = $value1['id'];
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        $data['allow_nums'] = $allow_nums;
        $data['allow_max_money'] = convert_money($allow_max_money);
        $data['allow_max_id'] = $allow_max_id;
        $this->ajaxReturn($data);
    }

    /**
     * 获取订单信息
     */
    public function getOrderInfo()
    {
        // 判断提交方式
        if (!IS_GET) {
            $this->ajaxReturn('请求非法');
        }

        // 提取POST数据
        //$data = I('cookie.goods','','strip_tags');stripcslashes
        $data = json_decode(I('get.data', '', 'stripcslashes'), true);
        // 遍历查询商品信息 重新组合数组
        foreach ($data as $v) {
            $info = M('mall_good')->field('id,name,spec,image,price,old_price,menu_id,description')->find($v['id']);
            $info['num'] = $v['num'];
            $info['price'] = convert_money($info['price']);
            $info['old_price'] = convert_money($info['old_price']);
            $info['warrany'] = $v['warrany'];
            if($v['warrany'] != ''){
                $info['price'] = $v['warr_price'];
                $info['old_price'] = null;
            }
            //$info['warr_price'] = $data['warr_price'];
            //暂时停用
            //$info['image'] = create_goods_thumb_url($info['image']);
            $array[] = $info;
        }
        $this->ajaxReturn($array);
    }

    public function setinvoice()
    {

        if (IS_POST) {

            $array = array();
            $array['style'] = $_REQUEST['ticket-radio'];

            if ($array['style'] == 0) {
                $array['company'] = $_REQUEST['company'];
                $array['bank'] = $_REQUEST['bank'];
                $array['num'] = $_REQUEST['num'];
                $array['account'] = $_REQUEST['account'];
                $array['address'] = $_REQUEST['address'];
                $array['telephone'] = $_REQUEST['telephone'];
            } else {
                $array['plain_title'] = I('plain_title', '个人');
            }

            $code = json_encode($array);
            cookie('invoice', $code);

            $this->redirect('comfirmOrder');

        }


        $invoice = cookie('invoice');
        $invoice = json_decode($invoice, true);
        if ($invoice['style'] === NULL) {
            $invoice['style'] = '1';
            $invoice['plain_title'] = '个人';

        }

        $this->assign('invoice_style', $invoice['style']);
        $this->assign('invoice', $invoice);
        $this->display();
    }

    /**
     * 订单确认
     */
    public function comfirmOrder()
    {
        $invoice = cookie('invoice');
        $invoice = json_decode($invoice, true);
        $warrany = I('cookie.goods','','strip_tags');
        $warrany = json_decode($warrany, true);

        foreach ($warrany as $v)
        {
            $warr_price = $v['warr_price'];
        }

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

        if (empty($goods)) {
            $this->error('购买商品出错, 请重新购买', U('Mall/Index/index', '', true, true), 2);
        }

        $ids = array();
        foreach ($goods as $v) {
            $v = (array)$v;
            // 判断商品状态 下架或已删除商品均不能下单
            $status = M('mall_good')->where(array('id' => $v['id']))->getField('status');
            if (empty($status) || $status == 2) {
                $this->error('商品已下架或已删除', U('Mall/Index/index', '', true, true), 2);
            } else {
                $ids[] = $v['id'];
            }
        }

        $with_invoice_result = M('mall_good')->where(array('id' => array('in', $ids)))->getField('with_invoice', true);

        if (in_array('0', $with_invoice_result)) {
            $with_invoice = 0;
        } else {
            $with_invoice = 1;
        }
        cookie('with_invoice', $with_invoice);
        $this->assign('with_invoice', $with_invoice);

//        foreach ($goods as $k=>$v){
//            $ids[]=$v['id'];
//        }
//        var_dump($ids);exit;
//        $this->openid=$this->getOpenId();
//        session('openid',$this->openid);
        // 查询当前用户的所有有效地址
        $where['user_id'] = session('uid');
        $where['status'] = 0;
        $address = M('mall_address')->where($where)->order('`default` DESC')->find();
        if ($address) {
            $address['region'] = get_region_row($address['region_id']);
        }
        
        $category = M('mall_category')->select();
        
        $this->assign('warr',$warr_price);
        $this->assign('address', $address);
        $this->assign('category', $category);
        $this->display('comfirm_order');
    }

    /**
     * 添加商品
     */
    public function addOrder()
    {
        if (!IS_AJAX) {
            E('该页面不存在', 404);
        }
        //$cart_data = json_decode(I('cartData', '', 'stripcslashes'), true);

        //$this->ajaxReturn($cart_data);
        //dump($cart_data);
        //die;
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
            if ($checkCouponResult['code'] != 0) {
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


        foreach ($cart_data as $key => $value) {
            // 查询单品库存和佣金
            $goods = M('mall_good')->field('stock,commission,sku_id,is_ecp')->where('id=' . $value['id'])->find();
            if ($goods['is_ecp'] == '1') {
                $warehouse_code = M('ecp_base_region')->where('region_id=' . $address['region_id'])->getField('warehouse_code');// 仓库代码
                $product_count = M('ecp_inventory')->where(array('sku_id' => $goods['sku_id'], 'warehouse_code' => $warehouse_code))->getField('product_count');// 库存
                if (intval($product_count) - $value['num'] < intval($last_stock)) {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '该商品所在区域库存不足, 无法下单'));
                }
                $cart_data[$key]['warehouse_code'] = $warehouse_code;
                $cart_data[$key]['is_ecp'] = 1;
            } else {
                if (intval($goods['stock']) - $value['num'] < 0) {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '该商品库存不足, 无法下单'));
                }
                $cart_data[$key]['warehouse_code'] = '';
                $cart_data[$key]['is_ecp'] = 0;
            }

            // 删除购物车商品
            $map = array(
                'uid' => session('uid'),
                'goods_id' => $value['id']
            );
            M('mall_cart')->where($map)->delete();

            // 获取商品表里的商品价格
            $price = M('mall_good')->where(array('id' => $value['id']))->getField('price');

            $cart_data[$key]['commission'] = $goods['commission'] * $value['num'];
            $cart_data[$key]['price'] = $price;
            $cart_data[$key]['sku_id'] = $goods['sku_id'];
        }

        $coupon_price = M('mall_coupon')->where(array('id' => $coupon_id))->getField('money_cut');
        $coupon_price ? $coupon_price : $coupon_price = 0;

        // 定义空数组 存储订单数据
        $data = array();

        // 是否为延保产品
        $ybGoods = M('mall_good')->find($cart_data[0]['id']);
        if($ybGoods['iswrrany'] == 1){
//            $warrany = json_decode($ybGoods['warrany'], true);
//            if(!$warrany){
//                $this->ajaxReturn(array('code' => 1, 'msg' => '订单提交失败,请重新下单'));
//            }
//            $data['total_price'] += convert_money($warrany[0]['Price'], '*');  // 获取单品购买总价
            $data['total_price'] = convert_money(I('post.totalPrice', 0, 'floatval'), '*');
        } else {
            // 遍历数组 组合佣金总额
            foreach ($cart_data as $v) {
                //$data['commission'] += $v['commission'];
                $data['total_price'] += $v['price'] * $v['num'];  // 获取单品购买总价
            }
        }



        $data['user_id'] = session('uid');
        $data["order_number"] = create_order_number();
        $data["real_price"] = $data['total_price'] - $coupon_price;
        $data['commission'] = create_commission($data["real_price"]);

        $data["pay_style"] = '0';
        $data["pay_status"] = '0';
        $data["address_id"] = I('address_id', 0, 'intval');
        $data["note"] = $order_info[0]['value'];
        $data["is_coupon"] = $is_coupon;
        $data["coupon_id"] = $coupon_id;
        $data["order_status"] = '1';
        $data["create_time"] = $_SERVER['REQUEST_TIME'];
        $data["cart_data"] = json_encode($cart_data);

        // 延保信息
        $data['yb_brand'] = I('yb_brand', '');
        $data['yb_model'] = I('yb_model', '');
        $data['yb_category'] = I('yb_category', 0, 'intval');
        $data['yb_sn'] = I('yb_sn', '');
        $data['yb_buydate'] = I('yb_buydate', '');
        $data['yb_price'] = convert_money(I('yb_price', 0, 'floatval'), '*');

        // 插入订单数据
        if ($id = M('mall_order')->add($data)) {

            // 订单提交成功需要减商品库存
            foreach ($cart_data as $value) {
                $item['good_id'] = $value['id'];
                $item['good_number'] = create_good_number();
                $item['good_name'] = $value['name'];
                $item['good_image'] = $value['image'];
                $item['good_price'] = $value['price'];
                $item['good_description'] = $value['description'];
                $item['order_number'] = $data['order_number'];

                M('mall_order_shop')->add($item);

                if ($value['is_ecp'] == 1 && $value['warehouse_code'] != '') {
                    $rs = M('ecp_inventory')
                        ->where(array('sku_id' => $value['sku_id'], 'warehouse_code' => $value['warehouse_code']))
                        ->setDec('product_count', $value['num']);
                } else {
                    M('mall_good')->where(array('id' => $value['id']))->setDec('stock', $value['num']);
                }
            }

            $order_number = $data['order_number'];

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
                $invoice = json_decode($invoice, true);
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

            statistics(array('openid' => session('openid'), 'action' => 'pay_start', 'order_id' => $id));
            $this->ajaxReturn(array('code' => 0, 'msg' => $order_number, 'url' => U('Mall/Index/paynow', array('order_num' => $order_number), true, true)));
        } else {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单提交失败,请重新下单'));
        }
    }

    /**
     * 支付
     */
    public function paynow()
    {
        header("Content-Type: text/html; charset=utf-8");
        $order_number = $_REQUEST['order_num'];

        $openid = M('user')->where(array('uid' => session('uid')))->getField('openid');
        //发起支付，传入基本参数
        $options = array(
            'appid' => C('APP_ID'),
            'appsecret' => C('APP_SECRET'),
            'mchid' => C('MCH_id'),
            'key' => C('KEY'),
            'notify' => C('NOTIFY_URL'),
        );

        $pay = new WechatPay($options);
        $order_info = M('mall_order')->where(array('order_number' => $order_number, 'user_id' => session('uid')))->find();

        if (empty($order_info)) $this->error('订单信息错误，请重试！');
        if ($order_info['pay_status'] == 1) $this->error('订单已支付，请勿重复支付！');

        $data1['body'] = '在线商城购物订单';
        $data1['attach'] = '订单号：' . $order_number;
        //$data1['total_fee']=1;
        $data1['total_fee'] = $order_info['real_price'];
        $data1['goods_tag'] = '在线商城购物订单';
        $data1['openid'] = $openid;
        $data1['out_trade_no'] = $order_number;



        $order = $pay->unifiedOrder($data1);
//        dump($order);
//die;


        $jsApiParameters = $pay->GetJsApiParameters($order);
        //dump($jsApiParameters);die;
        $this->assign('jsApiParameters', $jsApiParameters);
        $this->display();
    }


    /**
     * 加入购物车
     */
    public function addToCart()
    {
        // 判断提交方式
        if (!IS_POST) {
            $this->ajaxReturn('非法请求');
        }

        // 提取POST数据
        $data = array();
        $data['uid'] = session('uid');
        $data['goods_id'] = I('goods_id', 0, 'intval');
        $data['goods_num'] = I('goods_num', 0, 'intval');
        $data['create_time'] = $_SERVER['REQUEST_TIME'];

        // 检测当前用户是否有相同商品
        $where['uid'] = $data['uid'];
        $where['goods_id'] = $data['goods_id'];

        if (M('mall_cart')->where($where)->find()) {
            M('mall_cart')->where($where)->setInc('goods_num', $data['goods_num']);
            M('mall_cart')->where($where)->setField('create_time', $data['create_time']);
            $count = M('mall_cart')->where(array('uid' => session('uid')))->count();
            $return_array = array('code' => 0, 'msg' => '添加成功', 'num' => $count);
            $this->ajaxReturn($return_array);
        }

        // 获取库存预警线数量
        if (!S('stock')) {
            $where['type'] = 'stock';
            $last_stock = M('attribute')->where($where)->getField('value');
            S('stock', $last_stock);
        }

        // 查询当前商品库存
        $stock = M('mall_good')->where(array('id' => $data['goods_id']))->getField('stock');

        if ($stock - $data['goods_num'] <= S('stock')) {
            $this->ajaxReturn('该商品库已经售完,无法下单');
        }

        // 插入购物车
        if (M('mall_cart')->add($data)) {
            statistics(array('openid' => session('openid'), 'action' => 'add_cart', 'good_id' => $data['goods_id']));
            $count = M('mall_cart')->where(array('uid' => session('uid')))->count();
            $return_array = array('code' => 0, 'msg' => '添加成功', 'num' => $count);
            $this->ajaxReturn($return_array);
        } else {
            $return_array = array('code' => 1, 'msg' => '添加失败');
            $this->ajaxReturn($return_array);
        }
    }

    /**
     * 购物车
     */
    public function shoppingcart()
    {
        $uid = session('uid');
        // 查询当前用户所有的购物车商品
        $model = new \Think\Model();
        $list = $model->query("SELECT * FROM __PREFIX__mall_cart AS a
                               INNER JOIN __PREFIX__mall_good AS b
                               WHERE a.goods_id = b.id AND a.status = 0 AND a.uid = $uid
                               ORDER BY a.create_time");

        // 判断购物车是否为空
        if (!empty($list)) {
            $this->assign('list', $list);
            $this->display();
        } else {
            $this->display('cart_empty');
        }
    }

    /**
     * 删除购物车商品
     */
    public function delCart()
    {
        // 提交方式
        if (!IS_POST) {
            $this->ajaxReturn('请求方式不正确');
        }

        // 提取POST火速据
        $data = json_decode(I('data', '', 'stripcslashes'), true);

        foreach ($data as $v) {
            $re = M('mall_cart')->where(array('uid' => session('uid'), 'goods_id' => $v['id']))->delete();
            if (!$re) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '删除失败'));
            }
        }

        $this->ajaxReturn(array('code' => 0, 'msg' => '删除成功'));
    }

    /**
     * 商品列表
     */
    public function item()
    {
        // 判断提交方式
        if (!IS_GET) {
            $this->error('请求方式不存在');
        }
        // 提取GET数据  商品分类id
        $menu_id = I('menu_id', 0, 'intval');
        $class = I('get.class', 0, 'intval');
        $sort = I('get.sort');
        $sort == 'asc' ? $sort = 'desc' : $sort = 'asc';

        statistics(array('openid' => session('openid'), 'action' => 'menu_list', 'action_ext' => $menu_id));

        // 包含商品置顶功能 top 置顶 最优先 然后按照人工排序 最后 根据 人气 时间 销量 价格进行排序
        if ($class == 1) $order = 'click ' . $sort;
        if ($class == 2) $order = 'create_time ' . $sort;
        if ($class == 3) $order = 'sales_volume ' . $sort;
        if ($class == 4) $order = 'price ' . $sort;
        // 判断分类id 是否存在
        if ($menu_id) {
            // 判断分类 是否为顶级分类
            $pid = M('mall_menu')->where(array('id' => $menu_id))->getField('pid');

            if ($pid) {
                $list = M('mall_good')->where(array('menu_id' => $menu_id, 'status' => MallModel::GOODS_STATUS_SELLING))->order($order)->select();

            } else {
                // 当为顶级分类的时候 需要调用该分类下全部子类的商品
                $ids = M('mall_menu')->where(array('pid' => $menu_id))->getField('id', 'name', true);
                //二级分类
                $ids[] = $menu_id;

                $list = M('mall_good')->where(array('menu_id' => array('in', $ids), 'status' => MallModel::GOODS_STATUS_SELLING))->order($order)->select();
            }
        } else {
            $list = M('mall_good')->where(array('status' => MallModel::GOODS_STATUS_SELLING))->order($order)->select();
        }

        $this->assign('title', '商品列表');

        $this->assign('list', $list);
        $this->assign('sort', $sort);
        $this->display();
    }

    /**
     * 商品搜索
     */
    public function search()
    {
        // 显示标题
        $this->assign('title', '搜索结果');

        // 提取搜索关键词
        $keywords = I('keywords');
        statistics(array('openid' => session('openid'), 'action' => 'search', 'action_ext' => $keywords));
        // 模糊匹配
        $map['name|description'] = array('like', "%$keywords%");
        $map['status'] = MallModel::GOODS_STATUS_SELLING;

        $list = M('mall_good')->where($map)->select();

        $this->assign('list', $list);
        $this->display('item');
    }

    /**
     * 优惠券商品
     */
    public function coupanGoodsList()
    {
        $this->assign('title', '优惠券商品');

        // 提取优惠券ID
        $id = I('get.id', 0, 'intval');

        statistics(array('openid' => session('openid'), 'action' => 'coupon_goods', 'action_ext' => $id));

        // 获取该优惠券对应的 商品分类 和 商品列表
        $array = M('mall_coupon')->field('allow_class_id,sku_ids')->find($id);
        // dump($array);
        // var_dump($array['allow_class_id']);
        // die;

        // 默认为全部商品都可以使用
        $list = M('mall_good')->where(array('status' => MallModel::GOODS_STATUS_SELLING))->order('id desc')->select();

        $ids = array();

        // 允许的商品列表
        if (!empty($array['sku_ids'])) {
            $sku_ids = explode(',', $array['sku_ids']);
            $list = M('mall_good')->where(array('sku_id' => array('in', $sku_ids), 'status' => MallModel::GOODS_STATUS_SELLING))->select();
        } else {
            // 允许的商品分类
            if (!empty($array['allow_class_id'])) {
                $allow_class_ids = explode(',', $array['allow_class_id']);

                foreach ($allow_class_ids as $key => $value) {
                    $pid = M('mall_menu')->where(array('id' => $value))->getField('pid');
                    if ($pid) {
                        $list1[$key] = M('mall_good')->where(array('menu_id' => $value, 'status' => MallModel::GOODS_STATUS_SELLING))->order('id desc')->select();
                    } else {
                        // 当为顶级分类的时候 需要调用该分类下全部子类的商品
                        $ids = M('mall_menu')->where(array('pid' => $value))->getField('id', true);
                        $ids[] = $value;
                        $list1[$key] = M('mall_good')->where(array('menu_id' => array('in', $ids), 'status' => MallModel::GOODS_STATUS_SELLING))->order('id desc')->select();
                    }
                }

                $list2 = array();
                foreach ($list1 as $value2) {
                    foreach ($value2 as $value3) {
                        $list2[] = $value3;
                    }
                }

                // 多维数组 去重
                $list2 = array_unique_fb($list2);

                //dump($list1);die;

                $list = $list2;
            }
        }

        $this->assign('list', $list);
        $this->display('item');
    }

    /**
     * 秒杀
     */
    public function seckill()
    {
        //实例化
        $actionModel = M('activity_seckill_action');

        // 默认获取第一个活动作为当前秒杀活动
        $info = $actionModel->where(array('action_open' => 0))->order('action_id desc')->find();
        if (empty($info)) {
            $this->error('暂无秒杀活动', U('Mall/Index/index', '', true, true), 2);
        }

        statistics(array('openid' => session('openid'), 'action' => 'activity_seckill', 'action_ext' => $info['action_id']));

        $this->info = $info;
        $this->nowtime = $_SERVER['REQUEST_TIME'];
        $this->display();
    }

    /**
     * 秒杀活动商品详情
     */
    public function seckillGoodsDetails()
    {
        //实例化
        $actionModel = M('activity_seckill_action');

        // 提取GET数据 判断是否为秒杀商品 [活动id 和 商品id 有一项不符合即不能秒杀]
        $id = I('get.id', 0, 'intval');
        $action_id = I('get.aid', 0, 'intval');
        $map = array('action_id' => $action_id, 'action_open' => 0);

        // 获取秒杀活动
        $field = 'action_id,goods_id,seckill_price';
        $action_info = $actionModel->field($field)->where($map)->find();

        if (empty($action_info) || $id != $action_info['goods_id']) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '秒杀活动已结束或秒杀商品已下架'));
        }

        // 查看商品详情
        $info = M('mall_good')->find($id);

        // 下架 或 删除的 商品不能参加秒杀
        if (empty($info) || $info['status'] != MallModel::GOODS_STATUS_SELLING) {
            $this->error('商品已下架或已删除', U('Mall/Index/index', '', true, true), 2);
        }

        // 附加秒杀价格
        $info['seckill_price'] = convert_money($action_info['seckill_price']);
        $info['seckill_step'] = $action_info['seckill_step'];

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
                $RegionDataArray = $this->getRegionRowArrayWithUid(session('uid'));
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

        statistics(array('openid' => session('openid'), 'action' => 'activity_seckill_goods', 'action_ext' => $info['action_id']));

        $this->assign('aid', $action_id);
        $this->assign('info', $info);

        $this->display();
    }

    /**
     * 秒杀订单确认
     */
    public function seckillComfirmOrder()
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

        // 判断商品是否下架 或 秒杀活动是否结束
        $goods_id = $goods[0]['id'];
        $action_id = $goods[0]['aid'];

        $map = array('action_id' => $action_id, 'action_open' => 0);
        $action_info = M('activity_seckill_action')->where($map)->find();
        if (empty($action_info) || $action_info['goods_id'] != $goods_id) {
            $this->error('秒杀活动已结束或商品已下架', U('Mall/Index/index', '', true, true), 2);
        }
        // 判断商品状态 下架或已删除商品均不能下单
        $status = M('mall_good')->where(array('id' => $goods_id))->getField('status');
        if (empty($status) || $status != MallModel::GOODS_STATUS_SELLING) {
            $this->error('商品已下架或已删除', U('Mall/Index/index', '', true, true), 2);
        }

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
    public function seckillGetOrderInfo()
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
            $info = M('mall_good')->field('id,name,spec,image,price,old_price,menu_id')->find($v['id']);
            $price = M('activity_seckill_action')->where(array('goods_id' => $v['id']))->getField('seckill_price');
            if (!$price) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '秒杀的商品已删除或已下架'));
            }
            $info['num'] = $v['num'];
            $info['price'] = convert_money($price);
            $info['old_price'] = convert_money($info['price']);
            //$info['image'] = create_goods_thumb_url($info['image']);
            $array[] = $info;
        }


        $this->ajaxReturn($array);
    }

    /**
     * 确认商品 生成订单
     */
    public function seckillAddOrder()
    {
        if (!IS_AJAX) {
            E('该页面不存在', 404);
        }

        // 控制支付开启与关闭
        //switch_pay();

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
            if ($checkCouponResult['code'] != 0) {
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

        // 判断商品是否 符合 秒杀条件 下架 或者 秒杀时间是否在设置范围内
        $map = array('action_id' => $action_id, 'action_open' => 0);
        $action_info = M('activity_seckill_action')->where($map)->find();
        if (empty($action_info) || $action_info['goods_id'] != $goods_id) {
            $this->error('秒杀活动已结束或商品已下架', U('Mall/Index/index', '', true, true), 2);
        }
        // 判断订单时间是否在秒杀时间段之内
        $now_time = $_SERVER['REQUEST_TIME'];
        if ($now_time < $action_info['action_sdate']) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '该商品秒杀还未开始'));
        } else if ($now_time > $action_info['action_edate']) {
            // 当二阶段不为空的时候 判断
            if (!empty($action_info['second_sdate']) && !empty($action_info['second_edate'])) {
                if ($now_time < $action_info['second_sdate']) {
                    $this->ajaxReturn(array('code' => 1, 'msg' => '该商品秒杀还未开始'));
                } else if ($now_time > $action_info['second_edate']) {
                    // 当三阶段时间不为空的时候 判断
                    if (!empty($action_info['third_sdate']) && !empty($action_info['third_edate'])) {
                        if ($now_time < $action_info['third_sdate']) {
                            $this->ajaxReturn(array('code' => 1, 'msg' => '该商品秒杀还未开始'));
                        } else if ($now_time > $action_info['third_edate']) {
                            $this->ajaxReturn(array('code' => 1, 'msg' => '该商品秒杀已经结束'));
                        }
                    }
                }
            }
        }

        // 获取商品表里的商品价格
        $price = M('activity_seckill_action')->where(array('goods_id' => $goods_id))->getField('seckill_price');

        $cart_data[0]['commission'] = $goods['commission'] * $num;
        $cart_data[0]['price'] = $price;


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
        $data['order_type'] = MallModel::ACTIVITY_TYPE_SECKILL;  // 活动类型  秒杀 抢购 团购等 暂定型为 秒杀
        $data['action_id'] = $action_id;

        // 判断秒杀商品的数量
        $seckill_nums = M('activity_seckill_action')->where('action_id=' . $action_id)->getField('seckill_nums');
        if ($seckill_nums < $num && $seckill_nums >= 1) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '参与秒杀的商品数量不足,无法下单'));
        }

        if ($seckill_nums < 1) {
            $this->ajaxReturn(array('code' => 1, 'msg' => '商品已被抢光,无法下单'));
        }

        // 插入订单数据
        if ($id = M('mall_order')->add($data)) {
            // 订单提交成功需要减商品库存
            foreach ($cart_data as $value) {
                if ($value['is_ecp'] == 1 && $value['warehouse_code'] != '') {
                    $rs = M('ecp_inventory')
                        ->where(array('sku_id' => $value['sku_id'], 'warehouse_code' => $value['warehouse_code']))
                        ->setDec('product_count', $value['num']);
                } else {
                    M('mall_good')->where(array('id' => $value['id']))->setDec('stock', $value['num']);
                }
            }
            // 递减秒杀商品的数量
            M('activity_seckill_action')->where('action_id=' . $action_id)->setDec('seckill_nums', $num);
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
                $invoice = json_decode($invoice, true);

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
            statistics(array('openid' => session('openid'), 'action' => 'activity_seckill_order', 'action_ext' => $id));
            $this->ajaxReturn(array('code' => 0, 'msg' => $order_number));
        } else {
            $this->ajaxReturn(array('code' => 1, 'msg' => '订单提交失败,请重新下单'));
        }

    }

    /**
     * 分享统计
     */
    public function shareStatistics()
    {
        if (IS_AJAX) {
            $action = I('post.action');
            $action_ext = I('post.action_ext');

            statistics(array('openid' => session('openid'), 'action' => $action, 'action_ext' => $action_ext));
        }
    }
}
