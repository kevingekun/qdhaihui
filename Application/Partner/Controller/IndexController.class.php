<?php
namespace Partner\Controller;

use Common\Controller\BaseController;
use Common\Controller\HomeController;
use Common\Controller\WmallController;
use Common\Model\CommissionModel;
use Common\Model\MallModel;
use Common\Model\UserModel;
use Think\Crypt\Driver\Think;
use Think\Hook;
use Think\Model;

/**
 * 前台合伙人相关
 * @author: yanhuaitang
 * @date: 2015/10/30 17:52
 */
class IndexController extends WmallController
{
    public function _initialize()
    {
        parent::_initialize();
    }

    public function index()
    {

        $this->display();
    }

    /**
     * 申请成为合伙人
     */
    public function apply()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();

        if (IS_AJAX) {
            $realname = I('post.realname');
            $phone = I('post.phone');
            $code = I('post.code');
            $pay_way = I('post.pay_way');
            $account = I('post.account');
            $authen_name = I('post.authen_name');
            $qq = I('post.qq');
            $agree = I('post.agree');

            if ($user['check_status'] == UserModel::CHECK_STATUS_CHECK) {
                $this->ajaxReturn(array('code' => 8, 'msg' => '您的申请正在审核中'));
            }

            if (!is_chinese($realname)) {
                $this->ajaxReturn(array('code' => 1, 'msg' => '请正确填写真实姓名'));
            }

            if (!is_mobile($phone)) {
                $this->ajaxReturn(array('code' => 2, 'msg' => '请正确填写手机'));
            }

            /*if ($code != '') {
                $ct = M('code_telephone')->where(array('telephone' => $phone, 'code' => $code, 'code_style' => 'reg'))->order('id DESC')->find();
                if ($ct) {
                    if (($ct['create_time'] + 60 * 5) < time()) {
                        $this->ajaxReturn(array('code' => 7, 'msg' => '短信验证码已过期'));
                    }
                } else {
                    $this->ajaxReturn(array('code' => 7, 'msg' => '验证码错误'));
                }
            } else {
                $this->ajaxReturn(array('code' => 7, 'msg' => '验证码错误'));
            }*/

            if (!is_username($account) && !is_email($account) && !is_mobile($account)) {
                $this->ajaxReturn(array('code' => 3, 'msg' => '请正确填写支付宝账号'));
            }
            if (!is_chinese($authen_name)) {
                $this->ajaxReturn(array('code' => 4, 'msg' => '请正确填写支付宝认证姓名'));
            }

            if ($qq != '' && !is_qq($qq)) {
                $this->ajaxReturn(array('code' => 9, 'msg' => '请正确填写QQ号'));
            }

            if (!$agree) {
                $this->ajaxReturn(array('code' => 5, 'msg' => '请确认您同意《合伙人协议》'));
            }

            $phone2 = M('user')->where('uid=' . $uid)->getField('phone');
            if (!$phone2) {
                $data['phone'] = $phone;
            }

            if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
                $flag = exe_partner_rule($uid);
                if ($flag) { // 符合条件直接通过
                    $data['realname'] = $realname;
                    $data['qq'] = $qq;
                    $data['apply_time'] = time();
                    $data['partner_status'] = UserModel::PARTNER_STATUS_PASS;
                    $data['check_status'] = UserModel::CHECK_STATUS_PASS;
                    $data['audit_time'] = time();
                    $res1 = M('User')->where(array('uid' => $uid))->save($data);
                    if (false !== $res1) {
                        $payment = M('user_payment')->where(array('uid' => $uid, 'pay_way' => $pay_way))->find();
                        if ($payment) {
                            $payment['authen_name'] = $authen_name;
                            $payment['account'] = $account;
                            $payment['update_time'] = time();
                            $res2 = M('user_payment')->save($payment);
                        } else {
                            $res2 = M('user_payment')->add(array(
                                'uid' => $uid,
                                'pay_way' => $pay_way,
                                'account' => $account,
                                'authen_name' => $authen_name,
                                'create_time' => time(),
                                'update_time' => time(),
                            ));
                        }
                    }
                } else {
                    // 用户申请的临时信息
                    $tempData = array(
                        'realname' => $realname,
                        'phone' => $phone,
                        'qq' => $qq,
                        'pay_way' => $pay_way,
                        'account' => $account,
                        'authen_name' => $authen_name
                    );

                    $res1 = M('User')->where(array('uid' => $uid))->save(array(
                        'partner_status' => $user['partner_status'] == UserModel::PARTNER_STATUS_PASS ? UserModel::PARTNER_STATUS_PASS : UserModel::PARTNER_STATUS_CHECK,
                        'check_status' => UserModel::CHECK_STATUS_CHECK,
                        'apply_time' => time(),
                        'user_info_temp' => serialize($tempData),
                    ));
                }
            } else {
                // 用户申请的临时信息
                $tempData = array(
                    'realname' => $realname,
                    'phone' => $phone,
                    'qq' => $qq,
                    'pay_way' => $pay_way,
                    'account' => $account,
                    'authen_name' => $authen_name
                );

                $res1 = M('User')->where(array('uid' => $uid))->save(array(
                    'partner_status' => $user['partner_status'] == UserModel::PARTNER_STATUS_PASS ? UserModel::PARTNER_STATUS_PASS : UserModel::PARTNER_STATUS_CHECK,
                    'check_status' => UserModel::CHECK_STATUS_CHECK,
                    'apply_time' => time(),
                    'user_info_temp' => serialize($tempData),
                ));
            }


