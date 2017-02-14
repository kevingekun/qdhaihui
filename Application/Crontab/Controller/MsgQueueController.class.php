<?php
namespace Crontab\Controller;

use Common\Controller\CrontabController;
use Org\Pay\WechatPay;

class MsgQueueController extends CrontabController
{

    private $_redisHost;
    private $_redisPort;
    private $redis;

    public function _initialize()
    {
        parent::_initialize();

        $this->_redisHost = C('REDIS_HOST');
        $this->_redisPort = C('REDIS_PORT');

        $this->redis = new \Redis();
        $this->redis->connect($this->_redisHost, $this->_redisPort);

    }

//    public function startQueue()
//    {
//        $this->getBaseAuth();
//        $queue_name = 'msg_queue';
////		$uid=0;
////		$wechat_array['openid']=$this->openid;
////		$wechat_array['url']='';
////		$wechat_array['data']['result']='我们已收到您的领奖信息，请再次确认信息无误';
////		$wechat_array['data']['withdrawMoney']='15000元';
////		$wechat_array['data']['withdrawTime']='2015-10-19';
////		$wechat_array['data']['cardInfo']='中国银行(账号：62178****6061)';
////		$wechat_array['data']['arrivedTime']='预计到账时间3个工作日';
////		$wechat_array['data']['remark']='如有疑问请联系食在客服';
////		$temp_code='TM00012';
////
////		$this->redis->delete($queue_name);
////		$this->AddQueue($queue_name,$uid,$wechat_array,$temp_code);
//
//        $this->runQueue($queue_name);
//
//
//    }

    /**
     * 运行队列
     * @param $queue_name 队列名称
     */
    public function runQueue($queue_name)
    {
        $queue_size = $this->redis->lSize($queue_name);
        //$this->redis->delete($queue_name);
        if ($queue_size == 0) {

            exit('no queue to run');

        } else {

            $string = $this->redis->lPop($queue_name);
            $Now_array = json_decode($string, true);

            $lx = $Now_array['lx'];
            $temp_arr = $Now_array['temp_arr'];
            $user_arr = $Now_array['user_arr'];
            $msg_arr = $Now_array['msg_arr'];

            $result = $this->sendMsg($lx, $temp_arr, $user_arr, $msg_arr);

            if ($result['code'] == 1) {

                if ($Now_array['errortimes'] + 1 < C('MSG_QUEUE_ERROR_TIMES')) {

                    $Now_array['errortimes'] += 1;

                    $this->redis->rPush($queue_name, $Now_array);

                }

            }
            echo "ok";
            exit;

        }

    }


//    public function testpay()
//    {
//
//        $options = array(
//
//            'appid' => C('APP_ID'),
//            'appsecret' => C('APP_SECRET'),
//            'mchid' => C('MCH_ID'),
//            'key' => C('KEY'),
//
//
//        );
//        $pay = new WechatPay($options);
//
//        $openid = $this->getOpenId();
//
//        var_dump($openid);
//        exit;
//
//
//    }
//
//    public function test()
//    {
//
//        $this->display();
////		import('Org.Net.GetMac');
////		$getMac = new \Getmac(PHP_OS);
////		echo $getMac->macAddr;
//
////		$lx="1";
////		$temp_arr=array('msg'=>'reg_msg');
////		$user_arr=array('msg'=>'15288838788');
////		$msg_arr=array(
////			'msg'=>array(
////				'data'=>array(
////					'verify_code'=>'1234'
////				)
////			)
////		);
////
////		$result=$this->sendMsg($lx,$temp_arr,$user_arr,$msg_arr);
////
////		var_dump($result);
//
//    }


}


