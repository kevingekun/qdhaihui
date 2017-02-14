<?php
/**
 * 商品管理控制器
 * User: gaorenhua
 * Date: 2015/10/19 16:45
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;
use Common\Model\MallModel;

/**
 * 商品相关控制器
 * Class GoodsController
 * @package Admin\Controller
 */
class GoodsController extends AdminController
{
    /**
     * 商品列表
     */
    public function index()
    {
        $map = array(
            'menu_id' => I('get.menu_id', 0, 'intval'),
            'name' => I('get.name'),
            'tags' => I('get.tags'),
            'sku_id' => I('get.sku_id'),
            'status' => I('get.status', 1, 'intval')
        );

        $where = array('status' => array('NEQ', MallModel::GOODS_STATUS_DELETE));
        $map['menu_id'] ? $where['menu_id'] = $map['menu_id'] : '';
        $map['name'] != '' ? $where['name'] = array('LIKE', '%' . $map['name'] . '%') : '';
        $map['tags'] != '' ? $where['tags'] = array('LIKE', '%' . $map['tags'] . '%') : '';
        $map['sku_id'] != '' ? $where['sku_id'] = array('LIKE', '%' . $map['sku_id'] . '%') : '';
        $map['status'] != -1 ? $where['status'] = $map['status'] : '';

        //分类
        $category = get_goods_category($map['menu_id']);
        //商品状态
        $status = get_goods_status();

        // 区分 出售中/仓库中/已删除
        if (in_array($map['status'], $status)) {
            $where['status'] = $map['status'];
        }

        //计算各状态数
        $tempData = M('mall_good')->field('status,count(id) as num')->group('status')->select();
        foreach ($tempData as $key => $value) {
            $statusNum[$value['status']] = $value['num'];
        }

        $model = M('mall_good');

        // 导出excel
        if (I('get.action') == 'export') {
            $exportData = $model->where($where)->select();
            foreach ($exportData as $key => $val) {
                $exportData[$key]['pid'] = get_category_name($val['pid']);
                $exportData[$key]['menu_id'] = get_category_name($val['menu_id']);
                $exportData[$key]['group_id'] = get_group_name($val['group_id']);
                $exportData[$key]['price'] = convert_money($val['price']);
                $exportData[$key]['old_price'] = convert_money($val['old_price']);
                $exportData[$key]['create_time'] = date('Y-m-d H:i:s', $val['create_time']);
                $exportData[$key]['is_ecp'] = $exportData[$key]['is_ecp'] ? '同步' : '不同步';
            }
            $info = array(
                'id' => '商品ID',
                'pid' => '一级商品分类',
                'menu_id' => '二级商品分类',
                'group_id' => '商品分组',
                'name' => '商品名称',
                'spec' => '商品规格',
                'promotion' => '促销信息',
                'description' => '商品描述',
                'price' => '商品价格(元)',
                'old_price' => '商品原价(元)',
                'image' => '商品缩略图',
                'detail' => '商品详情',
                'is_ecp' => 'ECP同步',
                'sku_id' => 'SKU码',
                'stock' => '库存',
                'sales_volume' => '总销量',
                'tags' => '标签',
                'create_time' => '创建时间',
                'commission' => '佣金',
                'code_69' => '69码'
            );
            $this->export($exportData, $info);
        }

        $count = $model->where($where)->count();
        $list = $model->where($where)->page($this->page, $this->pageSize)->order('id desc')->select();

        $page = $this->page($count, $map, $this->pageSize);

        //  替换标签状态
        foreach ($list as $key => $value) {
            $tags = M('mall_tag')->where(array('id' => array('in', $value['tags'])))->getField('tag', true);
            $tags ? $list[$key]['tags'] = implode(',', $tags) : $list[$key]['tags'] = '--';
        }

        $this->assign('map', $map);
        $this->assign('count', $count);
        $this->assign('statusNum', $statusNum);
        $this->assign('status', $status);
        $this->assign('category', $category);
        $this->assign('page', $page); // 赋值分页输出
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加商品
     */
    public function addGoods()
    {
        if (IS_POST) {
            // 实例化模型
            $goods = D('goods');
//            var_dump($_REQUEST);
//            exit();
            // 自动验证
            if (!$data = $goods->create()) {
                $this->error($goods->getError());
            }
            // 获取是否延保商品
            $data['iswrrany'] = I('post.iswarrany');

            //接收并且处理延保价格存入数据库
            $warrany = I('post.warrany');
            //循环给各个字段添加字段名
            foreach ($warrany as $k => $value) {
                $value = explode(',',$value);
                $warrany_data[] = array(
                    'Type' => $value['0'],
                    'Year' => $value['1'],
                    'Price' => $value['2'],
                );
            }
            $data['warrany'] = json_encode($warrany_data);
            if ($_FILES ['image'] ['name'] !== '') {
                $img = parent::upload();
                $picurl = $img['image']['savepath'] . $img['image']['savename'];
                $data ["image"] = $picurl;
            } else {
                $this->error("未上传图片！");
            }

            // 判断是否ecp同步  如果不同步 检测商品库存不能为空
            if (!$data['is_ecp']) {
                $data['stock'] ? $data['stock'] : $this->error('商品库存不能为空');
            }

            // 组合商品信息
            $data['pid'] = $this->getFatherId($data['menu_id']);
            $data['old_price'] = convert_money($data['old_price'], '*');
            $data['price'] = convert_money($data['price'], '*');
            $data['commission'] = convert_money($data['commission'], '*');
            $data['show_images'] = json_encode($data['show_images']);
            $data['tags'] = $data['tags'] ? implode(',', $data['tags']) : '';
            $data['on_time'] = strtotime($data['on_time']);
            $data['off_time'] = strtotime($data['off_time']);
            // 判断上下架时间是否符合规范
            $checkTime = $this->onOrOffTheShelfHandle(strtotime($data['on_time']), strtotime($data['off_time']));
            $data['on_time'] = $checkTime['on'];
            $data['off_time'] = $checkTime['off'];
            // 广告位集合
            $data['ad_ids'] = $data['ad_ids'] ? implode(',', $data['ad_ids']) : '';

            if ($rs = M('mall_good')->add($data)) {
                operate_log($rs, 'mall_good', 1);
                S('goods', null);
                $this->success("添加商品成功！");
            } else {
                $this->error("添加商品失败！");
            }

        } else {
            $this->time = time();
            // 商品分组
            $map = array(
                'type' => 'goods_group',
                'status' => 0
            );
            $group = M('attribute')->field('title,value')->where($map)->select();
            $this->assign('group', $group);

            // 调用标签库
            $tags = M('mall_tag')->select();
            $this->assign('tags', $tags);

            // 调用广告位
            $ad = M('mall_advert')->where(array('status' => '1'))->select();
            $this->assign('ad', $ad);
            $menu = findMenu();
            // 商品分类
            $this->assign("menu", findMenu());
            $this->display();
        }
    }

    /**
     * 修改商品
     */
    public function updateGoods()
    {
        if (IS_POST) {
            // 实例化模型
            $goods = D('goods');

            // 自动验证
            if (!$data = $goods->create()) {
                $this->error($goods->getError());
            }

            if ($_FILES ['image'] ['name'] !== '') {
                $img = $this->upload();
                $picurl = $img['image']['savepath'] . $img['image']['savename'];
                $data ["image"] = $picurl;
            }

            // 判断是否ecp同步  如果不同步 检测商品库存不能为空
            if (!$data['is_ecp']) {
                $data['stock'] ? $data['stock'] : $this->error('商品库存不能为空');
            }

            // 合并商品数据
            $data['pid'] = $this->getFatherId($data['menu_id']);
            $data['old_price'] = convert_money($data['old_price'], '*');
            $data['price'] = convert_money($data['price'], '*');
            $data['commission'] = convert_money($data['commission'], '*');
            $data['show_images'] = json_encode($data['show_images']);
            $data['tags'] = $data['tags'] ? implode(',', $data['tags']) : '';
            // 判断上下架时间是否符合规范
            $checkTime = $this->onOrOffTheShelfHandle(strtotime($data['on_time']), strtotime($data['off_time']));
            $data['on_time'] = $checkTime['on'];
            $data['off_time'] = $checkTime['off'];
            // 广告位集合
            $data['ad_ids'] = $data['ad_ids'] ? implode(',', $data['ad_ids']) : '';

            $res = M('mall_good')->save($data);
            if ($res !== false) {
                operate_log($data['id'], 'mall_good', 2);
                S('goods', null);
                $this->success("修改商品成功！");
            } else {
                $this->error("修改商品失败！");
            }

        } else {
            // 提取get数组
            $id = I('id', 0, 'intval');
            $info = M('mall_good')->find($id);
            $this->assign('info', $info);

            // 商品banner
            $banners = json_decode($info['show_images'], true);
            $this->assign('banners', $banners);

            // 商品分组
            $map = array(
                'type' => 'goods_group',
                'status' => 0
            );
            $group = M('attribute')->field('title,value')->where($map)->select();
            $this->assign('group', $group);

            // 调用标签库
            $tags = M('mall_tag')->select();
            $this->assign('tags', $tags);

            // 调用广告位
            $ad = M('mall_advert')->where(array('status' => '1'))->select();
            $this->assign('ad', $ad);

            // 查询商品分类
            $this->assign('menu', findMenu());
            $this->display();
        }
    }

    /**
     * 删除商品
     */
    public function delGood()
    {
        // 提取get数据
        $id = I('get.id', 0, 'intval');

        operate_log($id, 'mall_good', 3);
        // 改变商品的状态
        if (M('mall_good')->where(array('id' => $id))->setField('status', 2)) {
            S('goods', null);
            $this->success('商品删除成功');
        } else {
            $this->error('商品删除失败');
        }
    }

    /**
     * 商品下架
     */
    public function toTop()
    {
        // 提取get数据
        $id = I('get.id', 0, 'intval');
        $top = I('top', 0, 'intval');
        $top ? $top : $top = 0;

        // 改变商品的状态
        if (M('mall_good')->where('id = ' . $id)->setField('top', $top)) {
            operate_log($id, 'mall_good', 2);
            $top ? $this->success('商品置顶成功') : $this->success('取消置顶成功');
        } else {
            $top ? $this->success('商品置顶失败') : $this->success('取消置顶失败');
        }
    }

    /**
     * 商品下架
     */
    public function offTheShelf()
    {
        // 提取get数据
        $id = I('get.id', 0, 'intval');
        $status = I('status', 0, 'intval');
        $status ? $status : $status = 0;

        // 改变商品的状态
        if (M('mall_good')->where('id = ' . $id)->setField('status', $status)) {
            operate_log($id, 'mall_good', 2);
            S('goods', null);
            $status ? $this->success('商品上架成功') : $this->success('商品下架成功');
        } else {
            $status ? $this->success('商品上架失败') : $this->success('商品下架失败');
        }
    }

    /**
     * 上传图片使用
     */
    public function editor()
    {
        $editor = new \Org\Util\Ueditor();
        echo $editor->output();
    }

    /**
     * 获取商品一级分类的id
     * @param $menuId 当前商品分类id
     * @return mixed 一级分类id
     */
    protected function getFatherId($menuId)
    {
        // 首先判断传入的id是否存在父级id
        $pid = M('mall_menu')->where(array('id' => $menuId))->getField('pid');

        return $pid ? $pid : $menuId;
    }


    //删除图片
    public function delFile()
    {
        if (!IS_AJAX) {
            exit('需要AJAX提交信息');
        }
        $img_url = I('post.url');
        $id = I('post.id', 0, 'intval');

        // 判断 数据库字段是否更新成功
        if ($this->updateBanner($id, $img_url)) {
            if (@unlink('.' . $img_url)) {
                $data = array(
                    'status' => 1,
                    'info' => ':)成功删除图片',
                );
            } else {
                $data = array(
                    'status' => 0,
                    'info' => ':(删除图片失败',
                );
            }
        } else {
            $data = array(
                'status' => 0,
                'info' => ':(删除图片失败',
            );
        }

        $this->ajaxReturn($data);
    }

    /**
     * 更新商品banner
     */
    public function updateBanner($goods_id, $img_url)
    {
        // 获取商品banner
        $banners = M('mall_good')->where(array('id' => $goods_id))->getField('show_images');
        $array = json_decode($banners, true);

        // 判断 是新增还是更新  更新的时候字段不为空
        if (!empty($array)) {
            foreach ($array as $k => $v) {
                if ($v == $img_url) {
                    unset($array[$k]);
                }
            }

            // 更新banner
            $data['id'] = $goods_id;
            $data['show_images'] = json_encode($array);

            if (M('mall_good')->save($data)) {
                operate_log($data['id'], 'mall_good', 2);
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }

    /**
     * 判断上下架时间 是否符合规范
     */
    protected function onOrOffTheShelfHandle($on_time, $off_time)
    {
        // 定义当前时间戳
        $now = $_SERVER['REQUEST_TIME'];
        $data = array();

        // 上下架时间均不为空
        if (!empty($on_time) && !empty($off_time)) {
            // 判断上下架时间是否符合规范  上架时间不能晚于 下架时间
            $on_time >= $off_time ? $this->error('上架时间不能晚于下架时间') : '';
            $on_time <= $now ? $this->error('上架时间不能晚于当前时间') : '';
            $off_time <= $now ? $this->error('下架时间不能晚于当前时间') : '';

            $data['on'] = $on_time;
            $data['off'] = $off_time;
        } elseif (!empty($on_time)) {
            $on_time <= $now ? $this->error('上架时间不能晚于当前时间') : '';

            $data['on'] = $on_time;
            $data['off'] = '0';
        } elseif (!empty($off_time)) {
            $off_time <= $now ? $this->error('下架时间不能晚于当前时间') : '';

            $data['on'] = '0';
            $data['off'] = $off_time;
        } else {
            $data['on'] = '0';
            $data['off'] = '0';
        }

        return $data;
    }

    /**
     * 商品列表, 如果是ecp同步的商品, 点击查看分仓库存弹出窗口显示的数据
     */
    public function warehouse()
    {
        if (IS_AJAX) {
            $skuId = I('post.sku_id');
            $data = M('ecp_inventory')->where(array('sku_id' => $skuId))->select();
            if ($data) {
                foreach ($data as $key => $value) {
                    $data[$key]['create_time'] = format_date($value['created_at'], 'Y-m-d H:i:s');
                    $data[$key]['update_time'] = format_date($value['updated_at'], 'Y-m-d H:i:s');
                }
                $this->ajaxReturn(array('code' => 0, 'msg' => '获取到分仓库存数据', 'data' => $data));
            } else {
                $this->ajaxReturn(array('code' => 1, 'msg' => '没有获取到' . $skuId . '的分仓库存数据'));
            }
        }
    }

    /**
     * 复制商品
     */
    public function copyGoods()
    {
        $id = I('get.id', 0, 'intval');
        $goods = M('mall_good')->find($id);
        if (!$goods) $this->error('该商品不存在!');

        unset($goods['id'], $goods['promotion'], $goods['sku_id'], $goods['tags'], $goods['shelves_time']);
        $goods['create_time'] = time();
        $goods['status'] = 0;
        $goods['stock'] = 0;
        $goods['commission'] = 0;
        $goods['click'] = 0;
        $goods['top'] = 0;
        $goods['with_invoice'] = 0;
        $goods['sort'] = 0;
        $goods['on_time'] = 0;
        $goods['off_time'] = 0;
        $goods['ad_ids'] = '';

        $res = M('mall_good')->add($goods);
        if (false !== $res) {
            operate_log($res, 'mall_good', 1);
            $this->success('复制商品成功!', U('Admin/Goods/index', '', true, true));
        } else {
            $this->error('复制商品失败');
        }
    }

    //============================================预览商品  begin==================================================
    /**
     * 预览商品
     * @param $id 商品ID
     */
    public function preview($id)
    {
        $id = intval($id);
        $this->assign('id', $id);
        $this->display();
    }

    /**
     * iframe 内嵌在preview中的商品详情
     * @param $id
     */
    public function previewDetail()
    {
        if (!IS_GET) $this->error('请求方式不正确');

        // 获取GET数据
        $id = I('get.id', 0, 'intval');

        // 查看商品详情
        $info = M('mall_good')->find($id);

        //取库存警戒值
        $StockLimit = getAttributeWithType('stock');

        if ($destination = session('hx_mall_good_mail_to')) {
            if ($region_id = get_region_id($destination)) {
                $RegionDataArray = get_region_row($region_id);
            } else {
                $this->error('未能获取地址的区域编码');
            }
            $StockControlData['province_name'] = $RegionDataArray['province_name'];
        } else {
            $StockControlData['province_name'] = '山东';
        }

        if ($info['is_ecp'] != '1') {
            if (($info['stock'] - $StockLimit['value']) >= '1') {
                $StockControlData['flag'] = 'success';
                $StockControlData['stock'] = $info['stock'];
            } else {
                $StockControlData['flag'] = 'failure';
            }
        } else {
            $ProductCountArray = getStockRowArray($info['sku_id'], $RegionDataArray['warehouse_code']);
            if (($ProductCountArray['product_count'] - $StockLimit['value']) >= '1') {
                $StockControlData['flag'] = 'success';
                $StockControlData['stock'] = $ProductCountArray['product_count'];
            } else {
                $StockControlData['flag'] = 'failure';
            }
        }
        $this->assign('StockControlData', $StockControlData);
        $info['show_images'] = json_decode($info['show_images'], true);
        $this->assign('info', $info);

        // 调用广告列表
        if (!empty($info['ad_ids'])) {
            $adList = M('mall_advert')->field('title,image,url')->where(array('id' => array('in', $info['ad_ids'])))->select();
            $this->assign('adlist', $adList);
        }
        $this->display();
    }

    //============================================预览商品  end==================================================

    /**
     * 产品大类, 如:冰箱/冷柜/波轮洗衣机/滚筒洗衣机/商用空调/家用空调/电视/燃气灶/吸油烟机/热水器/手机
     */
    public function category()
    {
        $list = M('mall_category')->select();

        $this->assign('list', $list);
        $this->display();
    }

    public function addCategory()
    {
        $model = M('mall_category');
        $data = $model->create();
        if ($model->add($data)) {
            $this->success('添加成功', U('category'), 1);
        } else {
            $this->error('添加失败', U('category'), 1);
        }
    }

    public function editCategory()
    {
        if(IS_POST) {
            $model = M('mall_category');
            $data = $model->create();
            if ($model->save($data)) {
                $this->success('修改成功', U('category'), 1);
            } else {
                $this->error('修改失败', U('category'), 1);
            }
        } else {
            $id = I('get.id', 0, 'intval');
            $info = M('mall_category')->find($id);
            $this->ajaxReturn($info);
        }
    }

    public function delCategory()
    {
        // 提交方式
        if (!IS_GET) {
            $this->error('非法访问');
        }

        // 提取get数据 待删除的商品分类id
        $id = I('get.id', 0, 'intval');

        // 删除分类
        if (M('mall_category')->delete($id)) {
            $this->success('删除成功', U('category'), 1);
        } else {
            $this->error('删除失败', U('category'), 1);
        }
    }
}
