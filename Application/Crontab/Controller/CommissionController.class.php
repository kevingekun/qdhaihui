<?php
/**
 * 合伙人相关
 * @author: yanhuaitang
 * @date: 2015/11/2 15:25
 */

namespace Crontab\Controller;

use Common\Controller\CrontabController;
use Common\Model\MallModel;
use Common\Model\UserModel;

class CommissionController extends CrontabController
{
    /**
     * 购买产品产生的佣金, 每批执行25条
     * 1. 粉丝购买返给上级
     * 2. 合伙人身份购买, 返给自身,也返给上级
     */
    public function productCommission()
    {
        $Order = M('mall_order');
        $where = array(
            'order_status' => MallModel::ORDER_STATUS_FINISH,
            'commission_status' => MallModel::COMMISSION_STATUS_NO,
            'complete_time' => array('ELT', time() - 60 * 60 * 24 * 7)
        );

        // 所有没撸佣金的订单
        $orders = $Order->where($where)->limit(0, 25)->order('pay_time ASC')->select();
        if ($orders) {
            $dataList = array();
            $orderIds = array();
            foreach ($orders as $key => $value) {
                $user = M('User')->where('uid=' . intval($value['user_id']))->find();
                $goodsInfo = json_decode($value['cart_data'], true);
                $orderIds[] = $value['id'];

                // 若是合伙人
                if ($user['partner_status'] == UserModel::PARTNER_STATUS_PASS) {
                    // 是合伙人 给自己加佣金日志
                    $dataList[] = array(
                        'uid' => $user['uid'],
                        'type' => 1,
                        'order_id' => $value['id'],
                        'money' => $value['commission'],
                        'fans_id' => $value['user_id'],//贡献者是自己
                        'desc' => "购买商品",
                        'status' => 0,
                        'create_time' => time(),
                        'update_time' => time(),
                    );
                } else {
                    //给上级加佣金日志,
                    if ($user['invite_id'] > 0) {
                        $dataList[] = array(
                            'uid' => $user['invite_id'],
                            'type' => 1,
                            'order_id' => $value['id'],
                            'money' => $value['commission'],
                            'fans_id' => $value['user_id'],
                            'desc' => "购买了{$goodsInfo['num']}台{$goodsInfo['name']}",
                            'status' => 0,
                            'create_time' => time(),
                            'update_time' => time(),
                        );
                    }
                }
            }

            M()->startTrans();
            //$res1: 给合伙人返佣金
            //$res2: 将核算过佣金的订单修改状态
            //$res3: 给合伙人的上级返佣金提成
            if ($res1 = M('commission_log')->addAll($dataList)) {

                //$res1 批量插入, 返回最小的id
                $map['id'] = array('EGT', $res1);
                $cLogs = M('commission_log')->where($map)->select();// 获取此次执行, 添加的所有的佣金记录
                $res3 = $this->commissionRewardByPercent($cLogs);

                // 处理过佣金的订单修改成已完成状态
                $where['id'] = array('IN', $orderIds);
                $data['commission_status'] = MallModel::COMMISSION_STATUS_YES;
                $res2 = $Order->where($where)->data($data)->save();
            }

            $date = date('Y-m-d H:i:s');

            if ($res1 && $res2 && !is_array($res3) && $res3) {
                M()->commit();
                exit($date . '　　处理产品佣金成功');
            } elseif ($res1 && $res2 && is_array($res3) && empty($res3)) {
                M()->commit();
                exit($date . '　　处理产品佣金成功');
            } else {
                M()->rollback();
                exit($date . '　　处理产品佣金失败');
            }
        } else {
            exit(date('Y-m-d H:i:s') . '已经没有可处理佣金的订单了');
        }
    }


