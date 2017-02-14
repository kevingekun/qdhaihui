<?php
namespace Org\Pay;

class WechatPay{

    private $appid;
    private $appsecret;
    private $mchid;
    private $key;
    private $curl_proxy_host;
    private $curl_proxy_port;
    private $values;
    private $notify;

    public function __construct($options)
    {

        if (!isset($options['appid']) || !isset($options['appsecret']) || !isset($options['mchid']) || !isset($options['key'])){

            exit('Parameter Missing');

        }

        $this->appid = $options['appid'];
        $this->appsecret = $options['appsecret'];
        $this->mchid = $options['mchid'];
        $this->key = $options['key'];
        $this->curl_proxy_host=$options['curl_proxy_host'];
        $this->curl_proxy_port=$options['curl_proxy_port'];
        $this->notify=$options['notify'];

    }

    public function unifiedOrder($data,$time=0){

        $this->values['body']=$data['body'];
        $this->values['attach']=$data['attach'];
        $this->values['out_trade_no']=$data['out_trade_no'];
        $this->values['total_fee']=$data['total_fee'];
        $this->values['notify_url']=$this->notify;

        if ($time!=0){
            $this->values['time_start']=date("YmdHis");
            $this->values['time_expire']=date("YmdHis", time() + $time);
        }
        
        $this->values['trade_type']='JSAPI';
        $this->values['product_id']=$data['product_id'];
        $this->values['openid']=$data['openid'];

        $url = "https://api.mch.weixin.qq.com/pay/unifiedorder";
        //检测必填参数
        if(!$this->check_set('out_trade_no')) {
            exit("缺少统一支付接口必填参数out_trade_no！");
        }else if(!$this->check_set('body')){
            exit("缺少统一支付接口必填参数body！");
        }else if(!$this->check_set('total_fee')) {
            exit("缺少统一支付接口必填参数total_fee！");
        }else if(!$this->check_set('trade_type')) {
            exit("缺少统一支付接口必填参数trade_type！");
        }

        //关联参数
        if($this->values['trade_type']== "JSAPI" && !$this->check_set('openid')){
            exit("统一支付接口中，缺少必填参数openid！trade_type为JSAPI时，openid为必填参数！");
        }

        $this->values['appid']=$this->appid;
        $this->values['mch_id']=$this->mchid;
        $this->values['spbill_create_ip']=$_SERVER['REMOTE_ADDR'];


        $this->values['nonce_str']=$this->getNonceStr();
        $this->values['sign']='';

        //ǩ��
        $this->SetSign();
        $xml = $this->ToXml();

//        $startTimeStamp = $this->getMillisecond();//请求开始时间
        $response = $this->postXmlCurl($xml, $url, false, 30);

        $result = $this->Init($response);

        return $result;

    }

    public function GetJsApiParameters($UnifiedOrderResult)
    {
        $this->values=array();

        if(!array_key_exists("appid", $UnifiedOrderResult)
            || !array_key_exists("prepay_id", $UnifiedOrderResult)
            || $UnifiedOrderResult['prepay_id'] == "")
        {
            exit("parameters error");
        }

        $this->values['appId']=$UnifiedOrderResult["appid"];
        $timeStamp = time();
        $this->values['timeStamp']=(string)$timeStamp;
        $this->values['nonceStr']=$this->getNonceStr();
        $this->values['package']="prepay_id=" . $UnifiedOrderResult['prepay_id'];
        $this->values['signType']="MD5";
        $this->values['paySign']=$this->MakeSign();
        $parameters = json_encode($this->values);
        return $parameters;
    }

    /**
     * 检测设置
     * @param $key
     * @return bool
     */
    public function check_set($key)
    {
        return array_key_exists($key, $this->values);
    }

    /**
     *
     * 产生随机字符串，不长于32位
     * @param int $length
     * @return 产生的随机字符串
     */
    public function getNonceStr($length = 32)
    {
        $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
        $str ="";
        for ( $i = 0; $i < $length; $i++ )  {
            $str .= substr($chars, mt_rand(0, strlen($chars)-1), 1);
        }
        return $str;
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
     * 输出xml字符
     * @throws WxPayException
     **/
    public function ToXml()
    {
        if(!is_array($this->values)
            || count($this->values) <= 0)
        {
           exit("���������쳣��");
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
     * 以post方式提交xml到对应的接口url
     *
     * @param string $xml  需要post的xml数据
     * @param string $url  url
     * @param bool $useCert 是否需要证书，默认不需要
     * @param int $second   url执行超时时间，默认30s
     * @throws WxPayException
     */
    private function postXmlCurl($xml, $url, $useCert = false, $second = 30)
    {
        $ch = curl_init();
        //设置超时
        curl_setopt($ch, CURLOPT_TIMEOUT, $second);

//        //如果有配置代理这里就设置代理
//        if(WxPayConfig::CURL_PROXY_HOST != "0.0.0.0"
//            && WxPayConfig::CURL_PROXY_PORT != 0){
//            curl_setopt($ch,CURLOPT_PROXY, WxPayConfig::CURL_PROXY_HOST);
//            curl_setopt($ch,CURLOPT_PROXYPORT, WxPayConfig::CURL_PROXY_PORT);
//        }
        curl_setopt($ch,CURLOPT_URL, $url);
        curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,FALSE);
        curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,FALSE);
        //设置header
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        //要求结果为字符串且输出到屏幕上
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);

//        if($useCert == true){
//            //设置证书
//              //使用证书：cert 与 key 分别属于两个.pem文件
//            curl_setopt($ch,CURLOPT_SSLCERTTYPE,'PEM');
//            curl_setopt($ch,CURLOPT_SSLCERT, WxPayConfig::SSLCERT_PATH);
//            curl_setopt($ch,CURLOPT_SSLKEYTYPE,'PEM');
//            curl_setopt($ch,CURLOPT_SSLKEY, WxPayConfig::SSLKEY_PATH);
//        }
        //post提交方式
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);
        //运行curl
        $data = curl_exec($ch);
        //返回结果
        if($data){
            curl_close($ch);
            return $data;
        } else {
            $error = curl_errno($ch);
            curl_close($ch);
            exit("curl出错，错误码:$error");
        }
    }


    /**
     * ��xmlתΪarray
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
     *
     * 检测签名
     */
    public function CheckSign()
    {
        if(!$this->check_set('sign')){
            return true;
        }

        $sign = $this->MakeSign();
        if($this->values['sign'] == $sign){
            return true;
        }
        exit("签名错误！");
    }

}