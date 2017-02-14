<?php


function addMessengerQueue($type, $temp_arr, $user_arr, $msg_arr)
{

    $TypeDefined = array('sms' => '1', 'wechat' => '2', 'both' => '3');


    if (array_key_exists($type, $TypeDefined)) {
        $Model_Redis = new \Redis();
        $Model_Redis->connect(C('REDIS_HOST'), C('REDIS_PORT'));
        $Model_Redis->auth(C('REDIS_AUTH'));


        $arr['lx'] = $TypeDefined[$type];
        $arr['temp_arr'] = $temp_arr;
        $arr['user_arr'] = $user_arr;
        $arr['msg_arr'] = $msg_arr;
        $arr['errortimes'] = 0;
        $arr['create_time'] = time();

        $string = json_encode($arr);
        $Model_Redis->rPush(C('DB_PREFIX') . 'msg_queue', $string);

    } else {
        return false;
    }


}
