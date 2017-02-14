<?php
return array(
    //操作记录日志
    'OPERATION_ON'=>true,// 开启用户记录日志
    'OPERATION_MEMBER'=>'hx_auth_user',
    'OPERATION_TYPE'=>'web',//分别为web,interface也就是网站,和接口
    'OPERATION_MEMBER_ID'=>'uid', //如果后台就取session,如果接口就直接取get,post请求的值
);