<?php
/**
 * 商城基础设置控制器
 * User: gaorenhua
 * Date: 2015/11/16 20:52
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;
use Common\Controller\AdminController;

/**
 * 设置商城首页Banner 以及其他相关功能
 * @package Admin\Controller
 */
class MallSettingController extends AdminController
{
    /**
     * banner 列表
     */
    public function bannerList()
    {
        $list = M('mall_banner')->select();
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加Banner
     */
    public function addBanner()
    {
        if (IS_POST) {
            // 实例化对象
            $Banner = M('mall_banner');

            // 动态验证
            $rules = array(
                array('title', 'require', '标题不能为空'),
                array('banner', 'require', '图片不能为空'),
                array('url', 'require', '网址不能为空'),
            );

            if (!$data = $Banner->validate($rules)->create()) {
                $this->error($Banner->getError());
            } else {

                // 上传文件
                if ($_FILES['banner']['name'] !== '') {
                    $img = parent::upload();
                    $picurl = $img['banner']['savepath'] . $img['banner']['savename'];
                    $data["banner"] = $picurl;
                } else {
                    $this->error("未上传图片！");
                }
                // 组合数据
                //$data['uid'] = session('admin_uid');
                $data['create_time'] = $_SERVER['REQUEST_TIME'];

                if ($Banner->add($data)) {
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
     * 更新Banner
     */
    public function updateBanner()
    {
        if (IS_POST) {
            // 实例化
            $banner = M('mall_banner');

            // 创建数据集
            $data = $banner->create();

            // 上传文件
            if ($_FILES['banner']['name'] !== '') {
                $img = parent::upload();
                $picurl = $img['banner']['savepath'] . $img['banner']['savename'];
                $data["banner"] = $picurl;
            }

            // 更新数据
            if ($banner->save($data)) {
                $this->success('修改成功');
            } else {
                $this->error('修改失败');
            }

        } else {
            $id = I('get.id', 0, 'intval');

            $info = M('mall_banner')->find($id);

            $this->assign('info', $info);
            $this->display();
        }
    }

    /**
     * 删除Banner
     */
    public function delBanner()
    {
        if (!IS_GET) {
            E('该页面不存在', 404);
        }

        // 提取GET数据
        $id = I('get.id', 0, 'intval');

        // 删除Banner
        if (M('mall_banner')->delete($id)) {
            $this->success('删除成功', U('bannerList'), 1);
        } else {
            $this->error('删除失败', U('bannerList'), 1);
        }
    }

    /**
     * 推送到首页 or 取消推送
     */
    public function pushToHome()
    {
        if (!IS_GET) {
            E('该页面不存在', 404);
        }

        // 提取get数据
        $id = I('get.id', 0, 'intval');
        $status = I('status', 0, 'intval');
        $status ? $status : $status = 0;

        // 改变商品的状态
        if (M('mall_banner')->where('id = ' . $id)->setField('status', $status)) {
            $status ?  $this->success('推送成功') : $this->success('取消成功');
        } else {
            $status ?  $this->success('推送失败') : $this->success('取消失败');
        }
    }
}