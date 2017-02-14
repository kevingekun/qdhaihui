<?php
namespace Org\Pay;

class WxPayNotify extends ApiController
{
    private $values;
    private $key;

    public function __construct($options)
    {

        if (!isset($options['key'])){

            exit('Parameter Missing');

        }

        $this->key = $options['key'];

    }

    /**
     *
     * 支付结果通用通知
     * @param function $callback
     * 直接回调函数使用方法: notify(you_function);
     * 回调类成员函数方法:notify(array($this, you_function));
     * $callback  原型为：function function_name($data){}
     */
    public function notify($callback, &$msg)
    {
        //获取通知的数据
        //$xml = $GLOBALS['HTTP_RAW_POST_DATA'];
        $xml = file_get_contents('php://input');
        //如果返回成功则验证签名
        try {
            $result = $this->Init($xml);
        } catch (Exception $e){
            $msg = $e->getMessage();
            return false;
        }

        return call_user_func($callback, $result);
    }


    /**
     * 将xml转为array
     * @param string $xml
     * @throws WxPayException
     */
    public function Init($xml)
    {
        $this->FromXml($xml);
        $this->CheckSign();
        return $this->values;
    }

    /**
     * 判断签名，详见签名生成算法是否存在
     * @return true 或 false
     **/
    public function IsSignSet()
    {
        return array_key_exists('sign', $this->values);
    }

    /**
     *
     * 检测签名
     */
    public function CheckSign()
    {
        if(!$this->IsSignSet()){
            return true;
        }

        $sign = $this->MakeSign();
        if($this->GetSign() == $sign){
            return true;
        }
        exit("签名错误！");
    }

    /**
     * 获取签名，详见签名生成算法的值
     * @return 值
     **/
    public function GetSign()
    {
        return $this->values['sign'];
    }

    /**
     * 将xml转为array
     * @param string $xml
     * @throws WxPayException
     */
    public function FromXml($xml)
    {
        if(!$xml){
            exit("xml数据异常！");
        }
        //将XML转为array
        //禁止引用外部xml实体
        $this->values = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
        return $this->values;
    }

    /**
     *
     * 回调入口
     * @param bool $needSign  是否需要签名输出
     */
    final public function Handle($needSign = true)
    {
        $msg = "OK";
        $result = $this->notify(array($this, 'NotifyCallBack'), $msg);
        if($result == false){
            $this->values['return_code']="FAIL";
            $this->values['return_msg']=$msg;
            $this->ReplyNotify(false);
            return;
        } else {
            $this->values['return_code']="SUCCESS";
            $this->values['return_msg']="OK";
        }
        $this->ReplyNotify($needSign);
    }

    /**
     *
     * 回调方法入口，子类可重写该方法
     * 注意：
     * 1、微信回调超时时间为2s，建议用户使用异步处理流程，确认成功之后立刻回复微信服务器
     * 2、微信服务器在调用失败或者接到回包为非确认包的时候，会发起重试，需确保你的回调是可以重入
     * @param array $data 回调解释出的参数
     * @param string $msg 如果回调处理失败，可以将错误信息输出到该方法
     * @return true回调出来完成不需要继续回调，false回调处理未完成需要继续回调
     */
    public function NotifyProcess($data, &$msg)
    {
        return true;
    }

    /**
     *
     * notify回调方法，该方法中需要赋值需要输出的参数,不可重写
     * @param array $data
     * @return true回调出来完成不需要继续回调，false回调处理未完成需要继续回调
     */
    final public function NotifyCallBack($data)
    {
        $msg = "OK";
        $result = $this->NotifyProcess($data, $msg);

        if($result == true){
            $this->values['return_code']="SUCCESS"  ;
            $this->values['return_msg']="OK";
        } else {
            $this->values['return_code']="FAIL";
            $this->values['return_msg']=$msg;
        }
        return $result;
    }

