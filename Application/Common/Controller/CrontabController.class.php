<?php
/**
 * 后台控制器基类
 * @author: yanhuaitang
 * @date: 2015/10/13 14:35
 */
namespace Common\Controller;

use Com\Wechat;
use Com\Wechat\TPWechat;
use Think\Controller;

class CrontabController extends BaseController
{
    public $openid;
    public $wechat;

    public function _initialize()
    {
        parent::_initialize();

        $options = array(
            'appid' => C('APP_ID'),
            'appsecret' => C('APP_SECRET'),
        );
        $this->wechat = new TPWechat($options);

    }

    /**
     * 快速获取openid
     * @return string openid
     */
    public function getOpenId()
    {
        if (empty($this->openid)) {
            $this->getBaseAuth();
        }
        return $this->openid;
    }

    public function getBaseAuth($params = array(), $url = '')
    {
        if (empty($url)) {
            $url = get_self_url($params, '');
        }

        $direct = $this->wechat->getOauthRedirect($url, '', 'snsapi_base');
        if (empty($_GET['code'])) {
            header('Location:' . $direct);
            exit;
        } else {
            $arr = $this->wechat->getOauthAccessToken();
            $this->openid = $arr['openid'];
            return $arr;
        }
    }


}