<?php
/**
 * 常见问题控制器
 * User: yanhuaitang
 * Date: 2015/11/17 15:05
 * Email: 468012316@qq.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;

/**
 * 常见问题模块
 * Class HelpController
 * @package Admin\Controller
 */
class HelpController extends AdminController
{
    public function __initialize()
    {
        parent::_initialize();
    }

    public function index()
    {
        $map = I('get.');
        $where = array();
        if ($map['category'] != 0) {
            $where['category'] = $map['category'];
        }
        if ($map['title'] != '') {
            $where['title'] = array('like', '%' . $map['title'] . '%');
        }

        $Help = M('help');
        $count = $Help->where($where)->count();
        $list = $Help->where($where)->page($this->page, $this->pageSize)->order('id DESC')->select();
        $page = $this->page($count, $map, $this->pageSize);

        $this->assign('map', $map);
        $this->assign('page', $page);
        $this->assign('list', $list);
        $this->assign('count', $count);
        $this->display();
    }

    /**
     * 添加或修改问题
     */
    public function edit()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            $category = I('post.category', 15, 'intval');
            $title = I('post.title');
            $content = I('post.content');
            if ($title == '' || $content == '') {
                $this->error('标题不能为空');
            }
            $data = array(
                'category' => $category,
                'title' => $title,
                'content' => $content,
                'create_by' => session('admin_uid'),
                'update_time' => time()
            );
            if ($id == 0) {
                $data['create_time'] = time();
                if (M('help')->add($data)) {
                    $this->success('添加成功', U('Admin/Help/index'));
                } else {
                    $this->error('添加失败');
                }
            } else {
                if (M('help')->where('id=' . $id)->save($data)) {
                    $this->success('修改成功', U('Admin/Help/index'));
                } else {
                    $this->error('修改失败');
                }
            }
        } else {
            $id = I('get.id', 0, 'intval');
            $help = M('help')->where('id=' . $id)->find();

            $this->assign('help', $help);
            $this->display();
        }
    }

    /**
     * 删除
     */
    public function del()
    {
        $id = I('get.id', 0, 'intval');
        $res = M('help')->where('id=' . $id)->delete();
        if ($res) {
            $this->success('删除成功', U('Admin/Help/index'));
        } else {
            $this->error('删除失败');
        }
    }
}
