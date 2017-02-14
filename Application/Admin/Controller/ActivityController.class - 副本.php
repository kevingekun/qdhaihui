<?php
namespace Admin\Controller;

use Common\Controller\AdminController;

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
        $coupon->where($where)->save($data);

        $this->success('操作成功');
        exit;

    }

    /**
     * 添加优惠券
     */
    public function couponadd()
    {
        if (IS_POST) {
            $coupon = D('coupon');

            // 自动验证
            if (!$data = $coupon->create()) {
                $this->error($coupon->getError());
            }
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

            if (M('mall_coupon')->add($data)) {
                $this->success("优惠券添加成功！");
            } else {
                $this->success("优惠券添加失败, 请重新添加");
            }
            die;
        }

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

    /**
     * 获取商品列表
     */
    public function getGoodsList()
    {
        $class_id = $_POST['class_id'];

        if (is_null($class_id)) {
            $goods_html .= '请勾选类别';
            echo $goods_html;
            exit;
        }

        if (is_array($class_id)) {
            $where['id'] = array('in', $class_id);
        }

        $class_list = M('mall_menu')->where($where)->select();

        $goods = M('mall_good');
        foreach ($class_list as $c) {
            $check = M('mall_good')->where(array('menu_id' => $c['id']))->count();
            if ($check != 0) {

                $goods_html .= '<div>' . $c['name'] . '</div>';
                $where_goode['menu_id'] = $c['id'];
                $goods_list = $goods->where($where_goode)->select();

                foreach ($goods_list as $value) {
                    $goods_html .= '<label style="height:15px;display: block;"><input type="checkbox" name="allow_goods[]" value="' . $value['sku_id'] . '">' . $value['name'] . '</label>';

                }
                $goods_html .= '<br>';

            }

        }
//
//
//        $where['pid']=array('in',$class_list);
//
//        $goods=M('mall_good')->where($where)->select();
//
//        $goods_html='';


        if (empty($goods_html)) {
            $goods_html .= '此类别无商品';
        }

        echo $goods_html;
    }

    /**
     * 获取分类列表
     */
    public function getClassList()
    {

        $class_list = M('mall_menu')->where(array('pid' => 0))->select();

        $class_html = '';

        foreach ($class_list as $value) {
            $class_html .= '<label style="height:25px;display: block;"><input type="checkbox" name="allow_classes[]" tag="tag' . $value['id'] . '" value="' . $value['id'] . '" onclick="changeclass(' . $value['id'] . ',0)"> ' . $value['name'] . '</label>';
            $son_class_list = M('mall_menu')->where(array('pid' => $value['id']))->select();

            if (!empty($son_class_list)) {

                $class_html .= '<div style="height:25px;display: block; ">├─';

                foreach ($son_class_list as $value1) {

                    $class_html .= ' <input type="checkbox" name="allow_classes[]" value="' . $value1['id'] . '" tag="tag' . $value['id'] . '" parentid="' . $value['id'] . '" onclick="changeclass(' . $value1['id'] . ',1)"> ' . $value1['name'] . '   ';

                }

                $class_html .= '</div>';

            }


        }

        if (empty($class_html)) {
            $class_html .= '暂无商品分类';
        }

        echo $class_html;
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


    //===========================================秒杀 begin=======================================================

    /**
     * 秒杀活动列表
     */
    public function seckill()
    {
        $list = M('activity_seckill_action')->order('action_id DESC')->select();
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 新建秒杀
     */
    public function seckillAdd()
    {
        $actionModel = M('activity_seckill_action');

        if (IS_POST) {
            if (!is_numeric(I('post.share_time_min'))) {
                $this->error('分享时间请填写数字类型！');
            } elseif (!is_numeric(I('share_time_max'))) {
                $this->error('分享时间请填写数字类型！');
            }

            if ($_FILES['reply_pic']['name'] !== '' || $_FILES['action_header_img']['name'] !== '') {
                $img = $this->upload();
                if(false === $img){
                    $this->error("上传图片失败！");
                }
                $picurl = $img['image']['savepath'] . $img['image']['savename'];
            } else {
                $this->error("请上传图片！");
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
                    'rand_min_time' => I('share_time_min'),
                    'rand_max_time' => I('share_time_max'),
                    'action_rule' => I('action_rule'),
//                    'action_token' => $this->token,
//                    'action_is_attention' => $_POST['action_is_attention'],
//                    'action_is_reg' => $_POST['action_is_reg'],
                    'action_open' => I('action_open', 0, 'intval'),
                    //'action_header_img' => $img['reply_pic']['savepath'] . $img['reply_pic']['savename'],
                    'reply_title' => I('reply_title'),
                    'reply_content' => I('reply_content'),
                    //'reply_pic' => $img['reply_pic']['savepath'] . $img['reply_pic']['savename'],
                    'reply_keyword' => I('reply_keyword')
                );

                if(isset($img['action_header_img']) && isset($img['reply_pic'])){
                    $data['action_header_img'] = $img['action_header_img']['savepath'] . $img['action_header_img']['savename'];
                    $data['reply_pic'] = $img['reply_pic']['savepath'] . $img['reply_pic']['savename'];
                }

//                $this->handleKeyword($this->_post('id', 'intval'), 'Seckill', $this->_post('reply_keyword', 'trim'));
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
//                    $actionModel->action_key = $this->get_key();
                    $actionModel->rand_min_time = I('share_time_min');
                    $actionModel->rand_max_time = I('share_time_max');
//                $actionModel->action_token = $this->token;
//                $actionModel->action_is_attention = I('action_is_attention');
//                $actionModel->action_is_reg = I('action_is_reg');
                    $actionModel->action_open = I('action_open', 0, 'intval');

                    if(isset($img['action_header_img']) && isset($img['reply_pic'])){
                        $actionModel->action_header_img = $img['action_header_img']['savepath'] . $img['action_header_img']['savename'];
                        $actionModel->reply_pic = $img['reply_pic']['savepath'] . $img['reply_pic']['savename'];
                    }
                    if ($res = $actionModel->add()) {
//                    $this->handleKeyword($res, 'Seckill', $this->_post('reply_keyword', 'trim'));
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
            $this->assign('id', intval($_GET['id']));
            $this->display();
        }
    }

    /**
     * 删除秒杀
     */
    public function seckillDel()
    {

    }


    //===========================================秒杀 end=======================================================


}