            if ($res1 !== false) {
                $this->ajaxReturn(array('code' => 0, 'msg' => '提交成功', 'url' => U('Partner/Index/qrcode')));
            } else {
                $this->ajaxReturn(array('code' => 9, 'msg' => '申请失败, 请联系管理员'));
            }
        } else {
            $payInfo = M('user_payment')->where(array('uid' => $user['uid'], 'pay_way' => 'alipay'))->find();
            $this->assign('payInfo', $payInfo);
            $this->assign('user', $user);
            $this->display();
        }
    }

    /**
     * 获取验证码
     */
//    public function getCode()
//    {
//        if (IS_AJAX) {
//            $mobile = I('post.mobile');
//            $data = get_code($mobile, 'reg');
//            $this->ajaxReturn($data);
//        }
//    }

    /**
     * 合伙人在线协议
     */
    public function agreement()
    {
        $this->content = $this->get_content(1);
        $this->display();
    }

    /**
     * 关于我们
     */
    public function aboutus()
    {
        // 实例化模型
        $model = M('article');

        $id = I('get.id', 0, 'intval');
        $type = $model->field('id,content')->find($id);
        $this->type = $type;
        $this->display();
    }

    /**
     * 个人中心
     */
    public function ucenter()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();

        if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
            $this->error('还不是合伙人,请申请....', U('Partner/Index/apply'));
        }
        // 销售佣金提成
        $saleReward = S('saleReward' . $uid);
        if (!$saleReward) {
            $saleReward = total_commission(CommissionModel::TYPE_PRODUCT_REWARD, $uid);
            S('saleReward' . $uid, convert_money($saleReward), 60);
        }

        // 销售佣金
        $saleCommission = S('saleCommission' . $uid);
        if (!$saleCommission) {
            $saleCommission = total_commission(CommissionModel::TYPE_PRODUCT, $uid);
            S('saleReward' . $uid, convert_money($saleCommission), 60);
        }

        // 推广佣金
        $spreadCommission = S('saleCommission' . $uid);
        if (!$spreadCommission) {
            $spreadCommission = total_commission(CommissionModel::TYPE_SPREAD, $uid);
            S('spreadCommission' . $uid, convert_money($spreadCommission), 60);
        }

        // 总粉丝
        $fansTotalNum = get_fans_num($uid);
        // 二级合伙人
        $partnerNum = get_fans_num($uid, 1);

        $inviteUser = M('user')->where('uid=' . $user['invite_id'])->find();

        $this->assign('partnerNum', $partnerNum);
        $this->assign('fansTotalNum', $fansTotalNum);
        $this->assign('saleReward', $saleReward);
        $this->assign('saleCommission', $saleCommission);
        $this->assign('spreadCommission', $spreadCommission);
        $this->assign('inviteUser', $inviteUser);
        $this->assign('user', $user);
        $this->display();
    }

    /**
     * 粉丝列表
     */
    public function fans()
    {
        $uid = session('uid');
        $User = M('User');
        $user = $User->where('uid=' . $uid)->find();

        if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
            $this->error('还不是合伙人,请申请....', U('Partner/Index/apply'));
        }

        $where = array(
            'u.invite_id' => $uid,
            'u.subscribe_time' => array('GT', 0),
        );

        if (IS_AJAX) {
            $page = I('post.p', 1, 'intval');
            $where1 = array_merge($where, array('mo.order_status' => MallModel::ORDER_STATUS_FINISH));
            $sql1 = $User->alias('u')
                ->field('u.*, IFNULL(SUM(mo.total_price),0) AS total_money, mo.order_status')
                ->join("LEFT JOIN __MALL_ORDER__ mo ON u.uid=mo.user_id")
                ->where($where)
                ->group('u.uid')
                ->having('mo.order_status=' . MallModel::ORDER_STATUS_FINISH)
                ->order('total_money DESC')
                ->buildSql();

            $where2 = $where;
            $where2['mo.order_status'] = array(
                array('NEQ', MallModel::ORDER_STATUS_FINISH),
                array('EXP', 'is NULL'),
                'OR'
            );

            $sql2 = $User->alias('u')
                ->field('u.*, IFNULL(SUM(mo.total_price),0) AS total_money, mo.order_status')
                ->join("LEFT JOIN __MALL_ORDER__ mo ON u.uid=mo.user_id")
                ->where($where)
                ->group('u.uid')
                ->having('mo.order_status<>' . MallModel::ORDER_STATUS_FINISH . ' OR mo.order_status IS NULL ')
                ->order('total_money DESC, u.uid ASC')
                ->buildSql();

            //file_put_contents('./tt.txt', "($sql1) UNION ($sql2) ", FILE_APPEND);

            $limit = ($page - 1) * $this->pageSize;
            $offset = $this->pageSize;
            $list = M()->query("($sql1) UNION ($sql2) LIMIT $limit,$offset");

            if ($list) {
                foreach ($list as $key => $value) {
                    $list[$key]['headimgurl'] = avatar($value['headimgurl']);
                    $list[$key]['color'] = is_buy($value['uid']) ? 'text-red' : 'text-blue';
                }
                $end = false;
            } else {
                $end = true;
            }
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            // 总粉丝
            $fansTotalNum = get_fans_num($uid);
            // 购买过的粉丝总数
            $fansNumOfBuy = S('fansNumOfBuy' . $uid);
            $where['mo.order_status'] = MallModel::ORDER_STATUS_FINISH;
            if (!$fansNumOfBuy) {
                $sql = $User->alias('u')
                    ->field('u.uid')
                    ->join('INNER JOIN __MALL_ORDER__ mo ON u.uid=mo.user_id')
                    ->where($where)
                    ->group('u.uid')
                    ->buildSql();
                $fansNumOfBuy = $User->table($sql . ' a')->count();
                S('fansNumOfBuy' . $uid, $fansNumOfBuy, 1);
            }

            unset($where['mo.order_status']);
            $count = $User->alias('u')->where($where)->count();// 粉丝总数
            $this->assign('fansNumOfBuy', $fansNumOfBuy);
            $this->assign('fansTotalNum', $fansTotalNum);
            $this->assign('pageSize', $this->pageSize);
            $this->assign('count', $count);
            $this->display();
        }
    }

    /**
     * 我的二级合伙人
     */
    public function partners()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();
        if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
            $this->error('还不是合伙人,请申请....', U('Partner/Index/apply'));
        }
        $User = M('User');
        $where = array(
            'u.invite_id' => $uid,
            'u.partner_status' => UserModel::PARTNER_STATUS_PASS,
            'u.subscribe_time' => array('NEQ', 0),
        );

        if (IS_AJAX) {
            $page = I('post.p', 1, 'intval');
            $where1 = array_merge($where, array('mo.order_status' => MallModel::ORDER_STATUS_FINISH));
            $sql1 = $User->alias('u')
                ->field('u.*, SUM(mo.total_price) AS total_money, mo.order_status')
                ->join("LEFT JOIN __MALL_ORDER__ mo ON u.uid=mo.user_id")
                ->where($where)
                ->group('u.uid')
                ->having('mo.order_status=' . MallModel::ORDER_STATUS_FINISH)
                ->order('total_money DESC')
                ->buildSql();

            $where2 = $where;
            $where2['mo.order_status'] = array(
                array('NEQ', MallModel::ORDER_STATUS_FINISH),
                array('EXP', 'is NULL'),
                'OR'
            );

            $sql2 = $User->alias('u')
                ->field('u.*, SUM(mo.total_price) AS total_money, mo.order_status')
                ->join("LEFT JOIN __MALL_ORDER__ mo ON u.uid=mo.user_id")
                ->where($where)
                ->group('u.uid')
                ->having('mo.order_status<>' . MallModel::ORDER_STATUS_FINISH . ' OR mo.order_status IS NULL ')
                ->order('total_money DESC, u.uid ASC')
                ->buildSql();

            $limit = ($page - 1) * $this->pageSize;
            $offset = $this->pageSize;
            $list = M()->query("($sql1) UNION ($sql2) LIMIT $limit,$offset");

            if ($list) {
                foreach ($list as $key => $value) {
                    $list[$key]['headimgurl'] = avatar($value['headimgurl']);
                    $list[$key]['color'] = is_buy($value['uid']) ? 'text-red' : 'text-blue';
                }
                $end = false;
            } else {
                $end = true;
            }
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            $count = $User->alias('u')->where($where)->count();
            $this->assign('pageSize', $this->pageSize);
            $this->assign('count', $count);
            $this->display();
        }
    }

    /**
     * 我的佣金
     */
    public function commission()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();
        if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
            $this->error('还不是合伙人,请申请....', U('Partner/Index/apply'));
        }

        $map = array('uid' => $uid);
        $Comm = M('commission_log');
        if (IS_AJAX) {
            $page = I('post.p', 0, 'intval');
            $list = $Comm->where($map)
                ->page("{$page},{$this->pageSize}")
                ->order('id DESC')
                ->select();
            $end = true;
            if ($list) {
                $end = false;
                $typeArr = commission_type();
                $commStatusArr = commission_status(true);
                foreach ($list as $key => $value) {
                    $list[$key]['create_time'] = format_date($value['create_time'], 'Y.m.d');
                    $list[$key]['type_string'] = $typeArr[$value['type']];
                    $list[$key]['money'] = convert_money($value['money']);
                    $nickname = get_user_field($value['fans_id']);
                    $list[$key]['fans_id'] = $nickname != '' ? $nickname : get_user_field($value['fans_id'], 'realname');
                    $list[$key]['status_string'] = $list[$key]['type'] == CommissionModel::TYPE_SPREAD ? '' : $commStatusArr[$value['status']];
                }
            }
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            $settledAmount = get_settled_commission($uid);
            $nosettledAmount = get_nosettled_commission($uid);

            $count = $Comm->where($map)->count();
            $this->assign('user', $user);
            $this->assign('count', $count);
            $this->assign('pageSize', $this->pageSize);
            $this->assign('settledAmount', $settledAmount);
            $this->assign('nosettledAmount', $nosettledAmount);
            $this->display();
        }

    }

    /**
     * 已结算佣金
     */
    public function settled()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();
        if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
            $this->error('还不是合伙人,请申请....', U('Partner/Index/apply'));
        }

