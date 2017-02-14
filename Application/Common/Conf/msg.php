<?php
return array(
    //短信账户
    'MSG_ACCOUNT'=>'cf_juyoujia', //短信账户账号
    'MSG_PASSWORD'=>'3704b9ef5fda37dbdd8440a1a0692800',   //短信账户密码
    'MSG_COMPUTER_IP' => '',    //短信发送允许IP
    'MSG_POST_URL'=>'http://106.ihuyi.cn/webservice/sms.php?method=Submit', //短信提交URL


    //短信验证码
    'CODE_EXPIRE_TIME'=> '60',           //验证码有效时间，单位秒
    'CODE_IP_ALLOW_TIMES'=>'100',          //每IP每半小时可发送验证码数量
    'CODE_TEL_DAY_MAX_TIMES'=>'100',            //手机号当日发送验证码总次数
    'CODE_IP_DAY_MAX_TIMES'=>'100',            //IP当日发送验证码总次数
);