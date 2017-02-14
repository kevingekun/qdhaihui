<?php
namespace Admin\Controller;

use Common\Controller\AdminController;

use Common\Model\MallModel;

/**
 * 活动相关(如秒杀,预售,抢购,团购)的程序都在此文件
 * Class ActivityController
 * @package Admin\Controller
 */
class ActivityController extends AdminController
{
    /**
     * 优惠券列表
     */
    public function couponlist()
    {
        $coupon = M('mall_coupon');

        if (is_string($_REQUEST['status'])) {
            $status = $_REQUEST['status'];
        } else {
            $status = 1;
        }

        $where['status'] = $status;

        if (!empty($_REQUEST['cname'])) {
            $where['coupon_name'] = array('like', '%' . $_REQUEST['cname'] . '%');
        }

        if (!empty($_REQUEST['csvalue'])) {

            if (!empty($_REQUEST['cevalue'])) {
                $where['money_cut'] = array('between', array(convert_money($_REQUEST['csvalue'], '*'), convert_money($_REQUEST['cevalue'], '*')));
            } else {
                $where['money_cut'] = array('EGT', convert_money($_REQUEST['csvalue'], '*'));
            }

        }

        if (!empty($_REQUEST['cevalue'])) {

            if (!empty($_REQUEST['csvalue'])) {
                $where['money_cut'] = array('between', array(convert_money($_REQUEST['csvalue'], '*'), convert_money($_REQUEST['cevalue'], '*')));
            } else {
                $where['money_cut'] = array('ELT', convert_money($_REQUEST['cevalue'], '*'));
            }

        }

        if (!empty($_REQUEST['cstime'])) {

            if (!empty($_REQUEST['cetime'])) {
                $where['start_time'] = array('between', array(strtotime($_REQUEST['cstime']), strtotime($_REQUEST['cetime'])));
                $where['end_time'] = array('between', array(strtotime($_REQUEST['cstime']), strtotime($_REQUEST['cetime'])));
            } else {
                $where['start_time'] = array('EGT', strtotime($_REQUEST['cstime']));
            }


        }

        if (!empty($_REQUEST['cetime'])) {

            if (!empty($_REQUEST['cstime'])) {
                $where['start_time'] = array('between', array(strtotime($_REQUEST['cstime']), $_REQUEST['cetime']));
                $where['end_time'] = array('between', array(strtotime($_REQUEST['cstime']), $_REQUEST['cetime']));
            } else {
                $where['end_time'] = array('ELT', strtotime($_REQUEST['cetime']));
            }


        }


        $list = $coupon->where($where)->select();
        $this->assign('status', $status);
        $this->assign('list', $list);
        $this->display();

    }

    /**
     * 停止优惠券
     */
    public function couponstop()
    {
        $id = $_REQUEST['id'];

        $coupon = M('mall_coupon');
        $where['id'] = $id;
        $data['status'] = 0;
        $res = $coupon->where($where)->save($data);
        if (false !== $res) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
        exit;
    }

