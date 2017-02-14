<?php
namespace Admin\Controller;

use Common\Controller\AdminController;
use Common\Model\AttributeModel;
use Common\Model\CommissionModel;
use Common\Model\UserModel;
use Org\Util\CsvImporter;

/**
 * 佣金相关操作
 * @author: yanhuaitang
 * @date: 2015/10/29 16:55
 */
class CommissionController extends AdminController
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
     * 合伙人销售佣金统计
     */
    public function partner()
    {
        $where = array();

        $map = I('get.');
        if ($map['realname'] != '') $where['u.realname'] = array('LIKE', '%' . $map['realname'] . '%');
        if ($map['phone'] != '') {
            $where2['u.phone'] = array('LIKE', '%' . $map['phone'] . '%');
            $where2['u.nickname'] = array('LIKE', '%' . $map['phone'] . '%');
            $where2['_logic'] = 'OR';
            $where['_complex'] = $where2;
        }

        if ($map['start_time'] != '' && $map['end_time'] != '') {
            $where['cl.create_time'] = array('BETWEEN', array(strtotime($map['start_time']), strtotime($map['end_time'])));
        } else {
            if ($map['start_time'] != '') $where['cl.create_time'] = array('EGT', strtotime($map['start_time']));
            if ($map['end_time'] != '') $where['cl.create_time'] = array('ELT', strtotime($map['end_time']));
        }

        if ($map['start_money'] != '') $where['cl.money'] = array('EGT', floatval($map['start_money']));
        if ($map['end_money'] != '') $where['cl.money'] = array('ELT', floatval($map['end_money']));

        if ($map['commission_type'] != '') $where['cl.type'] = intval($map['commission_type']);
        $map['commission_status'] = I('get.commission_status', -1, 'intval');
        if ($map['commission_status'] != -1) $where['cl.status'] = intval($map['commission_status']);

        $order = 'cl.create_time DESC';
        if ($map['order'] == 1) $order = 'cl.money ASC ';
        if ($map['order'] == 2) $order = 'cl.money DESC';

        $where['partner_status'] = UserModel::PARTNER_STATUS_PASS;
        $User = M('User');

        //佣金类型
        $commission_type = commission_type();
        $commission_status = commission_status();

        $count = $User->alias('u')
            ->join('INNER JOIN __COMMISSION_LOG__ cl ON cl.uid=u.uid')
            ->order($order)
            ->where($where)
            ->count();

        //导出excel
        if (isset($map['action']) && $map['action'] == 'export' && $count > 0) {
            $exportData = $User->alias('u')
                ->field('u.realname,u.nickname,u.phone,u.uid,cl.money,cl.status,cl.type,cl.create_time,cl.id')
                ->join('INNER JOIN __COMMISSION_LOG__ cl ON cl.uid=u.uid')
                ->order($order)
                ->where($where)
                ->select();
            foreach ($exportData as $key => $val) {
                $exportData[$key]['status'] = $commission_status[$val['status']];
                $exportData[$key]['type'] = $commission_type[$val['type']];
                $exportData[$key]['account'] = get_pay_account($val['uid']);
                $exportData[$key]['money'] = convert_money($val['money']);
                $exportData[$key]['fans_num'] = get_fans_num($val['uid']);
                $exportData[$key]['create_time'] = date('Y-m-d H:i:s', $val['create_time']);
            }
            $info = array(
                'id' => '佣金ID',
                'uid' => '用户ID',
                'realname' => '姓名',
                'nickname' => '微信昵称',
                'phone' => '手机',
                'account' => '支付宝账号',
                'fans_num' => '粉丝数',
                'money' => '金额(单位:元)',
                'status' => '状态',
                'type' => '佣金种类',
                'create_time' => '创建时间',
            );
            $this->export($exportData, $info);
        }

        /**
         * 按时间导出不含推广佣金的佣金记录
         */
        if (isset($map['action']) && $map['action'] == 'exportTaskData') {
            $whereExportTask = array();
            if ($map['start_time'] != '' && $map['end_time'] != '') {
                $whereExportTask['cl.create_time'] = array('BETWEEN', array(strtotime($map['start_time']), strtotime($map['end_time'])));
            } else {
                if ($map['start_time'] != '') $whereExportTask['cl.create_time'] = array('EGT', strtotime($map['start_time']));
                if ($map['end_time'] != '') $whereExportTask['cl.create_time'] = array('ELT', strtotime($map['end_time']));
            }
            $whereExportTask['cl.type'] = array('NEQ', CommissionModel::TYPE_SPREAD);
            $exportData = $User->alias('u')
                ->field('u.realname,u.nickname,u.phone,u.uid,cl.money,cl.status,cl.type,cl.create_time,cl.id')
                ->join('INNER JOIN __COMMISSION_LOG__ cl ON cl.uid=u.uid')
                ->order($order)
                ->where($whereExportTask)
                ->select();
            $this->exportTaskData($exportData);
        }

        $list = $User->alias('u')
            ->field('u.realname,u.nickname,u.phone,u.uid,cl.id,cl.money,cl.status,cl.type,cl.create_time,cl.invoice')
            ->join('INNER JOIN __COMMISSION_LOG__ cl ON cl.uid=u.uid')
            ->order($order)
            ->where($where)
            ->page("$this->page,$this->pageSize")
            ->select();


        $map = array_filter($map);
        $page = $this->page($count, $map, $this->pageSize);

        // 分组
//        $attrModel = new AttributeModel();
//        $groups = $attrModel->findAttributes('group');
//        $labels = $attrModel->findAttributes('label');


        // 各类佣金总额统计
        $commission['commission'] = total_commission();//总计佣金
        $commission['commission_product'] = total_commission(CommissionModel::TYPE_PRODUCT);//销售佣金总额
        $commission['commission_product_reward'] = total_commission(CommissionModel::TYPE_PRODUCT_REWARD);//销售佣金提成总额
        $commission['commission_spread'] = total_commission(CommissionModel::TYPE_SPREAD);//推广佣金总额
        //$commission['commission_spread_reward'] = total_commission(CommissionModel::TYPE_SPREAD_REWARD);//推广佣金提成总额

        $this->assign('commission', $commission);
        $this->assign('map', $map);
        $this->assign('commission_type', $commission_type);
        $this->assign('commission_status', $commission_status);
//        $this->assign('labels', $labels);
//        $this->assign('groups', $groups);
        $this->assign('page', $page);
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 导出要结算的佣金
     * @param $exportData
     */
    private function exportTaskData($exportData)
    {
        if (empty($exportData)) $this->error('没有符合条件的数据');

        //佣金类型
        $commission_type = commission_type();
        $commission_status = commission_status();

        foreach ($exportData as $key => $val) {
            $exportData[$key]['status'] = $commission_status[$val['status']];
            $exportData[$key]['type'] = $commission_type[$val['type']];
            $exportData[$key]['account'] = get_pay_account($val['uid']);
            $exportData[$key]['money'] = convert_money($val['money']);
            $exportData[$key]['create_time'] = date('Y-m-d H:i:s', $val['create_time']);
        }
        $info = array(
            'id' => '佣金ID',
            'uid' => '用户ID',
            'realname' => '姓名',
            'nickname' => '微信昵称',
            'phone' => '手机',
            'account' => '支付宝账号',
            'money' => '金额',
            'status' => '状态',
            'type' => '佣金类型',
            'create_time' => '创建时间',
        );

        $this->export($exportData, $info);
    }

    /**
     * 佣金调整
     */
    public function change()
    {
        if (IS_POST) {
            $money = convert_money(I('post.money', 0, 'floatval'), '*');
            if (!is_number($money) && !is_decimal($money)) {
                $this->error('金额输入错误, 请重新输入');
            }

            $relation_id = I('post.relation_id', 0, 'intval');
            $comm = M('commission_log')->where(array('id' => $relation_id))->find();
            if (!$comm) $this->error('不存在的佣金记录, 请重新进行调整');

            $desc = I('post.desc');
            $data = array(
                'uid' => $comm['uid'],
                'type' => 5,
                'money' => $money,
                'desc' => $desc,
                'relation_id' => $relation_id,
                'create_time' => time(),
                'update_time' => time(),
            );
            $res = M('commission_log')->add($data);
            if ($res) {
                operate_log($res, 'commission_log', 1);
                $this->success('保存成功', U('Admin/Commission/partner'));
            } else {
                $this->error('保存出错, 请重新操作');
            }
        } else {
            $id = I('get.id', 0, 'intval');
            //$commissionType = commission_type();
            $this->assign('relation_id', $id);
            $this->display();
        }
    }

    /**
     * 设置销售提成
     */
    public function setting_sale()
    {

        if (IS_POST) {
            $sale = floatval(I('post.sale'));
            if ($sale <= 0) {
                $this->error('百分比必须为正数');
            }
            if ($sale >= 60) {
                $this->error('百分比最高不能大于60%');
            }

            $commissionRule = array(
                'sale' => $sale,
            );
            $data = array(
                'value' => json_encode($commissionRule),
            );

            $rule = M('Attribute')->where(array('type' => 'commission_sale'))->find();
            $rs = M('Attribute')->where(array('type' => 'commission_sale'))->save($data);
            if (false !== $rs) {
                operate_log($rule['id'], 'attribute', 2);
                $this->success('规则更新成功');
            } else {
                $this->error('规则更新失败, 请联系系统管理员');
            }
        } else {
            $commissionRule = M('Attribute')->where(array('type' => 'commission_sale'))->find();
            if ($commissionRule) {
                $commissionRule = json_decode($commissionRule['value'], true);
            }
            $this->assign('commissionRule', $commissionRule);
            $this->display();
        }
    }

    /**
     * 推广佣金设置
     */
    public function setting_spread()
    {
        if (IS_POST) {
            $spread = I('post.spread', 0, 'floatval');
            $withdraw = I('post.withdraw', 0, 'floatval');
            if ($spread <= 0) {
                $this->error('金额必须为正数');
            }
            if ($withdraw <= 0) {
                $this->error('提现百分比必须是正数');
            }
            if ($withdraw >= 50) {
                $this->error('提现百分比最高不能大于50%');
            }

            $commissionRule = array(
                'spread' => convert_money($spread, '*'),// 转换成分
                'withdraw' => $withdraw,
            );
            $data = array(
                'value' => json_encode($commissionRule),
            );

            $rule = M('Attribute')->where(array('type' => 'commission_spread'))->find();
            $rs = M('Attribute')->where(array('type' => 'commission_spread'))->save($data);
            if (false !== $rs) {
                operate_log($rule['id'], 'attribute', 2);
                $this->success('规则更新成功');
            } else {
                $this->error('规则更新失败, 请联系系统管理员');
            }
        } else {
            $commissionRule = M('Attribute')->where(array('type' => 'commission_spread'))->find();
            if ($commissionRule) {
                $commissionRule = json_decode($commissionRule['value'], true);
            }
            $this->assign('commissionRule', $commissionRule);
            $this->display();
        }
    }

    /**
     * 设置合伙人佣金比例
     */
//    public function setting_commission()
//    {
//        if (IS_POST) {
//            $commission_top = I('post.commission_top', 0, 'floatval');
//            $commission_second = I('post.commission_second', 0, 'floatval');
//            if ($commission_top <= 0) {
//                $this->error('金额必须为正数');
//            }
//            if ($commission_second <= 0) {
//                $this->error('提现百分比必须是正数');
//            }
//            if ($commission_top >= 40 || $commission_second  >= 40 ) {
//                $this->error('获得佣金比例最高不能大于40%');
//            }
//
//            $data1 = array('value' => $commission_top);
//            $data2 = array('value' => $commission_second);
//
//            $rs1 = M('Attribute')->where(array('type' => 'commission_top'))->save($data1);
//            $rs2 = M('Attribute')->where(array('type' => 'commission_second'))->save($data2);
//            if (false !== $rs1 && false !== $rs2 ) {
//                $this->success('规则更新成功');
//            } else {
//                $this->error('规则更新失败, 请联系系统管理员');
//            }
//        } else {
//            $commission_top = M('Attribute')->where(array('type' => 'commission_top'))->getField('value');
//            $commission_second = M('Attribute')->where(array('type' => 'commission_second'))->getField('value');
//
//            $this->assign('commission_top', $commission_top);
//            $this->assign('commission_second', $commission_second);
//            $this->display();
//        }
//    }

    /**
     * 佣金发放审核
     */
    public function checkList()
    {
        $where = array();
        $map = I('get.');
        if ($map['realname'] != '') $where['u.realname'] = array('LIKE', '%' . $map['realname'] . '%');
        if ($map['phone'] != '') {
            $where2['u.phone'] = array('LIKE', '%' . $map['phone'] . '%');
            $where2['u.nickname'] = array('LIKE', '%' . $map['phone'] . '%');
            $where2['_logic'] = 'OR';
            $where['_complex'] = $where2;
        }
        if ($map['start_time'] != '') $where['cl.create_time'] = array('EGT', strtotime($map['start_time']));
        if ($map['end_time'] != '') $where['cl.create_time'] = array('ELT', strtotime($map['end_time']));

        if ($map['start_money'] != '') $where['cl.money'] = array('EGT', floatval($map['start_money']));
        if ($map['end_money'] != '') $where['cl.money'] = array('ELT', floatval($map['end_money']));

        if ($map['commission_type']) $where['cl.type'] = intval($map['commission_type']);

        $order = 'u.uid DESC';
        if ($map['order'] == 1) $order = 'cl.money ASC ';
        if ($map['order'] == 2) $order = 'cl.money DESC';

        $where['partner_status'] = UserModel::PARTNER_STATUS_PASS;
        $where['cl.status'] = CommissionModel::STATUS_CHECK;


        $User = M('User');

        //佣金类型
        $commission_type = commission_type();
        $commission_status = commission_status();

        $count = $User->alias('u')
            ->join('INNER JOIN __COMMISSION_LOG__ cl ON cl.uid=u.uid')
            ->order($order)
            ->where($where)
            ->count();

        //导出excel
        if (isset($map['action']) && $map['action'] == 'export' && $count > 0) {
            $exportData = $User->alias('u')
                ->field('u.realname,u.nickname,u.phone,u.uid,cl.money,cl.status,cl.type,cl.create_time,cl.id')
                ->join('INNER JOIN __COMMISSION_LOG__ cl ON cl.uid=u.uid')
                ->order($order)
                ->where($where)
                ->select();
            $clIds = array();
            foreach ($exportData as $key => $val) {
                $exportData[$key]['status'] = $commission_status[$val['status']];
                $exportData[$key]['type'] = $commission_type[$val['type']];
                $exportData[$key]['account'] = get_pay_account($val['uid']);
                $exportData[$key]['money'] = convert_money($val['money']);
                $exportData[$key]['create_time'] = date('Y-m-d H:i:s', $val['create_time']);
                if ($val['status'] == CommissionModel::STATUS_NO) {
                    $clIds[] = $val['id'];
                }
            }
            $info = array(
                'realname' => '姓名',
                'nickname' => '微信昵称',
                'phone' => '手机',
                'account' => '支付宝账号',
                'money' => '金额',
                'status' => '状态',
                'type' => '佣金种类',
                'create_time' => '创建时间',
            );
            if ($clIds) {
                $data['status'] = CommissionModel::STATUS_YES;
                M('commission_log')->where(array('id' => array('IN', $clIds)))->data(array('status' => CommissionModel::STATUS_YES))->save();
            }
            $this->export($exportData, $info);
        }

        $list = $User->alias('u')
            ->field('u.realname,u.nickname,u.phone,u.uid,cl.money,cl.status,cl.type,cl.create_time')
            ->join('INNER JOIN __COMMISSION_LOG__ cl ON cl.uid=u.uid')
            ->order($order)
            ->where($where)
            ->page("$this->page,$this->pageSize")
            ->select();

        $map = array_filter($map);
        $page = $this->page($count, $map, $this->pageSize);

        // 分组
//        $attrModel = new AttributeModel();
//        $groups = $attrModel->findAttributes('group');
//        $labels = $attrModel->findAttributes('label');


        // 各类佣金总额统计
//        $commission['commission'] = total_commission();//总计佣金
//        $commission['commission_product'] = total_commission(CommissionModel::TYPE_PRODUCT);//销售佣金总额
//        $commission['commission_product_reward'] = total_commission(CommissionModel::TYPE_PRODUCT_REWARD);//销售佣金提成总额
//        $commission['commission_spread'] = total_commission(CommissionModel::TYPE_SPREAD);//推广佣金总额
//        $commission['commission_spread_reward'] = total_commission(CommissionModel::TYPE_SPREAD_REWARD);//推广佣金提成总额

//        $this->assign('commission', $commission);
        $this->assign('map', $map);
        $this->assign('commission_type', $commission_type);
        $this->assign('commission_status', $commission_status);
//        $this->assign('labels', $labels);
//        $this->assign('groups', $groups);
        $this->assign('page', $page);
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 审核文件列表
     */
    public function fileList()
    {
        $model = M('commission_task');
        $count = $model->count();
        $list = $model->order('id DESC')->select();

        $page = $this->page($count, array(), $this->pageSize);
        $commissionStatus = commission_status();

        $this->assign('commissionStatus', $commissionStatus);
        $this->assign('count', $count);
        $this->assign('list', $list);
        $this->assign('page', $page);
        $this->display();
    }

    /**
     * 文件包含的佣金列表
     */
    public function fileDetail()
    {
        $id = I('get.id', 0, 'intval');
        if (!$id) $this->error('请求出错');

        $count = M('commission_task_data')
            ->where(array('task_id' => $id))
            ->count();
        $list = M('commission_task_data')
            ->where(array('task_id' => $id))
            ->page($this->page, $this->pageSize)
            ->select();

        //佣金类型
        $commission_type = commission_type();
        $commission_status = commission_status();
        $page = $this->page($count, array('id' => $id), $this->pageSize);

        $this->assign('commission_type', $commission_type);
        $this->assign('commission_status', $commission_status);
        $this->assign('count', $count);
        $this->assign('list', $list);
        $this->assign('page', $page);

        $this->display();
    }

    /**
     * 删除审核文件
     * 1. 删除commission_task_data 对应的记录
     * 2. commission_log对应的 佣金记录状态修改为 未结算状态 (除推广佣金),
     * 3. 对应的推广佣金需要删除
     */
    public function fileDel()
    {
        $id = I('get.id', 0, 'intval');
        if (!$id) $this->error('数据出错, 请重新操作');

        $taskData = M('commission_task_data')->where(array('task_id' => $id))->select();
        $taskDataCommissionIdArr = array();
        $taskDataSpreadCommissionIdArr = array();
        foreach ($taskData as $key => $value) {
            if ($value['type'] != CommissionModel::TYPE_SPREAD) {
                $taskDataCommissionIdArr[] = $value['commission_id'];
            } else {
                $taskDataSpreadCommissionIdArr[] = $value['commission_id'];
            }
        }

        M()->startTrans();
        operate_log($id, 'commission_task', 3);
        $res1 = M('commission_task')->delete($id);
        $res2 = M('commission_task_data')->where(array('task_id' => $id))->delete();
        $res3 = M('commission_log')->where(array('id' => array('IN', $taskDataCommissionIdArr)))->setField('status', CommissionModel::STATUS_NO);
        if($taskDataSpreadCommissionIdArr){
            $res4 = M('commission_log')->where(array('id' => array('IN', $taskDataSpreadCommissionIdArr)))->delete();
        }

        if ($res1 && $res2 && false !== $res3) {
            M()->commit();
            $this->success('删除成功');
        } else {
            M()->rollback();
            $this->error('删除失败');
        }
    }

    /**
     * 文件审核
     */
    public function fileCheck()
    {
        $id = I('post.id', 0, 'intval');
        $status = I('post.status', 0, 'intval');

        $statusArr = commission_status();
        if (!in_array($status, array_keys($statusArr)))
            $this->error('审核状态出错, 请重新审核');

        $data = array(
            'id' => $id,
            'status' => $status,
            'reason' => I('post.reason'),
            'check_time' => time(),
        );

        M()->startTrans();
        $task = M('commission_task')->find($id);
        if (!$task) $this->error('操作出错, 请刷新重试');
        $res1 = M('commission_task')->save($data);
        $taskData = M('commission_task_data')
            ->where(array('task_id' => $task['id']))
            ->select();
        foreach ($taskData as $key => $value) {
            if ($value['commission_id'] > 0) {
                $res2 = M('commission_log')->where(array('id' => $value['commission_id']))->setField('status', $status);
            } else {
                $taskDataId = $value['id'];
                unset($value['commission_id'], $value['id']);
                $res2 = M('commission_log')->add($value);
                if ($res2) {
                    $res4 = M('commission_task_data')->where(array('id' => $taskDataId))->setField('commission_id', $res2);
                }
            }
        }
        $res3 = M('commission_task_data')->where(array('task_id' => $id))->setField('status', $status);

        if ($res1 && false !== $res2 && false !== $res3) {
            M()->commit();
            operate_log($data['id'], 'commission_task', 2);
            $this->success('审核成功');
        } else {
            M()->rollback();
            $this->error('审核失败');
        }
    }

    /**
     * 整理好的佣金csv导入
     */
    public function fileImport()
    {
        if (IS_POST) {
            $config = array(
                'exts' => array('csv'),
            );
            $info = $this->upload($config);
            if ($info) {
                $filename = ROOT_PATH . '/uploads/' . $info['filename']['savepath'] . $info['filename']['savename'];
                $data = get_csv_content($filename);
                @unlink($filename);
                if ($data) {
                    $taskData = array();
                    $typeArr = array_values(commission_type());
                    $n = 2;
                    foreach ($data as $key => $value) {
                        if ($key == 0) continue;
                        $value = array_filter($value, 'trim');
                        if (!is_numeric($value[1])) $this->error(sprintf("第%d行的用户ID错误, 请修改后重新上传", $n));
                        if (!in_array($value[8], $typeArr)) $this->error(sprintf("第%d行的佣金类型错误, 请修改后重新上传", $n));
                        if ($value[7] != '未结算') $this->error(sprintf("第%d行的佣金状态必须是未结算状态才可上传, 请修改后重新上传", $n));
                        if ($value[8] != '推广佣金') {
                            $commission = M('commission_log')->find($value[0]);
                            if (!$commission) $this->error(sprintf("第%d行的佣金ID在佣金表中不存在, 请修改后重新上传", $n));
                            if (convert_money($value[6], '*') != $commission['money']) $this->error(sprintf("第%d行的佣金金额与佣金表中不符, 请修改后重新上传", $n));
                            if ($value[1] != $commission['uid']) $this->error(sprintf("第%d行的用户ID与佣金表中不符, 请修改后重新上传", $n));

                            $commission['commission_id'] = $commission['id'];
                            unset($commission['id']);
                            $taskData[] = $commission;
                        } else {
                            $taskData[] = array(
                                'uid' => $value[1],
                                'type' => CommissionModel::TYPE_SPREAD,
                                'order_id' => 0,
                                'money' => '-' . abs(convert_money($value[6], '*')),
                                'fans_id' => 0,
                                'desc' => '结算的推广佣金',
                                'status' => CommissionModel::STATUS_NO,
                                'create_time' => time(),
                                'update_time' => time(),
                                'settle_time' => 0,
                                'relation_id' => 0,
                                'commission_id' => 0,
                            );
                        }
                        $n++;
                    }

                    $task = array(
                        'task_name' => time() . mt_rand(100, 999),
                        'create_by' => session('admin_uid'),
                        'create_time' => time()
                    );

                    M()->startTrans();
                    $res1 = M('commission_task')->add($task);
                    if ($res1) {
                        foreach ($taskData as $key => $value) {
                            $value['task_id'] = $res1;
                            $taskData[$key] = $value;
                        }
                        $res2 = M('commission_task_data')->addAll($taskData);
                    }
                    if ($res1 && $res2) {
                        M()->commit();
                        $this->success('上传成功, 请核对后进行审核');
                    } else {
                        M()->rollback();
                        $this->error('结算失败, 请重新操作');
                    }
                } else {
                    $this->error('上传文件数据为空');
                }
            } else {
                echo '上传失败';
            }
        }
    }

    /**
     * 激励佣金任务列表及操作
     */
    public function reward()
    {
        if (IS_POST) {
            $startTime = strtotime(I('post.start_time'));
            $endTime = strtotime(I('post.end_time'));
            $type = I('post.type', 0, 'intval');
            $condition = I('post.condition', '');

            if (!$startTime || !$endTime || $type == 0) {
                $this->error('操作失败, 请重新操作');
            }

            // 添加一条任务
            $taskId = M('reward_task')->add(array(
                'start_time' => $startTime,
                'end_time' => $endTime,
                'create_time' => time(),
                'create_by' => session('admin_uid'),
            ));

            if (!$taskId) $this->error('添加任务失败, 请重新添加');

            $betweenWhere = array('BETWEEN', array($startTime, $endTime));

            // 统计以销售佣金为主
            if ($type == 1 || $type == 2) {
                $where1['create_time'] = $betweenWhere;
                $where1['type'] = $type == 1 ? CommissionModel::TYPE_PRODUCT : CommissionModel::TYPE_SPREAD;
                $cmPrefix1 = $type == 1 ? 'product' : 'spread';
                $having = $condition == '' ? '' : $cmPrefix1 . '_commission >= ' . convert_money(intval($condition), '*');
                $result = M('commission_log')
                    ->field('*, sum(money) as ' . $cmPrefix1 . '_commission')
                    ->where($where1)
                    ->group('uid')
                    ->having($having)
                    ->order($cmPrefix1 . '_commission DESC')
                    ->select();

                if ($result) {
                    $newData = array();
                    foreach ($result as $key => $value) {
                        //粉丝数
                        $count = M('user')->where(array(
                            'invite_id' => $value['uid'],
                            'subscribe_time' => array('GT', 0),
                            'create_time' => $betweenWhere
                        ))->count();

                        // 获取对应的销售佣金或推广佣金
                        $where2['uid'] = $value['uid'];
                        $where2['type'] = $type == 1 ? CommissionModel::TYPE_SPREAD : CommissionModel::TYPE_PRODUCT;
                        $where2['create_time'] = $betweenWhere;
                        $cmPrefix2 = $type == 1 ? 'spread' : 'product';
                        $tmpData = M('commission_log')
                            ->field('sum(money) AS ' . $cmPrefix2 . '_commission')
                            ->where($where2)
                            ->find();//推广佣金
                        $result[$key][$cmPrefix2 . '_commission'] = intval($tmpData[$cmPrefix2 . '_commission']);

                        $data = array(
                            'uid' => $value['uid'],
                            'task_id' => $taskId,
                            'product_commission' => $result[$key]['product_commission'],
                            'spread_commission' => $result[$key]['spread_commission'],
                            'fans_num' => $count,
                        );
                        $newData[] = $data;
                    }
                    $res = M('reward_task_data')->addAll($newData);
                    if ($res) {
                        $this->success('新建任务成功');
                        exit();
                    } else {
                        $this->error('任务数据添加失败');
                    }
                }
            } elseif ($type == 3) { // 先按粉丝计算
                $where1['b.create_time'] = $betweenWhere;
                $where1['b.subscribe_time'] = array('GT', 0);
                $where1['a.partner_status'] = UserModel::PARTNER_STATUS_PASS;
                $where1['a.subscribe_time'] = array('GT', 0);

                $result = M('user')->alias('a')
                    ->field('COUNT(*) AS fans_num, a.*')
                    ->join('LEFT JOIN __USER__ AS b ON a.uid=b.invite_id')
                    ->where($where1)
                    ->group('a.uid')
                    ->having('fans_num>=' . I('post.condition', 0, 'intval'))
                    ->order('fans_num DESC')
                    ->select();

                if ($result) {
                    $newData = array();
                    foreach ($result as $key => $value) {
                        // 销售佣金
                        $tmpData = M('commission_log')
                            ->field('SUM(money) AS product_commission')
                            ->where(array(
                                'uid' => $value['uid'],
                                'type' => CommissionModel::TYPE_PRODUCT,
                                'create_time' => $betweenWhere
                            ))->find();
                        $result[$key]['product_commission'] = intval($tmpData['product_commission']);

                        // 推广佣金
                        $tmpData = M('commission_log')
                            ->field('SUM(money) AS spread_commission')
                            ->where(array(
                                'uid' => $value['uid'],
                                'type' => CommissionModel::TYPE_PRODUCT,
                                'create_time' => $betweenWhere
                            ))->find();
                        $result[$key]['spread_commission'] = intval($tmpData['spread_commission']);

                        $data = array(
                            'uid' => $value['uid'],
                            'task_id' => $taskId,
                            'product_commission' => $result[$key]['product_commission'],
                            'spread_commission' => $result[$key]['spread_commission'],
                            'fans_num' => $value['fans_num'],
                        );
                        $newData[] = $data;
                    }
                    $res = M('reward_task_data')->addAll($newData);
                    if ($res) {
                        $this->success('新建任务成功');
                        exit();
                    } else {
                        $this->error('任务数据添加失败');
                        exit();
                    }
                }
            }
            $this->success('成功添加任务');
        } else {
            $count = M('reward_task')->count();
            $list = M('reward_task')->order('id DESC')->page($this->page, $this->pageSize)->select();
            $page = $this->page($count, array(), $this->pageSize);
            $this->assign('list', $list);
            $this->assign('page', $page);
            $this->display();
        }
    }

    /**
     * 删除导出列表
     * @param int $id
     */
    public function rewardDel($id = 0)
    {
        $taskId = intval($id);
        $res = M('reward_task')->where(array('id' => $taskId))->delete();
        if ($res)
            $this->success('删除成功');
        else
            $this->success('删除失败');
    }

    /**
     * 删除一条记录
     * @param int $id
     */
    public function rewardDataDel($id = 0)
    {
        $res = M('reward_task_data')->where(array('id' => $id))->delete();
        if ($res)
            $this->success('删除成功');
        else
            $this->success('删除失败');
    }


    /**
     * 查看对应任务列表
     * @param $id
     */
    public function rewardData($task_id)
    {
        $taskId = intval($task_id);

        $order = 'product_commission DESC';
        if (isset($_GET['type']) && trim($_GET['type']) != '') {
            $type = I('get.type');
            if ($type == 1) $order = 'product_commission DESC';
            if ($type == 2) $order = 'spread_commission DESC';
            if ($type == 3) $order = 'fans_num DESC';
        }

        $count = M('reward_task_data')->where(array('task_id' => $taskId))->count();
        $list = M('reward_task_data')
            ->where(array('task_id' => $taskId))
            ->page($this->page, $this->pageSize)
            ->order($order)
            ->select();

        $page = $this->page($count, array(), $this->pageSize);

        $this->assign('type', $type);
        $this->assign('taskId', $taskId);
        $this->assign('page', $page);
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 给选中的人或全部设置激励佣金
     */
    public function setReward()
    {
        if (IS_POST) {
            $type = I('post.type');
            $task_id = I('post.task_id', 0, 'intval');
            $ids = I('post.ids');
            $money = convert_money(I('post.money', 0, 'floatval'), '*');
            $remark = I('post.remark');
            if ($money <= 0) $this->error('奖励金额出错, 请重新操作');
            if ($type == 'all') {
                $where = array('task_id' => $task_id);
            } elseif ($type == 'check') {
                if ($ids == '') $this->error('数据出错, 请重新刷新操作');
                $ids = trim($ids, ',');
                $where = array(
                    'id' => array('IN', explode(',', $ids))
                );
            }

            $task = M('reward_task_data')->where($where)->select();
            if (!$task) $this->error('数据出错, 请重新刷新操作');

            $newData = array();
            foreach ($task as $key => $value) {
                $data = array(
                    'uid' => $value['uid'],
                    'type' => CommissionModel::TYPE_REWARD,
                    'money' => $money,
                    'desc' => $remark,
                    'create_time' => time(),
                    'update_time' => time()
                );
                $rs = M('commission_log')->add($data);
                operate_log($rs, 'commission_log', 1);
            }
            //$res = M('commission_log')->addAll($newData); // 批量添加
            if ($rs) {
                $this->success('设置成功!');
            } else {
                $this->error('设置失败!');
            }

        }
    }

    /**
     * 标记已开发票和取消发票标记
     */
    public function markInvoice()
    {
        $id = I('get.id', 0, 'intval');
        $invoice = I('get.invoice', 0, 'intval');

        if (in_array($invoice, array(0, 1))) {
            $res = M('commission_log')->where(array('id'=>$id))->setField('invoice', $invoice);
            $hint = $invoice == 0 ? '已取消发票标记' : '已标记为已开发票';
            if(false !== $res){
                operate_log($id, 'commission_log', 2);
                $this->success($hint);
            } else {
                $this->error('标记出错, 请重新操作');
            }
        } else {
            $this->error('标记出错, 请重新操作');
        }
    }
}
