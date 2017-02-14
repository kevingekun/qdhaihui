<?php
namespace Admin\Controller;

use Common\Controller\AdminController;

class ToolsController extends AdminController
{

    public function index()
    {
        $this->display();
    }

    public function reply()
    {
        $template = M("msg_template");
        $where['status'] = 1;
        $list = $template->where($where)->select();

        $this->assign('list', $list);
        $this->display();
    }

    public function msglog()
    {
        $msglog = M("msg_log");

        $count = $msglog->count();
        $list = $msglog->page($this->page, $this->pageSize)->select();
        $page = $this->page($count, '', $this->pageSize);

        foreach ($list as $key => $v) {
            $new_array[$key] = $v;
            $result = (array)json_decode($v['result']);
            $new_array[$key]['state'] = $result['code'] == 0 ? '发送成功' : '发送失败';
            $new_array[$key]['msg'] = $result['msg'];
        }

        $list = $new_array;
        $this->assign('list', $list);
        $this->assign('page', $page);
        $this->display();

    }

    public function upreply()
    {
        $template = M("msg_template");
        $where['status'] = 1;
        $where['id'] = $_REQUEST['id'];
        $info = $template->where($where)->find();

        if (IS_POST) {
            if ($info['temp_style'] == 1) {
                $data['temp_content'] = $_REQUEST['temp_content'];
            } else {
                $data['temp_first'] = $_REQUEST['temp_first'];
                $data['temp_remark'] = $_REQUEST['temp_remark'];
            }

            $template->where($where)->save($data);
            $this->success('修改成功！');
            exit;
        }

        $this->assign('info', $info);
        $this->display();
    }

    public function notice()
    {
        $this->display();
    }

    /**
     * 关闭操作
     */
    public function close()
    {
        if(IS_POST){
            $closeMall = I('post.close_mall', 0, 'intval');
            $closePay = I('post.close_pay', 0, 'intval');
            $data1 = array('value' => $closeMall);
            $data2 = array('value' => $closePay);

            $res1 = M('attribute')->where(array('type' => 'close_mall'))->save($data1);
            $res2 = M('attribute')->where(array('type' => 'close_pay'))->save($data2);

            M()->startTrans();
            if($res1 !== false && $res2 !== false){
                M()->commit();
                $this->success('操作成功');
            } else {
                M()->rollback();
                $this->error('操作失败');
            }
        } else {
            $closeMall = M('attribute')->where(array('type' => 'close_mall', 'status'=>0))->getField('value');
            $closePay = M('attribute')->where(array('type' => 'close_pay', 'status'=>0))->getField('value');

            $this->assign('closeMall', intval($closeMall));
            $this->assign('closePay', intval($closePay));
            $this->display();
        }
    }
}
