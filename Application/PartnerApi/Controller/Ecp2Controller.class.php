<?php
namespace PartnerApi\Controller;

use Common\Controller\ApiController;
use Think\Controller;

/**
 * ECP2 接口控制器
 * @author: yanhuaitang
 * @date: 2015/10/20 15:12
 */
class Ecp2Controller extends ApiController
{

    /**
     * 查询订单支付信息，包括卖家收款、扣款，买家付款，商家优惠、积分等信息。
     */
    public function getPaymentInfo()
    {
        $this->QueryLog();
        $_OrderID = trim($_POST['order_id']);
        $returnFlag = $subReturnFlag = $Temp_OrderData = $Temp_CouponData = array();
        $Model_MallOrder = M("MallOrder");
        $Temp_OrderData = $Model_MallOrder->where(array('order_number' => $_OrderID))->find();
        $Model_MallCoupon = M("MallCoupon");
        $Temp_CouponData = $Model_MallCoupon->where(array('id'=>$Temp_OrderData['coupon_id']))->find();
        $subReturnFlag['pay_type'] = '4';
        $subReturnFlag['pay_time'] = date("Y-m-d H:i:s", $Temp_OrderData['pay_time']);
        $subReturnFlag['order_total_price'] = convert_money($Temp_OrderData['total_price']);
        $subReturnFlag['order_payment'] = convert_money($Temp_OrderData['real_price']);
        $subReturnFlag['freight_price'] = '0';
        $subReturnFlag['coupon_discount'] = convert_money($Temp_CouponData['money_cut']);


        $returnFlag['success'] = true;
        $returnFlag['msg'] = '获取支付信息成功!';
        $returnFlag['paymentinfo'] = $subReturnFlag;

        header("Content-type: text/html; charset=utf-8");
        echo json_encode($returnFlag);
        exit();

    }


    public function getWorkCard()
    {
        /*
         * 淘宝工单状态：生效=1，已申请=2，已受理=3/已拒绝=10，执行中=4，已完成=5/失败=11
         *
         * */
        $this->QueryLog();
        $Model_WorkCard = M("MallWorkcard");
        $Model_MallGood = M("MallGood");
        $Model_MallOrder = M("MallOrder");
        $Model_User = M("User");

        $optionsWhere = $paramsData = $returnFlag = $subData = $Temp_SubData = $Temp_OrderData = $Temp_AddressData = array();
        $LimitStart = $Temp_List = $Temp_subXmlData = '';

        $optionsWhere['create_at'] = array('between', substr(intval($_POST['start_date']),0,11) . ',' . substr(intval($_POST['end_date']),0,11));
        $CountTotal = $Model_WorkCard->where($optionsWhere)->count();
//echo $Model_WorkCard->getLastSql();
        $typeDefinedArray = array('install' => "安装服务", 'repair' => "维修服务");
        $subTypeDefinedArray = array('1' => "挂装", '2' => "座装");

        if ($CountTotal > '0') {
            $Temp_List = $Model_WorkCard->where($optionsWhere)->select();
            foreach ($Temp_List AS $key => $value) {
                $Temp_GoodData = $subData = array();
                $Temp_GoodData = $Model_MallGood->where(array('id' => $value['good_id']))->find();
                $Temp_OrderData = $Model_MallOrder->where(array('order_number' => $value['order_id']))->find();
                $Temp_UserData = $Model_User->where(array('uid' => $value['user_id']))->find();

                $subData['biz_order_id'] = $value['order_number'];
                $subData['service_order_id'] = $value['id'];
                $subData['service_name'] = $typeDefinedArray[$value['type']];
                if ($value['type'] == 'install') {
                    $subData['service_name'] .= ' - ' . $subTypeDefinedArray[$value['sub_type']];
                }
                $subData['name'] = $subData['service_name'];
                if ($value['type'] == 'install') {
                    $subData['task_memo'] = $subTypeDefinedArray[$value['sub_type']];
                }
                $subData['task_status'] = $value['status'];
                $subData['task_type'] = '1';
                $subData['auction_id'] = $value['good_id'];
                $subData['auction_name'] = $Temp_GoodData['name'];
                $subData['auction_price'] = convert_money($Temp_GoodData['price']);
                $subData['task_price'] = convert_money($Temp_GoodData['price']);
                $subData['model_number'] = $Temp_GoodData['sku_id'];
                $subData['category'] = C('WEB_NAME');
                $subData['brand'] = C('WEB_NAME');
                $subData['auction_serial_num'] = $Temp_GoodData['sku_id'];
                $subData['receive_time'] = date("Y-m-d H:i:s", $Temp_GoodData['complete_time']);
                $subData['shop_name'] = C('WEB_NAME');
                $subData['buyer_id'] = $value['user_id'];
                $subData['buyer_nick'] = $Temp_UserData['nickname'];
                $subData['buyer_name'] = $value['contact_name'];
                $Temp_AddressData = get_region_row($value['region_id'], 'region_id');
                $subData['buyer_address'] = $Temp_AddressData['province_name'] . '-' . $Temp_AddressData['city_name'] . '-' . $Temp_AddressData['district_name'] . '-' . $value['address'];
                $subData['buyer_mobile'] = $value['mobile'];
                $subData['apply_date'] = date("Y-m-d H:i:s", $value['create_at']);
                $subData['expect_date'] = date("Y-m-d H:i:s", $value['need_time']);
                $subData['memo'] = $value['admin_note'];
                $Temp_SubData[] = $subData;
            }
        }

        $returnFlag['success'] = true;
        $returnFlag['msg'] = '获取成功';
        $returnFlag['count'] = $CountTotal;
        if ($CountTotal > '0') {
            $returnFlag['itemlistinfo'] = $Temp_SubData;
        }

        header("Content-type: text/html; charset=utf-8");
        echo json_encode($returnFlag);

        exit();

    }


