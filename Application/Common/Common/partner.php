<?php
/**
 * 合伙人相关函数
 * @author: yanhuaitang
 * @date: 2015/10/24 17:03
 */

/**
 * 合伙人审核状态
 * @param $status
 * @param bool|false $color
 * @return string
 */
function partner_status($status, $color = false)
{
    if ($color === false) {
        $arr = array(
            \Common\Model\UserModel::PARTNER_STATUS_REG => '未申请',
            \Common\Model\UserModel::PARTNER_STATUS_CHECK => '待审核',
            \Common\Model\UserModel::PARTNER_STATUS_REFUSE => '已拒绝',
            \Common\Model\UserModel::PARTNER_STATUS_PASS => '已通过'
        );
    } else {
        $arr = array(
            \Common\Model\UserModel::PARTNER_STATUS_REG => '<font>未申请</font>',
            \Common\Model\UserModel::PARTNER_STATUS_CHECK => '<font color="#ff8c00">待审核</font>',
            \Common\Model\UserModel::PARTNER_STATUS_REFUSE => '<font color="red">已拒绝</font>',
            \Common\Model\UserModel::PARTNER_STATUS_PASS => '<font color="green">已通过</font>'
        );
    }
    return isset($arr[$status]) ? $arr[$status] : '';
}

/**
 * 申请修改信息状态
 * @param bool|false $status
 * @return array
 */
function check_status($status = false, $color = false)
{
    if ($color === false) {
        $arr = array(
            \Common\Model\UserModel::CHECK_STATUS_NORMAL => '未申请',
            \Common\Model\UserModel::CHECK_STATUS_CHECK => '待审核',
            \Common\Model\UserModel::CHECK_STATUS_REFUSE => '已拒绝',
            \Common\Model\UserModel::CHECK_STATUS_PASS => '已通过',
        );
    } else {
        $arr = array(
            \Common\Model\UserModel::CHECK_STATUS_NORMAL => '<font>未申请</font>',
            \Common\Model\UserModel::CHECK_STATUS_CHECK => '<font color="#ff8c00">待审核</font>',
            \Common\Model\UserModel::CHECK_STATUS_REFUSE => '<font color="red">已拒绝</font>',
            \Common\Model\UserModel::CHECK_STATUS_PASS => '<font color="green">已通过</font>',
        );
    }

    if (isset($arr[$status])) {
        return $arr[$status];
    } else {
        return $arr;
    }
}

/**
 * 根据用户id获取用户表某个字段的信息
 * @param $uid
 * @param string $field
 * @return mixed
 */
function get_user_field($uid, $field = 'nickname')
{
    $res = M('user')->where('uid=' . intval($uid))->getField($field);
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
        'u.subscribe_time' => array('NEQ', 0),
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
function get_fans_num($uid, $type = 0, $expire = 60)
{
    $User = M('User');
    $where['invite_id'] = $uid;
    $where['subscribe_time'] = array('GT', 0);
    switch ($type) {
        case 1:
            $where['partner_status'] = \Common\Model\UserModel::PARTNER_STATUS_PASS;
            break;
        case 2:
            $where['partner_status'] = array('neq', \Common\Model\UserModel::PARTNER_STATUS_PASS);
            break;
        default:
    }

    $count = S('fansNum' . $uid . 'Type' . $type);
    if (!$count) {
        $count = $User->where($where)->count();
        S('fansNum' . $uid . 'Type' . $type, $count, $expire);
    }
    return $count;
}

/**
 * 获取用户的支付账户
 * @param $uid
 * @return string
 */
function get_pay_account($uid, $field = 'account', $pay_way = 'alipay')
{
    $where = array(
        'uid' => intval($uid),
        'pay_way' => $pay_way,
    );
    return M('user_payment')->where($where)->getField($field);
}

/**
 * 申请成为合伙人时, 执行验证规则
 * @param $uid 用户id
 * @return bool 符合规则 true, 不符合 false
 */
function exe_partner_rule($uid)
{
    $flag = false;
    $attribute = M('attribute')->where(array('type' => 'partner_rule'))->find();
    if (isset($attribute['value'])) {
        $partnerRule = json_decode($attribute['value'], true);
        if (!empty($partnerRule)) {
            $dateline = strtotime($partnerRule['dateline']);
            $amount = total_consum($uid);
            if (time() <= $dateline || $amount >= $partnerRule['amount']) {
                $flag = true;
            }
        }
    }

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
        \Common\Model\CommissionModel::TYPE_PRODUCT_REWARD => '销售提成',
        \Common\Model\CommissionModel::TYPE_SPREAD => '推广佣金',
//        \Common\Model\CommissionModel::TYPE_SPREAD_REWARD => '推广佣金提成',
        \Common\Model\CommissionModel::TYPE_REWARD => '激励佣金',
    );
}

