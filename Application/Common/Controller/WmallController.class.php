<?php
/**
 * Created by PhpStorm.
 * User: gaorenhua
 * Date: 2015/10/16 9:06
 * Email: 597170962@qq.com
 */

namespace Common\Controller;

use Com\Wechat;
use Com\Wechat\TPWechat;
use Common\Model\MallModel;
use Think\Controller;


class WmallController extends BaseController
{
    private $_appId; // 微信appid
    public $openid;
    public $wechat;
    protected $user; // 用户信息

    public function _initialize()
    {
        parent::_initialize();

        $this->_appId = C('APP_ID');
        $options = array(
            'appid' => $this->_appId,
            'appsecret' => C('APP_SECRET'),
        );
        $this->wechat = new TPWechat($options);

        // 页面底部js分享
        $this->wechat->getJsTicket();
        $signPackage = $this->wechat->getJsSign(get_self_url());
        $shareScript = $this->_share($signPackage);
        $this->assign('shareScript', $shareScript);
        //session('uid', 1000);
        if (!session('uid')) {
            $params = array('uid' => I('uid', 0, 'intval'));
            $this->getSessionUid($params);
        }
        //dump($this->getSessionUid($params));die;
        $uid = session('uid');
        $count_in_cart = M('mall_cart')->where(array('uid' => $uid, 'status' => 0))->count();
        $this->assign('count_in_cart', $count_in_cart);

        $menu = M('activity_menu');
        $menu_items = $menu
            ->alias('m')
            ->where('1')
            ->join('hx_activity_menu_item as i on m.item_id = i.id', 'left')
            ->order('priority DESC')
            ->select();
        $menu_items = json_encode($menu_items);
        $this->assign('menu_items', $menu_items);
    }

    /**
     * 将uid存入session
     * @param array $params
     * @return mixed|null
     */