    /**
     * 修改服务单状态
     * 销售平台根据该server_order_id回馈服务单状态
     */
    public function receiveWorkCard()
    {
//        $_POST = $_REQUEST;
        $returnFlag = $SaveData = $returnData = array();
        $this->QueryLog();
//        $_ServiceOrderString = substr(trim($_POST['service_order_id']),16);
        $_ServiceOrderString = intval(trim($_POST['service_order_id']));
        //判断订单状态是否已完成
        $Model_MallWorkcard = M('MallWorkcard');
        $returnData = $Model_MallWorkcard->where(array('id' => $_ServiceOrderString))->find();

                $SaveData['status'] = intval(trim($_POST['status']));
                $SaveData['receive_time'] = time();
                $SaveData['ecp_body'] = json_encode($_POST);
                $Model_MallWorkcard->where(array('id' => $_ServiceOrderString))->data($SaveData)->save();

                $returnFlag['retcode'] = true;
                $returnFlag['retmessage'] = '修改服务工单状态成功!';

        header("Content-type: text/html; charset=utf-8");
        echo json_encode($returnFlag);
        exit();

    }

    public function test()
    {
        echo "connectSuccess";
        exit();
    }


    /**
     * 因为每个服务器的时间都存在差异，为了避免漏单等情况，
     * 在查询订单列表信息时，最好根据订单上的服务器时间来确定查询的时间区间，
     * 按照该时间来查询用户在服务器上下的订单。如果订单的创建时间是应用服务器确定，
     * 则返回的是应用服务器时间，如果是数据库服务器，返回的是数据库服务器时间。
     * 查询完毕之后，当期的查询时间记入本地数据库，作为下一次查询的起始时间。
     */
    public function getTimeInfo()
    {
        //todo
        $returnFlag = array();
        $returnFlag['success'] = 'true';
        $returnFlag['msg'] = "获取成功！";
        $returnFlag['datetime'] = date("Y-m-d H:i:s");
        header("Content-type: text/html; charset=utf-8");
        echo json_encode($returnFlag);
    }

