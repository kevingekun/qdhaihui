<?php
return array(
    //数据库配置信息
    'DB_TYPE'   => 'mysql', // 数据库类型
    'DB_HOST'   => '192.168.1.193', // 服务器地址
    'DB_NAME'   => 'jvyoujia_trunk', // 数据库名
    'DB_USER'   => 'root', // 用户名
    'DB_PWD'    => 'qingdao', // 密码
    'DB_PORT'   => 3306, // 端口
    'DB_PREFIX' => 'hx_', // 数据库表前缀
    'DB_CHARSET'=> 'utf8', // 字符集
    'DB_DEBUG'  =>  true, // 数据库调试模式 开启后可以记录SQL日志 3.2.3新增

    'SESSION_PREFIX'   =>  'sess_', // session前缀
    'SESSION_TYPE'     => 'Memcache', //session保存至memcache
    'SESSION_EXPIRE'   => '1800', //过期时间
    'MEMCACHE_HOST'    => '192.168.1.193', //Memcache host
    'MEMCACHE_PORT' => 11211, //Memcache端口
    'DATA_CACHE_PREFIX' => 'mem_jvyoujia_partner_com', // 缓存前缀
    'DATA_CACHE_TYPE'   => 'Memcache', // 设置缓存类型为memcache缓存

    //redis 配置
    'REDIS_HOST'    =>'192.168.1.193',   //redis 服务器
    'REDIS_PORT'    =>'6379',        //redis 端口
    'REDIS_AUTH'    =>'qingdao0532', //redis 密码
);