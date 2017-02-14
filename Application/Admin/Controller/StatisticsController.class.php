<?php
namespace Admin\Controller;

use Common\Controller\AdminController;

class StatisticsController extends AdminController
{

    public $MemCacheHashKeyName = '';

    public function __initialize()
    {
        $this->MemCacheHashKeyName = C('DB_PREFIX') . '_ADMIN_Statistics_';

    }

    public function index()
    {

        if (IS_POST) {
            $StartDate = I('post.startdate');
            $EndDate = I('post.enddate');

            $StartDate_UnixTime = strtotime($StartDate);
            $EndDate_UnixTime = strtotime($EndDate) + 86399;

            $Model_Statistics_Datawarehouse = M("StatisticsDatawarehouse");
            $CommonData = $Model_Statistics_Datawarehouse->query('select type,sum(value) AS sum_value from ' . C('DB_PREFIX') . 'statistics_datawarehouse where create_time BETWEEN ' . $StartDate_UnixTime . ' AND ' . $EndDate_UnixTime . ' group by type');

            $EchartsPageData = $Model_Statistics_Datawarehouse->query('select type,sum(value) AS sum_value from ' . C('DB_PREFIX') . 'statistics_datawarehouse WHERE type IN (' . "'home','show_good','partner','menu_list','ucenter'" . ') AND create_time BETWEEN ' . $StartDate_UnixTime . ' AND ' . $EndDate_UnixTime . ' group by type');

            $EchartsSourceData = $Model_Statistics_Datawarehouse->query('select type,sum(value) AS sum_value from ' . C('DB_PREFIX') . 'statistics_datawarehouse WHERE type IN (' . "'in_menu','in_qrcode','in_activity','shared_to'" . ') AND create_time BETWEEN ' . $StartDate_UnixTime . ' AND ' . $EndDate_UnixTime . ' group by type');

            $Model_MallOrder = M("MallOrder");
            $OtherData['sum_pay_price'] = round($Model_MallOrder->where(array('pay_status' => '1', 'pay_time' => array('BETWEEN' => array($StartDate_UnixTime, $EndDate_UnixTime))))->sum('real_price') / 100, 2);

        } else {
            $Model_Statistics_Datawarehouse = M("StatisticsDatawarehouse");
            $CommonData = $Model_Statistics_Datawarehouse->query('select type,sum(value) AS sum_value from ' . C('DB_PREFIX') . 'statistics_datawarehouse  group by type');

            $EchartsPageData = $Model_Statistics_Datawarehouse->query('select type,sum(value) AS sum_value from ' . C('DB_PREFIX') . 'statistics_datawarehouse WHERE type IN (' . "'home','show_good','partner','menu_list','ucenter'" . ') group by type');

            $EchartsSourceData = $Model_Statistics_Datawarehouse->query('select type,sum(value) AS sum_value from ' . C('DB_PREFIX') . 'statistics_datawarehouse WHERE type IN (' . "'in_menu','in_qrcode','in_activity','shared_to'" . ') group by type');


            $Model_MallOrder = M("MallOrder");
            $OtherData['sum_pay_price'] = round($Model_MallOrder->where(array('pay_status' => '1'))->sum('real_price') / 100, 2);

        }

        foreach ($CommonData AS $key => $value) {
            $CommonDataResult[$value['type']] = $value['sum_value'];
        }


        foreach ($EchartsPageData AS $key => $value) {
            $EchartsDataPageTemp[$value['type']] = $value['sum_value'];
        }

        $EchartsPageDefinedArray = array('home', 'show_good', 'partner', 'menu_list', 'ucenter');
        foreach ($EchartsPageDefinedArray AS $key => $value) {
            if ($EchartsDataPageTemp[$value]) {
                $EchartsDataPageResult[$value] = $EchartsDataPageTemp[$value];
            } else {
                $EchartsDataPageResult[$value] = '0';
            }
        }

        foreach ($EchartsSourceData AS $key => $value) {
            $EchartsSourceDataTemp[$value['type']] = $value['sum_value'];
        }
        $EchartsSourceDefinedArray = array('in_menu', 'in_qrcode', 'in_activity', 'shared_to');
        foreach ($EchartsSourceDefinedArray AS $key => $value) {
            if ($EchartsSourceDataTemp[$value]) {
                $EchartsSourceDataResult[$value] = $EchartsSourceDataTemp[$value];
            } else {
                $EchartsSourceDataResult[$value] = '0';
            }
        }

        $OtherData['show_pay_rate'] = round($CommonDataResult['pay_success'] / $CommonDataResult['show_good'], '2');


//        var_dump($EchartsSourceDataResult);
//        exit();

        $this->assign('CommonData', $CommonDataResult);
        $this->assign('OtherData', $OtherData);
        $this->assign('EchartsPageData', $EchartsDataPageResult);
        $this->assign('EchartsSourceData', $EchartsSourceDataResult);
        $this->display();
    }

