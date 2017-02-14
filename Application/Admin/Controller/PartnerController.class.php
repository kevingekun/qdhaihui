<?php
namespace Admin\Controller;

use Common\Controller\AdminController;
use Common\Model\AttributeModel;
use Common\Model\MallModel;
use Common\Model\UserModel;
use Org\Util\Csv;

/**
 * 合伙人相关
 * @author: yanhuaitang
 * @date: 2015/10/22 10:40
 */
class PartnerController extends AdminController
{
    /**
     * 合伙人列表
     */
    public function index()
    {
        // 筛选条件
        $map = array(
            'nickname' => I('get.nickname', '', 'trim'),
            'phone' => I('get.phone', '', 'trim'),
            'group_id' => I('get.group_id', 0, 'intval'),
            'tag_id' => I('get.tag_id', 0, 'intval'),
            'start_time' => I('get.start_time', '', 'trim'),
            'end_time' => I('get.end_time', '', 'trim'),
            'order' => I('get.order', 0, 'intval'),
        );

        $where = array(
            'u.partner_status' => UserModel::PARTNER_STATUS_PASS,
            'u.subscribe_time' => array('GT', 0)
        );

        $order = 'u.uid DESC';
        if ($map['nickname'] != '') $where['u.nickname'] = array('LIKE', '%' . $map['nickname'] . '%');
        if ($map['phone'] != '') $where['u.phone'] = array('LIKE', '%' . $map['phone'] . '%');

        if ($map['start_time'] != '' && $map['end_time'] != '') {
            $where['u.create_time'] = array('BETWEEN', array(strtotime($map['start_time']), strtotime($map['end_time'])));
        } else {
            if ($map['start_time'] != '') $where['u.create_time'] = array('BETWEEN', strtotime($map['start_time']));
            if ($map['end_time'] != '') $where['u.create_time'] = array('ELT', strtotime($map['end_time']));
        }

        if ($map['group_id'] > 0) $where['u.group_id'] = $map['group_id'];
        if ($map['tag_id'] > 0) $where['_string'] = 'FIND_IN_SET(\'' . $map['tag_id'] . '\', tag_id)';

        if ($map['order'] == 1) $order = ' count_fans DESC ';
        if ($map['order'] == 2) $order = ' count_fans ASC ';

        $buildSql = M('user')->alias('u')
            ->field('u.*, count(su.uid) as count_fans')
            ->join('LEFT JOIN __VIEW_ALL_FANS__ su ON u.uid=su.invite_id')
            //->join('LEFT JOIN __MALL_ORDER__ mo ON u.uid=mo.user_id')
            ->where($where)
            ->group('u.uid')
            ->order($order)
            ->buildSql();

        // 导出excel
        if (I('get.action') == 'export') {
            $exportData = M()->table($buildSql . ' a')->select();
            foreach ($exportData as $key => $val) {
                $exportData[$key]['tag_id'] = get_tag_text($val['tag_id']);
                $exportData[$key]['group_id'] = get_attr_title($val['group_id'], 'value');
                $exportData[$key]['sum_total_price'] = convert_money($val['sum_total_price']);
                $exportData[$key]['count_order_id'] = get_order_num($val['uid']);
                $exportData[$key]['count_fans'] = intval($val['count_fans']);

                $exportData[$key]['full_address'] = $val['country'] . $val['province'] . $val['city'];
                $exportData[$key]['alipay'] = M('user_payment')->where(array('uid' => $val['uid'], 'pay_way' => 'alipay'))->getField('account');
                $pay_time = M('mall_order')->where(array('user_id' => $val['uid'], 'pay_time' => array('gt', 0)))->order('id DESC')->getField('pay_time');
                $exportData[$key]['pay_time'] = format_date($pay_time, 'Y-m-d H:i:s');
                $exportData[$key]['create_time'] = format_date($val['create_time']);
            }

            $info = array(
                'uid' => 'ID',
                'nickname' => '昵称',
                'phone' => '手机',
                'realname' => '姓名',
                'full_address' => '所在地区',
                'tag_id' => '标签',
                'group_id' => '分组',
                'invite_nickname' => '推荐人',
                'alipay' => '支付宝账户',
                'qq' => 'QQ号',
                'sum_total_price' => '总消费金额',
                'count_order_id' => '成交订单数',
                'count_fans' => '发展下级数量',
                'pay_time' => '最后购买时间',
                'create_time' => '注册时间'
            );
            $this->export($exportData, $info);
        }

        $count = M()->table($buildSql . ' a')->count();
        $list = M()->table($buildSql . ' a')
            ->page($this->page, $this->pageSize)
            ->select();

        // 当日合伙人
        $today = strtotime(date('Y-m-d', NOW_TIME));
        $todayCount = M('user')->where(array(
            'partner_status' => UserModel::PARTNER_STATUS_PASS,
            'create_time' => array('EGT', $today),
            'subscribe_time' => array('GT', 0),
        ))->count();
        $totalCount = M('user')->where(array(
            'partner_status' => UserModel::PARTNER_STATUS_PASS,
            'subscribe_time' => array('GT', 0),
        ))->count();

        // 分组和标签
        $attrModel = new AttributeModel();
        $groups = $attrModel->findAttributes('partner_group');
        $tags = $attrModel->findAttributes('partner_tag');

        $page = $this->page($count, $map, $this->pageSize);

        $this->assign('todayCount', $todayCount);
        $this->assign('totalCount', $totalCount);
        $this->assign('map', $map);
        $this->assign('tags', $tags);
        $this->assign('groups', $groups);
        $this->assign('page', $page);
        $this->assign('list', $list);
        $this->display();
    }

