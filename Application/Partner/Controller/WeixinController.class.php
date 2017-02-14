<?php
namespace Partner\Controller;

use Com\Wechat\TPWechat;
use Think\Controller;

/**
 * 微信交互url
 * Class WeixinController
 * @package Partner\Controller
 */
class WeixinController extends Controller
{
    private $options;

    public function _initialize()
    {
        $this->options = array(
            'appid' => C('APP_ID'),//'wx7fd1d6e2994b9de3',
            'appsecret' => C('APP_SECRET'),//'29800262d6d320e58b3195b5da741cfb',
            'token' => C('APP_TOKEN'),//'ab21e6c443ef36bd0de2e353c809aefe',
            'encodingaeskey' => C('APP_KEY'),//'fFeZWx24N6Xca2ev1qiAFQmRjBY18m2WXsv7M4TCo96'
        );
    }

    /**
     * 微信消息接口入口
     * 所有发送到微信的消息都会推送到该操作
     * 所以，微信公众平台后台填写的api地址则为该操作的访问地址
     */
    public function index()
    {
        /* 加载微信SDK */
        $wechat = new TPWechat($this->options);
        $wechat->valid();
        $type = $wechat->getRev()->getRevType();
        switch ($type) {
            case TPWechat::MSGTYPE_TEXT:
                $keyword = $wechat->getRevContent();
                $this->reply($keyword, $wechat);
                //$wechat->text($keyword)->reply();
                //$wechat->transfer_customer_service()->reply();
                exit;
                break;
            case TPWechat::MSGTYPE_EVENT:
                $data = $wechat->getRev()->getRevData();
                $record_info = json_encode($data);
                //写入接口log
                switch ($data['Event']) {
                    case 'subscribe':
                        $openid = $data['FromUserName'];
                        $weixinUserInfo = $wechat->getUserInfo($openid);
                        if($weixinUserInfo){
                            $data['nickname'] = $weixinUserInfo['nickname'];
                            $data['sex'] = $weixinUserInfo['sex'];
                            $data['city'] = $weixinUserInfo['city'];
                            $data['country'] = $weixinUserInfo['country'];
                            $data['subscribe'] = $weixinUserInfo['subscribe'];

                            $data['province'] = $weixinUserInfo['province'];
                            $data['language'] = $weixinUserInfo['language'];
                            $data['headimgurl'] = $weixinUserInfo['headimgurl'];
                            $data['unionid'] = $weixinUserInfo['unionid'];
                            $data['remark'] = $weixinUserInfo['remark'];

                            $data['groupid'] = $weixinUserInfo['groupid'];
                        }
                        $data['openid'] = $openid;
                        $data['subscribe_time'] = time();
                        $data['update_time'] = time();
                        $data = array_map('null_to_blank', $data);
                        $User = M('user');
                        $userInfo = $User->where(array('openid'=>$openid))->find();
                        if($userInfo){
                            $User->where(array('uid'=>$userInfo['uid']))->save($data);
                        } else {
                            $data['create_time'] = time();
                            $User->add($data);
                        }
                        statistics(array('openid' => $openid, 'action' => 'subscribe', 'action_ext' => $openid));
                        $replyContent = M('wechat_reply')->where(array('type'=>'subscribe'))->getField('content');
                        $wechat->text($replyContent)->reply();
                        break;
                    case 'unsubscribe':
                        $openid = $data['FromUserName'];
                        $userinfo = M('user');
                        $data['subscribe_time'] = 0;
                        $data['subscribe'] = 0;
                        $data['update_time'] = time();
                        $userinfo->where(array('openid' => $openid))->save($data);
                        statistics(array('openid' => $openid, 'action' => 'unsubscribe', 'action_ext' => $openid));
                        echo '';
                        break;
                }
                break;
            case TPWechat::MSGTYPE_IMAGE:
                //...
                break;
            default:
                //$wechat->text("help info")->reply();
        }
    }

    /**
     * 微信公众号自动回复
     */
    private function reply($keyword, $wechat)
    {
        $reply = M('wechat_reply')->where(array('keyword'=>$keyword))->order('id DESC')->find();
        if($reply){
            $this->sendReply($reply, $wechat);
        } else {
            $reply = M('wechat_reply')->where(array('keyword'=>array('LIKE', '%'.$keyword.'%')))->order('id DESC')->find();
            if($reply){
                $this->sendReply($reply, $wechat);
            } else {
                $wechat->transfer_customer_service()->reply();
            }
        }
    }

    /**
     * 公众号发送回复
     * @param array $reply
     * @param $wechat
     */
    private function sendReply($reply, $wechat)
    {
        if($reply['type'] == 'text'){
            $wechat->text(htmlspecialchars_decode($reply['content']))->reply();
        } else {
            $wechat->transfer_customer_service()->reply();
        }
    }

}
