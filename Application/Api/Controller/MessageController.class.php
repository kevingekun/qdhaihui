<?php
namespace Api\Controller;

use Common\Controller\ApiController;

class MessageController extends ApiController
{


    public function _initialize()
    {
        parent::_initialize();
    }



    /**
     * 写入队列
     *
     * @param $lx 1-短信    2-微信    3-全部
     * @param $temp_arr     模板数组    'wehchat'=>'','msg'=>''
     * @param $user_arr     账号数组    'wehchat'=>'','msg'=>''
     * @param $msg_arr      消息数组    'wehchat'=>array(),'msg'=>array()
     *
     */
    /*
        example:

        $queue_name='msg_queue';
        $uid  //用户ID 备用

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

    */

    /**
     * @param $queue_name  队列名称
     * @param $uid    用户ID
     * @param $lx       类型
     * @param $temp_arr 模板数组
     * @param $user_arr 用数组
     * @param $msg_arr  消息数组
     */
    public function addQueue($queue_name, $uid, $lx, $temp_arr, $user_arr, $msg_arr)
    {

        $arr['lx'] = $lx;
        $arr['temp_arr'] = $temp_arr;
        $arr['user_arr'] = $user_arr;
        $arr['msg_arr'] = $msg_arr;
        $arr['uid'] = $uid;
        $arr['errortimes'] = 0;
        $arr['create_time'] = time();
        $string = json_encode($arr);
        $this->redis->rPush($queue_name, $string);

    }

    /**
     * ajax 调用该方法，需使用post方式传入手机号，get方式无效
     *
     * code_style   验证码类型  reg-注册验证码  pwd-修改密码验证码
     *
     */
    public function getRegCode()
    {

        $code_expire_time = C('CODE_EXPIRE_TIME');
        $code_ip_allow_times = C('CODE_IP_ALLOW_TIMES');
        $code_tel_day_max_times = C('CODE_TEL_DAY_MAX_TIMES');
        $code_ip_day_max_times = C('CODE_IP_DAY_MAX_TIMES');

        if (!$_POST){
            $return_array = array('code' => 1, 'msg' => '参数错误请重试！');
            $this->ajaxReturn($return_array);
        }

        $IP = get_client_ip();
        $telephone = $_POST['tel'];
        $code_style = $_POST['style'];

        $now = time();

        $code_telephone = M("code_telephone");

        //获取手机获取验证码的间隔时间
        $where_tel['telephone'] = $telephone;
        $where_tel['code_style'] = $code_style;
        $where_tel['expire_time'] = array('EGT', $now);
        $result = $code_telephone->where($where_tel)->find();

        if (!empty($result)) {
            $return_array = array('code' => 1, 'msg' => '验证码发送过于频繁，请稍候再试！');
            $this->ajaxReturn($return_array);
        }

        //获取半小时内该IP验证码发送次数
        $half_an_hour_ago = $now - 1800;
        $where_ip['ip'] = $IP;
        $where_ip['create_time'] = array('EGT', $half_an_hour_ago);

        $count = $code_telephone->where($where_ip)->count();

        if ($count >= $code_ip_allow_times) {
            $return_array = array('code' => 1, 'msg' => '验证码发送过于频繁，请稍候再试！');
            $this->ajaxReturn($return_array);
        }

        //获取今日起止时间
        $beginToday = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
        $endToday = mktime(0, 0, 0, date('m'), date('d') + 1, date('Y')) - 1;


        //计算当日该手机号获取次数
//        $where_tel_max['telephone'] = $telephone;
//        $where_tel_max['code_style'] = $code_style;
//        $where_tel_max['create_time'] = array('between', array($beginToday, $endToday));
//
//        $count_tel_today = $code_telephone->where($where_tel_max)->count();
//
//        if ($count_tel_today >= $code_tel_day_max_times) {
//
//            $return_array = array('code' => 1, 'msg' => '已达到当日发送验证码最大次数，请明日再试');
//            echo json_encode($return_array);
//            exit;
//        }

//        //计算当日该IP获取次数
//
//        $where_ip_max['ip'] = $IP;
//        $where_ip_max['create_time'] = array('between', array($beginToday, $endToday));
//
//        $count_ip_today = $code_telephone->where($where_ip_max)->count();
//
//        if ($count_ip_today >= $code_ip_day_max_times) {
//
//            $return_array = array('code' => 1, 'msg' => '已达到当日发送验证码最大次数，请明日再试');
//            echo json_encode($return_array);
//            exit;
//
//        }

        //检测通过 生成验证码
        $code = random(6, 1);

        $data['ip'] = $IP;
        $data['telephone'] = $telephone;
        $data['create_time'] = $now;
        $data['code_style'] = $code_style;
        $data['expire_time'] = $now + $code_expire_time - 1;
        $data['code'] = $code;

        $code_telephone->add($data);


        //发送短信
        $lx = 1;
        $temp_arr = array('msg' => 'reg_msg');
        $user_arr = array('msg' => $telephone);
        $msg_arr = array('msg' => array('data' => array('verify_code' => $code)));

        $result = $this->sendMsg($lx, $temp_arr, $user_arr, $msg_arr);

        $data_log['telephone']=$telephone;
        $data_log['code_style']=$code_style;
        $data_log['code']=$code;
        $data_log['result']=json_encode($result);
        $data_log['create_time']=time();

        M('msg_log')->add($data_log);

        $this->ajaxReturn($result);
    }
    
    public function buy_ok($telephone,$code_style,$orderNum,$product_name){
    	
    	$code_telephone = M("order_telephone");
    	
    	$IP = get_client_ip();
    	$now = time();
    	
    	echo $telephone;
    	
    	$data['ip'] = $IP;
    	$data['telephone'] = $telephone;
    	$data['create_time'] = $now;
    	$data['code_style'] = $code_style;
    	$data['expire_time'] = $now;
    	$data['code'] = $orderNum;
    	
    	$code_telephone->add($data);
    	
    	$lx = 1;
    	$temp_arr = array('msg' => 'buy_ok');
    	$user_arr = array('msg' => $telephone);
    	$msg_arr = array('msg' => array('data' => array('order_num' => $orderNum,'product_name'=>$product_name)));
    	
    	$result = $this->sendMsg($lx, $temp_arr, $user_arr, $msg_arr);
    	
    	$data_log['telephone']=$telephone;
    	$data_log['code_style']=$code_style;
    	$data_log['code']=$orderNum;
    	$data_log['result']=json_encode($result);
    	$data_log['create_time']=time();
    	
    	M('msg_log')->add($data_log);
    }

}