    /**
     *
     * 回复通知
     * @param bool $needSign 是否需要签名输出
     */
    final private function ReplyNotify($needSign = true)
    {
        if($needSign == true && $this->values['return_code']=="SUCCESS")
        {
            $this->SetSign();
        }

        if ($this->values['result_code']=="SUCCESS"){
            $order=M("mall_order");
            $data['pay_status']=1;
            $data['pay_time']=time();
            $data['update_time']=time();
            $data['order_status']=2;
            $where['order_number']=$this->values['out_trade_no'];

            $order->where($where)->save($data);

            $info=$order->where($where)->find();
            
            //获取订单地址中的手机号
            $where_id['id'] = $info['address_id'];
            $address = M("mall_address");
            $phone = $address->where($where_id)->getField('mobile');
            $code_style = "buy_ok";
            $order_num = $info['order_number'];
            
            $json_data = $info['cart_data'];
            $de_json = json_decode($json_data,TRUE);
            $count_json = count($de_json);
            $good = M("mall_good");
            $product_name = "";
            for ($i = 0; $i < $count_json; $i++){
            	$good_id['id'] = $de_json[$i]['id'];
            	$good_name = $good->where($good_id)->getField('name');
            	$product_name = $product_name.'【'.$good_name.'】';
            }
            
            //$message = new MessageController();
            //$message = A('Application://api/Message');
            $this->buy_ok($phone,$code_style,$order_num,$product_name);
            

            $openid=M('user')->where(array('uid'=>$info['user_id']))->getField('openid');

            $lx="wechat";
            $temp_arr=array(
                'wechat'=>'OPENTM202183094'
            );
            $user_arr=array(
                'wechat'=>$openid
            );
            $msg_arr=array(

                'wechat'=>array(
                    'url'=>HOME_URL.U('Mall/Ucenter/orderDetail/order_id/'.$info['id'].'/'),
                    'data'=>array(
                        'first'=>array('value'=>'你好，你的商品已支付成功'),
                        'keyword1'=>array('value'=>convert_money($info['real_price']).'元','color'=>'#173177'),
                        'keyword2'=>array('value'=>'商城在线支付','color'=>'#173177'),
                        'keyword3'=>array('value'=>'微信支付','color'=>'#173177'),
                        'keyword4'=>array('value'=>$info['order_number'],'color'=>'#173177'),
                        'keyword5'=>array('value'=>date('Y-m-d H:i:s',time()),'color'=>'#173177'),
                        'remark'=>array('value'=>'你可以到交易记录查看更多信息')
                    )
                )
            );

            addMessengerQueue($lx,$temp_arr,$user_arr,$msg_arr);


        }

        echo $this->ToXml();



//        $myfile = fopen("newfile.txt", "w") or die("Unable to open file!");
//        $txt = json_encode($this->values);
//        fwrite($myfile, $txt);
//        fclose($myfile);
        //$this->replyNotify1($this->ToXml());
    }

    /**
     * 输出xml字符
     * @throws WxPayException
     **/
    public function ToXml()
    {
        if(!is_array($this->values)
            || count($this->values) <= 0)
        {
            exit("数组数据异常！");
        }

        $xml = "<xml>";
        foreach ($this->values as $key=>$val)
        {
            if (is_numeric($val)){
                $xml.="<".$key.">".$val."</".$key.">";
            }else{
                $xml.="<".$key."><![CDATA[".$val."]]></".$key.">";
            }
        }
        $xml.="</xml>";
        return $xml;
    }

    /**
     * 设置签名，详见签名生成算法
     * @param string $value
     **/
    public function SetSign()
    {
        $sign = $this->MakeSign();
        $this->values['sign'] = $sign;
        return $sign;
    }

    /**
     * 生成签名
     * @return 签名，本函数不覆盖sign成员变量，如要设置签名需要调用SetSign方法赋值
     */
    public function MakeSign()
    {
        //签名步骤一：按字典序排序参数
        ksort($this->values);
        $string = $this->ToUrlParams();
        //签名步骤二：在string后加入KEY
        $string = $string . "&key=".$this->key;
        //签名步骤三：MD5加密
        $string = md5($string);
        //签名步骤四：所有字符转为大写
        $result = strtoupper($string);
        return $result;
    }

    /**
     * 格式化参数格式化成url参数
     */
    public function ToUrlParams()
    {
        $buff = "";
        foreach ($this->values as $k => $v)
        {
            if($k != "sign" && $v != "" && !is_array($v)){
                $buff .= $k . "=" . $v . "&";
            }
        }

        $buff = trim($buff, "&");
        return $buff;
    }
    
    public function buy_ok($telephone,$code_style,$orderNum,$product_name){
    	 
    	$code_telephone = M("order_telephone");
    	 
    	$IP = get_client_ip();
    	$now = time();
    	 
    	$data['ip'] = $IP;
    	$data['telephone'] = $telephone;
    	$data['create_time'] = $now;
    	$data['code_style'] = $code_style;
    	$data['expire_time'] = $now;
    	$data['code'] = $orderNum;
    	 
    	$code_telephone->add($data);
    	 
    	$lx = 1;
    	$temp_arr = array('msg' => 'buy_ok');
    	$user_arr = array('msg' => $telephone);
    	$msg_arr = array('msg' => array('data' => array('order_num' => $orderNum,'product_name'=>$product_name)));
    	 
    	$result = $this->sendMsg($lx, $temp_arr, $user_arr, $msg_arr);
    	 
    	$data_log['telephone']=$telephone;
    	$data_log['code_style']=$code_style;
    	$data_log['code']=$orderNum;
    	$data_log['result']=json_encode($result);
    	$data_log['create_time']=time();
    	 
    	M('msg_log')->add($data_log);
    }
    
    

}