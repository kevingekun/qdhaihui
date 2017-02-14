<?php
/**
 * 常见问题控制器
 * User: leehwui 
 * Date: 2015/12/17 15:05
 * Email: leehwui@163.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;


class NoticeController extends AdminController
{
    public function __initialize()
    {
        parent::_initialize();
    }

    public function index()
    {


        $map = array();

        $notice = M('mall_notice');

        $res = $notice
            ->alias('n')
            ->field('n.*, a.username')
            ->join('hx_auth_user as a on n.created_by = a.user_id', 'left')
            ->where($map)
            ->select();
        
        $count = $notice->where($map)->count();
        $page = $this->page($count, array(), $this->pageSize);

        $this->assign('list', $res);
        $this->display(); 
    }


    public function add()
    {
        if (IS_POST) {
            $content = I('post.content');

            $data = array(
                'content' => $content, 
                'created_at' => time(),
                'created_by' => session('user_id'),
            );

            $notice = M('mall_notice');
            $result = $notice->data($data)->add();

            if (!$result) {
                $this->error('创建公告失败');
                exit;
            }

            $this->success('创建公告成功', 'index');
            exit;

        }

        $this->display();
    }


    public function modify()
    {
        if (IS_POST) {

            $id = intval(I('post.id'));
            $content = I('post.content');

            $map['id'] = array('eq', $id);
            $data = array('content' => $content, 'updated_at' => time());

            $notice = M('mall_notice');
            $result = $notice->where($map)->find();
            $result = $notice->where($map)->setField($data);

            if (!$result) {
                $this->error('更新公告失败');
                exit;
            }

            $this->success('更新公告成功');
            exit;

        }

        $this->error('请求方式错误');
    }


    /**
     * 删除
     */
    public function del()
    {

        if (IS_AJAX) {
            $id = intval(I('post.id')); 

            $notice = M('mall_notice');
            $map['id'] = array('eq', $id);
            $result = $notice->where($map)->delete();

            if ($result) {
                $data = array(
                    'code' => 0,
                    'msg' => 'notice deleted',
                );

                $this->ajaxReturn($data);
                exit;
            }

            $data = array(
                'code' => 1,
                'msg' => '未找到相关记录',
            );

            $this->ajaxReturn($data);
            exit;
        }

        $data = array(
            'code' => 2,
            'msg' => '错误的请求方式',
        );

        $this->ajaxReturn($data);
        exit;
    }
}
