<?php
/**
 * 登录 注册模块
 * User: gaorenhua
 * Date: 2015/10/14 9:26
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;

use Think\Verify;
use Think\Controller;
use Org\Util\Rbac;

class LoginController extends Controller
{
    /**
     * 登录
     */
    public function login()
    {
        // 判断提交方式
        if (IS_POST) {
            // 实例化Login对象
            $login = D('Login');

            // 自动验证 创建数据集
            if (!$data = $login->create()) {
                $this->error($login->getError());
            }

            // 组合查询条件
            $where = array();
            $where['username'] = $data['username'];

            $authInfo = RBAC::authenticate($where, 'auth_user');
            //使用用户名、密码和状态的方式进行认证
            if (false === $authInfo) {
                $this->error('帐号不存在或已禁用！');
            } else {
                if ($authInfo['password'] != $data['password']) {
                    $this->error('密码错误！');
                }
                session(C('USER_AUTH_KEY'), $authInfo['user_id']);  // 当前用户id
                $_SESSION[C('USER_AUTH_KEY')] = $authInfo['user_id'];
                if($this->checkSuperUser($authInfo['username'])){
                    $_SESSION[C('ADMIN_AUTH_KEY')] = true; // 因为session函数 有前缀, 所以为了保证和RBAC.class.php统一, 这里用 $_SESSION
                }

                session('user_id', $authInfo['user_id']);   // 当前用户昵称
                session('nickname', $authInfo['nickname']);   // 当前用户昵称
                session('username', $authInfo['username']);   // 当前用户名
                session('lastdate', $authInfo['lastdate']);   // 上一次登录时间
                session('lastip', $authInfo['lastip']);       // 上一次登录ip

                $roleName = M('auth_role')->getField('name');
                session('rolename', $roleName);

                //保存登录信息
                $data = array();
                $data['user_id'] = $authInfo['user_id'];
                $data['lastdate'] = time();
                $data['loginnum'] = array('exp', 'loginnum+1');
                $data['lastip'] = get_client_ip();
                M('User')->save($data);
                operate_log($data['user_id'], 'auth_user', 2);

                // 缓存访问权限
                RBAC::saveAccessList($authInfo['user_id']);
                $this->success('登录成功！', '/Admin/Index/index');
            }
        } else {
            $this->display();
        }
    }

    /**
     * 注册
     */
    public function register()
    {
        // 判断提交方式
        if (IS_POST) {
            // 实例化对象
            $user = D('Register');

            // 自动验证 创建数据集
            if (!$data = $user->create()) {
                // 防止输出中文乱码
                header("Content-type: text/html; charset=utf-8");
                exit($user->getError());
            }

            //插入数据库
            if ($id = $user->add($data)) {
                $this->success('注册成功', U('Rbac/userList'), 2);
            } else {
                $this->error('注册失败');
            }
        } else {
            $this->display();
        }
    }

    /**
     * 退出
     */
    public function logout()
    {
        // 清楚所有session
        session_destroy();
        // 防止输出中文乱码
        header("Content-type: text/html; charset=utf-8");
        redirect(U('Login/login'), 2, '正在退出登录...');
    }

    /**
     * 检查是否超级管理员
     * @param $username 用户名
     * @return bool
     */
    private function checkSuperUser($username)
    {
        $superUser = C('RBAC_SUPERADMIN');
        $superUserArr = explode(',', $superUser);
        $superUserArr = array_map('trim', $superUserArr);
        if(empty($superUserArr)) return false;

        if(in_array($username, $superUserArr)){
            return true;
        } else {
            return false;
        }
    }

    /**
     * 验证码
     */
    public function verify()
    {
        // 实例化Verify对象
        $verify = new Verify();

        // 配置验证码参数
        $verify->fontSize = 14;     // 验证码字体大小
        $verify->length = 4;        // 验证码位数
        $verify->imageH = 34;       // 验证码高度
        $verify->useImgBg = true;   // 开启验证码背景
        $verify->useNoise = false;  // 关闭验证码干扰杂点
        $verify->entry();
    }
}