    /**
     * 获取订单列表接口用于查询当前时间段内的新增订单列表信息。
     * 如果没有起始时间，则默认为当前时间往前推一个月。ECP2只获取已付款订单。
     */
    public function getOrdersInfo()
    {
        $this->QueryLog();
        $paramsData = $returnFlag = $WhereOptions = $Dict_Order = array();
        $Model_MallOrder = $lastMonthSecCountDefined = $CountTotal = '';

        $lastMonthSecCountDefined = 60 * 60 * 24 * 30;


//        [AppKey=PARTNER, AppPwd=239B5F335E23F1EBE0532B2B10AC37D6, AuthString=bd08fc98fd57456581c49f774f0ce471, start_date=2015-12-10 15:30:00, end_date=2015-12-10 16:00:00, order_state=30, page=0, page_size=100, sort_type=0]

        file_put_contents('./testEcp2.txt', var_export($_POST, true));

//        $_POST = array(
//            'start_date' => '2015-12-10 15:10:00', //1449731400
//            'end_date' => '2015-12-10 16:00:00',
//            'order_date' => 30,
//            'page' => 0,
//            'page_size' => 100,
//            'sort_type' => 0
//        );
        //echo strtotime('2015-12-10 15:10:00');die;
        // 支付时间  2015-12-10 15:11:11
        //echo date('Y-m-d H:i:s', 1449731471);die;
//dump($_POST);die;
        if ($_POST['start_date']) {
            $paramsData['start_date'] = strtotime($_POST['start_date']);
        } else {
            $paramsData['start_date'] = time() - $lastMonthSecCountDefined;
        }
        if ($_POST['end_date']) {
            if ($_POST['start_date'] == '') {
                $paramsData['start_date'] = strtotime($_POST['end_date']) - $lastMonthSecCountDefined;
            }
            $paramsData['end_date'] = strtotime($_POST['end_date']);
        } else {
            $paramsData['end_date'] = time();
        }
        if (($paramsData['end_date'] - $paramsData['start_date']) > $lastMonthSecCountDefined) {
            $paramsData['start_date'] = $paramsData['end_date'] - $lastMonthSecCountDefined;
        }

        //todo 条件要修改
        $paramsData['sortType'] = $_POST['start_date'];
        $paramsData['dateType'] = $_POST['start_date'];

        $Model_MallOrder = M("MallOrder");
        if ($paramsData['dateType'] == '1') {
            $WhereOptions['create_time'] = array('between', $paramsData['start_date'] . ',' . $paramsData['end_date']);
            $OrderOptionsString = 'create_time';
        } else {
            $WhereOptions['pay_time'] = array('between', $paramsData['start_date'] . ',' . $paramsData['end_date']);
            $OrderOptionsString = 'pay_time';
        }

        if ($paramsData['sortType'] != '' AND $paramsData['sortType'] != '1') {
            $OrderOptionsString .= ' ASC';
        } else {
            $OrderOptionsString .= ' DESC';
        }

//        $WhereOptions['pay_status'] = '1';

        $CountTotal = $Model_MallOrder->where($WhereOptions)->order($OrderOptionsString)->count();

        $lastSql = $Model_MallOrder->getLastSql();
        file_put_contents('./testEcp2.txt', $lastSql);

        if ($CountTotal >= '1') {
            $paramsData['page'] = intval($_POST['page']);
            if (intval($_POST['page_size']) >= '100') {
                $paramsData['page_size'] = '100';
            } else {
                $paramsData['page_size'] = intval($_POST['page_size']);
            }
            $pageNum = ceil($CountTotal / $paramsData['page_size']);

            if ($paramsData['page'] <= '1') {
                $LimitStart = '0';
            } elseif ($paramsData['page'] > $pageNum) {
                $LimitStart = ($pageNum - 1) * $paramsData['page_size'];
            } else {
                $LimitStart = ($paramsData['page'] - 1) * $paramsData['page_size'];
            }

            $ReturnList = $Model_MallOrder
                ->where($WhereOptions)
                ->order($OrderOptionsString)
                ->limit($LimitStart, $paramsData['page_size'])
                ->select();

            $Dict_Order = array(
                'order_id' => 'order_number',
                'vender_id' => '',
                'order_state' => '',
                'order_state_remark' => '',
                'delivery_type' => '',
                'invoice_info' => '',
                'order_remark' => '',
                'order_start_time' => '',
                'order_end_time' => '',
                'consignee_info' => '',
                'item_info_list' => '',
                'vender_remark' => '',
                'pin' => '',
                'return_order' => '',
                'payment_confirm_time' => '',
                'vat_invoice_info' => '',
                'is_Elec' => '',
                'is_Normal' => '',
                'title' => '',
                'modified' => '',
                'parent_order_id' => '',
                'activity_id' => '',
            );

            $Model_MallGood = M("MallGood");
            $Model_Invoice = M("MallInvoice");
            $Model_MallAddress = M("MallAddress");
            foreach ($ReturnList AS $key => $value) {
                $returnOrder = $AddressData = $Temp_RegionData = $returnSubGoods =array();
                $returnOrder['order_id'] = $value['order_number'];
                $returnOrder['vender_id'] = 'partner';
                $returnOrder['order_state'] = 'WAIT_SELLER_STOCK_OUT';
                $returnOrder['order_state_remark'] = '已付款';
                $returnOrder['delivery_type'] = 'any';
                $returnOrder['invoice_info'] = ($value['need_invoice'] == '0') ? '不需要开具发票' : $value['need_invoice'];
                $returnOrder['order_remark'] = $value['note'];
                $returnOrder['order_start_time'] = date("Y-m-d H:i:s", $value['create_time']);
                $returnOrder['order_end_time'] = ($value['complete_time'] > '0') ? date("Y-m-d H:i:s", $value['complete_time']) : 'null';

                $Temp_AddressData = $Model_MallAddress
                    ->where(array('id' => $value['address_id'], 'user_id' => $value['user_id']))
                    ->find();
                $Temp_RegionData = get_region_row($Temp_AddressData['region_id']);

                $AddressData['fullname'] = $Temp_AddressData['name'];
                $AddressData['telephone'] = $Temp_AddressData['telephone'];
                $AddressData['mobile'] = $Temp_AddressData['mobile'];
                $AddressData['full_address'] = $Temp_RegionData['province_name']." ".$Temp_RegionData['city_name']." ".$Temp_RegionData['district_name']." ".$Temp_AddressData['full_address'];
                $AddressData['province'] = $Temp_RegionData['province_name'];
                $AddressData['city'] = $Temp_RegionData['city_name'];
                $AddressData['county'] = $Temp_RegionData['district_name'];

                $returnOrder['consignee_info'] = $AddressData;

                foreach (json_decode($value['cart_data'], true) AS $key2 => $value2) {
                    $GoodDataFromDB = $SubGoods = array();
                    $GoodDataFromDB = $Model_MallGood->where(array('id' => $value2['id']))->field('sku_id,price,sku_name')->find();
                    $SubGoods['sku_id'] = $GoodDataFromDB['sku_id'];
                    $SubGoods['sku_name'] = $GoodDataFromDB['sku_name'];
                    $SubGoods['price'] = convert_money($value2['price']);
                    $SubGoods['ware_id'] = $value2['id'];
                    $SubGoods['tem_total'] = $value2['num'];
                    $returnSubGoods[] = $SubGoods;
                }
                $returnOrder['item_info_list'] = $returnSubGoods;
                $returnOrder['vender_remark'] = $value['sellers_note'];
                $returnOrder['pin'] = $value['user_id'];
                $returnOrder['return_order'] = '0';
                $returnOrder['payment_confirm_time'] = date("Y-m-d H:i:s", $value['pay_time']);
                //发票处理

                if ($value['need_invoice'] != '0') {
                    if ($value['is_normal'] == '1') {
                        $FieldDefinedWithInvoice = 'plain_title,vat_taxpaper_ident  AS taxpaper_ident,vat_registered_address AS registered_address,vat_registered_phone AS registered_phone,vat_deposit_bank AS deposit_bank,vat_bank_account AS bank_account';
                    } else {
                        $FieldDefinedWithInvoice = 'plain_title';

                    }
                    $TempData = $Model_Invoice->where(array('order_number' => $value['order_number']))->field($FieldDefinedWithInvoice)->find();
                    if ($value['is_normal'] == '1') {
                        $returnOrder['vat_invoice_info'] = $TempData;
                        unset($returnOrder['vat_invoice_info']['plain_title']);
                    }
                }

                $returnOrder['title'] = $TempData['plain_title'];
                $returnOrder['is_elec'] = $value['is_elec'];
                $returnOrder['is_normal'] = $value['is_normal'];
                if ($value['need_invoice'] != '0') {
                    if ($value['is_normal'] == '0') {
                        $returnOrder['title'] = $TempData['plain_title'];
                    }
                }

                $returnOrder['modified'] = date("Y-m-d H:i:s",$value['update_time']);
                $returnOrder['parent_order_id'] = '';
                $returnOrder['activity_id'] = '';
                $Temp_OrderInfo = $returnOrder;

                $returnOrdersInfo[] = ($Temp_OrderInfo);
            }
        }
        //定义返回数据
        $returnFlag['success'] = 'true';
        $returnFlag['msg'] = '获取成功';
        $returnFlag['count'] = $CountTotal;
        if ($CountTotal > '0') {
            $returnFlag['orders'] = $returnOrdersInfo;
        }

        header("Content-type: text/html; charset=utf-8");
        echo json_encode($returnFlag);
        exit();
        //return $params['method'];
    }

