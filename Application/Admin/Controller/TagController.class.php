<?php
/**
 * 商品分类控制器
 * User: gaorenhua
 * Date: 2015/10/19 15:05
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;


class TagController extends AdminController
{
    // 实例化
    protected $Tag = '';

    public function _initialize()
    {
        parent::_initialize();
        $this->Tag = M('mall_tag');
    }

    /**
     * 商品分类列表
     */
    public function index()
    {
        $list = $this->Tag->select();
        $this->assign("menu", $list);
        $this->display();
    }

    /**
     * 添加商品分类
     */
    public function addTag()
    {
        // 提交方式
        if (!IS_POST) {
            $this->error('请求方式错误');
        }

        // 创建数据集
        $data = $this->Tag->create();
        if ($rs = $this->Tag->add($data)) {
            operate_log($rs, 'mall_tag', 1);
            $this->success('添加成功', U('index'), 1);
        } else {
            $this->error('添加失败', U('index'), 1);
        }

    }

    /**
     * 修改商品分类
     */
    public function updateTag()
    {
        if (IS_POST) {
            // 创建数据集
            $this->Tag->create();

            if ($this->Tag->save($data)) {
                $this->success('修改成功', U('index'), 1);
            } else {
                $this->error('修改失败', U('index'), 1);
            }
        } else {
            // 提取商品id
            $id = I('get.id', 0, 'intval');

            // 查
            $info = $this->Tag->find($id);
            $this->ajaxReturn($info);
        }
    }

    /**
     * 删除商品分类
     */
    public function delTag()
    {
        // 提交方式
        if (!IS_GET) {
            $this->error('非法访问');
        }

        // 提取get数据 待删除的商品分类id
        $id = I('get.id', 0, 'intval');

        // 检查该商品分类下是否存在商品  存在商品则不能删除 需先删除该分类下的全部商品 才能删除该分类
        $map['_string'] = "find_in_set($id, tags)";

        if (D('mall_good')->where($map)->find()) {
            // dump(D('mall_good')->_sql());die;
            $this->error('当前分类下存在商品,无法删除', U('index'), 1);
        } else {
            // 删除分类
            operate_log($id, 'mall_tag', 3);
            if ($this->Tag->delete($id)) {
                $this->success('删除成功', U('index'), 1);
            } else {
                $this->error('删除失败', U('index'), 1);
            }
        }
    }
}