    public function Ajax4Home()
    {

        $this->redis = new \Redis();
        $this->redis->connect(C('REDIS_HOST'), C('REDIS_PORT'));
        $this->redis->auth(C('REDIS_AUTH'));
        $this->redis->select('2');

        $this->Redis_HashKeyName = C('DB_PREFIX') . 'statistics_' . date('Y-m-d') . '_';

        $CommonData['days_pv'] = $this->redis->get($this->Redis_HashKeyName . 'days_pv');
        $CommonData['days_uv'] = $this->redis->get($this->Redis_HashKeyName . 'days_uv');


        $Model_Statistics_Datawarehouse = M("StatisticsDatawarehouse");


        if (S($this->MemCacheHashKeyName . 'yestday_uv')) {
            $CommonData['yestday_uv'] = S($this->MemCacheHashKeyName . 'yestday_uv');
        } else {

            $YestDayYMDArray = explode('-', date('Y-m-d', strtotime('-1 day')));

            $CommonData['yestday_uv'] = $Model_Statistics_Datawarehouse->where(array('year' => $YestDayYMDArray[0], 'month' => $YestDayYMDArray[1], 'day' => $YestDayYMDArray[2], 'type' => 'days_uv'))->order('id DESC')->getField('value');
            S($this->MemCacheHashKeyName . 'yestday_uv', $CommonData['yestday_uv'], '3600');
        }

        $CommonData['uv_yestday_today_growth_rate'] .= round((($CommonData['days_uv'] - $CommonData['yestday_uv']) / $CommonData['yestday_uv']) * 100, '2') . '%';

        $CommonData['days_subscribe'] = $this->redis->get($this->Redis_HashKeyName . 'days_subscribe');
        $CommonData['days_shared_to'] = $this->redis->get($this->Redis_HashKeyName . 'days_shared_to');
        $CommonData['days_click_shared'] = $this->redis->get($this->Redis_HashKeyName . 'days_click_shared');


        $CommonData['days_pay_start'] = $this->redis->get($this->Redis_HashKeyName . 'days_pay_start');


        //首页K线图###########开始##########

        if (S($this->MemCacheHashKeyName . 'admin_home_echarts')) {
            $EchartsData = S($this->MemCacheHashKeyName . 'admin_home_echarts');

        } else {


            $EchartsData = array();
            $EchartsData['tooltip'] = array('trigger' => 'axis');
            $EchartsData['legendp'] = array('datar' => array('浏览PV', '浏览UV', '到店PV', '到店UV'));
            $EchartsData['toolbox'] = array('show' => 'false');
            $EchartsData['lineStyle'] = array('type' => 'dashes');
            $EchartsData['calculable'] = true;
            $EchartsData['yAxis'] = array('type' => 'values');

            //首页K线图###########倒查天数##########
            $TimePeriod = 14;

            for ($i = 0; $i < $TimePeriod; $i++) {
                //生成倒序年月日.

                $TheDay = $TimePeriod - $i;
                $DateTemp = date('Y-m-d', strtotime('-' . $TheDay . ' day'));

                $DateTempArray[] = $DateTemp;
                $NowYMDArray = explode('-', $DateTemp);
                $Uv = $Model_Statistics_Datawarehouse->where(array('year' => $NowYMDArray[0], 'month' => $NowYMDArray[1], 'day' => $NowYMDArray[2], 'type' => 'uv'))->getField('value');
                if (!$Uv) {
                    $Uv = '0';
                }
                $UvArray[] = $Uv;

                $Pv = $Model_Statistics_Datawarehouse->where(array('year' => $NowYMDArray[0], 'month' => $NowYMDArray[1], 'day' => $NowYMDArray[2], 'type' => 'pv'))->getField('value');
                if (!$Pv) {
                    $Pv = '0';
                }
                $PvArray[] = $Pv;

                $Home = $Model_Statistics_Datawarehouse->where(array('year' => $NowYMDArray[0], 'month' => $NowYMDArray[1], 'day' => $NowYMDArray[2], 'type' => 'home'))->getField('value');
                if (!$Home) {
                    $Home = '0';
                }
                $HomeArray[] = $Home;

                $ShowGood = $Model_Statistics_Datawarehouse->where(array('year' => $NowYMDArray[0], 'month' => $NowYMDArray[1], 'day' => $NowYMDArray[2], 'type' => 'show_good'))->getField('value');
                if (!$ShowGood) {
                    $ShowGood = '0';
                }
                $ShowGoodArray[] = $ShowGood;

            }
            //sort($DateTempArray);

            $EchartsData['xAxis'] = array('type' => 'category', 'boundaryGap' => false, 'splitLine' => false, 'data' => $DateTempArray);
            $EchartsData['series'][] = array('name' => '浏览PV', 'smooty' => 'true', 'type' => 'line', 'symbol' => 'circle', 'stack' => '总量', 'data' => $UvArray);
            $EchartsData['series'][] = array('name' => '浏览UV', 'smooty' => 'true', 'type' => 'line', 'symbol' => 'circle', 'stack' => '总量', 'data' => $PvArray);
            $EchartsData['series'][] = array('name' => '首页', 'smooty' => 'true', 'type' => 'line', 'symbol' => 'circle', 'stack' => '总量', 'data' => $HomeArray);
            $EchartsData['series'][] = array('name' => '产品曝光', 'smooty' => 'true', 'type' => 'line', 'symbol' => 'circle', 'stack' => '总量', 'data' => $ShowGoodArray);

            S($this->MemCacheHashKeyName . 'admin_home_echarts', $EchartsData, '7200');

        }
        //首页K线图###########结束##########


        //首页金额类###########开始##########

        if (S($this->MemCacheHashKeyName . 'admin_home_money')) {
            $MoneyData = S($this->MemCacheHashKeyName . 'admin_home_money');

        } else {

            $Model_MallOrder = M("MallOrder");
            $ToDayUnixTimeStart = strtotime(date('Y-m-d'));
            $MoneyData['sum_real_price'] = round($Model_MallOrder->where(array('pay_time' => array('EGT', $ToDayUnixTimeStart)))->sum('real_price') / 100, '2');

            $MoneyData['sum_partner_real_price'] = round($Model_MallOrder->join(C('DB_PREFIX') . 'user ON  ' . C('DB_PREFIX') . 'user.uid = ' . C('DB_PREFIX') . 'mall_order.user_id')->where(array('pay_time' => array('EGT', $ToDayUnixTimeStart), 'check_status' => '9'))->sum('real_price') / 100, '2');
            $MoneyData['sum_fans_real_price'] = round($Model_MallOrder->join(C('DB_PREFIX') . 'user ON  ' . C('DB_PREFIX') . 'user.uid = ' . C('DB_PREFIX') . 'mall_order.user_id')->where(array('pay_time' => array('EGT', $ToDayUnixTimeStart)))->sum('real_price') / 100, '2');
            S($this->MemCacheHashKeyName . 'admin_home_money', $MoneyData, '300');
        }
        //首页金额类###########结束##########


        //首页人数类###########开始##########
        if (S($this->MemCacheHashKeyName . 'admin_home_people')) {
            $PeopleData = S($this->MemCacheHashKeyName . 'admin_home_people');
        } else {
            $Model_User = M("User");
            $PeopleData['new_partner'] = $Model_User->where(array('audit_time' => array('EGT', $ToDayUnixTimeStart), 'partner_status' => '9'))->count('uid');
            $PeopleData['new_fans'] = $Model_User->where(array('subscribe_time' => array('EGT', $ToDayUnixTimeStart)))->count('uid');
            S($this->MemCacheHashKeyName . 'admin_home_people', $PeopleData, '300');

        }

        //首页人数类###########结束##########

        //首页底部排名###########开始##########
        if (S($this->MemCacheHashKeyName . 'admin_home_ranking_list')) {
            $RankingData = S($this->MemCacheHashKeyName . 'admin_home_ranking_list');
        } else {

            $Model_User = M("User");
            $RankingData['fans_ranking'] = $Model_User->query("SELECT uid,nickname, phone,( SELECT COUNT( uid ) FROM " . C('DB_PREFIX') . "user  WHERE invite_id = a.uid) AS field_3 FROM  `" . C('DB_PREFIX') . "user`  AS a  WHERE 1  ORDER BY field_3 DESC,uid ASC LIMIT 0 , 10");

            $MonthStart_UnixTime = strtotime(date('Y-m-01', strtotime('-1 month')));
            $MonthEnd_UnixTime = strtotime(date('Y-m-t', strtotime('-1 month')));
            $Model_CommissionLog = M("CommissionLog");
            $RankingData['month_commission_ranking'] = $Model_CommissionLog->query("SELECT user.uid,user.nickname,user.phone,(select sum(money) ) AS field_3 FROM `" . C('DB_PREFIX') . "commission_log` INNER JOIN " . C('DB_PREFIX') . "user AS user ON user.uid = " . C('DB_PREFIX') . "commission_log.uid WHERE " . C('DB_PREFIX') . "commission_log.create_time BETWEEN $MonthStart_UnixTime AND $MonthEnd_UnixTime  GROUP BY uid  order by field_3 DESC,uid ASC limit 10");

            $RankingData['all_commission_ranking'] = $Model_CommissionLog->query("SELECT user.uid,user.nickname,user.phone,(select sum(money) ) AS field_3 FROM `" . C('DB_PREFIX') . "commission_log` INNER JOIN " . C('DB_PREFIX') . "user AS user ON user.uid = " . C('DB_PREFIX') . "commission_log.uid   GROUP BY uid  order by field_3 DESC,uid ASC limit 10");

            S($this->MemCacheHashKeyName . 'admin_home_ranking_list', $RankingData, 3600);
        }

        //首页底部排名###########结束##########

        $Result = array();
        $Result['echarts'] = $EchartsData;
        $Result['common_data'] = $CommonData;
        $Result['money_data'] = $MoneyData;
        $Result['people_data'] = $PeopleData;
        $Result['rank_data'] = $RankingData;
        echo $this->ajaxReturn($Result);

    }


}