    /**
     * 修改运单号接口用于实现自有销售平台上订单运单号的修改。
     * 销售平台根据该运单号查询运单的物流详细信息。
     */
    public function modifyLogisticsNo()
    {

        //todo
//        $_POST = $_REQUEST;
        $returnFlag = $SaveData = $returnData = array();
        $this->QueryLog();
        $paramsLimitDefinedArray = array('order_id' => 'str', 'sku_id' => 'str', 'tem_total' => 'intval', 'logistics_id' => 'str', 'waybill' => 'str');

        $this->verifyParams($paramsLimitDefinedArray, $_POST);


        //todo
        $Model_MallOrder = '';
        //判断订单状态是否已完成
        $Model_shipping = M('ShippingRoute');
        $returnData = $Model_shipping->where(array('order_number' => trim($_POST['order_id'])))->find();

//        if ($returnData === NULL) {
            //物流单不存在、创建
            //确认订单是否存在
            $Model_MallOrder = M('MallOrder');
            $OrderData = $Model_MallOrder->where(array('order_number' => trim($_POST['order_id'])))->find();
            if ($OrderData === NULL) {
                $returnFlag['retcode'] = '404';
                $returnFlag['retmessage'] = '订单不存在';
            } else {
                $LogisticsDefinedArray = array(
                    'SF' => 'SFExpress',
                    'WLB' => 'WLB',
                    'CNWL' => 'CNWL',
                );
                $SaveData['way_bill_no'] = trim($_POST['waybill']);
                $SaveData['order_id'] = $OrderData['id'];
                $SaveData['order_number'] = trim($_POST['order_id']);
                $SaveData['logistics_id'] = $LogisticsDefinedArray[trim($_POST['logistics_id'])];
                $SaveData['status'] = '0';
                $SaveData['created_at'] = time();
                $SaveData['ecp_body'] = json_encode($_POST);
                $Model_shipping->data($SaveData)->add();

                //修改订单状态为已发货
                //$Model_MallOrder->where(array('order_number' => $SaveData['order_number']))->setField('order_status', '3');
                $Model_MallOrder->where(array('order_number' => $SaveData['order_number']))->setField(array('delivery_time'=>time(), 'order_status'=>3, 'update_time'=>time()));


                //发送发货模板消息
                $user_info=M('user')->where(array('uid'=>$OrderData['user_id']))->find();

                $lx="both";
                $temp_arr=array(
                    'msg'=>'deliver_msg',
                    'wechat'=>'OPENTM200565259'
                );
                $user_arr=array(
                    'msg'=>$user_info['phone'],
                    'wechat'=>$user_info['openid']
                );
                $msg_arr=array(
                    'msg'=>array(
                        'data'=>array(
                            'order_num'=>$OrderData['order_number'],
                            'express'=>'顺丰速运',
                            'express_num'=>trim($_POST['waybill'])
                        )
                    ),
                    'wechat'=>array(
                        'url'=>HOME_URL.U('Mall/Ucenter/orders'),
                        'data'=>array(
                            'first'=>array('value'=>'尊敬的用户，您的商品已发货'),
                            'keyword1'=>array('value'=>$OrderData['order_number'],'color'=>'#173177'),
                            'keyword2'=>array('value'=>'顺丰速运','color'=>'#173177'),
                            'keyword3'=>array('value'=>trim($_POST['waybill']),'color'=>'#173177'),
                            'remark'=>array('value'=>'请注意查收')
                        )
                    )
                );

                addMessengerQueue($lx,$temp_arr,$user_arr,$msg_arr);



                $returnFlag['retcode'] = '0';
                $returnFlag['retmessage'] = '修改物流号成功!';
            }


//
//        } else {
//            $returnFlag['retcode'] = '503';
//            $returnFlag['retmessage'] = '此物流单异常';
//        }
        header("Content-type: text/html; charset=utf-8");
        echo json_encode($returnFlag);
        exit();

    }



