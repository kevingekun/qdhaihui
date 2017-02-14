<?php

/**
 * 用户登录验证模型
 * User: gaorenhua
 * Date: 2015/10/14 9:37
 * Email: 597170962@qq.com
 */
namespace Admin\Model;
use Common\Model\AdminModel;

class LoginModel extends AdminModel
{
    // 重新定义表
    protected $tableName = 'auth_user';

    /**
     * 自动验证
     * self::EXISTS_VALIDATE 或者0 存在字段就验证（默认）
     * self::MUST_VALIDATE 或者1 必须验证
     * self::VALUE_VALIDATE或者2 值不为空的时候验证
     */
    protected $_validate = array(
        array('username', 'require', '用户名不能为空！'), //默认情况下用正则进行验证
        array('password', 'require', '登录密码不能为空！'), // 默认情况下用正则进行验证
        array('verify', 'verify_check', '验证码错误', 0, 'function'), // 判断验证码是否正确
    );

    /**
     * 自动完成
     */
    protected $_auto = array (
        /* 登录的时候自动完成 */
        array('password', 'md5', 3, 'function') , // 对password字段使用md5函数处理
        array('lastdate', 'time', 1, 'function'), // 对lastdate字段在登录的时候写入当前时间戳
        array('lastip', 'get_client_ip', 1, 'function'), // 对lastip字段在登录的时候写入当前登录ip地址
    );

}