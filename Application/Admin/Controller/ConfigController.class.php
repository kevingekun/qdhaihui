<?php
/**
 * 通用配置文件控制器.
 * User: gaorenhua
 * Email: gaorenhua0812@gmail.com
 * Date: 2016/3/18 14:57
 */

namespace Admin\Controller;
use Common\Controller\AdminController;

class ConfigController extends AdminController
{
    /**
     * 基本配置
     */
    public function index()
    {
        $this->display();
    }

    /**
     * 微信配置
     */
    public function wechat()
    {
        $this->display();
    }

    /**
     * Session/缓存配置
     */
    public function session()
    {
        $this->display();
    }

    /**
     * Cookie配置
     */
    public function cookie()
    {
        $this->display();
    }

    /**
     * 数据库配置
     */
    public function database()
    {
        $this->display();
    }

    /**
     * 权限控制配置
     */
    public function rbac()
    {
        $this->display();
    }

    /**
     * 日志配置
     */
    public function operation()
    {
        $this->display();
    }

    /**
     * redis配置
     */
    public function redis()
    {
        $this->display();
    }

    /**
     * 短信配置
     */
    public function msg()
    {
        $this->display();
    }

    /**
     * 更新配置文件
     */
    public function updateConfig()
    {
        if (!IS_POST) $this->error('您访问的页面不存在，请稍后再试');

        // 提取配置信息
        $data = I('post.');

        // 处理个别配置项
        foreach ($data as $k => $v) {
            if (in_array($k, array('SHOW_PAGE_TRACE','COOKIE_SECURE','DB_DEBUG','OPERATION_ON','USER_AUTH_ON'))) $data[$k] = $v ? true : false;
        }

        $filename = $data['file'];
        unset($data['file']);

        // 写入配置文件
        if (FF($filename, $data, CONF_PATH)) {
            $this->success('修改成功');
        } else {
            $this->error('修改失败');
        }
    }
}