    /**
     * 退款列表接口用于获取销售平台上退款订单列表信息。
     */
    public function getRefundInfo()
    {
        $this->QueryLog();
        $Model_MallRefund = M("MallRefund");

        $optionsWhere = $paramsData = $returnFlag = $subData = $Temp_SubData = array();
        $LimitStart = $Temp_List = $Temp_subXmlData = '';
        if ($_POST['status']) {
            // add by yanhuaitang @ 2015-12-09 14:55, ECP定的是9, 现在改成4就拉
            if($_POST['status'] >= 4){
                $optionsWhere['status'] = intval($_POST['status']);
            }
        }

        $optionsWhere['create_at'] = array('between', strtotime($_POST['apply_time_start']) . ',' . strtotime($_POST['apply_time_end']));
        if ($_POST['check_time_start'] AND $_POST['check_time_end']) {
            $optionsWhere['check_at'] = array('between', strtotime($_POST['check_time_start']) . ',' . strtotime($_POST['check_time_end']));
        }
        $CountTotal = $Model_MallRefund->where($optionsWhere)->count();

        $paramsData['page_index'] = intval($_POST['page_index']);

        if (intval($_POST['page_size']) >= '100') {
            $paramsData['page_size'] = '100';
        } else {
            $paramsData['page_size'] = intval($_POST['page_size']);
        }
        $pageNum = ceil($CountTotal / $paramsData['page_size']);

        if ($paramsData['page_index'] <= '1') {
            $LimitStart = '0';
        } elseif ($paramsData['page_index'] > $pageNum) {
            $LimitStart = ($pageNum - 1) * $paramsData['page_size'];
        } else {
            $LimitStart = ($paramsData['page_index'] - 1) * $paramsData['page_size'];
        }

        $Temp_List = $Model_MallRefund->where($optionsWhere)->limit($LimitStart, $paramsData['page_size'])->select();


        $returnFlag['success'] = 'true';
        $returnFlag['msg'] = "获取退款信息成功！";
        $returnFlag['count'] = $CountTotal;
        if ($CountTotal > '0') {

            foreach ($Temp_List AS $key => $value) {
                $subData['id'] = 'partner_refund_' . $value['id'];
                $subData['buyer_id'] = $value['user_id'];
                $subData['buyer_name'] = $value['user_name'];
                $subData['apple_time'] = date("Y-m-d H:i:s", $value['create_at']);
                $subData['check_time'] = date("Y-m-d H:i:s", $value['check_at']);

                switch ($value['step_status']) {
                    case "first":
                        $subData['apply_refund_sum'] = $value['first_money'];
                        break;
                    case "second":
                        $subData['apply_refund_sum'] = $value['second_money'];
                        break;
                    case "third":
                        $subData['apply_refund_sum'] = $value['third_money'];
                        break;

                }
                $subData['status'] = $value['status'];
                $subData['check_username'] = $value['check_username'];
                $subData['sku_id'] = $value['sku_id'];
                $subData['order_id'] = $value['order_number'];
                $subData['reason'] = '1:' . $value['first_note'] . '; 2:' . $value['second_note'] . '; 3:' . $value['third_note'];
                $subData['desc'] = 'admin:' . $value['admin_note'] . ';1:' . $value['first_admin_note'] . '; 2:' . $value['second_admin_note'] . '; 3:' . $value['third_admin_note'];
                $subData['refundqty'] = $value['refund_num'];
                $Temp_SubData[] = $subData;
//                $Temp_subXmlData .= data_to_xml($Temp_subXmlData);
            }
            $returnFlag['refundinfo'] = $Temp_SubData;
        }
        header("Content-type: text/html; charset=utf-8");
        echo json_encode($returnFlag);
        exit();

    }

