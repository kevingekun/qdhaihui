<?php
/**
 * 角色权限验证模块
 * User: gaorenhua
 * Date: 2015/10/13 18:41
 * Email: 597170962@qq.com
 */

namespace Admin\Controller;

use Common\Controller\AdminController;

class RbacController extends AdminController
{
    /**
     * 用户列表
     */
    public function userList()
    {
        $list = M('auth_user')->select();
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加用户
     */
    public function addUser()
    {
        // 判断请求方式
        if (IS_POST) {
            // 实例化对象
            $user = M('auth_user');
            // 验证规则
            $rules = array(
                array('nickname', 'require', '昵称必填'),
                array('username', 'require', '用户名必填'),
                array('password', 'require', '密码必填'),
                array('repassword', 'password', '确认密码不正确', 0, 'confirm'),
                array('email', 'email', '邮箱格式不正确'), // 内置正则验证邮箱格式
                array('mobile', '/^1[34578]\d{9}$/', '手机号码格式不正确', 0), // 正则表达式验证手机号码
            );

            // 创建数据集
            $data = $user->validate($rules)->create();
            if (!$data) $this->error($user->getError());

            $data['regdate'] = $_SERVER['REQUEST_TIME'];
            $data['regip'] = get_client_ip();
            $data['role_id'] = I('role_id', 0, 'intval');

            // 处理密码
            $data['password'] = md5($data['password']);

            //插入数据库
            if ($id = $user->add($data)) {
                $this->success('添加成功', U('Rbac/userList'), 2);
            } else {
                $this->error('添加失败');
            }
        } else {
            // 角色列表
            $list = M('auth_role')->select();
            $this->assign('list', $list);
            $this->display();
        }
    }

    /**
     * 修改用户
     */
    public function upUser()
    {
        // 判断请求方式
        if (IS_POST) {
            // 实例化对象
            $user = M('auth_user');

            // 验证规则
            $rules = array(
                array('nickname', 'require', '昵称必填'),
                array('username', 'require', '用户名必填'),
                array('email', 'email', '邮箱格式不正确'), // 内置正则验证邮箱格式
                array('mobile', '/^1[34578]\d{9}$/', '手机号码格式不正确', 0), // 正则表达式验证手机号码
            );

            // 创建数据集
            $data = $user->validate($rules)->create();
            if (!$data) $this->error($user->getError());
            // 过滤掉空数组
            $data = array_filter($data);
            $data['repassword'] = I('post.repassword');
            if (!empty($data['password'])) {
                if ($data['password'] != $data['repassword']) $this->error('两次输入密码不一致!');
                $data['password'] = md5($data['password']);
            }

            //插入数据库
            if (false !== $user->save($data)) {
                $this->success('修改成功', U('Rbac/userList'), 2);
            } else {
                $this->error('修改失败');
            }
        } else {
            // 提取get数据
            $id = I('get.id', 0, 'intval');
            $info = M('auth_user')->find($id);
            if (!$info) $this->error('用户不存在');

            // 查询角色id
            $role_id = $info['role_id'];
            // 角色列表
            $list = M('auth_role')->select();

            $this->assign('info', $info);
            $this->assign('list', $list);
            $this->assign('role_id', $role_id);
            $this->display();
        }
    }

    /**
     * 删除用户
     */
    public function delUser()
    {
        // 提取get数据
        $id = I('id', 0, 'intval');

        if (M('auth_user')->delete($id)) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 修改密码
     */
    public function changePassword()
    {
      if (IS_POST) {
        // 自动验证规则
        $rules = array(
          array('password','require','请输入新密码!'), //默认情况下用正则进行验证
          array('repassword','require','请再次输入新密码!'), //默认情况下用正则进行验证
          array('repassword','password','确认密码不正确',0,'confirm'), // 验证确认密码是否和密码一致
        );

        // 自动验证
        $user = M('auth_user');
        if (!$data = $user->validate($rules)->create()) {
          $this->error($user->getError(), __SELF__, 2);
        }

        // 重组数组
        $data['oldpass'] = I('post.oldpass');
        // dump($data);die;

        // 获取该用户原密码
        $oldpass = $user->where(array('user_id' => session('user_id')))->getField('password');
        // var_dump($oldpass);die;
        if ($oldpass != md5($data['oldpass'])) {
          $this->error('原密码输入不正确', __SELF__, 2);
        }

        if (md5($data['oldpass']) == md5($data['password'])) {
          $this->error('新密码与原密码一样,修改失败', __SELF__, 2);
        }

        // 重新处理数据
        $data['user_id'] = session('user_id');
        $data['password'] = md5($data['password']);
        unset($data['oldpass']);
        unset($data['repassword']);
        // dump($data);die;

        // 更新密码
        if ($user->save($data)) {
          $this->success('修改成功', __SELF__, 1);
        } else {
          $this->error('修改失败', __SELF__, 2);
        }

      } else {
        $this->display();
      }
    }

    /**
     * 角色列表
     */
    public function roleList()
    {
        $list = M('auth_role')->select();
        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加角色
     */
    public function addRole()
    {
        // 判断请求方式
        if (IS_POST) {
            // 实例化模型
            $role = M('auth_role');

            // 动态验证规则
            $rules = array(
                array('name', 'require', '名称不能为空！'), //默认情况下用正则进行验证
                array('name', '', '该角色已经存在！', 0, 'unique', 1), // 在新增的时候验证name字段是否唯一
                array('status', array(0, 1), '状态选择不正确！', 2, 'in'), // 当值不为空的时候判断是否在一个范围内
            );

            // 验证
            if (!$role->validate($rules)->create()) {
                // 防止输出中文乱码
                header("Content-type: text/html; charset=utf-8");
                exit($role->getError());
            }

            // 添加角色
            if ($role->add()) {
                $this->success('添加成功', U('roleList'), 1);
            } else {
                $this->error('添加失败');
            }
        } else {
            $this->display();
        }
    }

    /**
     * 修改角色
     */
    public function upRole()
    {
        // 判断请求方式
        if (IS_POST) {
            // 实例化模型
            $role = M('auth_role');

            // 动态验证规则
            $rules = array(
                array('name', 'require', '名称不能为空！'), //默认情况下用正则进行验证
                array('status', array(0, 1), '状态选择不正确！', 2, 'in'), // 当值不为空的时候判断是否在一个范围内
            );

            // 验证
            if (!$role->validate($rules)->create()) {
                // 防止输出中文乱码
                header("Content-type: text/html; charset=utf-8");
                exit($role->getError());
            }

            // 添加角色
            if ($role->save()) {
                $this->success('修改成功', U('roleList'), 1);
            } else {
                $this->error('修改失败');
            }
        } else {
            // 提取get数据
            $id = I('id', 0, 'intval');

            $info = M('auth_role')->find($id);

            $this->assign('info', $info);
            $this->display();
        }
    }

    /**
     * 设置权限
     */
    public function giveAuth()
    {
        if (IS_POST) {
            $rid = I('rid', 0, 'intval');
            $db = M('auth_access');

            //清空原有权限
            $db->where(array('role_id' => $rid))->delete();
            //组合新权限
            $data = array();
            foreach ($_POST['node_id'] as $v) {
                $tmp = explode('_', $v);
                $data[] = array(
                    'role_id' => $rid,
                    'node_id' => $tmp[0],
                    'level' => $tmp[1]
                );
            }

            //插入新的权限
            if ($db->addAll($data)) {
                $this->success('修改成功');
            } else {
                $this->error('修改失败，请联系管理员');
            }
        } else {
            $id = I('get.id', 0, 'intval');
            $role = M('auth_role')->where(array('id'=>$id))->find();
            if(!$role) $this->error('角色不存在');

            // 查询条件
            $list = M('auth_node')->select();
            $list = node_merge($list);  // 递归重组

            //获取当前用户组权限
            $node_array = M("auth_access")->where(array('role_id' => $id))->getField('node_id', true);


            $list = $this->createAuthList($list, $node_array);
            $this->assign('list', $list);
            $this->assign('role', $role);
            $this->display();
        }
    }

    /**
     * 递归重组下权限列表
     * @param $list
     * @param $node_array
     * @return mixed
     */
    private function createAuthList($list, $node_array)
    {
        foreach($list as $key => $value){
            if (in_array($value['id'], $node_array)) {
                $list[$key]['checked'] = '1';
            } else {
                $list[$key]['checked'] = '0';
            }

            if (!empty($value['child'])) {
                $list[$key]['child'] = $this->createAuthList($value['child'], $node_array);
            }
        }
        return $list;
    }

    /**
     * 删除角色
     */
    public function delRole()
    {
        // 提取get数据
        $id = I('id', 0, 'intval');

        if (M('auth_role')->delete($id)) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

    /**
     * 节点列表
     */
    public function nodeList()
    {
        // 实例化模型
        $role = M('auth_node');

        // 查询条件
        $where = array();
        $list = $role->where($where)->select();
        $list = node_merge($list);  // 递归重组

        $this->assign('list', $list);
        $this->display();
    }

    /**
     * 添加节点
     */
    public function addNode()
    {
        // 实例化模型
        $node = M('auth_node');

        // 判断请求方式
        if (IS_POST) {
            // 动态验证规则
            $rules = array(
                array('name', 'require', '标识不能为空！'), //默认情况下用正则进行验证
                //array('name', '', '该标识已经存在！', 0, 'unique', 1), // 在新增的时候验证name字段是否唯一
                array('title', 'require', '名称不能为空！'), //默认情况下用正则进行验证
                array('status', array(0, 1), '状态选择不正确！', 2, 'in'), // 当值不为空的时候判断是否在一个范围内
            );

            // 验证
            if (!$node->validate($rules)->create()) {
                $this->error($node->getError());
            }

            // 添加角色
            if ($node->add()) {
                $this->success('添加成功', U('nodeList'), 1);
            } else {
                $this->error('添加失败');
            }
        } else {
            // 获取所有父级节点
            $list = $node->field('id,pid,title')->select();
            $list = node_merge($list);  // 递归重组

            $this->assign('list', $list);
            $this->display();
        }
    }

    /**
     * 修改节点
     */
    public function upNode()
    {
        // 实例化模型
        $node = M('auth_node');

        // 判断请求方式
        if (IS_POST) {
            // 动态验证规则
            $rules = array(
                array('name', 'require', '标识不能为空！'), //默认情况下用正则进行验证
                array('title', 'require', '名称不能为空！'), //默认情况下用正则进行验证
                array('status', array(0, 1), '状态选择不正确！', 2, 'in'), // 当值不为空的时候判断是否在一个范围内
            );

            // 验证
            if (!$node->validate($rules)->create()) {
                $this->error($node->getError());
            }

            // 添加角色
            if ($node->save()) {
                $this->success('修改成功', U('nodeList'), 1);
            } else {
                $this->error('修改失败');
            }
        } else {
            // 获取所有父级节点
            $list = $node->field('id,pid,title')->select();
            $list = node_merge($list);  // 递归重组

            $this->assign('list', $list);

            // 提取get数据
            $id = I('id', 0, 'intval');

            // 获取单条节点数据
            $info = $node->find($id);

            $this->assign('info', $info);
            $this->display();
        }
    }

    /**
     * 删除节点
     */
    public function delNode()
    {
        // 提取get数据
        $id = I('id', 0, 'intval');

        if (M('auth_node')->delete($id)) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }

}
