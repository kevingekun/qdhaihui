<?php
/**
 * 后台控制器基类
 * @author: yanhuaitang
 * @date: 2015/10/13 14:35
 */
namespace Common\Controller;

use Think\Controller;
use Org\Util\Rbac;

class AdminController extends BaseController
{
    /**
     * 自动执行
     */
    public function _initialize()
    {
        parent::_initialize();

        // 用户权限检查
        if (C('USER_AUTH_ON') && !in_array(MODULE_NAME, explode(',', C('NOT_AUTH_MODULE')))) {
            if (!RBAC::AccessDecision()) {
                //检查认证识别号
                if (!$_SESSION [C('USER_AUTH_KEY')]) {
                    // //跳转到认证网关
                    header("Content-type: text/html; charset=utf-8");
                    redirect(PHP_FILE . C('USER_AUTH_GATEWAY'), 2, '您还没登录,正在跳转到登录页...');
                }
                // 没有权限 抛出错误
                if (C('RBAC_ERROR_PAGE')) {
                    // 定义权限错误页面
                    redirect(C('RBAC_ERROR_PAGE'));
                } else {
                    if (C('GUEST_AUTH_ON')) {
                        $this->assign('jumpUrl', PHP_FILE . C('USER_AUTH_GATEWAY'));
                    }
                    // 提示错误信息
                    $this->error(L('_VALID_ACCESS_'));
                }
            }
        }
    }


    public function getOperationRecord()
    {
        //查list;
        import('Org.Msj.OperationRecord');
        $operation_obj = new \Org\Msj\OperationRecord;
        $log_list = $operation_obj->logList(array('member_id' => session('admin_uid')));

        //记录日志
        $operation_obj->writeLog();
    }
}