    /**
     * 推广佣金
     */
    public function spreadCommission()
    {
        $User = M('user');
        $map1 = array(
            // 'partner_status' => UserModel::PARTNER_STATUS_PASS,// 只要是粉丝就计算反佣金
            'commission_status' => UserModel::COMMISSION_STATUS_NO,
            'invite_id' => array('GT', 0),
            'subscribe_time' => array('GT', 0),
        );
        $users = $User->where($map1)->limit(0, 25)->order('create_time ASC')->select();

        //每增加1名粉丝获得佣金
        $attribute = M('attribute')->where(array('type' => 'commission_spread'))->getField('value');
        $attr = json_decode($attribute, true);
        $spread = (is_array($attr) && isset($attr['spread'])) ? intval($attr['spread']) : 0;

        if($users && $spread > 0){
            $dataList = array();
            $uids = array();
            foreach($users as $k => $user){
                $uids[] = $user['uid'];
                $dataList[] = array(
                    'uid' => $user['invite_id'],
                    'type' => 3,
                    'order_id' => 0,
                    'money' => $spread,
                    'fans_id' => $user['uid'],
                    'desc' => "推荐{$user['nickname']}获得推广佣金",
                    'status' => 0,
                    'create_time' => time(),
                    'update_time' => time(),
                );
            }
            M()->startTrans();
            $res1 = M('commission_log')->addAll($dataList);

            // 获取需要处理佣金提成的记录
            //$map2['id'] = array('EGT', $res1);
            //$cLogs = M('commission_log')->where($map2)->select();
            //$res3 = $this->commissionRewardByPercent($cLogs, 4);

            $where = array(
                'uid' => array('IN', $uids),
                'commission_status' => UserModel::COMMISSION_STATUS_NO
            );
            $data = array(
                'commission_status' => UserModel::COMMISSION_STATUS_YES
            );
            $res2 = $User->where($where)->data($data)->save();

            $date = date('Y-m-d H:i:s');
// 干掉推广佣金提成
//            if ($res1 && $res2 && !is_array($res3) && $res3) {
//                M()->commit();
//                exit($date . '　　处理推广佣金成功');
//            } elseif ($res1 && $res2 && is_array($res3) && empty($res3)) {
//                M()->commit();
//                exit($date . '　　处理推广佣金成功');
//            } else {
//                M()->rollback();
//                exit($date . '　　处理推广佣金失败');
//            }

            if ($res1 && $res2) {
                M()->commit();
                exit($date . '　　处理推广佣金成功');
            } else {
                M()->rollback();
                exit($date . '　　处理推广佣金失败');
            }

        } else {
            exit(date('Y-m-d H:i:s') . '没有需要处理的推广佣金');
        }

    }

    /**
     * 按百分比, 从二级合伙人的佣金给一级合伙人提成
     * @param $cLogs 需要计算佣金提成的 佣金记录( 比如销售佣金记录和推广佣金记录, 按每一条 按比例提给上级合伙人 )
     * @param $type 奖励类型 1-产品佣金, 2-销售提成, 3-推广佣金, 4-激励佣金
     * @return array|bool|string 返回空数组-无拥挤记录可以按比例提, 返回数字-表示批量添加记录的第一条记录的id
     */
    private function commissionRewardByPercent($cLogs, $type=2)
    {
        // 提成比例
        $attribute = M('attribute')->where(array('type' => 'commission_sale'))->getField('value');
        $attr = json_decode($attribute, true);
        $percent = (is_array($attr) && isset($attr['sale'])) ? intval($attr['sale']) : 0;

        // 销售提成: 从佣金中按 提成规则百分比提给上级合伙人
        $dataList = array();
        foreach ($cLogs as $k => $v) {
            $inviteId = M('user')->where(array('uid' => $v['uid']))->getField('invite_id');

            if ($inviteId > 0 && $percent > 0) {
                $dataList[] = array(
                    'uid' => $inviteId,
                    'type' => $type,// 佣金类型,  1-产品佣金, 2-产品佣金提成, 3-推广佣金, 4-推广佣金提成, 5-激励佣金
                    'order_id' => $v['order_id'],
                    'money' => intval($v['money'] * $percent / 100),
                    'fans_id' => $v['fans_id'],
                    'desc' => "获得下线提供的佣金提成",
                    'status' => 0,
                    'create_time' => time(),
                    'update_time' => time(),
                );
            }
        }

        if(empty($dataList)){
            return array();
        } else {
            return M('commission_log')->addAll($dataList);
        }
    }


}

