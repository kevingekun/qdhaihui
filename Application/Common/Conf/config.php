<?php
return array(
    //'配置项'=>'配置值'

    'LOAD_EXT_FILE'      =>'mall,partner,validate',// 加载函数文件
    'LOAD_EXT_CONFIG' 		=> 'base,cookie,database,msg,operation,rbac,redis,session,wechat,config-local',// 加载配置文件

    'TMPL_CACHE_ON'     => false,        // 是否开启模板编译缓存,设为false则每次都会重新编译
    'DB_BIND_PARAM'     => true, // 支持参数的自动绑定

    'DEFAULT_FILTER'        =>  'trim,htmlspecialchars', // 默认参数过滤方法 用于I函数...

    'MSG_QUEUE_ERROR_TIMES'=>3,             //消息队列错误退出次数

    // 表单令牌验证, 配合 conf/tags.php
    'TOKEN_ON'      =>    false,  // 是否开启令牌验证 默认关闭
    'TOKEN_NAME'    =>    '__hash__',    // 令牌验证的表单隐藏字段名称，默认为__hash__
    'TOKEN_TYPE'    =>    'md5',  //令牌哈希验证规则 默认为MD5
    'TOKEN_RESET'   =>    true,  //令牌验证出错后是否重置令牌 默认为true


    'TMPL_ACTION_ERROR' => dirname(__DIR__) . '/Tpl/dispatch_jump.tpl', // 默认错误跳转对应的模板文件
    

);