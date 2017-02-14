<?php
/**
 * 合伙人相关
 * @author: yanhuaitang
 * @date: 2015/11/2 15:25
 */
namespace Statistics\Controller;

use Common\Controller\CrontabController;

class DailySettlementController extends CrontabController
{

    public $hashKeyName = '';
    public $CommonToDBData = '';


    public function _initialize()
    {


        $this->redis = new \Redis();
        $this->redis->connect(C('REDIS_HOST'), C('REDIS_PORT'));
        $this->redis->auth(C('REDIS_AUTH'));
        $this->redis->select('2');



        if ($this->redis->exists(C('DB_PREFIX') . 'statistics_daily_settlement_run_flag')) {
            $this->SaveLog('Warning:!!!!!!!!!!!!!!!!!!! Daily Settlement Run conflictt');
            exit();
        }

        //todo 测试期间,日期修改为当天
        $this->hashKeyName = C('DB_PREFIX') . 'statistics_' . date('Y-m-d' , strtotime('-1 day'));
//        $this->hashKeyName = C('DB_PREFIX') . 'statistics_' . date('Y-m-d');

        //准备公用数据,减少重复获取
        $this->CommonToDBData = array();
        $this->CommonToDBData['year'] = date('Y');
        $this->CommonToDBData['month'] = date('m');
        $this->CommonToDBData['day'] = date('d');
        $this->CommonToDBData['week'] = date('W');
        $this->CommonToDBData['week_day'] = date('w');

    }


    private function SaveToDB($TypeString,$ValueArray,$KeyNameString){

        $Model_Statistics_DataWarehouse = M('StatisticsDatawarehouse');
        $SaveData = $this->CommonToDBData;
        $SaveData['type'] = $TypeString;
        $SaveData['value'] = $ValueArray;
        $SaveData['create_time'] = time();
        if ($Model_Statistics_DataWarehouse->data($SaveData)->add()){
            $this->redis->del($KeyNameString);
        }





    }

    public function start()
    {
        $this->redis->set(C('DB_PREFIX') . 'statistics_daily_settlement_run_flag',1);
        $this->SaveLog('DailySettlement Start');


        $Pending_Data= $this->redis->keys($this->hashKeyName.'*');

        var_dump($Pending_Data);

        if (count($Pending_Data) <= 0){
            $this->SaveLog('DailySettlement Stop, Pending Data is NULL');
            $this->redis->del(C('DB_PREFIX') . 'statistics_daily_settlement_run_flag');
            exit();
        }


        foreach($Pending_Data AS $KeyNameString){
            $Value_By_KeyNameString = $this->redis->get($KeyNameString);

            $TypeString =  substr($KeyNameString,strlen($this->hashKeyName.'_-----'));


            switch($TypeString){
                case "hot_user":
                    $this->Processor_HOT_USER($KeyNameString);
                    break;
                case "hot_referrer":
                    $this->Processor_HOT_REFERRER($KeyNameString);
                    break;
                case "hot_enter_point":
                    $this->Processor_HOT_ENTER_POINT($KeyNameString);
                    break;
                case "show_good":
                    $this->Processor_HOT_SHOW_GOOD($KeyNameString);
                    break;
                default:
                    $this->SaveToDB($TypeString,$Value_By_KeyNameString,$KeyNameString);
                    break;
            }
            ++$step;
        }


        $this->redis->del(C('DB_PREFIX') . 'statistics_daily_settlement_run_flag');
        $this->SaveLog('DailySettlement End of Run. This Task sorting  record line at '.$step );
    }


    /*
 *
 * 热门商品
 * */
    private function Processor_HOT_SHOW_GOOD($KeyNameString)
    {
        $Pending_Data = $this->redis->ZREVRANGE($KeyNameString,0,-1,'WITHSCORES');

        if (count($Pending_Data) >= 1){

            $Model_Statistics_ObjTable = M('StatisticsHotShowGood');
            $SaveData = $this->CommonToDBData;

            $SaveData['create_time'] = time();

            foreach($Pending_Data AS $key =>$value) {
                ++$step;
                $SaveData['count_num'] = $value;
                $SaveData['value'] = $key;
                $SaveData['sorts_num'] = $step;
                $Model_Statistics_ObjTable->data($SaveData)->add();
            }
        }
        $this->redis->del($KeyNameString);
        return true;

    }
    /*
 *
 * 热门入口
 * */
    private function Processor_HOT_ENTER_POINT($KeyNameString)
    {
        $Pending_Data = $this->redis->ZREVRANGE($KeyNameString,0,-1,'WITHSCORES');

        if (count($Pending_Data) >= 1){

            $Model_Statistics_ObjTable = M('StatisticsHotEnterPoint');
            $SaveData = $this->CommonToDBData;

            $SaveData['create_time'] = time();

            foreach($Pending_Data AS $key =>$value) {
                ++$step;
                $SaveData['count_num'] = $value;
                $SaveData['value'] = $key;
                $SaveData['sorts_num'] = $step;
                $Model_Statistics_ObjTable->data($SaveData)->add();
            }
        }
        $this->redis->del($KeyNameString);
        return true;

    }



    /*
     *
     * 热门来源
     * */
    private function Processor_HOT_REFERRER($KeyNameString)
    {
        $Pending_Data = $this->redis->ZREVRANGE($KeyNameString,0,-1,'WITHSCORES');

        if (count($Pending_Data) >= 1){

            $Model_Statistics_ObjTable = M('StatisticsHotReferrer');
            $SaveData = $this->CommonToDBData;

            $SaveData['create_time'] = time();

            foreach($Pending_Data AS $key =>$value) {
                ++$step;
                $SaveData['count_num'] = $value;
                $SaveData['value'] = $key;
                $SaveData['sorts_num'] = $step;
                $Model_Statistics_ObjTable->data($SaveData)->add();
            }
        }
        $this->redis->del($KeyNameString);
        return true;

    }

    /*
     *
     * 热门用户排序
     * */
    private function Processor_HOT_USER($KeyNameString)
    {
        $Pending_Data = $this->redis->ZREVRANGE($KeyNameString,0,-1,'WITHSCORES');

        if (count($Pending_Data) >= 1){

            $Model_Statistics_ObjTable = M('StatisticsHotUser');
            $SaveData = $this->CommonToDBData;

            $SaveData['create_time'] = time();

            foreach($Pending_Data AS $key =>$value) {
                ++$step;
                $SaveData['count_num'] = $value;
                if (strpos($key, 'openid_') !== false){
                    $SaveData['type'] = 'openid';

                    $SaveData['value'] = substr($key,7);
                }elseif(strpos($key,'uid_') !== false){
                    $SaveData['type'] = 'uid';
                    $SaveData['value'] = substr($key,4);
                }

                $SaveData['sorts_num'] = $step;
                $Model_Statistics_ObjTable->data($SaveData)->add();
            }
        }
        $this->redis->del($KeyNameString);
        return true;

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
