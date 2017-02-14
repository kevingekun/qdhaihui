<?php
/**
 * 广告位管理控制器
 * User: gaorenhua
 * Email: gaorenhua0812@gmail.com
 * Date: 2015/12/17 11:41
 */

namespace Admin\Controller;
use Common\Controller\AdminController;

class AdvertController extends AdminController
{
    /**
     * 广告位列表
     */
    public function adList()
    {
        $list = M('mall_advert')->select();
        $this->assign('list', $list);
        $this->display();
        $this->display();
    }

    /**
     * 添加广告位
     */
    public function addAdvert()
    {
        if (IS_POST) {
            // 实例化对象
            $advert = M('mall_advert');

            // 动态验证
            $rules = array(
                array('title', 'require', '标题不能为空'),
                array('image', 'require', '图片不能为空'),
                array('url', 'require', '网址不能为空'),
            );

            if (!$data = $advert->validate($rules)->create()) {
                $this->error($advert->getError());
            } else {

                // 上传文件
                if ($_FILES['image']['name'] !== '') {
                    $img = parent::upload();
                    $picurl = $img['image']['savepath'] . $img['image']['savename'];
                    $data["image"] = $picurl;
                } else {
                    $this->error("未上传图片！");
                }
                // 组合数据
                $data['uid'] = session('admin_uid');
                $data['create_time'] = $_SERVER['REQUEST_TIME'];

                if ($rs = $advert->add($data)) {
                    operate_log($rs, 'mall_advert');
                    $this->success('添加成功', __SELF__, 1);
                } else {
                    $this->error('添加失败', __SELF__, 1);
                }
            }

        } else {
            $this->display();
        }
    }

    /**
     * 编辑广告位
     */
    public function editAdvert()
    {
        if (IS_POST) {
            // 实例化
            $advert = M('mall_advert');

            // 创建数据集
            $data = $advert->create();

            // 上传文件
            if ($_FILES['image']['name'] !== '') {
                $img = parent::upload();
                $picurl = $img['image']['savepath'] . $img['image']['savename'];
                $data["image"] = $picurl;
            }

            // 更新数据
            if (false !== $advert->save($data)) {
                operate_log($data['id'], 'mall_advert', 2);
                $this->success('修改成功');
            } else {
                $this->error('修改失败');
            }

        } else {
            $id = I('get.id', 0, 'intval');

            $info = M('mall_advert')->find($id);

            $this->assign('info', $info);
            $this->display();
        }
    }

    /**
     * 删除广告位
     */
    public function delAdvert()
    {
        if (!IS_GET) {
            E('该页面不存在', 404);
        }

        // 提取GET数据
        $id = I('get.id', 0, 'intval');

        operate_log($id, 'mall_advert', 3);

        // 删除Banner
        if (M('mall_advert')->delete($id)) {
            $this->success('删除成功', U('adList'), 1);
        } else {
            $this->error('删除失败', U('adList'), 1);
        }
    }

    /**
     * 置顶广告位
     */
    public function topToAdvert()
    {
        if (!IS_GET) {
            E('该页面不存在', 404);
        }

        // 提取get数据
        $id = I('get.id', 0, 'intval');
        $status = I('status', 0, 'intval');
        $status ? $status : $status = 0;

        // 改变商品的状态
        if (M('mall_advert')->where('id = ' . $id)->setField('status', $status)) {
            $status ?  $this->success('推送成功') : $this->success('取消成功');
        } else {
            $status ?  $this->success('推送失败') : $this->success('取消失败');
        }
    }
}