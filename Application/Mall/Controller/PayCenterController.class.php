<?php
namespace Mall\Controller;

use Common\Controller\BaseController;
use Org\Pay\WechatPay;
use Org\Pay\WxPayNotify;

class PayCenterController extends BaseController{

    public function _initialize()
    {
        parent::_initialize();

    }

    public function notify(){

        //传入基本参数
        $options=array(
            'key'=>C('KEY'),
        );

        $notify = new WxPayNotify($options);
        $notify->Handle(false);

    }

    public function getParameters(){

        //传入基本参数
        $options=array(
            'appid'=>C('APP_ID'),
            'appsecret'=>C('APP_SECRET'),
            'mchid'=>C('MCH_id'),
            'key'=>C('KEY'),
            'notify'=>C('NOTIFY_URL'),
        );

        $pay = new WechatPay($options);

        $data['body']='test';
        $data['attach']='test';
        $data['total_fee']='1';
        $data['goods_tag']='test';
        $data['openid']=$this->getOpenId();
        $data['out_trade_no']='';

        $order=$pay->unifiedOrder($data);

        $jsApiParameters = $pay->GetJsApiParameters($order);

        $this->assign('jsApiParameters',$jsApiParameters);

        $this->display();


    }

    public function payNow(){
        $id=$_POST['id'];
        $record=M('mall_order')->where(array('id'=>$id))->find();

        if ($record['user_id']!=session('uid')){
            $return_array=array('code'=>1,'msg'=>'信息不匹配，请重试');
            return $return_array;
        }

        if ($record['pay_status']==1 || $record['order_status']==2){
            $return_array=array('code'=>1,'msg'=>'订单已支付，请勿重复支付！');
            return $return_array;
        }

        $openid=M('user')->where(array('uid'=>session('uid')))->getField('openid');

        //发起支付，传入基本参数
        $options=array(
            'appid'=>C('APP_ID'),
            'appsecret'=>C('APP_SECRET'),
            'mchid'=>C('MCH_id'),
            'key'=>C('KEY'),
            'notify'=>C('NOTIFY_URL'),
        );

        $pay = new WechatPay($options);

        $data1['body']='在线商城购物订单';
        $data1['attach']='订单号：'.$record['order_number'];
        //$data1['total_fee']=1;
        $data1['total_fee']=$record['real_price'];
        $data1['goods_tag']='在线商城购物订单';
        $data1['openid']=$openid;
        $data1['out_trade_no']=$record['order_number'];

        $order=$pay->unifiedOrder($data1);
        $jsApiParameters = $pay->GetJsApiParameters($order);

        $json['status']='1';
        $json['remark']=$jsApiParameters;
        $this->ajaxReturn($json);

    }

    public function index()
    {

        //传入基本参数
        $options=array(
            'appid'=>C('APP_ID'),
            'appsecret'=>C('APP_SECRET'),
            'mchid'=>C('MCH_id'),
            'key'=>C('KEY'),
            'notify'=>C('NOTIFY_URL'),
        );

        $pay = new WechatPay($options);

        $data['body']='test';
        $data['attach']='test';
        $data['total_fee']='1';
        $data['goods_tag']='test';
        $data['openid']=$this->getOpenId();
        $data['out_trade_no']='';

        $order=$pay->unifiedOrder($data);

        $jsApiParameters = $pay->GetJsApiParameters($order);

        $this->assign('jsApiParameters',$jsApiParameters);

        $this->display();


    }

}