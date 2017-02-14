<?php
/**
 * 商品分类控制器
 * User: gaorenhua
 * Date: 2015/10/19 15:05
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;
use Common\Controller\AdminController;


class MallMenuController extends AdminController
{
    /**
     * 商品分类列表
     */
    public function index() {
        $this->assign("menu", findMenu());
        $this->display();
    }

    /**
     * 添加商品分类
     */
    public function addMenu() {
        // 提交方式
        if (!IS_POST) {
            $this->error('请求方式错误');
        }

        // 实例化
        $model = M('mall_menu');

        // 创建数据集
        $data = $model->create();
        if ($model->add($data)) {
            $this->success('添加成功', U('index'), 1);
        } else {
            $this->error('添加失败', U('index'), 1);
        }

    }

    /**
     * 修改商品分类
     */
    public function updateMenu()
    {
        if (IS_POST) {
            // 实例化
            $model = M('mall_menu');

            // 创建数据集
            $data = $model->create();
            if ($data['id'] == $data['pid']) {
                $this->error('修改失败,同分类无法设置子分类', U('index'), 1);
            }

            if ($model->save($data)) {
                $this->success('修改成功', U('index'), 1);
            } else {
                $this->error('修改失败', U('index'), 1);
            }
        } else {
            // 提取商品id
            $id = I('get.id', 0, 'intval');

            // 查
            $info = M('mall_menu')->find($id);
            $this->ajaxReturn($info);
        }
    }

    /**
     * 删除商品分类
     */
    public function delMenu() {
        // 提交方式
        if (!IS_GET) {
            $this->error('非法访问');
        }

        // 提取get数据 待删除的商品分类id
        $id = I('get.id', 0, 'intval');

        // 检查该商品分类下是否存在商品  存在商品则不能删除 需先删除该分类下的全部商品 才能删除该分类
        $map['pid|menu_id'] = $id;
        if (M('mall_good')->where($map)->find()) {
            $this->error('当前分类下存在商品,无法删除', U('index'), 1);
        } else {
            // 删除分类
            if (M('mall_menu')->delete($id)) {
                $this->success('删除成功', U('index'), 1);
            } else {
                $this->error('删除失败', U('index'), 1);
            }
        }
    }
}