<?php
define('DS', DIRECTORY_SEPARATOR);
require dirname(__FILE__) . DS . 'vendor' . DS . 'autoload.php';
date_default_timezone_set('PRC');

error_reporting(E_ALL);

$crontab_config = [
    'closeOrder' => [
        'name' => '自动关闭订单',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/Mall/closeOrder',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/closeOrder.log',
        'time' => '* * * * *'
    ],
    'logisticsRoute' => [
        'name' => '自动抓取路由信息',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Logistics/Route/updateRoutes',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/updateRoutes.log',
        'time' => '*/20 * * * *'
    ],
    'messageRemindByDay' => [
        'name' => '模板消息队列1',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/OrderQueue/couponRemind',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/couponRemind.log',
        'time' => '* * */1 * *'
    ],
    'messageRemindByMinute' => [
        'name' => '模板消息队列2',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/OrderQueue/payRemind',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/payRemind.log',
        'time' => '* * * * *'
    ],
    'messageRemindByMinute2' => [
        'name' => '模板消息队列3',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/MsgQueue/startQueue',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/startQueue.log',
        'time' => '* * * * *'
    ],
//    'mysqlBak' => [
//        'name' => 'mysql自动备份',
//        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/Mall/closeOrder',
//        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/test.log',
//        'time' => '* */1 * * *'
//    ],
    'productCommission' => [
        'name' => '自动计算销售佣金',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/Commission/productCommission',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/productCommission.log',
        'time' => '* * * * *'
    ],
    'redisQueue' => [
        'name' => 'Redis队列',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/MsgQueue/startQueue',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/startQueue.log',
        'time' => '* * * * *'
    ],
    'remindPay' => [
        'name' => '自动提醒付款',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/Mall/remindPay',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/remindPay.log',
        'time' => '* * * * *'
    ],
    'spreadCommission' => [
        'name' => '自动计算推广佣金',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Crontab/Commission/spreadCommission',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/spreadCommission.log',
        'time' => '* * * * *'
    ],
    'statistics' => [
        'name' => '自动分析统计信息入库',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Statistics/DataFlow/start',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/start.log',
        'time' => '* * * * *'
    ],
    'timingOffTheShelf' => [
        'name' => '商品自动下架',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Logistics/Mall/timingOffTheShelf',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/timingOffTheShelf.log',
        'time' => '* * * * *'
    ],
    'timingOnTheShelf' => [
        'name' => '商品自动下架',
        'cmd' => 'curl http://cron_p1.hehuofa.com:8080/Logistics/Mall/timingOnTheShelf',
        'output' => '/qqdata/data/www/partner001/BackgroundService/Logs/timingOnTheShelf.log',
        'time' => '* * * * *'
    ],
];

$crontab_server = new \Jenner\Zebra\Crontab\Crontab($crontab_config, '/data/www/partner001/BackgroundService/Logs/test.log');
$crontab_server->start();
