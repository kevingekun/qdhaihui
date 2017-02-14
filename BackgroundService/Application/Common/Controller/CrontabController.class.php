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

    /**
     * 生成短信内容
     * @param $tempid  模板名称
     * @param $arr     传递内容
     * @return array   返回数组
     */
    public function getMsgContent($tempid, $arr)
    {
        $msg_temp = M("msg_template");
        $result = $msg_temp->where(array('temp_code' => $tempid))->find();

        //查询模板信息
        if (empty($result)) {
            $result_array = array('code' => 1, 'msg' => "No Such Template!");
            return $result_array;
            exit;
        }
        $temp_content = $result['temp_content'];

        //获取所需参数
        $temp_variable = $result['temp_variable'];
        $temp_variable_array = explode("|", $temp_variable);
        $temp_variable_array = array_filter($temp_variable_array);
        $temp_style = $result['temp_style'];

        if ($temp_style == 1) {

            //判断参数是否完整
            foreach ($temp_variable_array as $v) {
                if (empty($arr[$v])) {
                    $result_array = array('code' => 1, 'msg' => "Parameter $v Lost");
                    return $result_array;
                    exit;
                }
                //替换关键词
                $temp_content = str_replace('@' . $v . '@', $arr[$v], $temp_content);
            }

            $return_content = $temp_content;

        } else {
            //判断参数是否完整
            foreach ($temp_variable_array as $v) {
                if (empty($arr[$v])) {
                    $result_array = array('code' => 1, 'msg' => "Parameter $v Lost");
                    return $result_array;
                }
                //替换关键词
                $new_array[$v] = $arr[$v];
                //优先使用自定义关键词
                if ($v == 'first' || $v == 'remark') {
                    if (!empty($result['temp_' . $v])) {
                        $new_array[$v]['value'] = $result['temp_' . $v];
                    }
                }
            }
            $return_content = $new_array;
        }

        $result_array = array('code' => 0, 'msg' => $return_content);
        return $result_array;
    }

    /**
     * 发送信息类
     * @param $lx 1-短信    2-微信    3-全部
     * @param $temp_arr     模板数组    'wehchat'=>'','msg'=>''
     * @param $user_arr     账号数组    'wehchat'=>'','msg'=>''
     * @param $msg_arr      消息数组    'wehchat'=>array(),'msg'=>array()
     *
     * example
     *
     *
     *
     */
    /*
        example:

        $lx="1";
        $temp_arr=array('msg'=>'reg_msg');
        $user_arr=array('msg'=>'13000000000');
        $msg_arr=array(
            'msg'=>array(
                'data'=>array(
                    'verify_code'=>'1234'
                )
            )
        );

        $lx="2";
        $temp_arr=array('wechat'=>'TM00178');
        $user_arr=array('wechat'=>'o4Wwrt0ddMRHOjazgcxPjKgQ17BM');
        $msg_arr=array(
            'wechat'=>array(
                'url'=>'',
                'data'=>array(
                    'first'=>array('value'=>'尊敬的客户'),
                    'number'=>array('value'=>'1046'),
                    'remark'=>array('value'=>'请在5分钟内输入')
                )
            )
        );

        $lx='3';
        $temp_arr=array('msg'=>'reg_msg','wechat'=>'TM00178');
        $user_arr=array('msg'=>'18660236954','wechat'=>'o4Wwrt0ddMRHOjazgcxPjKgQ17BM');

        $msg_arr=array(
            'msg'=>array(
                'data'=>array(
                    'verify_code'=>'1234'
                )
            ),
            'wechat'=>array(
                'url'=>'',
                'data'=>array(
                    'first'=>array('value'=>'尊敬的客户'),
                    'number'=>array('value'=>'1046'),
                    'remark'=>array('value'=>'请在5分钟内输入')
                )
            )
        );


        $result=$this->sendMsg($lx,$temp_arr,$user_arr,$msg_arr);

        var_dump($result);
    */

    public function sendMsg($lx, $temp_arr, $user_arr, $msg_arr)
    {
        switch ($lx) {
            case '1':
                $msg_temp_id = $temp_arr['msg'];
                $msg_user_id = $user_arr['msg'];
                $msg_data = $msg_arr['msg']['data'];

                if (empty($msg_user_id)) {
                    $result_array = array('code' => 1, 'msg' => "Telephone number is null");
                    return $result_array;
                }

                $result_array = $this->getMsgContent($msg_temp_id, $msg_data);

                file_put_contents('./msgqueue.log', json_encode($result_array) . "\n\n", FILE_APPEND);

                if ($result_array['code'] == 1) {
                    return $result_array;
                }

                //调用短信接口
                return $result = $this->sendTelMsg($msg_user_id, $result_array['msg']);

                file_put_contents('./msgqueue.log', json_encode($result) . "\n\n", FILE_APPEND);
                break;

            case '2':
                $wechat_temp_id = $temp_arr['wechat'];
                $wechat_user_id = $user_arr['wechat'];
                $wechat_data = $msg_arr['wechat']['data'];

                $template_id = $this->getTemplateId($wechat_temp_id);

                file_put_contents('./msgqueue.log', json_encode($template_id) . "\n\n", FILE_APPEND);

                if (empty($wechat_user_id)) {
                    $result_array = array('code' => 1, 'msg' => "Openid is null");
                    return $result_array;
                }

                $send_arr['touser'] = $wechat_user_id;
                $send_arr['template_id'] = $template_id;
                $send_arr['url'] = $msg_arr['wechat']['url'];

                $result_array = $this->getMsgContent($wechat_temp_id, $wechat_data);

                if ($result_array['code'] == 1) {
                    return $result_array;
                }

                $send_arr['data'] = $result_array['msg'];

                $result = $this->wechat->sendTemplateMessage($send_arr);

                if ($result === false) {
                    $return_array = array('code' => 1, 'msg' => '');
                } else {
                    $return_array = array('code' => 0, 'msg' => 'msgid:' . $result['msgid']);
                }

                return $return_array;
                break;

            case '3':
                $msg_temp_id = $temp_arr['msg'];
                $msg_user_id = $user_arr['msg'];
                $msg_data = $msg_arr['msg']['data'];

                if (empty($msg_user_id)) {
                    $result_array = array('code' => 1, 'msg' => "Telephone number is null");
                    file_put_contents('./msgqueue.log', json_encode($result_array) . "\n\n", FILE_APPEND);
                }

                $result_array = $this->getMsgContent($msg_temp_id, $msg_data);

                if ($result_array['code'] == 1) {
                    file_put_contents('./msgqueue.log', json_encode($result_array) . "\n\n", FILE_APPEND);
                }

                //调用短信接口
                $result = $this->sendTelMsg($msg_user_id, $result_array['msg']);

                if ($result['code'] == 1) {
                    file_put_contents('./msgqueue.log', json_encode($result) . "\n\n", FILE_APPEND);
                }
                $wechat_temp_id = $temp_arr['wechat'];
                $wechat_user_id = $user_arr['wechat'];
                $wechat_data = $msg_arr['wechat']['data'];

                $template_id = $this->getTemplateId($wechat_temp_id);

                file_put_contents('./msgqueue.log', json_encode($template_id) . "\n\n", FILE_APPEND);

                if (empty($wechat_user_id)) {
                    $result_array = array('code' => 1, 'msg' => "Openid is null");
                    return $result_array;
                }

                $send_arr['touser'] = $wechat_user_id;
                $send_arr['template_id'] = $template_id;
                $send_arr['url'] = $msg_arr['wechat']['url'];

                $result_array = $this->getMsgContent($wechat_temp_id, $wechat_data);

                if ($result_array['code'] == 1) {
                    return $result_array;
                }

                $send_arr['data'] = $result_array['msg'];
                $result = $this->wechat->sendTemplateMessage($send_arr);

                if ($result === false) {
                    $return_array = array('code' => 1, 'msg' => '');
                } else {
                    $return_array = array('code' => 0, 'msg' => 'msgid:' . $result['msgid']);
                }

                return $return_array;
                break;

        }
    }

    public function sendTelMsg($telephone, $content)
    {

        $msg_user_id = C('MSG_ACCOUNT');
        $msg_user_password = C('MSG_PASSWORD');
        $target = C('MSG_POST_URL');

        $post_data = "account=" . $msg_user_id . "&password=" . $msg_user_password . "&mobile=" . $telephone . "&content=" . rawurlencode($content);

        $xml = $this->http_post($target, $post_data);

        $return_array = xml_to_array($xml);

        if ($return_array['SubmitResult']['code'] == 2) {
//            $_SESSION['mobile'] = $mobile;
//            $_SESSION['mobile_code'] = $mobile_code;
            $result_array = array('code' => 0, 'msg' => '短信发送成功');
        } else {

            $result_array = array('code' => 1, 'msg' => $return_array['SubmitResult']['msg']);

        }

        return $result_array;
    }

    /**
     * 根据模板code获取模板ID
     * 先查询数据库是否有记录，没有去服务器换去
     * 如已有数据大于等于15（官方要求），则删除使用量最小的模板
     * @param $str
     * @return mixed
     */
    public function getTemplateId($str)
    {

        $template_code = $str;
        $msg_wechat_template = M("msg_wechat_template");
        $result = $msg_wechat_template->where(array('template_code' => $template_code))->find();

        $use_times = $result['use_times'] + 1;
        $update['use_times'] = $use_times;
        $msg_wechat_template->where(array('template_code' => $template_code))->save($update);

        file_put_contents('./msgqueue.log', json_encode($result) . "\n\n", FILE_APPEND);

        if (empty($result)) {

            //计算已占用模板数量  每个公众号不超过15个
            $count = $msg_wechat_template->count();

            $template_id = $this->wechat->addTemplateMessage($str);

            $data["template_code"] = $str;
            $data["template_id"] = $template_id;

            if ($count >= 15) {
                //超过15个 替换使用数量最低的模板；
                $msg_wechat_template->order('use_times')->limit(1)->delete();
            }

            $msg_wechat_template->add($data);

        } else {
            $template_id = $result['template_id'];
        }

        return $template_id;

    }

    private function http_post($url, $post_fields)
    {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_fields);

        $response = curl_exec($ch);
        curl_close($ch);

        return $response;
    }

}