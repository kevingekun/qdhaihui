<?php
namespace Admin\Controller;

use Common\Controller\AdminController;
use Think\Upload\Driver\Qiniu\QiniuStorage;

/**
 * 自动回复
 * @author: yanhuaitang
 * @date: 2016/1/12 11:45
 */
class ReplyController extends AdminController
{
    /**
     * 关注时自动回复
     */
    public function subscribe()
    {
        $reply = M('wechat_reply')->where(array('type' => 'subscribe'))->find();
        if (IS_POST) {
            $content = I('post.content');
            if ($content == '') $this->error('回复内容不能为空');
            if (!$reply) {
                $data = array(
                    'type' => 'subscribe',
                    'content' => $content,
                    'create_time' => NOW_TIME,
                    'update_time' => NOW_TIME
                );
                $result = M('wechat_reply')->add($data);
                if ($result) {
                    $this->success('设置成功');
                } else {
                    $this->error('设置失败');
                }
            } else {
                $reply['content'] = $content;
                $reply['update_time'] = NOW_TIME;
                $result = M('wechat_reply')->save($reply);
                if (false !== $result) {
                    operate_log($reply['id'], 'wechat_reply', 2);
                    $this->success('设置成功');
                } else {
                    $this->error('设置失败');
                }
            }
        } else {
            $this->assign('reply', $reply);
            $this->display();
        }
    }

    /**
     * 关键字自动回复
     */
    public function text()
    {
        $count = M('wechat_reply')->where(array('type' => 'text'))->count();
        $list = M('wechat_reply')
            ->where(array('type' => 'text'))
            ->order('id DESC')
            ->page($this->page, $this->pageSize)
            ->select();
        $page = $this->page($count, array(), $this->pageSize);
        $this->assign('page', $page);
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加/修改关键字 自动回复
     */
    public function textEdit()
    {
        $id = I('get.id', 0, 'intval');
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            $keyword = I('post.keyword');
            $precision = I('post.precision', 0, 'intval');
            $content = I('post.content');
            if ($keyword == '' || $content == '') $this->error('关键字或内容不能为空');
            if (strlen($content) > 1000) $this->error('内容不能超过1000字');
            $data = array(
                'type' => 'text',
                'keyword' => $keyword,
                'precision' => $precision,
                'content' => $content,
                'create_time' => NOW_TIME,
                'update_time' => NOW_TIME
            );
            if ($id == 0) {
                $res = M('wechat_reply')->add($data);
                if ($res) {
                    operate_log($res, 'wechat_reply', 1);
                    $this->success('添加成功', U('Admin/Reply/text'));
                } else {
                    $this->error('添加失败');
                }
            } else {
                $data['id'] = $id;
                $res = M('wechat_reply')->save($data);
                if (false !== $res) {
                    operate_log($id, 'wechat_reply', 2);
                    $this->success('修改成功', U('Admin/Reply/text'));
                } else {
                    $this->error('修改失败');
                }
            }
        } else {
            $reply = M('wechat_reply')->where(array('type' => 'text', 'id' => $id))->find();
            $this->assign('id', $id);
            $this->assign('reply', $reply);
            $this->display();
        }
    }

    /**
     * 图文自动回复
     */
    public function news()
    {

    }

    /**
     * 删除自动回复
     */
    public function del()
    {
        $id = I('get.id', 0, 'intval');
        operate_log($id, 'wechat_reply', 3);
        $result = M('wechat_reply')->delete($id);
        if ($result) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

}