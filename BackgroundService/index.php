<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2014 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
// 应用入口文件

// 检测PHP环境
if (version_compare(PHP_VERSION, '5.3.0', '<')) die('require PHP > 5.3.0 !');

// 开启调试模式 建议开发阶段开启 部署阶段注释或者设为false
define('APP_DEBUG', true);

//网站首页url
define('HOME_URL', 'http://jvyoujia.startsrun.com');

// 定义应用目录
define('APP_PATH', './Application/');

//定义模板目录
#define('TMPL_PATH', '../Tpl/');

//新建模块
//define('BIND_MODULE','Msgqueue');
//define('BIND_MODULE','Mall');

// 引入composer下载的包
require './vendor/autoload.php';


// 引入ThinkPHP入口文件
require '../ThinkPHP/ThinkPHP.php';

// 亲^_^ 后面不需要任何代码了 就是如此简单
