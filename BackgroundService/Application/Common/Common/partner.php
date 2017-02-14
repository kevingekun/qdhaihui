<?php
/**
 * 合伙人相关函数
 * @author: yanhuaitang
 * @date: 2015/10/24 17:03
 */

/**
 * 合伙人审核状态
 * @param $status
 * @return string
 */
function partner_status($status)
{
    $partnerStatus = \Common\Model\UserModel::$partnerStatus;
    return isset($partnerStatus[$status]) ? $partnerStatus[$status] : '';
}

/**
 * 根据用户id获取用户表某个字段的信息
 * @param $uid
 * @param string $field
 * @return mixed
 */
function get_user_field($uid, $field='nickname')
{
    $res = M('user')->where('uid='.intval($uid))->getField($field);
    return $res ? $res : '';
}

/**
 * 本人消费总金额
 * @param $uid 用户id
 * @return float
 */
function total_consum($uid)
{
    $map = array(
        'user_id' => intval($uid),
        'order_status' => \Common\Model\MallModel::ORDER_STATUS_FINISH,
    );
    $total = M('mall_order')->where($map)->getField('SUM(total_price)');
    return convert_money($total);
}

/**
 * 本人的粉丝的购买总额
 * @param $uid
 * @return float
 */
function fans_total_consum($uid)
{
    $User = M('User');
    $where = array(
        'u.invite_id' => intval($uid),
        'mo.order_status' => \Common\Model\MallModel::ORDER_STATUS_FINISH,
    );
    $data = $User->alias('u')
        ->field('SUM(mo.total_price) AS total')
        ->join('LEFT JOIN __MALL_ORDER__ mo ON u.uid=mo.user_id')
        ->where($where)
        ->find();
    return convert_money($data['total']);
}

/**
 * 获取下级数量
 * @param $uid
 * @param int $type 0-合伙人+粉丝, 1-合伙人, 2-粉丝
 * @param int $expire 缓存时间
 * @return mixed
 */
function get_fans_num($uid, $type = 0, $expire=60)
{
    $User = M('User');
    $where['invite_id'] = $uid;
    switch ($type) {
        case 1:
            $where['partner_status'] = \Common\Model\UserModel::PARTNER_STATUS_PASS;
            break;
        case 2:
            $where['partner_status'] = array('neq', \Common\Model\UserModel::PARTNER_STATUS_PASS);
            break;
        default:
    }

    $count = S('fansNum'.$uid.'Type'.$type);
    if(!$count){
        $count = $User->where($where)->count();
        S('fansNum'.$uid.'Type'.$type, $count, $expire);
    }
    return $count;
}

/**
 * 获取用户的支付账户
 * @param $uid
 * @return string
 */
function get_pay_account($uid, $field = 'account',$pay_way = 'alipay')
{
    $where = array(
        'uid' => intval($uid),
        'pay_way' => $pay_way,
    );
    return M('user_payment')->where($where)->getField($field);
}

/**
 * 申请成为合伙人时, 执行验证规则
 * @param $uid
 * @return bool
 */
function exe_partner_rule($uid)
{
    $partnerRule = C('PARTNER_RULE');
    if (!$partnerRule) {
        $partnerRule = array(
            'dateline' => '2015-11-11',// 默认截止日期
            'amount' => '1000',// 默认消费金额
        );
    }

    $flag = false;
    $dateline = strtotime($partnerRule['dateline']);
    if (NOW_TIME <= $dateline) $flag = true;

    $amount = total_consum($uid);
    if ($amount >= $partnerRule['amount']) $flag = true;

    return $flag;
}

/**
 * 佣金类型
 * @return array
 */
function commission_type()
{
    return array(
        \Common\Model\CommissionModel::TYPE_PRODUCT => '销售佣金',
        \Common\Model\CommissionModel::TYPE_PRODUCT_REWARD => '销售佣金提成',
        \Common\Model\CommissionModel::TYPE_SPREAD => '推广佣金',
//        \Common\Model\CommissionModel::TYPE_SPREAD_REWARD => '推广佣金提成',
//        \Common\Model\CommissionModel::TYPE_REWARD => '激励佣金',
    );
}

function commission_status()
{
    return array(
        \Common\Model\CommissionModel::STATUS_YES => '已结算',
        \Common\Model\CommissionModel::STATUS_NO => '未结算',
        \Common\Model\CommissionModel::STATUS_CHECK => '待审核',
    );
}


/**
 * 佣金总额
 * @param int $uid 用户id
 * @param int $type 佣金类型
 * @param int $status 结算状态
 * @return float 对应总金额
 */
function total_commission($type = 0, $uid = 0, $status=2)
{
    $Commission = M('commission_log');
    $typeArr = array_keys(commission_type());
    $where = array();
    if (in_array($type, $typeArr)) {
        $where['type'] = $type;
    }
    if(in_array($status, array(0,1))){
        $where['commission_status'] = $status;
    }

    if ($uid == 0) {
        $res = $Commission->field('SUM(money) AS total')->where($where)->find();// 全部
    } else {
        $where['uid'] = $uid;
        $res = $Commission->field('SUM(money) AS total')->where($where)->find();
    }

    return convert_money(floatval($res['total']));
}

/**
 * 生成二维码url
 * @param $uid
 */
function create_qrcode_url($uid)
{
    $url = U('Partner/Index/invite', array('uid' => $uid), true, true);
    $filePath = './qrcode/' . substr($uid, -2) . '/';
    if (!file_exists($filePath)) mkdirs($filePath);
    $outfile = $filePath . md5($uid) . '.png';
    if (!file_exists($outfile)){
        $user = M('user')->where('uid='.$uid)->find();
        if($user['headimgurl']){
            $outfile = qrcode($url, $outfile, $user['headimgurl']);
        } else {
            $outfile = qrcode($url, $outfile);
        }
    }
    return HOME_URL . '/' . ltrim(ltrim($outfile, '.'), '/');
}



/**
 * 生成佣金日志
 * @param $uid 合伙人id
 * @param int $type 佣金类型,  1-产品佣金, 2-销售提成, 3-推广佣金, 4-激励佣金
 * @param int $money 佣金金额(单位:分)
 * @param string $desc 描述或理由, 使用时参考格式如: 购买了{X}台{XXX电视机}
 * @param int $fansId 粉丝id 或 贡献者id
 * @param int $orderId 订单id
 * @return array|bool 保存失败, 返回false , 成功返回此条佣金日志信息
 */
//function save_commission_log($uid, $type = 1, $money = 0, $desc = '', $fansId = 0, $orderId = 0)
//{
//    $data = array(
//        'uid' => intval($uid),
//        'type' => intval($type),
//        'money' => floatval($money),
//        'desc' => $desc,
//        'fans_id' => intval($fansId),
//        'order_id' => intval($orderId),
//        'status' => 0,
//        'create_time' => time(),
//        'update_time' => time(),
//    );
//
//    if ($id = M('commission_log')->add($data)) {
//        $data['id'] = $id;
//        return $data;
//    }
//    return false;
//}


//function add_commission_queue($orderId)
//{
//    $redisHost = C('REDIS_HOST');
//    $redisPort = C('REDIS_PORT');
//
//    $redis = new \Redis();
//    $redis->connect($redisHost, $redisPort);
//
//    $redis->rPush('commission_queue', json_encode($orderId));
//}

