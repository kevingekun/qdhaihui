<?php
namespace Admin\Controller;

use Com\Wechat\TPWechat;
use Common\Controller\AdminController;
use Common\Model\AttributeModel;

/**
 * 用户相关
 * @author: yanhuaitang
 * @date: 2015/11/10 16:12
 */
class UserController extends AdminController
{
    /**
     * 用户列表
     */
    public function index()
    {
        // 筛选条件
        $map = array(
            'nickname' => I('get.nickname', '', 'trim'),
            'phone' => I('get.phone', '', 'trim'),
            'group_id' => I('get.group_id', 0, 'intval'),
            'label_id' => I('get.label_id', 0, 'intval'),
            'start_time' => I('get.start_time', '', 'trim'),
            'end_time' => I('get.end_time', '', 'trim'),
            'order' => I('get.order', 0, 'intval'),
        );
        $where = array();
        $map['nickname'] != '' ? $where['nickname'] = array('LIKE', '%' . $map['nickname'] . '%') : '';
        $map['phone'] != '' ? $where['phone'] = array('LIKE', '%' . $map['phone'] . '%') : '';
        $map['group_id'] != 0 ? $where['group_id'] = $map['group_id'] : '';
        $map['label_id'] != 0 ? $where['label_id'] = $map['label_id'] : '';
        $map['start_time'] != '' ? $where['create_time'] = array('egt', strtotime($map['start_time'])) : '';
        $map['end_time'] != '' ? $where['end_time'] = array('elt', strtotime($map['end_time'])) : '';

        // 分组
        $attrModel = new AttributeModel();
        $groups = $attrModel->findAttributes('group');
        $labels = $attrModel->findAttributes('label');

        $User = M('user');
        $count = $User->where($where)->count();
        $list = $User->where($where)
            ->page($this->page, $this->pageSize)
            ->order('uid DESC')
            ->select();
        $page = $this->page($count, $map, $this->pageSize);

        $this->assign('groups', $groups);
        $this->assign('labels', $labels);
        $this->assign('map', $map);
        $this->assign('page', $page);
        $this->assign('count', $count);
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 修改用户信息
     * @param $id
     */
    public function edit($id)
    {
        if (IS_POST) {
            $data = I('post.');
            $id = I('post.uid');
            $user = M('user')->where(array('uid' => $id))->find();
            if (!$user) $this->error('该用户不存在');

            $res = M('user')->where(array('uid' => $id))->save($data);
            if ($res !== false) {
                operate_log($id, 'user', 3);
                $this->success('修改成功', '/Admin/User/index');
            } else {
                $this->error('修改失败', '/Admin/User/index');
            }
        } else {
            $id = intval($id);

            // 分组
            $attrModel = new AttributeModel();
            $groups = $attrModel->findAttributes('group');
            $labels = $attrModel->findAttributes('label');

            $user = M('user')->where(array('uid' => $id))->find();
            if (!$user) $this->error('用户不存在!');

            $this->assign('groups', $groups);
            $this->assign('labels', $labels);
            $this->assign('user', $user);
            $this->display();
        }
    }

    /**
     * 删除用户
     * @param $id
     */
    public function del($id)
    {
        $id = intval($id);
        operate_log($id, 'user', 3);
        $res = M('user')->where(array('uid' => $id))->delete();
        if ($res) {
            $this->success('删除成功!');
        } else {
            $this->error('删除失败!');
        }
    }

    /**
     * 更新所有粉丝信息
     */
    public function updateFansInfo()
    {
        $this->page = I('get.p', 0, 'intval');
        $endPage = I('get.end', 10, 'intval');
        if($this->page > $endPage) $this->error('更新完毕', U('Admin/User/index'));

        $options = array(
            'appid' => C('APP_ID'),
            'appsecret' => C('APP_SECRET'),
        );
        $wechat = new TPWechat($options);

        $where = array();
        //$where['subscribe_time'] = array('GT', 0);
        //$count = M('user')->where($where)->count();
        $list = M('user')->where($where)->page($this->page, $this->pageSize)->order('uid DESC')->select();

        if($list){
            foreach ($list as $key => $value) {
                $userInfo = array(
                    'subscribe' => intval($value['subscribe']),
                    'openid' => $value['openid'],
                    'nickname' => $value['nickname'],
                    'sex' => intval($value['sex']),
                    'language' => $value['language'],
                    'city' => $value['city'],
                    'province' => $value['province'],
                    'country' => $value['country'],
                    'headimgurl' => $value['headimgurl'],
                    //'subscribe_time' => intval($value['subscribe_time']),
                    'remark' => $value['remark'],
                    'groupid' => intval($value['groupid']),
                );
                $tempInfo = $wechat->getUserInfo($value['openid']);
                if (!isset($tempInfo['errcode'])) {
                    unset($tempInfo['unionid']);
                    unset($tempInfo['subscribe_time']);
                    $userInfo = array_map('null_to_blank', $userInfo);
                    $tempInfo = array_map('null_to_blank', $tempInfo);
                    ksort($userInfo);
                    ksort($tempInfo);
                    $userInfoMd5 = md5(json_encode($userInfo));
                    $tempInfoMd5 = md5(json_encode($tempInfo));

                    // 两边信息不同, 则更新库中的信息
                    if ($userInfoMd5 != $tempInfoMd5) {
                        $res = M('user')->where(array('uid' => $value['uid']))->save($tempInfo);
                    }
                } else {
                    $this->error('获取粉丝接口调用超过限制，请稍后再来', U('Admin/User/index'));
                }
            }
            $this->success('更新中请勿关闭...进度：第' . $this->page . '页, ' . $this->pageSize . '条', U('Admin/User/updateFansInfo', array('p' => $this->page + 1, 'end'=>$endPage)));
        } else {
            $this->success('更新完毕', U('Admin/User/index'));
        }
    }
}