//        $map = array(
//            'uid' => $uid,
//            'status' => CommissionModel::STATUS_YES,
//            'type' => array('NEQ', CommissionModel::TYPE_SPREAD)
//        );
        $map['_string'] = " (uid = $uid AND status=" . CommissionModel::STATUS_YES . " AND type<>" . CommissionModel::TYPE_SPREAD . ")
                            OR
                            (type=" . CommissionModel::TYPE_SPREAD . " AND money<0) ";
        $Comm = M('commission_log');

        if (IS_AJAX) {
            $page = I('post.p', 0, 'intval');
            $list = $Comm->where($map)
                ->page($page, $this->pageSize)
                ->order('id DESC')
                ->select();

            if ($list) {
                $end = false;
                $typeArr = commission_type();
                foreach ($list as $key => $value) {
                    $list[$key]['pay_time'] = format_date($value['pay_time'], 'Y.m.d');
                    $list[$key]['type'] = $typeArr[$value['type']];
                    $list[$key]['money'] = abs(convert_money($value['money']));
                    $nickname = get_user_field($value['fans_id']);
                    $list[$key]['fans_id'] = $nickname != '' ? $nickname : get_user_field($value['fans_id'], 'realname');
                }
            } else {
                $end = true;
            }
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            $count = $Comm->where($map)->count();
            $this->assign('pageSize', $this->pageSize);
            $this->assign('count', $count);
            $this->display();
        }
    }

    /**
     * 未结算佣金
     */
    public function nosettled()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();
        if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
            $this->error('还不是合伙人,请申请....', U('Partner/Index/apply'));
        }

        $map = array(
            'uid' => $uid,
            'status' => array('NEQ', CommissionModel::STATUS_YES),
            'type' => array('NEQ', CommissionModel::TYPE_SPREAD)
        );
        $Comm = M('commission_log');

        if (IS_AJAX) {
            $page = I('post.p', 0, 'intval');
            $list = $Comm->where($map)
                ->page($page, $this->pageSize)
                ->order('id DESC')
                ->select();
            if ($list) {
                $end = false;
                $typeArr = commission_type();
                foreach ($list as $key => $value) {
                    $list[$key]['create_time'] = format_date($value['create_time'], 'Y.m.d');
                    $list[$key]['type'] = $typeArr[$value['type']];
                    $list[$key]['money'] = convert_money($value['money']);
                    $nickname = get_user_field($value['fans_id']);
                    $list[$key]['fans_id'] = $nickname != '' ? $nickname : get_user_field($value['fans_id'], 'realname');
                }
            } else {
                $end = true;
            }
            $this->ajaxReturn(array('code' => 0, 'data' => $list, 'end' => $end));
        } else {
            $count = $Comm->where($map)->count();
            $this->assign('pageSize', $this->pageSize);
            $this->assign('count', $count);
            $this->display();
        }
    }

    public function question()
    {
        // 实例化模型
        $this->content = $this->get_content(3);
        $this->display();
    }

    /**
     * 个人二维码页面
     */
    public function qrcode()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();
        //if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
        //    $this->error('还不是合伙人,请申请....', U('Partner/Index/apply'));
        //}
        //$qrcode = create_qrcode_url($uid);
        $qrcode = $this->createQR_codeUrl($uid); // 长链接转短连接
        $fansNum = get_fans_num($uid);

        $this->assign('fansNum', $fansNum);
        $this->assign('qrcode', $qrcode);
        $this->assign('user', $user);
        $this->display();
    }

    /**
     * 将一条长链接转成短链接之后生成二维码
     * @param $uid
     * @author gaorenhua <597170962@qq.com>
     */
    public function createQR_codeUrl($uid)
    {
        // 待转长链接
        $longUrl = U('Mall/Index/index', array('uid' => $uid), true, true);
        $shortUrl = $this->wechat->getShortUrl($longUrl);

        // 获取二维码ticket
        if (!S('long_ticket_qrcode'.$uid)) {
            $ticket = $this->wechat->getQRCode($shortUrl, 2);
            S('long_ticket_qrcode'.$uid, $ticket['ticket']);
        }
        return $this->wechat->getQRUrl(S('long_ticket_qrcode'.$uid));
    }

    /**
     * 销售金额
     */
    public function sale()
    {
        $uid = session('uid');
        $user = M('user')->where('uid=' . $uid)->find();
        if ($user['partner_status'] != UserModel::PARTNER_STATUS_PASS) {
            $this->error('还不是合伙人,请申请....', U('Partner/Index/apply'));
        }

        $User = M('user');
        $list = $User->alias('u')
            ->field('u.nickname, u.headimgurl, mo.total_price')
            ->join('INNER JOIN __MALL_ORDER__ mo ON u.uid=mo.user_id')
            ->where(array('u.uid' => $uid, 'order_status' => MallModel::ORDER_STATUS_WAIT_PAY))
            ->order('mo.pay_time DESC')
            ->select();
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 获取文章内容
     * @param $aid 文章id
     * @return mixed 内容
     */
    protected function get_content($aid)
    {
        //实例化模型
        $article = M('article');
        $content = $article->where('id='. $aid)->getField('content');
        return htmlspecialchars_decode($content);
    }
}
