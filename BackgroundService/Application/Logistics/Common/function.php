<?php
/**
 * Home应用通用函数
 * @author: yanhuaitang
 * @date: 2015/10/13 15:48
 */

/**
 * 通过推广链接, 授权之后保存用户
 * @param $openid
 * @return int|mixed
 */
function save_author_user($openid)
{
    $User = M('user');
    $user = $User->where("openid='{$openid}'")->find();

    if(!$user){
        $inviteId = intval(isset($_GET['uid']) ? $_GET['uid'] : 0);
        if($inviteId > 0){
            $inviteUser = $User->where("invite_id={$inviteId}")->find();
            $inviteId = $inviteUser ? $inviteUser['invite_id'] : 0;
        }
        $data = array(
            'openid' => $openid,
            'invite_id' => $inviteId
        );
        return $insertId = $User->data($data)->add();
    }
    return 0;
}

