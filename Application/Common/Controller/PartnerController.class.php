<?php
/**
 * 前台控制器基类
 * @author: yanhuaitang
 * @date: 2015/10/13 14:35
 */
namespace Common\Controller;

use Com\Wechat;
use Com\Wechat\TPWechat;
use Com\WechatAuth;
use Think\Controller;

class HomeController extends BaseController
{
//    private $_appId; // 微信appid
//    public $openid;
//    public $wechat;
//
//    public function _initialize()
//    {
//        parent::_initialize();
//
//        $this->_appId = C('APP_ID');
//        $options = array(
//            'appid' => $this->_appId,
//            'appsecret' => C('APP_SECRET'),
//        );
//        $this->wechat = new TPWechat($options);
//
//        // 页面底部js分享
//        $this->wechat->getJsTicket();
//        $signPackage = $this->wechat->getJsSign(get_self_url());
//        $shareScript = $this->_share($signPackage);
//        $this->assign('shareScript', $shareScript);
//
//    }
//
//
//    /**
//     * 快速获取openid
//     * @return string openid
//     */
//    public function getOpenId()
//    {
//        if (empty($this->openid)) {
//            $this->getBaseAuth();
//        }
//        return $this->openid;
//    }
//
//    /**
//     * 获取用户信息
//     * @return array 返回用户信息
//     */
//    public function getUserBasicInfo()
//    {
//        if (empty($this->openid)){
//            $info_array = $this->getUserInfoAuth();
//        }
//
//        if (S('UserInfo_'.$this->openid)){
//            $info_array=S('UserInfo_'.$this->openid);
//            return $info_array;
//        }
//
//        $weixin_user = M("weixin_user");
//        $where['openid'] = $this->openid;
//        $info = $weixin_user->where($where)->find();
//
//        if (!empty($info)) {
//            $info_array = $info;
//        } else {
//            $info_array = $this->getUserInfoAuth();
//            $data['openid'] = $this->openid;
//            $data['nickname'] = $info_array['nickname'];
//            $data['sex'] = $info_array['sex'];
//            $data['city'] = $info_array['city'];
//            $data['country'] = $info_array['country'];
//            $data['province'] = $info_array['province'];
//            $data['language'] = $info_array['language'];
//            $data['headimgurl'] = $info_array['headimgurl'];
//            $data['create_time'] = time();
//            $weixin_user->add($data);
//        }
//
//        S('UserInfo_'.$this->openid,$info_array);
//        return $info_array;
//    }
//
//
//    /**
//     * @param array $params 以数组形式传入参数 可空
//     * @param string $url 自定义跳转网址 可空
//     * @return array        返回数组
//     * @usage            获取openid —— $info_array=$this->getBaseAuth();   $openid=$info_array['openid'];
//     */
//    public function getBaseAuth($params = array(), $url = '')
//    {
//        if (empty($url)) {
//            $url = get_self_url($params, '');
//        }
//
//        $direct = $this->wechat->getOauthRedirect($url, '', 'snsapi_base');
//        if (empty($_GET['code'])) {
//            header('Location:' . $direct);
//            exit;
//        } else {
//            $arr = $this->wechat->getOauthAccessToken();
//            $this->openid = $arr['openid'];
//            return $arr;
//        }
//    }
//
//    /**
//     * @param array $params 以数组形式传入参数 可空
//     * @param string $url 自定义跳转网址 可空
//     * @return array        返回数组
//     * @usage            获取用户信息 —— $user_info=$this->getUserInfoAuth();
//     */
//    public function getUserInfoAuth($params = array(), $url = '')
//    {
//        if (empty($url)) {
//            $url = get_self_url($params, '');
//        }
//
//        $direct = $this->wechat->getOauthRedirect($url, '', 'snsapi_userinfo');
//        if (empty($_GET['code'])) {
//            header('Location:' . $direct);
//            exit;
//        } else {
//            $arr = $this->wechat->getOauthAccessToken();
//            $this->openid = $arr['openid'];
//            $user_info = $this->wechat->getUserInfo($this->openid);
//            return $user_info;
//        }
//    }
//
//
//    /**
//     * 通用微信分享
//     * eg:
//     * 复制到对应模板底部:
//     * <script type="text/javascript">
//        window.shareData = {
//        "moduleName":"Live",
//        "moduleID":"0",
//        "imgUrl": "http://hx.t2.01china.com/logo1.png",
//        "timeLineLink": "http://hx.t2.01china.com/",
//        "sendFriendLink": "http://hx.t2.01china.com/",
//        "weiboLink": "http://hx.t2.01china.com/",
//        "tTitle": "分享测试",
//        "tContent": "分享简介测试"
//        };
//       </script>
//       {$shareScript}
//     * @param $signPackage
//     * @return string
//     */
//    private function _share($signPackage)
//    {
//        return $html = <<<HTML
//            <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
//            <script type="text/javascript">
//                wx.config({
//                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
//                    appId: '{$signPackage['appid']}', // 必填，公众号的唯一标识
//                    timestamp: {$signPackage['timestamp']}, // 必填，生成签名的时间戳
//                    nonceStr: '{$signPackage['noncestr']}', // 必填，生成签名的随机串
//                    signature: '{$signPackage['signature']}',// 必填，签名，见附录1
//                    jsApiList: [
//                        'checkJsApi',
//                         'onMenuShareTimeline',
//                         'onMenuShareAppMessage',
//                         'onMenuShareQQ',
//                         'onMenuShareWeibo',
//                         'openLocation',
//                         'getLocation',
//                         'addCard',
//                         'chooseCard',
//                         'openCard',
//                         'hideMenuItems'
//                    ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
//                });
//                wx.ready(function () {
//                    // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
//                    /*document.querySelector('#checkJsApi').onclick = function () {
//                        wx.checkJsApi({
//                            jsApiList: [
//                                'getNetworkType',
//                                'previewImage'
//                            ],
//                            success: function (res) {
//                            //alert(JSON.stringify(res));
//                        }
//                    });
//                    };*/
//                    // 2. 分享接口
//                    // 2.1 监听“分享给朋友”，按钮点击、自定义分享内容及分享结果接口
//                    wx.onMenuShareAppMessage({
//                    	title: window.shareData.tTitle,
//                    	desc: window.shareData.tContent,
//                    	link: window.shareData.sendFriendLink,
//                    	imgUrl: window.shareData.imgUrl,
//                    	type: '',// 分享类型,music、video或link，不填默认为link
//                    	dataUrl: '',// 如果type是music或video，则要提供数据链接，默认为空
//                    	success: function () {
//                    	    //shareHandle('friend');
//                    	},
//                    	cancel: function () {
//                    		//alert('分享朋友失败');
//                    	}
//                    });
//                    // 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口
//                    wx.onMenuShareTimeline({
//                        title: window.shareData.fTitle? window.shareData.fTitle:window.shareData.tTitle,
//                        link: window.shareData.sendFriendLink,
//                        imgUrl: window.shareData.imgUrl,
//                        success: function () {
//                            //shareHandle('frineds');
//                            //alert('分享朋友圈成功');
//                        },
//                        cancel: function () {
//                            //alert('分享朋友圈失败');
//                        }
//                    });
//                    // 2.4 监听“分享到微博”按钮点击、自定义分享内容及分享结果接口
//                    wx.onMenuShareWeibo({
//                        title: window.shareData.tTitle,
//                        desc: window.shareData.tContent,
//                        link: window.shareData.sendFriendLink,
//                        imgUrl: window.shareData.imgUrl,
//                        success: function () {
//                            //shareHandle('weibo');
//                            //alert('分享微博成功');
//                        },
//                        cancel: function () {
//                            //alert('分享微博失败');
//                        }
//                    });
//                    if(window.shareData.timeline_hide == '1'){
//                        wx.hideMenuItems({
//                            menuList: [
//                                'menuItem:share:timeline', //隐藏分享到朋友圈
//                            ],
//                        });
//                    }
//                    wx.error(function (res) {
//                        if(res.errMsg){
//                            wx.hideOptionMenu();
//                        }
//                    });
//                });
//            </script>
//HTML;
//
//    }
}