/**
 * 佣金处理状态
 * @return array
 */
function commission_status($color = false)
{
    if ($color === true) {
        return array(
            \Common\Model\CommissionModel::STATUS_NO => '<font color="red">未结算</font>',
            \Common\Model\CommissionModel::STATUS_CHECK => '<font color="#ff8c00">待审核</font>',
            \Common\Model\CommissionModel::STATUS_CHECKING => '<font color="blue">审核中</font>',
            \Common\Model\CommissionModel::STATUS_PAY => '<font color="#7b68ee">待打款</font>',
            \Common\Model\CommissionModel::STATUS_YES => '<font color="green">已结算</font>',
        );
    }
    return array(
        \Common\Model\CommissionModel::STATUS_NO => '未结算',
        \Common\Model\CommissionModel::STATUS_CHECK => '待审核',
        \Common\Model\CommissionModel::STATUS_CHECKING => '审核中',
        \Common\Model\CommissionModel::STATUS_PAY => '待打款',
        \Common\Model\CommissionModel::STATUS_YES => '已结算',
    );
}


/**
 * 佣金总额
 * @param int $uid 用户id
 * @param int $type 佣金类型
 * @param int $status 结算状态
 * @return float 对应总金额
 */
function total_commission($type = 0, $uid = 0, $status = -1)
{
    $Commission = M('commission_log');
    $typeArr = array_keys(commission_type());
    $where = array();
    if (in_array($type, $typeArr)) {
        $where['type'] = $type;
    }
    $statusArr = array_keys(commission_status());
    if (in_array($status, $statusArr)) {
        $where['status'] = $status;
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
 * 计算佣金
 * @param array $where
 * @return float
 */
function total_commission_new(array $where = array())
{
    $res = M('commission_log')
        ->field('SUM(money) AS total')
        ->where($where)
        ->find();
    return convert_money(floatval($res['total']));
}

/**
 * 获取  未结算佣金 = (不是推广佣金的佣金 + 产品佣金*10% <从推广佣金里扣> ) && 状态为没有已结算 且 金额>0
 * @param int $uid 默认0计算全部的
 * @return float
 */
function get_nosettled_commission($uid = 0)
{
    $nosettledAmountKey = md5('nosettledAmount_' . $uid);
    $nosettledAmount = S($nosettledAmountKey);
    if (!$nosettledAmount) {
        $where = array(
            'type' => array('NEQ', \Common\Model\CommissionModel::TYPE_SPREAD),
            'status' => array('NEQ', \Common\Model\CommissionModel::STATUS_YES),
        );
        if ($uid > 0) $where['uid'] = $uid;
        $nosettledAmount = total_commission_new($where);
        S($nosettledAmountKey, $nosettledAmount, 60 * 5);
    }
    return $nosettledAmount;
}

/**
 * 获取已结算佣金总额
 * @param int $uid 默认0计算全部的
 * @return float|mixed
 */
function get_settled_commission($uid = 0)
{
    $settledAmountKey = md5('settledAmount_' . $uid);
    $settledAmount = S($settledAmountKey);
    if (!$settledAmount) {
        // 除推广佣金以外的结算的佣金
        $otherWhere = array(
            'type' => array('NEQ', \Common\Model\CommissionModel::TYPE_SPREAD),
            'status' => \Common\Model\CommissionModel::STATUS_YES,
        );
        if ($uid > 0) $otherWhere['uid'] = $uid;
        $otherAmount = total_commission_new($otherWhere);

        // 已经结算的推广佣金
        $spreadWhere = array(
            'type' => \Common\Model\CommissionModel::TYPE_SPREAD,
            'status' => \Common\Model\CommissionModel::STATUS_YES,
            '_string' => 'money < 0'
        );
        if ($uid > 0) $spreadWhere['uid'] = $uid;
        $spreadAmount = total_commission_new($spreadWhere);

        $settledAmount = $otherAmount + abs($spreadAmount);
        S($settledAmountKey, $settledAmount, 60 * 5);
    }
    return $settledAmount;
}


/**
 * 生成二维码url
 * @param $uid
 */
function create_qrcode_url($uid)
{
    $url = U('Mall/Index/index', array('uid' => $uid), true, true);
    $filePath = './qrcode/' . substr($uid, -2) . '/';
    if (!file_exists($filePath)) mkdirs($filePath);
    $outfile = $filePath . md5($uid) . '.png';
    if (!file_exists($outfile)) {
        $user = M('user')->where('uid=' . $uid)->find();
        if ($user['headimgurl']) {
            $avatar = download_weixin_avatar($user['headimgurl'], '132');
            if ($avatar) {
                $outfile = qrcode($url, $outfile, $avatar);
                @unlink($avatar);
            } else {
                $outfile = qrcode($url, $outfile);
            }
        } else {
            $outfile = qrcode($url, $outfile);
        }
    }
    return HOME_URL . '/' . ltrim(ltrim($outfile, '.'), '/');
}

/**
 * 下载微信头像到本地
 * @param $url
 * @return bool|string
 */
function download_weixin_avatar($url, $size = '64')
{
    $filePath = './qrcode/tmp/';
    if ($content = file_get_contents($url . $size)) {
        if (!file_exists($filePath)) mkdirs($filePath);
        $outfile = $filePath . md5($url) . '.jpg';
        file_put_contents($outfile, $content);
        return $outfile;
    } else {
        return false;
    }
}

/**
 * 生成邀请人id
 * 根据邀请人id , 先判断此人是否是合伙人, 如果此人不是合伙人, 则向上追溯, 返回他的邀请人id
 * @param $uid
 * @return int
 */
function create_invite_id($uid)
{
    // 邀请人信息
    $inviteUserInfo = M('user')->where('uid=' . $uid)->find();

    // 如果邀请人不是合伙人, 则向上追溯 (粉丝不能发展粉丝, 被邀请人算上级的粉丝)
    if ($inviteUserInfo['partner_status'] != \Common\Model\UserModel::PARTNER_STATUS_PASS) {
        $inviteId = $inviteUserInfo['invite_id'];
    } else {
        $inviteId = $inviteUserInfo['uid'];
    }

    return intval($inviteId);
}


/**
 * 获取邀请人信息
 * @param $inviteId 邀请人id
 * @return bool|mixed
 */
function get_invite_user($inviteId, $field = 'nickname')
{
    $inviteId = intval($inviteId);
    if ($inviteId > 0) {
        $key = md5('inviteUser_' . $field . $inviteId);
        $inviteUser = S($key);
        if (!$inviteUser) {
            $inviteUser = M('user')->where('uid=' . $inviteId)->getField($field);
            S($key, $inviteUser, 60 * 60 * 5);
        }
        return $inviteUser;
    } else {
        return '系统推荐';
    }
}

/**
 * 用户是否购买过
 * @param $uid
 * @return bool false-无购买记录, true-有购买记录
 */
function is_buy($uid)
{
    $key = md5('is_buy_' . $uid);
    $order = S($key);
    if (!$order) {
        $where = array(
            'user_id' => $uid,
            'order_status' => \Common\Model\MallModel::ORDER_STATUS_FINISH
        );
        $order = M('mall_order')->where($where)->find();
        if ($order) {
            S($key, $order, 60 * 60 * 24);
            return true;
        }
        return false;
    } else {
        return true;
    }
}

/**
 * 查询单个用户信息(带缓存)
 * @param $where
 */
function get_user_info($uid, $where = array(), $expire = 300)
{
    $key = md5('user_info_' . $uid);
    $user = S($key);
    if (!$user) {
        $where = array_merge(array('uid' => $uid), $where);
        $user = M('user')->where($where)->find();
        S($key, $user, $expire);
    }
    return $user;
}

/**
 * 获取用户的 类型  合伙人 or 粉丝
 */
function get_user_partner_type($uid)
{
    $partner_status = M('user')->where('uid=' . $uid)->getField('partner_status');
    return $partner_status == \Common\Model\UserModel::PARTNER_STATUS_PASS ? '合伙人' : '粉丝';
}

/**
 * 查询用户订单数量
 * @param $uid 用户uid
 * @param array $orderStatus 条件, 默认查询 已付款和完成交易的订单
 * @return int 订单数量
 */
function get_order_num($uid, $orderStatus = array())
{
    $where['user_id'] = $uid;
    if (is_string($orderStatus)) {
        $where['order_status'] = $orderStatus;
    } elseif (is_array($orderStatus) && !empty($orderStatus)) {
        $where['order_status'] = $orderStatus;
    } elseif (is_array($orderStatus) && empty($orderStatus)) {
        $where['order_status'] = array('IN', array(
            \Common\Model\MallModel::ORDER_STATUS_WAIT_DELIVER,
            \Common\Model\MallModel::ORDER_STATUS_WAIT_RECEIVE,
            \Common\Model\MallModel::ORDER_STATUS_FINISH,
        ));
    }

    return intval(M('mall_order')->where($where)->count());
}

/**
 * 获取未处理对话的数量 (按人头计算)
 * @return int 数量
 */
function get_wait_case_count()
{
    $options = array(
        'appid' => C('APP_ID'),
        'appsecret' => C('APP_SECRET'),
    );
    $wechat = new \Com\Wechat\TPWechat($options);
    $result = $wechat->getKFSessionWait();
    return $result['count'];
}

/**
 * 获取标签数组
 * @param $uid 用户id
 * @return array 返回数组
 */
function get_tag_with_uid($uid)
{
    $tagStr = M('user')->where(array('uid' => $uid))->getField('tag_id');
    $tagStr = trim($tagStr);
    if ($tagStr == '') {
        return array();
    }

    $tagArr = explode(',', $tagStr);
    $data = M('attribute')->where(array('id' => array('IN', $tagStr)))->select();
    return $data ? $data : array();
}

/**
 * 根据tagid 返回tag的名称(逗号链接)
 * @param string $tagId 逗号隔开的id
 * @return string 标签名称, 用逗号连接
 */
function get_tag_text($tagId)
{
    if ($tagId == '') return '';

    $tagArr = explode(',', $tagId);
    $tagArr = array_filter($tagArr);
    $data = M('attribute')->where(array('id' => array('IN', $tagArr)))->getField('value', true);
    return $data ? join(',', $data) : 'test';
}

/**
 * 佣金来源(返回佣金来源描述)
 * @param $commId 佣金id
 * @return string 返回佣金来源描述
 */
function commission_origin($commId)
{
    $commission = M('commission_log')->where(array('id' => $commId))->find();
    if (!$commission) return '';
    switch ($commission['type']) {
        case 1:
            // 销售佣金
            $order = M('mall_order')->where(array('id' => $commission['order_id']))->find();
            return $order ? '订单号: <a href="' . U('Admin/Orders/orderDetails', array('id' => $order['id'])) . '">' . $order['order_number'] . '</a>' : '';
            break;
        case 2:
            // 销售提成
            $order = M('mall_order')->where(array('id' => $commission['order_id']))->find();
            $fans = M('user')->where(array('uid' => $commission['fans_id']))->find();
            if ($order && $fans) {
                return '<a href="' . U('Admin/User/edit', array('id' => $fans['uid'])) . '">' . $fans['nickname'] . '</a> 购买了 <a href="' . U('Admin/Orders/orderDetails', array('id' => $order['id'])) . '">' . $order['order_number'] . '</a> 提供的提成';
            } else {
                return '';
            }
            break;
        case 3:
            // 推广佣金
            $fans = M('user')->where(array('uid' => $commission['fans_id']))->find();
            return $fans ? '新增粉丝 <a href="' . U('Admin/User/edit', array('id' => $fans['uid'])) . '">' . $fans['nickname'] . '</a>' : '';
            break;
        case 5:
            // 激励佣金
            return '奖励佣金';
            break;
        default:
            return '';
    }
}

/**
 * 获取下级成交单数
 * @param int $uid 用户id
 * @return int 下级成交单数
 * 说明: 完成总订单数 - 退款订单数
 */
function get_fans_order_num($uid)
{
    $fansIdArr = M('user')->where(array('invite_id' => $uid))->getField('uid', true);
    if (!$fansIdArr) return 0;
    $orderTotalNum = M('mall_order')
        ->where(array('user_id' => array('IN', $fansIdArr), 'order_status' => \Common\Model\MallModel::ORDER_STATUS_FINISH))
        ->count();

    $refundOrderNum = M('mall_refund')
        ->where(array('user_id' => array('IN', $fansIdArr), 'order_status' => 9))
        ->count();

    $num = intval($orderTotalNum) - $refundOrderNum;
    return $num;
}

/**
 * 获取用户总消费金额
 * @param int $uid
 * @return float
 */
function get_total_consume_amount($uid)
{
    $finishOrder = M('mall_order')
        ->field('SUM(real_price) AS amount')
        ->where(array('user_id' => $uid, 'order_status' => \Common\Model\MallModel::ORDER_STATUS_FINISH))
        ->find();
    $amount = convert_money(floatval($finishOrder['amount']));
    return $amount;
}

/**
 * 获取粉丝成交金额
 * @param int $uid 用户id
 * @return float 粉丝成交金额
 */
function get_fans_order_amount($uid)
{
    $fansIdArr = M('user')->where(array('invite_id' => $uid))->getField('uid', true);
    if (!$fansIdArr) return 0;
    $result = M('mall_order')
        ->field('SUM(real_price) AS amount')
        ->where(array('user_id' => array('IN', $fansIdArr), 'order_status' => \Common\Model\MallModel::ORDER_STATUS_FINISH))
        ->find();
    $amount = convert_money(floatval($result['amount']));
    return $amount;
}


