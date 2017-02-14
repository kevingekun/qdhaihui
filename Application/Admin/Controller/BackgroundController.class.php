<?php
/**
 * 后台公共服务, 文件上传走这里
 * User: gaorenhua
 * Date: 2015/10/19 16:45
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;
use Common\Model\MallModel;

class BackgroundController extends AdminController
{

    function _initialize(){
//        $session_name = session_name();
//        if(isset($_POST[$session_name]))
//        {
//            session_id($_POST[$session_name]);
//            session_start();
//        }
    }
    /**
     * 多文件上传
     */
    public function fileUpload(){

        $token=I('post.token');
        $timestamp=I('post.timestamp');
        $verifyToken = md5('unique_salt' . $timestamp);
        file_put_contents('./up.log',var_export($_REQUEST,true)."\r\n".var_export($info,true),FILE_APPEND);
        if (!empty($_FILES) && $token == $verifyToken) {
            $info = parent::upload();

            $data=array(
                'savename'=>$info['Filedata']['savename'],//保存名称
                'savepath'=>$info['Filedata']['savepath'],//保存路径
                'status'=>1,//状态
            );

            $this->ajaxReturn($data);
        }
    }
}
