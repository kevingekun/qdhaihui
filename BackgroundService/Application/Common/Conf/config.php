<?php
return array(
    //'配置项'=>'配置值'
    
    //首页url
    'HOME_URL' => 'http://hx.t2.01china.com',

    'APP_ID' => '',//wx7fd1d6e2994b9de3
    'APP_SECRET' => '',  //29800262d6d320e58b3195b5da741cfb
    'MCH_id'=>'1253660801',
    'KEY'=>'530843e06e4d1df94ff887a20affc36c',
    'NOTIFY_URL'=>'http://hx.t2.01china.com/index.php/Mall/PayCenter/notify.html',       //在线支付回调地址

    'LOAD_EXT_FILE'      =>'mall,partner,validate',// 加载函数文件
    'LOAD_EXT_CONFIG' 		=> 'config-local',// 加载配置文件
    // 开启SESSION

    //数据库配置信息
    'DB_TYPE'   => 'mysql', // 数据库类型
    'DB_HOST'   => 'localhost', // 服务器地址
    'DB_NAME'   => 'jvyoujia.startsrun.com', // 数据库名
    'DB_USER'   => 'root', // 用户名
    'DB_PWD'    => 'root', // 密码
    'DB_PORT'   => 3306, // 端口
    'DB_PREFIX' => 'hx_', // 数据库表前缀
    'DB_CHARSET'=> 'utf8', // 字符集
    'DB_DEBUG'  =>  true, // 数据库调试模式 开启后可以记录SQL日志 3.2.3新增

    /**
     * 角色权限控制 RBAC
     */
    'USER_AUTH_ON'  =>  true,                   // 是否需要认证
    'USER_AUTH_TYPE'    =>  2,                  // 认证类型 1-登录认证 2-实时认证
    'USER_AUTH_KEY' =>  'uid',               // 认证识别号
    'REQUIRE_AUTH_MODULE'   =>  '',             // 默认需要认证模块
    'NOT_AUTH_MODULE'   =>  '',                 // 默认无需认证模块
    'USER_AUTH_GATEWAY' =>  '/Admin/Login/login',    // 认证网关
    'RBAC_ROLE_TABLE'   =>  'hx_auth_role',          // 角色表名称
    'RBAC_USER_TABLE'   =>  'hx_auth_user',        // 用户表名称
    'RBAC_ACCESS_TABLE' =>  'hx_auth_access',        // 权限表名称
    'RBAC_NODE_TABLE'   =>  'hx_auth_node',          // 节点表名称
    'RBAC_SUPERADMIN'   =>  'admin',//超级管理员名称

    'TMPL_CACHE_ON'     => false,        // 是否开启模板编译缓存,设为false则每次都会重新编译
    'DB_BIND_PARAM'     => true, // 支持参数的自动绑定
    'DATA_CACHE_TYPE'   => 'Memcache', // 设置缓存类型为memcache缓存

    'DEFAULT_MODULE'        =>  'Mall',  // 默认模块

    'DEFAULT_FILTER'        =>  'trim,htmlspecialchars', // 默认参数过滤方法 用于I函数...

    //操作记录日志
    'OPERATION_ON'=>true,// 开启用户记录日志
    'OPERATION_MEMBER'=>'hx_auth_user',
    'OPERATION_TYPE'=>'web',//分别为web,interface也就是网站,和接口
    'OPERATION_MEMBER_ID'=>'uid', //如果后台就取session,如果接口就直接取get,post请求的值

    //redis 配置
    'REDIS_HOST'=>'localhost',      //redis 服务器
    'REDIS_PORT'=>'6379',                 //redis 端口
    'REDIS_AUTH'=>'123456',        //redis 密码

    //队列信息
    'MSG_QUEUE_ERROR_TIMES'=>3,             //消息队列错误退出次数


    //提醒消息限制
    //'PAY_REMIND'=>  30,                 //支付提醒，微信通知，单位分钟
    'PAY_REMIND'=>  1,                 //支付提醒，微信通知，单位分钟
    'COUPON_EXPIRE_REMIND'=>3,           //优惠券过期提醒，短信通知，单位天

    'MSG_ACCOUNT'=>'cf_juyoujia', //短信账户账号
    'MSG_PASSWORD'=>'123456',   //短信账户密码
    'MSG_COMPUTER_IP' => '',    //短信发送允许IP
    'MSG_POST_URL'=>'https://106.ihuyi.com/webservice/sms.php?op=Submit', //短信提交URL

    //短信验证码
    'CODE_EXPIRE_TIME'=> '60',           //验证码有效时间，单位秒
    'CODE_IP_ALLOW_TIMES'=>'5',          //每IP每半小时可发送验证码数量
    'CODE_TEL_DAY_MAX_TIMES'=>'3',            //手机号当日发送验证码总次数
    'CODE_IP_DAY_MAX_TIMES'=>'10',            //IP当日发送验证码总次数

    // 表单令牌验证, 配合 conf/tags.php
    'TOKEN_ON'      =>    true,  // 是否开启令牌验证 默认关闭
    'TOKEN_NAME'    =>    '__hash__',    // 令牌验证的表单隐藏字段名称，默认为__hash__
    'TOKEN_TYPE'    =>    'md5',  //令牌哈希验证规则 默认为MD5
    'TOKEN_RESET'   =>    true,  //令牌验证出错后是否重置令牌 默认为true

    'URL_MODEL'             =>  2,

    // 开启页面trace
    'SHOW_PAGE_TRACE'   => false,
    //
    'PAGE_SIZE' => 25,
);