    /**
     * 发票信息接口，接收ECP2推来的发票信息和PDF二进制流并存储,参考文档： alibaba.electronic.invoice.upload.pdf
     */
    public function receiveInvoiceInfo()
    {
        $this->QueryLog();
        $paramsData = $returnFlag = $optionsWhere= array();

        $optionsWhere['order_number'] = $_POST['tid'];
        //判断是否已推送


        $InvoiceModel = M("mall_invoice");
        $ThisRecordHistoryData = $InvoiceModel->where($optionsWhere)->find();
            //insert
            $paramsData['serial_no'] = $_POST['serial_no'];
            $paramsData['electronic_invoice_no'] = $_POST['electronic_invoice_no'];
            $paramsData['anti_fake_code'] = $_POST['anti_fake_code'];

            $paramsData['ecp_echo_time'] = time();

            //if (file_put_contents('./invoice_file/' . $paramsData['order_id'] . '.pdf', $_POST['invoice_file_data']) != false) {
            //    unset($_POST['invoice_file_data']);
            //}
            $paramsData['ecp_body'] = json_encode($_POST);


            $InvoiceModel->where($optionsWhere)->save($paramsData);
            $OrderModel = M("MallOrder");
            $ReturnStatus = $OrderModel->where(array('order_number' => $optionsWhere['order_number']))->setField(array('invoice' => '1'));


            $order_info= $OrderModel->where(array('order_number' => $optionsWhere['order_number']))->find();
            $telephone=M('user')->where(array('uid'=>$order_info['user_id']))->getField('phone');

            //增加电子发票通知

            $lx="sms";
            $temp_arr=array(
                'msg'=>'invoice_remind',
            );
            $user_arr=array(
                'msg'=>$telephone,
            );
            $msg_arr=array(
                'msg'=>array(
                    'data'=>array(
                        'order_number'=>$order_info['order_number']
                    )
                ),

            );

            addMessengerQueue($lx,$temp_arr,$user_arr,$msg_arr);



//            if ($ReturnStatus == true) {

                $returnFlag['is_success'] = true;

//            } else {
//                $returnFlag['is_success'] = false;
//                $returnFlag['msg'] = 'modify invoice status failed';
//            }


        header("Content-type: text/html; charset=utf-8");
        echo json_encode($returnFlag);

        exit();

    }

    /**
     * ECP接口连接log
     */
    protected function QueryLog()
    {

        $Log = M("EcpRequestLog");
        $SaveData = array();
        $Temp = debug_backtrace();
        $SaveData['method'] = $Temp[1]['function'];
        $SaveData['create_time'] = date("y-m-d H:i:s");
        $SaveData['query_string'] = json_encode($_REQUEST);
        $Log->add($SaveData);
    }

    protected function verifyParams($ruleDefined, $params)
    {


    }
}