    /**
     * 添加优惠券
     */
    public function couponadd()
    {
        if (IS_POST) {
            $coupon = D('coupon');

            if (!$data = $coupon->create()) $this->error($coupon->getError());

            if ($_FILES ['image'] ['name'] !== '') {
                $img = $this->upload();
                $picurl = $img['image']['savepath'] . $img['image']['savename'];
                $data ["coupon_pic"] = $picurl;
            }

            $post = I('post.');
            if ($post['setleast'] == '') {
                $data['money_over'] = 0;
            } else {
                $data['money_over'] = convert_money($post['money_over'], '*');
            }

            if ($post['allow_class'] == '') {
                $data['allow_class_id'] = '';
            } else {
                if (isset($post['allow_classes']) && !empty($post['allow_classes'])) {
                    $data['allow_class_id'] = implode(',', $post['allow_classes']);
                } else {
                    $this->error('请选择要限制的分类');
                }
            }

            if ($post['allow_goods'] == '') {
                $data['sku_ids'] = '';
            } else {
                if (is_array($post['allow_goods']) && !empty($post['allow_goods'])) {
                    $data['sku_ids'] = implode(',', $post['allow_goods']);
                } else {
                    $this->error('请选择要限制的商品');
                }
            }

            $data['money_cut'] = convert_money($post['money_cut'], '*');
            $data['status'] = 1;
            $data['start_time'] = strtotime($post['start_time']);
            $data['end_time'] = strtotime($post['end_time']);
            $data['create_time'] = time();
            $data['update_time'] = time();

            if ($post['couponid'] != '') {
                $res = M('mall_coupon')->where(array('id' => $post['couponid']))->save($data);
                $option = '修改';
            } else {
                $res = M('mall_coupon')->add($data);
                $option = '添加';
            }

            if ($res) {
                $this->success("优惠券{$option}成功！", U('Admin/Activity/couponlist', array(), true, true));
            } else {
                $this->error("优惠券{$option}失败, 请重新{$option}", U('Admin/Activity/couponlist', array(), true, true));
            }
        } else {
            $product_class = M("mall_menu");
            $result = $product_class->where(array('pid' => 0))->select();

            foreach ($result as $key => $value) {
                $new_array[$key] = $value;
                $pid = $value['id'];
                $result1 = $product_class->where(array('pid' => $pid))->select();
                foreach ($result1 as $key1 => $value1) {
                    $new_array[$key]['son'][$key1] = $value1;
                }
            }

            $this->assign('classlist', $new_array);
            $this->display();
        }
    }

    /**
     * 编辑修改优惠券
     */
    public function couponEdit()
    {
        $id = I('get.id', 0, 'intval');
        $coupon = M('mall_coupon')->find($id);
        if (!$coupon) $this->error('该优惠券不存在, 请重新编辑修改');

        $classList = $this->classListHtml($coupon['allow_class_id']);
        $goodsList = $this->goodsListHtml($coupon['allow_class_id'], $coupon['sku_ids']);

        $this->assign('classList', $classList);
        $this->assign('goodsList', $goodsList);
        $this->assign('coupon', $coupon);
        $this->display();
    }

    /**
     * 获取商品列表
     */
    public function getGoodsList()
    {
        if(IS_AJAX){
            $class_id = $_POST['class_id'];
            echo is_null($class_id) ? '请勾选类别' : $this->goodsListHtml($class_id);
        }
    }

    /**
     * 商品列表
     * @param array|string $class_id 分类数座或逗号隔开
     * @param string $sku_ids 商品sku_id(多个逗号隔开)
     * @return string html
     */
    private function goodsListHtml($class_id, $sku_ids = '')
    {
        if (is_array($class_id)) {
            $where['id'] = array('in', $class_id);
        } elseif(is_string($class_id) && $class_id != ''){
            $where['id'] = array('in', explode(',', $class_id));
        }

        $goods_html = '';
        $class_list = M('mall_menu')->where($where)->select();
        foreach ($class_list as $c) {
            $check = M('mall_good')->where(array('menu_id' => $c['id']))->count();
            if ($check != 0) {
                $goods_html .= '<div>' . $c['name'] . '</div>';
                $where_goode['menu_id'] = $c['id'];
                $goods_list = M('mall_good')->where($where_goode)->select();
                $sku_ids = $sku_ids != '' ? explode(',', $sku_ids) : array();
                foreach ($goods_list as $value) {
                    $checked = '';
                    if($sku_ids){
                        $checked = in_array($value['sku_id'], $sku_ids) ? 'checked' : '';
                    }
                    $goods_html .= '<label style="height:15px;display: block;"><input type="checkbox" name="allow_goods[]" ' . $checked . ' value="' . $value['sku_id'] . '">' . $value['name'] . '</label>';
                }
                $goods_html .= '<br>';
            }
        }

        return $goods_html == '' ? '此类别无商品' : $goods_html;
    }

    /**
     * 获取分类列表
     */
    public function getClassList()
    {
        if (IS_AJAX) {
            echo $this->classListHtml();
        }
    }

