<?php
/**
 * user模型
 * @author: yanhuaitang
 * @date: 2015/10/13 14:35
 */
namespace Common\Model;

use Think\Model;

class UserModel extends BaseModel
{
    protected $tableName = 'user';

    const PARTNER_STATUS_REG = 0; // 粉丝注册时状态, 未申请状态
    const PARTNER_STATUS_CHECK = 1; // 申请合伙人, 待审核状态
    const PARTNER_STATUS_REFUSE = 2; // 申请合伙人, 拒绝状态
    const PARTNER_STATUS_PASS = 9; // 申请合伙人, 已通过

    const CHECK_STATUS_NORMAL = 0;// 默认
    const CHECK_STATUS_CHECK = 1;// 待审核
    const CHECK_STATUS_REFUSE = 2;// 已拒绝
    const CHECK_STATUS_PASS = 9;// 已通过

    const COMMISSION_STATUS_NO = 0; // 推广奖励, 未处理
    const COMMISSION_STATUS_YES = 1; // 已处理

    public static $partnerStatus = array(
        self::PARTNER_STATUS_REG => '未申请',
        self::PARTNER_STATUS_CHECK => '待审核',
        self::PARTNER_STATUS_REFUSE => '已拒绝',
        self::PARTNER_STATUS_PASS => '已通过'
    );


    /**
     * 获取直属上级信息
     * @param $uid
     * @return array
     */
    public function getParent($uid)
    {
        $inviteId = $this->where('uid=' . intval($uid))->getField('invite_id');
        $data = $this->where('uid=' . intval($inviteId))->find();
        return $data ?: array();
    }

    /**
     * 获取直属下级信息, 带分页及查询条件
     * @param $uid
     * @param array $map 条件
     * @param string $order 排序
     * @param int $page 分页
     * @param int $pageSize 每页数量
     * @return array
     */
    public function getChildren($uid, $map = array(), $order = 'create_time DESC', $page = 1, $pageSize = 25)
    {
        $where['invite_id'] = intval($uid);
        $where = array_merge($where, $map);
        $count = $this->where($where)->count();
        $data = $this->where($where)->order($order)->page("$page, $pageSize")->select();
        return array('count' => $count, 'data' => $data) ?: array('count' => $count, 'data' => array());
    }

    /**
     * 获取微信用户列表
     * @param array $map 条件
     * @param string $order 排序
     * @param int $page 分页
     * @param int $pageSize 每页数量
     * @return array
     */
    public function getUserList($map = array(), $order = 'create_time DESC', $page = 1, $pageSize = 25)
    {
        $count = $this->where($map)->count();
        $data = $this->where($map)->order($order)->page("$page, $pageSize")->select();
        return array('count' => $count, 'data' => $data) ?: array('count' => $count, 'data' => array());
    }

    /**
     * 获取粉丝总数
     * @param $uid
     * @param $map 可选择添加条件
     * @return mixed
     */
    public function getChildrenCount($uid, $map = array())
    {
        $where['invite_id'] = intval($uid);
        $where = array_merge($where, $map);
        return $this->where($where)->count();
    }

    /**
     * 获取推荐人信息
     * @param $uid
     * @param array $map 查询条件
     * @return array
     */
    public function getUserInfo($uid, $map = array())
    {
        $where['uid'] = intval($uid);
        $where = array_merge($where, $map);
        $data = $this->where($where)->find();
        return $data ?: array();
    }


}