    public function getSessionUid($params = array())
    {
        $openid = session('openid');
        if (empty($openid)) {
            $this->getBaseAuth($params);
            session('openid', $this->openid);
        }

        if (empty($params)) {
            $params = array('uid' => I('uid', 0, 'intval'));
        }

//        // 生成邀请人id
//        $inviteId = I('get.uid', 0, 'intval');
//        $inviteId = create_invite_id($inviteId);

        $this->openid = session('openid');

        if (S('UserInfo_' . $this->openid)) {
            $info_array = S('UserInfo_' . $this->openid);
        } else {
            $weixin_user = M("user");
            $where['openid'] = $this->openid;
            $info = $weixin_user->where($where)->find();

            // 生成邀请人id
            $inviteId = I('get.uid', 0, 'intval');
            $inviteId = create_invite_id($inviteId);

            if (!empty($info)) {
                // 未关注前未获取到全部信息, 现在关注了, 需要重新获取用户信息
                if($info['nickname'] == '' && $info['subscribe_time'] > 0){
                    $info_array = $this->getUserInfoAuth($params);
                    $info['openid'] = $this->openid;
                    $info['nickname'] = $info_array['nickname'] ? $info_array['nickname'] : '';
                    $info['sex'] = $info_array['sex'] ? $info_array['sex'] : '';
                    $info['city'] = $info_array['city'] ? $info_array['city'] : '';
                    $info['country'] = $info_array['country'] ? $info_array['country'] : '';
                    $info['province'] = $info_array['province'] ? $info_array['province'] : '';
                    $info['language'] = $info_array['language'] ? $info_array['language'] : '';
                    $info['headimgurl'] = $info_array['headimgurl'] ? $info_array['headimgurl'] : '';
                    $info['subscribe_time'] = intval($info_array['subscribe_time']);
                    $info['unionid'] = $info_array['unionid'] ? $info_array['unionid'] : '';
                    $info['remark'] = $info_array['remark'] ? $info_array['remark'] : '';
                    $info['groupid'] = intval($info_array['groupid']);
                    $info['invite_id'] = $inviteId;
                    $weixin_user->save($info);
                }
                $info_array = $info;
            } else {
                $info_array = $this->getUserInfoAuth($params);

                $data['openid'] = $this->openid;
                $data['nickname'] = $info_array['nickname'] ? $info_array['nickname'] : '';
                $data['sex'] = $info_array['sex'] ? $info_array['sex'] : '';
                $data['city'] = $info_array['city'] ? $info_array['city'] : '';
                $data['country'] = $info_array['country'] ? $info_array['country'] : '';
                $data['province'] = $info_array['province'] ? $info_array['province'] : '';
                $data['language'] = $info_array['language'] ? $info_array['language'] : '';
                $data['headimgurl'] = $info_array['headimgurl'] ? $info_array['headimgurl'] : '';
                $data['subscribe_time'] = intval($info_array['subscribe_time']);
                $data['unionid'] = $info_array['unionid'] ? $info_array['unionid'] : '';
                $data['remark'] = $info_array['remark'] ? $info_array['remark'] : '';
                $data['groupid'] = intval($info_array['groupid']);
                $data['invite_id'] = $inviteId;
                $data['create_time'] = time();
                $data['client_ip'] = get_client_ip();
                $id = $weixin_user->add($data);
                $info_array['uid'] = $id;
            }

            if($info['nickname'] != ''){
                S('UserInfo_' . $this->openid, $info_array, 300);
            }

        }
        session('uid', $info_array['uid']);

        // 扫描推荐人二维码, 若未关注, 则跳转至关注引导链接
        if(isset($_GET['uid']) && $info['subscribe_time'] == 0){
            $attribute = getAttributeWithType('follow_url');
            $redirectUrl = $attribute['value'] ? $attribute['value'] : HOME_URL;
            redirect($redirectUrl);
        }
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

    /**
     * 获取用户详细信息
     * 调用 $this->getUserBasicInfo
     * @return mixed 返回用户信息数组
     */
    public function getUserBasicInfo()
    {
        $uid = session('uid');
        if (empty($uid)) {
            $this->getSessionUid();
        }

        $this->openid = M('user')->where(array('id' => session('uid')))->getField('openid');

        if (S('UserInfo_' . $this->openid)) {
            $info_array = S('UserInfo_' . $this->openid);
        } else {
            $weixin_user = M("user");
            $where['openid'] = $this->openid;
            $info_array = $weixin_user->where($where)->find();
            S('UserInfo_' . $this->openid, $info_array);
        }
        $this->user = $info_array;
        return $info_array;

    }

//    /**
//     * 获取用户信息
//     * @return array 返回用户信息
//     */
//    public function getUserBasicInfo($params = array())
//    {
//        if (empty($this->openid)) {
//            $info_array = $this->getUserInfoAuth($params);
//            //$this->openid=$this->getOpenId();
//        }
//
//        // 生成邀请人id
//        $inviteId = I('get.uid', 0, 'intval');
//        $inviteId = create_invite_id($inviteId);
//
//
//        if (S('UserInfo_' . $this->openid)) {
//            $info_array = S('UserInfo_' . $this->openid);
//        } else {
//            $weixin_user = M("user");
//            $where['openid'] = $this->openid;
//            $info = $weixin_user->where($where)->find();
//
//            if (!empty($info)) {
//                $info_array = $info;
//            } else {
//                $data['openid'] = $this->openid;
//                $data['nickname'] = $info_array['nickname'] ? $info_array['nickname'] : '';
//                $data['sex'] = $info_array['sex'] ? $info_array['sex'] : '';
//                $data['city'] = $info_array['city'] ? $info_array['city'] : '';
//                $data['country'] = $info_array['country'] ? $info_array['country'] : '';
//                $data['province'] = $info_array['province'] ? $info_array['province'] : '';
//                $data['language'] = $info_array['language'] ? $info_array['language'] : '';
//                $data['headimgurl'] = $info_array['headimgurl'] ? $info_array['headimgurl'] : '';
//                $data['invite_id'] = $inviteId;
//                $data['create_time'] = time();
//                $id = $weixin_user->add($data);
//                $info_array['uid'] = $id;
//            }
//            S('UserInfo_' . $this->openid, $info_array);
//        }
//        $this->user = $info_array;
//        return $info_array;
//    }


    /**
     * @param array $params 以数组形式传入参数 可空
     * @param string $url 自定义跳转网址 可空
     * @return array        返回数组
     * @usage            获取openid —— $info_array=$this->getBaseAuth();   $openid=$info_array['openid'];
     */
    public function getBaseAuth($params = array(), $url = '')
    {
        if (empty($url)) {
            $url = get_self_url($params, '');
        }

        $direct = $this->wechat->getOauthRedirect($url, 'base', 'snsapi_base');
//        file_put_contents("test.log",$_GET['code'].'<br>');
//        file_put_contents("test.log",$_GET['state'].'2333<br>');

//        if (empty($_GET['code'])) {
        if (empty($_GET['code']) || $_GET['state'] != 'base') {
            header('Location:' . $direct);
            exit;
        } else {
            $arr = $this->wechat->getOauthAccessToken();
            $this->openid = $arr['openid'];
            return $arr;
        }
    }

    /**
     * @param array $params 以数组形式传入参数 可空
     * @param string $url 自定义跳转网址 可空
     * @return array        返回数组
     * @usage            获取用户信息 —— $user_info=$this->getUserInfoAuth();
     */
    public function getUserInfoAuth($params = array(), $url = '')
    {
        if (empty($url)) {
            $url = get_self_url($params, '');
        }

        $direct = $this->wechat->getOauthRedirect($url, 'userinfo', 'snsapi_userinfo');

//        file_put_contents("test.log",$_GET['code'].'<br>');
        file_put_contents("test.log", $_GET['state'] . '<br>');
//        if (empty($_GET['code'])) {
        if (empty($_GET['code']) || $_GET['state'] != 'userinfo') {
            header('Location:' . $direct);
            exit;
        } else {
            $arr = $this->wechat->getOauthAccessToken();
            //todo
            $this->openid = $arr['openid'];
            $result = $this->wechat->getUserInfo($this->openid);
            return $result;
        }
    }

    /**
     * 根据订单状态获取订单列表
     * @param $_StatusAuto 状态
     * @param $uid 用户id
     * @param array $_PageData
     * @param string $_SortString
     * @return array|bool
     */
    protected function getOrdersListWithStatus($_StatusAuto, $uid = 0, $_PageData = array('page' => 1, 'size' => 10), $_SortString = 'create_time DESC')
    {
        $returnOrderListArray = array();
        $OrderStatusDictionary = order_status();

        $Model_MallOrder = M('MallOrder');
        if (is_array($_StatusAuto)){
            $optionsWhere['order_status'] = array('IN', $_StatusAuto);
        }else {
            $optionsWhere['order_status'] = $_StatusAuto;
        }
        if ($uid > 0) $optionsWhere['user_id'] = $uid;
        $Temp_ListData = $Model_MallOrder->where($optionsWhere)->page($_PageData['page'], $_PageData['size'])->order(trim($_SortString))->select();

        foreach ($Temp_ListData AS $key => $value) {
            $value['order_status_string'] = $OrderStatusDictionary[$value['order_status']];
            $value['create_time'] = date('Y-m-d H:i:s', $value['create_time']);
            $cartData = json_decode($value['cart_data'], true);
            $total = 0;
            foreach ($cartData AS $key2 => $value2) {
                $Temp_GoodData = $this->getGoodData($value2['id']);
                $good_id = $value2['id'];
                $cartData[$key2]['image'] = $Temp_GoodData['image'];
                $cartData[$key2]['spec'] = $Temp_GoodData['spec'];
                $cartData[$key2]['url'] = U('Mall/Index/detail', array('id' => $value2['id']), true, true);
                $cartData[$key2]['orderDetailUrl'] = U('Mall/Ucenter/orderDetail', array('order_id' => $value['id'], 'good_id' => $good_id), true, true);
                // $total += $value2['price'];  直接获取 订单表的 real_price 真实价格 无需重新计算
                $cartData[$key2]['price'] = convert_money($value2['price']);
            }
            $value['cart_data_list'] = $cartData;
            $value['count'] = count($cartData);
            // $value['total'] = convert_money($total);
            $value['total'] = convert_money($value['real_price']); //直接获取 订单表的 real_price 真实价格 无需重新计算
            $value['orderDetailUrl'] = U('Mall/Ucenter/orderDetail', array('order_id' => $value['id']), true, true);
            $returnOrderListArray[$key] = $value;
        }
        return $returnOrderListArray;
    }

    protected function getGoodData($_GoodID, $_Field = array('name', 'price', 'image', 'spec', 'description'))
    {
        $hashKey = md5($_GoodID . json_encode($_Field));
        $Temp_value = S($hashKey);
        if (!$Temp_value) {
            $Temp_value = M("MallGood")->where(array('id' => $_GoodID))->field($_Field)->find();
            S($hashKey, $Temp_value, 300);
        }
        return $Temp_value;
    }


    /**
     * 通用微信分享
     * eg:
     * 复制到对应模板底部:
     * <script type="text/javascript">
     * window.shareData = {
     * "moduleName":"Live",
     * "moduleID":"0",
     * "imgUrl": "http://hx.t2.01china.com/logo1.png", // 图片链接
     * "timeLineLink": "http://hx.t2.01china.com/", // 朋友圈链接
     * "sendFriendLink": "http://hx.t2.01china.com/", // 发送给朋友链接
     * "weiboLink": "http://hx.t2.01china.com/", // 微博链接
     * "tTitle": "分享测试", // 标题
     * "tContent": "分享简介测试" // 简介
     * };
     * </script>
     * {$shareScript}
     * @param $signPackage
     * @return string
     */
    private function _share($signPackage)
    {
        $statUrl = U('Mall/Index/shareStatistics', '', true, true);
        return $html = <<<HTML
            <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
            <script type="text/javascript">
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: '{$signPackage['appid']}', // 必填，公众号的唯一标识
                    timestamp: {$signPackage['timestamp']}, // 必填，生成签名的时间戳
                    nonceStr: '{$signPackage['noncestr']}', // 必填，生成签名的随机串
                    signature: '{$signPackage['signature']}',// 必填，签名，见附录1
                    jsApiList: [
                        'checkJsApi',
                         'onMenuShareTimeline',
                         'onMenuShareAppMessage',
                         'onMenuShareQQ',
                         'onMenuShareWeibo',
                         'openLocation',
                         'getLocation',
                         'addCard',
                         'chooseCard',
                         'openCard',
                         'hideMenuItems'
                    ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
                wx.ready(function () {
                    // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
                    /*document.querySelector('#checkJsApi').onclick = function () {
                        wx.checkJsApi({
                            jsApiList: [
                                'getNetworkType',
                                'previewImage'
                            ],
                            success: function (res) {
                            //alert(JSON.stringify(res));
                        }
                    });
                    };*/

                    // 2. 分享接口
                    // 2.1 监听“分享给朋友”，按钮点击、自定义分享内容及分享结果接口
                    wx.onMenuShareAppMessage({
                    	title: window.shareData.tTitle,
                    	desc: window.shareData.tContent,
                    	link: window.shareData.sendFriendLink,
                    	imgUrl: window.shareData.imgUrl,
                    	type: '',// 分享类型,music、video或link，不填默认为link
                    	dataUrl: '',// 如果type是music或video，则要提供数据链接，默认为空
                    	success: function () {
                    	    shareHandle('friend');
                    	},
                    	cancel: function () {
                    		//alert('分享朋友失败');
                    	}
                    });
                    // 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口
                    wx.onMenuShareTimeline({
                        title: window.shareData.fTitle? window.shareData.fTitle:window.shareData.tTitle,
                        link: window.shareData.sendFriendLink,
                        imgUrl: window.shareData.imgUrl,
                        success: function () {
                            shareHandle('frineds');
                            //alert('分享朋友圈成功');
                        },
                        cancel: function () {
                            //alert('分享朋友圈失败');
                        }
                    });
                    // 2.4 监听“分享到微博”按钮点击、自定义分享内容及分享结果接口
                    wx.onMenuShareWeibo({
                        title: window.shareData.tTitle,
                        desc: window.shareData.tContent,
                        link: window.shareData.sendFriendLink,
                        imgUrl: window.shareData.imgUrl,
                        success: function () {
                            shareHandle('weibo');
                            //alert('分享微博成功');
                        },
                        cancel: function () {
                            //alert('分享微博失败');
                        }
                    });
                    if(window.shareData.timeline_hide == '1'){
                        wx.hideMenuItems({
                            menuList: [
                                'menuItem:share:timeline', //隐藏分享到朋友圈
                            ],
                        });
                    }
                    wx.error(function (res) {
                        if(res.errMsg){
                            wx.hideOptionMenu();
                        }
                    });
                });
            </script>
            <script>
                function shareHandle(str){
                    $.post('{$statUrl}', {'action':'shared_to','action_txt':str}, function(data){
                        //alert('haha');
                    });
                }
            </script>
HTML;

    }
}