    /**
     * 分类列表
     * @param string $allowClassList 分类id (逗号隔开)
     * @return string 返回html
     */
    private function classListHtml($allowClassList = '')
    {
        $allowClassList = $allowClassList != '' ? explode(',', $allowClassList) : array();
        $class_list = M('mall_menu')->where(array('pid' => 0))->select();
        $class_html = '';
        foreach ($class_list as $value) {
            $checked = '';
            if ($allowClassList) {
                $checked = in_array($value['id'], $allowClassList) ? 'checked' : '';
            }
            $class_html .= '<label style="height:25px;display: block;"><input type="checkbox" ' . $checked . ' name="allow_classes[]" tag="tag' . $value['id'] . '" value="' . $value['id'] . '" onclick="changeclass(' . $value['id'] . ',0)"> ' . $value['name'] . '</label>';
            $son_class_list = M('mall_menu')->where(array('pid' => $value['id']))->select();
            if (!empty($son_class_list)) {
                $class_html .= '<div style="height:25px;display: block; ">├─';
                foreach ($son_class_list as $value1) {
                    $checked = '';
                    if ($allowClassList) {
                        $checked = in_array($value['id'], $allowClassList) ? 'checked' : '';
                    }
                    $class_html .= ' <input type="checkbox" ' . $checked . ' name="allow_classes[]" value="' . $value1['id'] . '" tag="tag' . $value['id'] . '" parentid="' . $value['id'] . '" onclick="changeclass(' . $value1['id'] . ',1)"> ' . $value1['name'] . '   ';
                }
                $class_html .= '</div>';
            }
        }

        if (empty($class_html)) {
            $class_html .= '暂无商品分类';
        }
        return $class_html;
    }

    /**
     * 优惠券详情页
     */
    public function couponDetails()
    {
        if (!IS_GET) {
            $this->error('请求不存在');
        }

        // 提取get数据
        $id = I('get.id', 0, 'intval');

        $info = M('mall_coupon')->find($id);

        $class_arr = explode(',', $info['allow_class_id']);
        $sku_arr = explode(',', $info['sku_ids']);
        foreach ($class_arr as $key => $v) {
            $info['class_name'][$key] = getclassname($v);
        }

        foreach ($sku_arr as $key => $v) {
            $info['goods_name'][$key] = get_goods_name($v);
        }

        // dump($info);die;
        $this->assign('info', $info);
        $this->display('coupon_details');
    }

    /**
     * 领取优惠券记录
     */
    public function couponRecord()
    {
        $couponId = I('get.id', 0, 'intval');
        $list = M('mall_coupon_record')
            ->where(array('coupon_id' => $couponId, 'deleted' => 0))
            ->page($this->page, $this->pageSize)
            ->order('id desc')
            ->select();
        $count = M('mall_coupon_record')
            ->where(array('coupon_id' => $couponId, 'deleted' => 0))
            ->count();
        $page = $this->page($count, array(), $this->pageSize);

        $this->assign('page', $page); // 赋值分页输出
        $this->assign('list', $list);
        $this->display();
    }

