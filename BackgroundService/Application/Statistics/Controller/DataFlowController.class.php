<?php
/**
 * 合伙人相关
 * @author: yanhuaitang
 * @date: 2015/11/2 15:25
 */
//$actionArray = array('subscribe','unsubscribe','submit_order','show_good','shared_to','click_shared','pay_start','pay_success','home');
namespace Statistics\Controller;

use Common\Controller\CrontabController;

class DataFlowController extends CrontabController
{

    public $hashKeyName = '';
    public $dataFlow = array();


    public function _initialize()
    {
        $this->redis = new \Redis();
        $this->redis->connect(C('REDIS_HOST'), C('REDIS_PORT'));
        $this->redis->auth(C('REDIS_AUTH'));
        $this->redis->select('2');
        $this->hashKeyName = C('DB_PREFIX') . 'statistics_' . date("Y-m-d");

        if ($this->redis->exists(C('DB_PREFIX') . 'statistics_dataflow_run_flag')) {
            $this->SaveLog('Error DataFlow Run conflictt');
            exit();
        }
    }


    public function start()
    {
        $this->redis->set(C('DB_PREFIX') . 'statistics_dataflow_run_flag',1);
        $this->SaveLog('DataFlow Start');

        while ($TempData = $this->redis->rpop(C('DB_PREFIX') . 'statistics_dataflow')) {
            $this->dataFlow = array();
            $this->dataFlow = json_decode($TempData, true);
            $this->redis->incr($this->hashKeyName . '_days_pv');
            $this->Processor_UV();
            $this->Processor_ACTION_SORTING();
            $this->Processor_HOT_ENTER_POINT();
            $this->Processor_HOT_REFERRER();

            //todo 测试代码, 上线后删除 .注意要保留计步器
            if ($step == '5000') {
                break;
            } else {
                $step++;
            }
        }

        $this->redis->del(C('DB_PREFIX') . 'statistics_dataflow_run_flag');
        $this->SaveLog('DataFlow End of Run. This Task sorting  record line is '.$step );


    }


    private function Processor_ACTION_SORTING()
    {
        $Action = $this->dataFlow['action'];

        if ($Action != '') {
            $this->redis->incr($this->hashKeyName . '_days_' . $Action);


            switch ($Action) {
//                case "submit_order":
////                    $Result['action_ext'] = $InArray['order_id'];
//                    break;
                case "show_good":
                    $this->Processor_SHOW_GOOD();
                    break;
//                case "shared_to":
//                    $Result['action_ext'] = $InArray['shared_url'];
//                    break;
//                case "click_shared":
//                    $Result['action_ext'] = $InArray['uid'];
//                    $Result['referer_action'] = 'click_shared';
//                    break;
//                case "pay_start":
//                    $this->Processor_PAY_START();
//                    break;
                case "pay_success":
                    $this->Processor_PAY_SUCCESS();
                    break;
            }


        }

    }


    /*
     *
     * 统计支付成功金额
     * */
    private function Processor_PAY_SUCCESS()
    {
        $ExtData = $this->dataFlow['action_ext'];

        $OrderData = $this->GetMallOrderDataArray($ExtData);
        if ($OrderData) {
            $this->redis->incrby($this->hashKeyName . '_days_pay_aggregate', $OrderData['real_price']);
        }
    }


    /*
     *
     * 热门来源排序
     * */
    private function Processor_HOT_REFERRER()
    {
        $this->redis->zincrby($this->hashKeyName . '_temp_hot_referrer', '1', $this->dataFlow['referrer_url']);
    }


    /*
     *
     * 热门入口排序
     * */
    private function Processor_HOT_ENTER_POINT()
    {
        $Action = $this->dataFlow['action'];

        $TempURL = $this->dataFlow['_server']['REQUEST_URI'];
        if ($Action == 'click_shared' AND $this->dataFlow['action_ext'] != '') {
            $TempURL = $this->dataFlow['action_ext'];
        }
        $TempURL = 'http://' . $this->dataFlow['_server']['SERVER_NAME'] . $TempURL;
        $this->redis->zincrby($this->hashKeyName . '_temp_hot_enter_point', '1', $TempURL);
    }

    /*
     *
     * 热销商品排行
     * */
    private function Processor_SHOW_GOOD()
    {
        $ExtData = $this->dataFlow['action_ext'];
        if ($ExtData) {
            $this->redis->zincrby($this->hashKeyName . '_temp_show_good', '1', $ExtData);
        }
    }

    /*
     *
     * UV计算及热心群众排行
     * */

    private function Processor_UV()
    {
        $User = $this->dataFlow['user'];
        if ($this->redis->zscore($this->hashKeyName . '_temp_hot_user', $User) == false) {

            $this->redis->incr($this->hashKeyName . '_days_uv');
        }
        $this->redis->zincrby($this->hashKeyName . '_temp_hot_user', '1', $User);
    }


    public function deleteAll()
    {
        $TempData = $this->redis->keys('*');
        foreach ($TempData AS $key => $value) {
            if ($value != $this->hashKeyName . '_queue') {
                $this->redis->del($value);
                echo "delete this KeyName -> " . $value . "\r\n";
            }
        }
    }

    /*
     * 根据订单号 order_number 取订单数据
     * */

    private function GetMallOrderDataArray($Order_ID)
    {
        $Model_Order = M("MallOrder");
        if ($Order_ID) {
            return $Model_Order->where(array('order_number' => $Order_ID))->find();
        } else {
            return false;
        }
    }




    private function SaveLog($InputString,$ExtArray = '')
    {
        echo date("Y-m-d H:i:s"), ' ';
        echo 'Message:', $InputString, "\r\n";
        if ($ExtArray) {
            echo 'ExtData:', var_export($ExtArray), "\r\n";
            echo '############################', "\r\n";
        }

    }
}