    public function editPartner($id = 0)
    {
        $User = M('User');
        if (IS_POST) {
            $uid = I('post.uid', 0, 'intval');
            $data = array(
                'realname' => I('post.realname'),
                'phone' => I('post.phone'),
                'group_id' => I('post.group_id'),
                'label_id' => I('post.label_id'),
            );
            $res = $User->where('uid=' . $uid)->save($data);
            if (false !== $res) {
                operate_log($uid, 'user', 2);
                $this->success('修改成功');
            } else {
                $this->success('修改失败');
            }
        } else {
            $user = $User->where('uid=' . intval($id))->find();
            if (empty($user)) {
                $this->error('不存在此人');
            }

            // 推荐人姓名
            $inviteNickname = $User->where('uid=' . $user['invite_id'])->getField('nickname');

            // 分组
            $attrModel = new AttributeModel();
            $groups = $attrModel->findAttributes('group');
            $labels = $attrModel->findAttributes('label');

            $this->assign('inviteNickname', $inviteNickname);
            $this->assign('labels', $labels);
            $this->assign('groups', $groups);
            $this->assign('user', $user);
            $this->display();
        }
    }

    /**
     * 合伙人下面的粉丝
     */
    public function fans()
    {
        $map = array(
            'realname' => I('get.realname', '', 'trim'),
            'phone' => I('get.phone', '', 'trim'),
            'group_id' => I('get.group_id', 0, 'intval'),
            'tag_id' => I('get.tag_id', 0, 'intval'),
            'start_time' => I('get.start_time', '', 'trim'),
            'end_time' => I('get.end_time', '', 'trim'),
            'order' => I('get.order', 0),
        );

        $where = array(
            'subscribe_time' => array('GT', 0)
        );
        $uid = I('get.id', 0, 'intval');
        if ($uid > 0) $where['invite_id'] = $uid;

        $order = 'uid DESC';
        if ($map['realname'] != '') $where['realname'] = array('LIKE', '%' . $map['realname'] . '%');
        if ($map['group_id'] > 0) $where['group_id'] = $map['group_id'];
        if ($map['label_id'] > 0) $where['label_id'] = $map['label_id'];
        if ($map['phone'] != '') {
            $where2['phone'] = array('LIKE', '%' . $map['phone'] . '%');
            $where2['nickname'] = array('LIKE', '%' . $map['phone'] . '%');
            $where2['_logic'] = 'OR';
            $where['_complex'] = $where2;
        }

        if ($map['start_time'] != '' && $map['end_time'] != '') {
            $where['create_time'] = array('BETWEEN', array(strtotime($map['start_time']), strtotime($map['end_time'])));
        } else {
            if ($map['start_time'] != '') $where['create_time'] = array('EGT', strtotime($map['start_time']));
            if ($map['end_time'] != '') $where['create_time'] = array('ELT', strtotime($map['end_time']));
        }

        if ($map['group_id'] > 0) $where['group_id'] = $map['group_id'];
        if ($map['tag_id'] > 0) $where['_string'] = 'FIND_IN_SET(\'' . $map['tag_id'] . '\', tag_id)';

        if ($map['order'] == 1) $order = ' uid DESC ';
        if ($map['order'] == 2) $order = ' uid ASC ';

        $User = M('user');
        // 导出excel
        if (I('get.action') == 'export') {
            $exportData = $User->where($where)->order($order)->select();
            foreach ($exportData as $key => $val) {
                $exportData[$key]['invite_id'] = get_invite_user($val['invite_id']);
                $exportData[$key]['partner_status'] = $val['partner_status'] == \Common\Model\UserModel::PARTNER_STATUS_PASS ? '合伙人' : '粉丝';
                $exportData[$key]['address'] = $val['country'] . $val['province'] . $val['city'];
                $exportData[$key]['tag_id'] = get_tag_text($val['tag_id']);
                $exportData[$key]['group_id'] = get_attr_title($val['group_id'], 'value');
                $exportData[$key]['create_time'] = format_date($val['create_time']);
            }
            $info = array(
                'nickname' => '昵称',
                'realname' => '真实姓名',
                'phone' => '手机',
                'partner_status' => '是否合伙人',
                'invite_id' => '邀请人',
                'qq' => 'QQ',
                'address' => '所在地',
                'tag_id' => '标签',
                'group_id' => '分组',
                'create_time' => '注册时间'
            );
            $this->export($exportData, $info);
        }

        $count = $User->where($where)->count();
        $list = $User->where($where)->order($order)->page($this->page, $this->pageSize)->select();
        $page = $this->page($count, $map, $this->pageSize);

        // 分组和标签
        $attrModel = new AttributeModel();
        $groups = $attrModel->findAttributes('partner_group');
        $tags = $attrModel->findAttributes('partner_tag');

        // 当日粉丝
        $today = strtotime(date('Y-m-d', NOW_TIME));
        $whereToday = array(
            'create_time' => array('EGT', $today),
            'subscribe_time' => array('GT', 0),
        );
        if ($uid > 0) $whereToday['uid'] = $uid;
        $todayCount = M('User')->where($whereToday)->count();

        $this->assign('map', $map);
        $this->assign('todayCount', $todayCount);
        $this->assign('count', $count);
        $this->assign('tags', $tags);
        $this->assign('groups', $groups);
        $this->assign('page', $page);
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 合伙人规则设置
     */
    public function rule()
    {
        if (IS_POST) {
            if (!is_date($dateline = I('post.dateline'))) {
                $this->error('日期格式错误, 请重新选择');
            }
            if (!is_positive_number($amount = I('post.amount'))) {
                $this->error('金额必须为正整数');
            }
            $partnerRule = array(
                'dateline' => $dateline,
                'amount' => $amount
            );
            $data = array(
                'value' => json_encode($partnerRule),
            );
            $rs = M('Attribute')->where(array('type' => 'partner_rule'))->find();
            $res = M('Attribute')->where(array('type' => 'partner_rule'))->save($data);
            if ($res !== false) {
                operate_log($rs['id'], 'attribute', 2);
                $this->success('规则更新成功');
            } else {
                $this->error('规则更新失败, 请联系系统管理员');
            }
        } else {
            $partnerRule = M('Attribute')->where(array('type' => 'partner_rule'))->find();
            if ($partnerRule) {
                $partnerRule = json_decode($partnerRule['value'], true);
            }
            $this->assign('partnerRule', $partnerRule);
            $this->display();
        }
    }

    /**
     * 合伙人审核
     */
    public function audit()
    {
        if (IS_POST) {
            $post = I('post.');
            if (!in_array($post['partner_status'], array(UserModel::PARTNER_STATUS_PASS, UserModel::PARTNER_STATUS_REFUSE))) {
                $this->error('审核状态不正确, 请重新选择');
            }
            $partner_status = I('post.partner_status', '', 'intval');

            $data = array(
                'partner_status' => $partner_status,
                'reason' => I('post.reason'),
                'audit_time' => time()
            );

            $uidStr = trim(I('post.uid'), ',');
            $uidArr = explode(',', $uidStr);
            $uidArr = array_map('intval', $uidArr);

            $res = M('User')->where(array('uid' => array('IN', $uidArr)))->save($data);
            if ($res !== false) {
                $users = M('User')->where(array('uid' => array('IN', $uidArr)))->select();
                foreach ($users as $key => $value) {
                    if ($post['partner_status'] == UserModel::PARTNER_STATUS_PASS) {
                        $temp_arr = array('wechat' => 'OPENTM206164559');
                        $user_arr = array('wechat' => $value['openid']);
                        $msg_arr = array(
                            'wechat' => array(
                                'url' => U('Partner/Index/qrcode', '', true, true),
                                'data' => array(
                                    'first' => array('value' => '您的合伙人申请审核通过, 赶紧邀请粉丝去吧'),
                                    'keyword1' => array('value' => $value['nickname']),
                                    'keyword2' => array('value' => '申请合伙人'),
                                    'keyword3' => array('value' => date('Y-m-d H:i:s', $value['audit_time'])),
                                    'remark' => array('value' => '')
                                )
                            )
                        );
                    } else {
                        $temp_arr = array('wechat' => 'OPENTM201057607');
                        $user_arr = array('wechat' => $value['openid']);
                        $msg_arr = array(
                            'wechat' => array(
                                'url' => U('Partner/Index/qrcode', '', true, true),
                                'data' => array(
                                    'first' => array('value' => '您的合伙人申请已被拒绝'),
                                    'keyword1' => array('value' => $value['nickname']),
                                    'keyword2' => array('value' => I('post.reason')),
                                    'remark' => array('value' => '')
                                )
                            )
                        );
                    }
                    addMessengerQueue('wechat', $temp_arr, $user_arr, $msg_arr);
                    operate_log($value['uid'], 'user', 2);
                }
                $this->success('审核成功');
            } else {
                $this->error('修改失败');
            }
        } else {
            $map = array(
                'realname' => I('get.realname', '', 'trim'),
                'phone' => I('get.phone', '', 'trim'),
                'nickname' => I('get.nickname', '', 'trim'),
                'start_time' => I('get.start_time', '', 'trim'),
                'end_time' => I('get.end_time', '', 'trim'),
                'partner_status' => I('get.partner_status', ''),
                'check_status' => I('get.check_status', '')
            );

            $where = array(
                'subscribe_time' => array('NEQ', 0),
            );
            if ($map['realname'] != '') $where['realname'] = array('LIKE', '%' . $map['realname'] . '%');
            if ($map['phone'] != '') $where['phone'] = array('LIKE', '%' . $map['phone'] . '%');
            if ($map['nickname'] != '') $where['nickname'] = array('LIKE', '%' . $map['nickname'] . '%');
            if ($map['start_time'] != '') $where['create_time'] = array('EGT', strtotime($map['apply_time']));
            if ($map['end_time'] != '') $where['create_time'] = array('ELT', strtotime($map['apply_time']));
            if ($map['partner_status'] != '') $where['partner_status'] = $map['partner_status'];
            if ($map['check_status'] != '') $where['check_status'] = $map['check_status'];

            $User = M('User');
            $count = $User->where($where)->count();
            $list = $User
                ->where($where)
                ->page("$this->page, $this->pageSize")
                ->order('uid DESC')
                ->select();

            $page = $this->page($count, $map);

            // 合伙人状态
            $partnerStatus = UserModel::$partnerStatus;
            // 修改信息审核状态
            $checkStatus = check_status(-1);

            $this->assign('checkStatus', $checkStatus);
            $this->assign('partnerStatus', $partnerStatus);
            $this->assign('map', $map);
            $this->assign('page', $page);
            $this->assign('list', $list);
            $this->display();
        }
    }

    /**
     * 合伙人审核修改信息
     */
    public function check()
    {
        if (IS_POST) {
            $check_status = I('post.check_status', 0, 'intval');
            $check_reason = I('post.check_reason');
            $uid = I('post.uid', 0, 'intval');
            if (!in_array($check_status, array(UserModel::CHECK_STATUS_PASS, UserModel::CHECK_STATUS_REFUSE))) {
                $this->error('审核状态不正确, 请重新选择');
            }

            $uidStr = trim(I('post.uid'), ',');
            $uidArr = explode(',', $uidStr);
            $uidArr = array_map('intval', $uidArr);

            $users = M('User')->where(array('uid' => array('IN', $uidArr)))->select();
            if ($users) {
                foreach ($users as $key => $value) {
                    $tempInfo = trim($value['user_info_temp']) == '' ? array() : unserialize($value['user_info_temp']);
                    if ($tempInfo) {
                        $data = array(
                            'uid' => $value['uid'],
                            'realname' => $tempInfo['realname'],
                            'phone' => $tempInfo['phone'],
                            'qq' => $tempInfo['qq'],
                            'check_status' => $check_status,
                            'check_reason' => $check_reason,
                            //'audit_time' => time()
                        );
                        $paymentData = array(
                            'uid' => $value['uid'],
                            'pay_way' => $tempInfo['pay_way'],
                            'account' => $tempInfo['account'],
                            'authen_name' => $tempInfo['authen_name'],
                            'create_time' => time(),
                            'update_time' => time()
                        );
                        $res1 = M('user')->save($data);

                        if ($check_status == UserModel::PARTNER_STATUS_PASS) {
                            $p = M('user_payment')->where(array('pay_way' => 'alipay', 'uid' => $value['uid']))->find();
                            $res2 = $p ? M('user_payment')->where(array('id' => $p['id']))->save($paymentData) : M('user_payment')->add($paymentData);

                            $temp_arr = array('wechat' => 'OPENTM206164559');
                            $user_arr = array('wechat' => $value['openid']);
                            $msg_arr = array(
                                'wechat' => array(
                                    'url' => U('Partner/Index/apply', '', true, true),
                                    'data' => array(
                                        'first' => array('value' => '您的修改信息申请已审核通过'),
                                        'keyword1' => array('value' => $value['nickname']),
                                        'keyword2' => array('value' => '修改信息'),
                                        'keyword3' => array('value' => date('Y-m-d H:i:s', $value['audit_time'])),
                                        'remark' => array('value' => '')
                                    )
                                )
                            );
                            addMessengerQueue('wechat', $temp_arr, $user_arr, $msg_arr);
                            operate_log($value['uid'], 'user', 2);
                        } else {

                            $temp_arr = array('wechat' => 'OPENTM201057607');
                            $user_arr = array('wechat' => $value['openid']);
                            $msg_arr = array(
                                'wechat' => array(
                                    'url' => U('Partner/Index/apply', '', true, true),
                                    'data' => array(
                                        'first' => array('value' => '您的修改信息申请被拒绝, 请重新申请！'),
                                        'keyword1' => array('value' => $value['nickname']),
                                        'keyword2' => array('value' => I('post.check_reason')),
                                        'remark' => array('value' => '')
                                    )
                                )
                            );
                            addMessengerQueue('wechat', $temp_arr, $user_arr, $msg_arr);
                            operate_log($value['uid'], 'user', 2);
                        }
                    }
                }
            }
            $this->success('审核完成');
        }
    }

    /**
     * 自定义标签
     */
    public function label()
    {
        $attrModel = new AttributeModel();
        if (IS_POST) {
            $attribute = I('post.attribute');
            $ids = I('post.ids');
            $sql = '';
            foreach ($attribute as $key => $value) {
                if ($value == '') {
                    $this->error('请正确填写标签值');
                }
                $sql .= " UPDATE __ATTRIBUTE__ SET `title`='{$value}' WHERE `id`={$ids[$key]};";
            }
            $attrModel->execute($sql);
            redirect(U('Admin/Partner/label'));
        } else {
            $attribute = $attrModel->findAttributes('label', AttributeModel::STATUS_ON);
            $this->assign('attribute', $attribute);
            $this->display();
        }
    }

    /**
     * 标签管理
     */
    public function tag()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            $tagname = I('post.tagname');
            if ($tagname == '') {
                $this->error('标签名称不能为空');
            }

            if ($id) {
                $res = M('attribute')->where(array('id' => $id, 'type' => 'partner_tag', 'status' => 0))->setField('value', $tagname);
            } else {
                $data = array(
                    'type' => 'partner_tag',
                    'status' => 0,
                    'title' => '合伙人标签',
                    'value' => $tagname
                );
                $res = M('attribute')->add($data);
            }
            if (false !== $res) {
                $this->success('修改成功');
            } else {
                $this->error('修改失败');
            }
        } else {
            $list = M('attribute')->where(array('type' => 'partner_tag', 'status' => 0))->select();

            $id = I('get.id', 0, 'intval');
            if ($id) {
                $tag = M('attribute')->where(array('id' => $id, 'type' => 'partner_tag', 'status' => 0))->find();
                $this->assign('tag', $tag);
            }

            $this->assign('list', $list);
            $this->display();
        }
    }

    /**
     * 删除标签
     * @param $id 标签id
     */
    public function delTag($id)
    {
        $id = intval($id);
        $res = M('attribute')->where(array('id' => $id, 'type' => 'partner_tag', 'status' => 0))->delete();
        if ($res) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 分组管理
     */
    public function group()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            $groupname = I('post.groupname');
            if ($groupname == '') {
                $this->error('标签名称不能为空');
            }

            if ($id) {
                $res = M('attribute')->where(array('id' => $id, 'type' => 'partner_group', 'status' => 0))->setField('value', $groupname);
            } else {
                $data = array(
                    'type' => 'partner_group',
                    'status' => 0,
                    'title' => '合伙人分组',
                    'value' => $groupname
                );
                $res = M('attribute')->add($data);
            }
            if (false !== $res) {
                $this->success('修改成功');
            } else {
                $this->error('修改失败');
            }
        } else {
            $list = M('attribute')->where(array('type' => 'partner_group', 'status' => 0))->select();

            $id = I('get.id', 0, 'intval');
            if ($id) {
                $group = M('attribute')->where(array('id' => $id, 'type' => 'partner_group', 'status' => 0))->find();
                $this->assign('group', $group);
            }

            $this->assign('list', $list);
            $this->display();
        }
    }

    /**
     * 删除分组
     * @param $id 分组id
     */
    public function delGroup($id)
    {
        $id = intval($id);
        $res = M('attribute')->where(array('id' => $id, 'type' => 'partner_group', 'status' => 0))->delete();
        if ($res) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 给用户设置分组
     */
    public function setGroup()
    {
        $uid = I('post.uid');
        $group_id = I('post.partner_group');
        if ($uid == '') $this->error('数据错误, 请重新操作!');

        $uidArr = explode(',', trim($uid, ','));
        $n = 0;
        foreach ($uidArr as $key => $value) {
            $res = M('user')->where(array('uid' => $value))->setField('group_id', $group_id);
            if (false !== $res) $n++;
        }
        $this->success(sprintf('共%d条, 成功%d条, 失败%d条', count($uidArr), $n, count($uidArr) - $n));
    }

    /**
     * 给用户设置标签
     */
    public function setTag()
    {
        $uid = I('post.uid');
        $tag_id = I('post.partner_tag');
        if ($uid == '') $this->error('数据错误, 请重新操作!');

        $uidArr = explode(',', trim($uid, ','));
        $n = 0;
        foreach ($uidArr as $key => $value) {
            $user = M('user')->where(array('uid' => $value))->find();
            if ($user) {
                $userTag = trim($user['tag_id']);
                $userTagArr = explode(',', $userTag);
                if (!in_array($tag_id, $userTag)) {
                    $userTagArr[] = $tag_id;
                }
                $userTagArr = array_filter($userTagArr);
                ksort($userTagArr);
                $tagStr = implode(',', $userTagArr);
                $res = M('user')->where(array('uid' => $value))->setField('tag_id', $tagStr);
                if (false !== $res) $n++;
            }
        }
        $this->success(sprintf('共%d条, 成功%d条, 失败%d条', count($uidArr), $n, count($uidArr) - $n));
    }

    /**
     * 给合伙人单独设置佣金比例
     */
    public function setCommission()
    {
        $uid = I('post.uid', 0, 'intval');
        $commission_ratio = I('post.commission_ratio', 0, 'floatval');

        $user = M('user')->where(array('uid' => $uid))->find();
        if (!$user) $this->error('数据错误, 请重新操作!');
        if ($commission_ratio > 30) $this->error('佣金比例不能大于30%!');

        $rs = M('user')->where(array('uid' => $uid))->setField('commission_ratio', $commission_ratio);

        if (false !== $rs) {
            $this->success('设置佣金比例成功');
        } else {
            $this->error('设置佣金比例失败');
        }
    }


    //private function

    /**
     * 删除用户标签
     * @param $uid 用户uid
     * @param $id 标签id
     */
    public function delUserTag($uid, $id)
    {
        $user = M('user')->where(array('uid' => $uid))->find();
        if (!$user) $this->error('用户不存在');
        $tagArr = explode(',', $user['tag_id']);

        if (in_array($id, $tagArr)) {
            foreach ($tagArr as $k => $v) {
                if ($id == $v) unset($tagArr[$k]);
            }
        }

        $tagStr = implode(',', $tagArr);
        $res = M('user')->where(array('uid' => $uid))->setField('tag_id', $tagStr);
        if ($res !== false) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 更新协议
     */
    public function article()
    {
        // 实例化模型
        $model = M('article');

        if (IS_POST) {
            $data = $model->create();
            $data['create_time'] = $_SERVER['REQUEST_TIME'];

            if ($model->save($data)) {
                $this->success('更新成功');
            } else {
                $this->error('更新失败');
            }
        } else {
            $id = I('get.id', 0, 'intval');
            $type = $model->field('id,content')->find($id);
            $this->type = $type;
            $this->display();
        }
    }
}
