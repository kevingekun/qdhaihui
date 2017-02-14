<?php
return array(
    /**
     * 角色权限控制 RBAC
     */
    'USER_AUTH_ON'  =>  true,                        // 是否需要认证
    'USER_AUTH_TYPE'    =>  2,                       // 认证类型 1-登录认证 2-实时认证
    'USER_AUTH_KEY' =>  'admin_uid',                 // 认证识别号
    'ADMIN_AUTH_KEY' =>  'admin_auth_key',           // 超级管理员
    'REQUIRE_AUTH_MODULE'   =>  '',                  // 默认需要认证模块
    'NOT_AUTH_MODULE'   =>  '',                 // 默认无需认证模块
    'USER_AUTH_GATEWAY' =>  '/Admin/Login/login',    // 认证网关
    'RBAC_ROLE_TABLE'   =>  'hx_auth_role',          // 角色表名称
    'RBAC_USER_TABLE'   =>  'hx_auth_user',     // 用户表名称
    'RBAC_ACCESS_TABLE' =>  'hx_auth_access',        // 权限表名称
    'RBAC_NODE_TABLE'   =>  'hx_auth_node',          // 节点表名称
    'RBAC_SUPERADMIN'   =>  'admin',//超级管理员名称,  多个用逗号隔开
);