    public function couponRecordDel()
    {
        $id = I('get.id', 0, 'intval');
        $res = M('mall_coupon_record')->where(array('id' => $id))->setField('deleted', 1);
        if (false !== $res) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败, 请重新操作');
        }

    }


    //===========================================秒杀 begin=======================================================

    /**
     * 秒杀活动列表
     */
    public function seckill()
    {
        $list = M('activity_seckill_action')->order('action_id desc')->select();

        // 循环获取商品信息
        foreach ($list as $key => $value) {
            $list[$key]['goods_info'] = get_good_data($value['goods_id']);
        }

        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加秒杀活动
     */
    public function seckillAdd()
    {
        $actionModel = M('activity_seckill_action');

        if (IS_POST) {
            if ($_FILES['action_header_img']['name'] !== '') {
                $img = $this->upload();
                if (false === $img) {
                    $this->error("上传图片失败！");
                }
                $picurl = $img['action_header_img']['savepath'] . $img['action_header_img']['savename'];
            }

            // 第一阶段秒杀开始结束时间
            $sdate = strtotime(I('action_sdate'));
            $edate = strtotime(I('action_edate'));

            if ($edate < $sdate) {
                $this->error('活动结束时间小于开始时间！');
            }

            // 第二阶段和第三阶段秒杀开始结束时间 可为空 需判断
            $second_sdate = strtotime(I('second_sdate'));
            $second_edate = strtotime(I('second_edate'));
            $third_sdate = strtotime(I('third_sdate'));
            $third_edate = strtotime(I('third_edate'));

            if (!empty($second_sdate) && !empty($second_edate)) {
                if ($second_edate < $second_sdate) {
                    $this->error('活动结束时间小于开始时间！');
                }
            }

            if (!empty($third_sdate) && !empty($third_edate)) {
                if ($third_edate < $third_sdate) {
                    $this->error('活动结束时间小于开始时间！');
                }
            }

            // 判断价格
            if (!is_numeric(I('post.seckill_price'))) {
                $this->error('价格需是数字类型');
            } else {
                $seckill_price = convert_money(I('post.seckill_price', 0, 'intval'), '*');
            }

            // 判断商品是否存在
            $gid = I('post.goods_id', 0, 'intval');
            $goods = M('mall_good')->where(array('status' => MallModel::GOODS_STATUS_SELLING))->find($gid);
            if ($goods) {
                $goods_id = $gid;
            } else {
                $this->error('选择的商品不存在或已下架');
            }

            if (isset($_POST['id']) && !empty($_POST['id'])) {
                $data = array(
                    'action_id' => I('id', 0, 'intval'),
                    'action_name' => I('action_name'),
                    'action_sdate' => $sdate,
                    'action_edate' => $edate,
                    'second_sdate' => $second_sdate,
                    'second_edate' => $second_edate,
                    'third_sdate' => $third_sdate,
                    'third_edate' => $third_edate,
                    'action_open' => I('action_open', 0, 'intval'),
                    'seckill_price' => $seckill_price,
                    'seckill_nums' => I('post.seckill_nums', 0, 'intval'),
                    'goods_id' => $goods_id
                );

                // 更新秒杀图片
                $picurl ? $data['action_header_img'] = $picurl : '';

                $res = $actionModel->save($data);
                if (false !== $res) {
                    $this->success('修改成功');
                } else {
                    $this->error('修改失败');
                }
            } else {
                if ($actionModel->create()) {
                    $actionModel->action_sdate = $sdate;
                    $actionModel->action_edate = $edate;
                    $actionModel->second_sdate = $second_sdate;
                    $actionModel->second_edate = $second_edate;
                    $actionModel->third_sdate = $third_sdate;
                    $actionModel->third_edate = $third_edate;
                    $actionModel->action_open = I('action_open', 0, 'intval');
                    $actionModel->seckill_price = $seckill_price;
                    $actionModel->seckill_nums = I('post.seckill_nums', 0, 'intval');
                    $actionModel->goods_id = $goods_id;

                    if (isset($img['action_header_img'])) {
                        $actionModel->action_header_img = $picurl;
                    }
                    if ($res = $actionModel->add()) {
                        $this->success('添加成功');
                    }
                }
            }
        } else {
            if (isset($_GET['id']) && !empty($_GET['id'])) {
                $result = $actionModel->where(array('action_id' => intval($_GET['id'])))->find();
                if ($result) {
                    $this->assign('op', '修改');
                    $this->assign('result', $result);
                } else {
                    $this->assign('op', '添加');
                }
            } else {
                $this->assign('op', '添加');
            }

            // 调用全部商品
            $goods_list = M('mall_good')->field('id,name')->where(array('status' => MallModel::GOODS_STATUS_SELLING))->select();
//            dump($goods_list);die;

            $this->goods_list = $goods_list;

            $this->assign('id', intval($_GET['id']));
            $this->display();
        }
    }

    /**
     * 删除秒杀
     */
    public function seckillDel()
    {
        $actionModel = M('activity_seckill_action');

        $id = I('get.id', 0, 'intval');

        if ($actionModel->delete($id)) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 秒杀商品订单
     */
    public function seckillOrderList()
    {
        // 分页参数
        $page = $this->page;
        $pageSize = $this->pageSize;
        // 实例化一下model对象
        $model = new \Think\Model();

        //计算各状态数
        $Temp_data = D('Orders')->field('order_status,count(orders.id) as num')->where(array('order_type' => MallModel::ACTIVITY_TYPE_SECKILL))->group('order_status')->select();
        // dump($Temp_data);die;
        foreach ($Temp_data as $key => $value) {
            $StatusNum[$value['order_status']] = $value['num'];
            $StatusNum['all'] = $StatusNum['all'] + $value['num'];
        }

        // 查询条件
        $where = array('order_type' => MallModel::ACTIVITY_TYPE_SECKILL);

        // 提取GET数据  订单的状态值
        $status = I('get.s', 0, 'intval');
        // $status ? $where['order_status'] = $status : $where['_string'] = '1=1';
        $status ? $where['order_status'] = $status : '';

        // 判断是否是搜索
        $search = I('search', 0, 'intval');
        if ($search) {
            // 提取搜索时的POST数据
            $mobile_orderno = I('mobile_orderno');    // 收货人 订单号 手机号
            $pay_type = I('pay_type', 0, 'intval');   // 支付方式
            $start_create_time = I('start_create_time', '', 'strtotime');  // 订单创建时间
            $end_create_time = I('end_create_time', '', 'strtotime');  // 订单结束时间
            $goods_name = I('goods_name');

            if ($mobile_orderno) {
                $where['address.mobile|orders.order_number|address.name|user.nickname'] = $mobile_orderno;
            }

            if ($pay_type) {
                $where['orders.pay_style'] = $pay_type;
            }

            if (!empty($start_create_time) && !empty($end_create_time)) {
                $where['create_time'] = array('between', array($start_create_time, $end_create_time));
            }

            if (!empty($start_create_time) && empty($end_create_time)) {
                $where['create_time'] = array('between', array($start_create_time, $_SERVER['REQUEST_TIME']));
            }

            if (empty($start_create_time) && !empty($end_create_time)) {
                $where['create_time'] = array('between', array(0, $end_create_time));
            }

            if ($goods_name) {
                $goods_name = str_replace('\\', '\\\\', trim(json_encode($goods_name), '"'));
                $where['cart_data'] = array('LIKE', '%' . $goods_name . '%');
            }
        }

        $map = I('post.');
        // 循环数组 替换订单状态
        $status = C('ORDER_STATUS');
        $type = C('DELIVERY_TYPE');
        $pay = C('PAY_STYLE');

        if ($_GET['action'] == 'export') {
            $this->exportOrders($where);
        }

        $count = D('Orders')->where($where)->count('order_number');
        $list = D('Orders')->where($where)->order('orders.id desc')->page($page, $pageSize)->select();

        for ($i = 0; $i < count($list); $i++) {
            $list[$i]['order_status_id'] = $list[$i]['order_status'];
            $list[$i]['order_status'] = $status[$list[$i]['order_status']];
            $list[$i]['delivery_type'] = $type[$list[$i]['delivery_type']];
            $list[$i]['pay_style'] = $pay[$list[$i]['pay_style']];
        }

        foreach ($list AS $key => $value) {
            $cart_data_list = json_decode($value['cart_data'], true);
            $cart_data = array();
            foreach ($cart_data_list AS $key2 => $value2) {
                $cart_data[$key2] = get_good_data($value2['id']);
                $cart_data[$key2]['num'] = $value2['num'];  // 获取用户购买的数量
                $cart_data[$key2]['image'] = $value2['image'];  // 获取商品图片
            }
            $value['cart_data_list'] = $cart_data;
            $list[$key] = $value;
        }

        unset($map['__hash__']);
        unset($map['agent_rank_id2']);

        $show = $this->page($count, $map, $pageSize); // 实例化分页类 传入总记录数和每页显示的记录数

        $this->assign('StatusNum', $StatusNum);
        $this->assign('map', $map);
        $this->assign('result', $list);
        $this->assign('page', $show); // 赋值分页输出

        $this->display();
    }


    //===========================================秒杀 end=======================================================
    //===========================================团购 start=======================================================//

    /**
     * 团购活动列表
     */
    public function groupList()
    {
        // 实例化
        $GroupModel =M('activity_group_action');

        // 活动列表
        $list = $GroupModel->order('act_id desc')->select();
        // 循环获取商品信息
        foreach ($list as $key => $value) {
            $list[$key]['goods_info'] = get_good_data($value['goods_id']);
            $list[$key]['ext_info'] = unserialize($value['ext_info']);
            $list[$key]['goods_tags'] = implode(',', unserialize($value['goods_tags']));
            if ($list[$key]['ext_info']) {
                $str = '';
                foreach ($list[$key]['ext_info'] as $v) {
                    $str .= '人数: ' . $v['num'] . ' , 价格: ￥' . convert_money($v['price']) . '<br/>';
                }

                $list[$key]['ext_info'] = $str;
            } else {
                $list[$key]['ext_info'] = '--';
            }
        }

        $this->assign('list', $list);
        $this->display('group_list');
    }

    /**
     * 添加团购商品
     */
    public function addGroupGoods()
    {
        // 实例化
        $GroupModel =M('activity_group_action');

        // 判断提交方式
        if (IS_POST) {
            // 提取POST数据集
            $data = $GroupModel->create();

            // 处理数据集 && 附加数据
            $data['end_time'] = strtotime($data['end_time']);
            $nums = I('post.nums', 0, 'intval');    // 阶梯人数
            $price = I('post.price', 0, 'intval');  // 阶梯价格
            $data['goods_tags'] = serialize(explode(',', $data['goods_tags']));

            // 处理上传图片 为空时不更新数据库中的图片信息
            if ($_FILES['act_image']['name'] !== '') {
                $img = $this->upload();
                if (false === $img) {
                    $this->error("上传图片失败！");
                }
                $data['act_image'] = $img['act_image']['savepath'] . $img['act_image']['savename'];
            }

            // 处理阶梯价格
            $ext_info = array();
            $count = count($nums);
            for ($i = $count-1; $i >= 0; $i--) {
                // 如果数量小于 0, 排除
                if ($nums[$i] <= 0) {
                    continue;
                }
                // 如果价格小于 0, 排除
                if ($price[$i] <= 0) {
                    continue;
                }

                // 加入价格阶梯
                $ext_info[$nums[$i]] = array('num' => $nums[$i], 'price' => convert_money($price[$i], '*'));
            }
            if (count($ext_info) < 1) {
                $this->error('阶梯价格不能为空');
            }

            // 升序排列
            ksort($ext_info);
            $data['ext_info'] = serialize(array_values($ext_info));

            //dump($data);die;

            // 添加 或者 更新
            if ($data['act_id']) { // 活动ID存在则更新该活动
                if (false !== $GroupModel->save($data)) {
                    // 设置为已购买之后发送模版消息
                    if ($data['is_finished'] == 1) {
                        // 获取参与团购的人数
                        $map = array('act_id' => $data['act_id']);
                        $count = M('activity_group_bespoke')->where($map)->Count('openid');
                        $openid = M('activity_group_bespoke')->where($map)->getField('openid',true);
                        //dump($openid);die;
                        foreach ($openid as $value) {
                            $goodData = get_good_data($data['goods_id']);
                            $temp_arr = array('wechat' => 'OPENTM206953801');
                            $user_arr = array('wechat' => $value);
                            $msg_arr = array(
                                'wechat' => array(
                                    'url' => HOME_URL . U('Mall/Activity/bespoke', array('id'=> $data['goods_id'], 'aid'=> $data['act_id'])),
                                    'data' => array(
                                        'first' => array('value' => '您好，您参与的团购现已开团'),
                                        'keyword1' => array('value' => $goodData['name']),
                                        'keyword2' => array('value' => date('Ymd', time())),
                                        'keyword3' => array('value' => $count . '人'),
                                        'remark' => array('value' => '请您尽快前往购买！')
                                    )
                                )
                            );
                            //dump($msg_arr);die;
                            addMessengerQueue('wechat', $temp_arr, $user_arr, $msg_arr);
                        }
                    }
                    $this->success('更新成功', U('groupList'), 1);
                } else {
                    $this->error('更新失败');
                }
            } else { // 活动id 不存在则新建活动
                if ($GroupModel->add($data)) {
                    $this->success('新建成功', U('groupList'), 1);
                } else {
                    $this->error('新建失败,请重新添加...');
                }
            }

        } else {
            // 提取GET数据
            $act_id = I('get.id', 0, 'intval');
            $info = $GroupModel->find($act_id);
            $info['ext_info'] = unserialize($info['ext_info']);
            $info['goods_tags'] = implode(',', unserialize($info['goods_tags']));

            $info ? $this->assign('info', $info) : '';

            // 获取正在出售的商品列表
            $map['status'] = MallModel::GOODS_STATUS_SELLING;
            $goods_list = M('mall_good')->field('id,name')->where($map)->select();

            $this->assign('goods_list', $goods_list);
            $this->display('group_add');
        }
    }

    /**
     * 删除团购活动
     */
    public function delGroup()
    {
        if (!IS_GET) {
            $this->error('请求方式错误');
        }

        $id = I('get.id', 0, 'intval');

        if (M('activity_group_action')->delete($id)) {
            $this->success('删除成功', U('groupList'), 1);
        } else {
            $this->error('删除失败', U('groupList'), 1);
        }
    }

    /**
     * 查看预约人数
     */
    public function showDepositNums()
    {
        // 提取GET数据
        $act_id = I('get.id', 0, 'intval');
        $map = array('act_id' => $act_id);
        $count = M('activity_group_bespoke')->where($map)->Count('openid');
        $list = M('activity_group_bespoke')->where($map)->page($this->page, $this->pageSize)->order('create_time desc')->select();
        $page = $this->page($count, $map, $this->pageSize);

        foreach ($list as $k => $v) {
            $uid = M('user')->where(array('openid' => $v['openid']))->getField('uid');
            $username = get_user_info($uid);
            $list[$k]['username'] = $username['nickname'];
        }

        $this->assign('list', $list);
        $this->assign('page', $page);
        $this->display();
    }

    //===========================================团购 end=======================================================//

    //===========================================预售 start=======================================================//

    /**
     * 预售活动列表
     */
    public function bookingList()
    {
        // 实例化
        $GroupModel =M('activity_booking_action');

        // 活动列表
        $list = $GroupModel->order('act_id desc')->select();
        // 循环获取商品信息
        foreach ($list as $key => $value) {
            $list[$key]['goods_info'] = get_good_data($value['goods_id']);
        }

        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加预售商品
     */
    public function addBookingGoods()
    {
        // 实例化
        $GroupModel =M('activity_booking_action');

        // 判断提交方式
        if (IS_POST) {
            // 提取POST数据集
            $data = $GroupModel->create();
            $data['price'] = convert_money($data['price'], '*');
            $data['start_time'] = strtotime($data['start_time']);

            // 处理上传图片 为空时不更新数据库中的图片信息
            if ($_FILES['act_image']['name'] !== '') {
                $img = $this->upload();
                if (false === $img) {
                    $this->error("上传图片失败！");
                }
                $data['act_image'] = $img['act_image']['savepath'] . $img['act_image']['savename'];
            }

            //dump($data);die;

            // 添加 或者 更新
            if ($data['act_id']) { // 活动ID存在则更新该活动
                if (false !== $GroupModel->save($data)) {
                    $this->success('更新成功', U('bookingList'), 1);
                } else {
                    $this->error('更新失败');
                }
            } else { // 活动id 不存在则新建活动
                if ($GroupModel->add($data)) {
                    $this->success('新建成功', U('bookingList'), 1);
                } else {
                    $this->error('新建失败,请重新添加...');
                }
            }

        } else {
            // 提取GET数据
            $act_id = I('get.id', 0, 'intval');
            $info = $GroupModel->find($act_id);

            $info ? $this->assign('info', $info) : '';

            // 获取正在出售的商品列表
            $map['status'] = MallModel::GOODS_STATUS_SELLING;
            $goods_list = M('mall_good')->field('id,name')->where($map)->select();

            $this->assign('goods_list', $goods_list);
            $this->display();
        }
    }

    /**
     * 删除预售活动
     */
    public function delBooking()
    {
        if (!IS_GET) {
            $this->error('请求方式错误');
        }

        $id = I('get.id', 0, 'intval');

        if (M('activity_booking_action')->delete($id)) {
            $this->success('删除成功', U('bookingList'), 1);
        } else {
            $this->error('删除失败', U('bookingList'), 1);
        }
    }

    /**
     * 查看预售预约人数
     */
    public function showBookingNums()
    {
        // 提取GET数据
        $act_id = I('get.id', 0, 'intval');
        $map = array('act_id' => $act_id);
        $count = M('activity_booking_bespoke')->where($map)->Count('openid');
        $list = M('activity_booking_bespoke')->where($map)->page($this->page, $this->pageSize)->order('create_time desc')->select();
        $page = $this->page($count, $map, $this->pageSize);

        foreach ($list as $k => $v) {
            $uid = M('user')->where(array('openid' => $v['openid']))->getField('uid');
            $username = get_user_info($uid);
            $list[$k]['username'] = $username['nickname'];
        }

        $this->assign('list', $list);
        $this->assign('page', $page);
        $this->display();
    }

    //===========================================预售 end=======================================================//

    public function menu()
    {
        $list = M('activity_menu')
            ->alias('m')
            ->field('m.*, i.url, i.title')
            ->join('hx_activity_menu_item as i on m.item_id=i.id', 'left')
            ->where('1')
            ->select();

        $this->assign('list', $list);
        $this->display();
    }

    public function newMenuItem()
    {
        if (IS_POST) {
            $data = I('post.');
            $data['created_by'] = session('user_id');
            $data['created_at'] = time();

            $menu = D('activity_menu');

            if ($menu->create($data)) {
                $result = $menu->add();
                if($result) {
                    $this->success('添加菜单项成功', U('menu'));
                    exit;
                } else {
                    $this->error('添加菜单项失败');
                    exit;
                }
            } 
        }

        $items = M('activity_menu_item');
        $item_list = $items->where('1')->select();
        $this->assign('item_list', $item_list);

        $this->display();
    }

    public function editMenuItem()
    {
        if (IS_POST) {
            $data = I('post.');
            $data['modified_by'] = session('user_id');
            $data['updated_at'] = time();

            $menu = D('activity_menu');
            if ($menu->create($data)) {
                $result = $menu->where('id='.$data['id'])->save($data);
                if($result) {
                    $this->success('菜单更新成功', U('menu'));
                    exit;
                } else {
                    $this->error('更新菜单失败');
                    exit;
                }
            }
        }
        $id = I('get.id');

        $menu = M('activity_menu');
        $result = $menu->where(array('id' => $id))->find();

        $item = M('activity_menu_item');
        $item_list = $item->where('1')->select();

        $this->assign('result', $result);
        $this->assign('item_list', $item_list);
        $this->display();
    }

    public function deleteMenuItem()
    {
        $id = I('get.id');

        $menu = M('activity_menu');

        $result = $menu->where('id='.$id)->delete();

        if ($result) {
            $this->success('菜单项删除成功', U('menu'));
            exit;
        }

        $this->error('菜单项删除失败');
        exit;
    }

}
