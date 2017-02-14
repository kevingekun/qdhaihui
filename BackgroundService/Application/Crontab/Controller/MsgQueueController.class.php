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
        $this->redis->auth(C('REDIS_AUTH'));

    }

    public function startQueue()
    {
        $queue_name = C('DB_PREFIX').'msg_queue';
        echo $queue_name, "\r\n";
        $this->runQueue($queue_name);
    }

    /**
     * 运行队列
     * @param $queue_name 队列名称
     */
    public function runQueue($queue_name)
    {

        $queue_size = $this->redis->lSize($queue_name);

        $queue=S('queue_'.$queue_name);

        if (!empty($queue)){
            echo "queue is running", "\r\n";
            exit;
        }
        S('queue_'.$queue_name,'run');
//        var_dump($queue_size);
        //$this->redis->delete($queue_name);
        if ($queue_size == 0) {

            S('queue_'.$queue_name,NULL);
            echo "no queue to run";
            exit;

        } else {

            while($queue_size!=0){

                $string = $this->redis->lPop($queue_name);
                $Now_array = json_decode($string, true);

                $lx = $Now_array['lx'];
                $temp_arr = $Now_array['temp_arr'];
                $user_arr = $Now_array['user_arr'];
                $msg_arr = $Now_array['msg_arr'];

                $result = $this->sendMsg($lx, $temp_arr, $user_arr, $msg_arr);

                file_put_contents('./msgqueue.log', json_encode($result) . "\n\n", FILE_APPEND);

                if ($result['code'] == 1) {

                    if ($Now_array['errortimes'] + 1 < C('MSG_QUEUE_ERROR_TIMES')) {

                        $Now_array['errortimes'] += 1;

                        $this->redis->rPush($queue_name, $Now_array);

                    }else{

                        //超过次数 入库
                        $data['lx']=$Now_array['lx'];
                        $data['temp_arr']=$Now_array['temp_arr'];
                        $data['user_arr']=$Now_array['user_arr'];
                        $data['msg_arr']=$Now_array['msg_arr'];
                        $data['create_time']=time();
                        $data['status']=0;

                        M('msg_queue_error')->add($data);

                    }

                }

                echo "ok";

                $queue_size = $this->redis->lSize($queue_name);
//                var_dump($queue_size);



            }


            S('queue_'.$queue_name,NULL);
            exit;

        }

    }


}


