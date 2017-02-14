<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <title>合伙人管理</title>
    <link rel="stylesheet" href="/new_theme/common/sui/sui.css">
    <link rel="stylesheet" href="/new_theme/common/css/gdt.css">
    <link rel="stylesheet" href="/new_theme/common/css/set.css"/>
    <script src="/new_theme/common/js/jquery.js"></script>
    <script src="/new_theme/common/js/scrollheight.js"></script>
    <script src="/new_theme/common/js/placeholder.js"></script>
</head>
<body>
<div class="wrapper clearfix" id="root">
    <header>
    <div class="header-clearfix">
        <div class="h-info clearfix">
            <div class="logo-wrap">
                <div class="logo">
                    <a href="<?php echo U('Admin/Index/index');?>">
                        管理
                        <br/>
                        平台
                    </a>
                </div>
                <!--<div class="platform-sel _bubble">
                    <div class="platform-sel-cur switchbutton">
                        <span class="platform-control"></span>
                        <i class="platform-sel-tri switchicon" style="display: none;"></i>
                    </div>
                </div>-->
            </div>
            <div class="user">
                <div class="user-pic"></div>
                <div class="user-id">
                    <p title="" class="company ellipsis"><?php echo session('rolename');?></p>
                    <p class="id">
                        <span>用户名:<?php echo session('username');?></span>
                        <span>帐户ID:<?php echo session('user_id');?></span>
                    </p>
                </div>
            </div>
            <div class="extra" id="gUserBar">
                <a class="logout" title="修改密码" href="<?php echo U('Admin/Rbac/changePassword');?>">修改密码</a>
                <a class="logout" id="_logout" title="退出" href="<?php echo U('Admin/login/logout');?>">退出</a>
                <!--<a class="btn-create s-button-right" href="javascript:;" id="createorder" title="新建广告">装修页面</a>-->
            </div>
        </div>
    </div>
    <div class="top" style="height:56px;;width:100%;"><!--顶部占位--></div>
</header>
<!--[if lt IE 11]>
<div  class="alert alert-warning alert-small" role="alert" style="position: relative;z-index:100;margin-bottom: 0">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <strong>系统检测到您使用的浏览器版本过低，为达到更好的体验效果请升级您的浏览器，我们为您推荐:</strong>
    <a href="http://www.firefox.com.cn/download/" target="_blank">Firefox浏览器</a>
    <a href="http://www.maxthon.cn/" target="_blank">遨游浏览器</a>
    <a href="http://se.360.cn/" target="_blank">360浏览器</a>
    <a href="http://www.liebao.cn/" target="_blank">猎豹浏览器</a>
</div>
<![endif]-->


<?php define('DEFINE_SIDE_MENU_CURRENT', 'Partner'); ?>
<div class="aside">
    <div class="menu-tree" id="_hNav">
        <div class="inner">
            <a href="<?php echo U('Admin/Index/index');?>" class="menu <?php if((DEFINE_SIDE_MENU_CURRENT) == "index"): ?>current<?php endif; ?>">
            <span class="currentline"></span>
            <i class="ico ico-home"></i>

            <p>首 页</p>
            </a>
            <a href="<?php echo U('Admin/Partner/index');?>" class="menu <?php if((DEFINE_SIDE_MENU_CURRENT) == "Partner"): ?>current<?php endif; ?>">
            <span class="currentline"></span>
            <i class="ico ico-partner"></i>

            <p>合伙人</p>
            </a>

            <a href="<?php echo U('Goods/index');?>" class="menu <?php if((DEFINE_SIDE_MENU_CURRENT) == "Goods"): ?>current<?php endif; ?>">
            <span class="currentline"></span>
            <i class="ico ico-sheet"></i>

            <p>商 品</p>
            </a>
            <a href="<?php echo U('Orders/index');?>" class="menu <?php if((DEFINE_SIDE_MENU_CURRENT) == "Orders"): ?>current<?php endif; ?>" >
            <span class="currentline"></span>
            <i class="ico ico-generalize"></i>

            <p>订 单</p>
            </a>
            <a href="<?php echo U('Admin/Commission/index');?>" class="menu <?php if((DEFINE_SIDE_MENU_CURRENT) == "Commission"): ?>current<?php endif; ?>">
            <span class="currentline"></span>
            <i class="ico ico-finance"></i>

            <p>佣 金</p>
            </a>
            <a href="<?php echo U('Admin/Activity/couponlist');?>" class="menu <?php if((DEFINE_SIDE_MENU_CURRENT) == "activity"): ?>current<?php endif; ?>" >
            <span class="currentline"></span>
            <i class="ico ico-activity"></i>

            <p>活 动</p>
            </a>
            <a href="<?php echo U('Admin/Tools/index');?>" class="menu <?php if((DEFINE_SIDE_MENU_CURRENT) == "Tools"): ?>current<?php endif; ?>">
            <span class="currentline"></span>
            <i class="ico ico-tool"></i>

            <p>工具箱</p>
            </a>
        </div>
    </div>
</div>


    <div class="main home" id="main" style="overflow: auto;">
        <div class="side clearfix" style="width:56px;height:100px;float:left;">
        </div>
        <div class="main-container" style="height:auto;">
            <div class="gdt-toufang gdt-toufang-account">
                <div class="tuiguang-tab" id="_hSubNav">
                    <ul>
                        <li style="width:56px"></li>
                        <li class="goback"><a href="javascript:history.back(-1)"><i></i></a></li>
                        <li class="on"><a href="#" onclick="">合伙人列表</a></li>
                        <li><a href="<?php echo U('Admin/Partner/fans');?>" onclick="">合伙人粉丝统计</a></li>
                        <li><a href="<?php echo U('Admin/Partner/rule');?>" onclick="">合伙人规则设置</a></li>
                        <li><a href="<?php echo U('Admin/Partner/audit');?>" onclick="">合伙人审核</a></li>
                        <li><a href="<?php echo U('Admin/Partner/tag');?>">标签管理</a></li>
                        <li><a href="<?php echo U('Admin/Partner/group');?>">分组管理</a></li>
                    </ul>
                </div>
                <div class="container-box">
                    <div class="row">
                        <div class="alert alert-success" role="alert">
                            目前拥有<strong style="font-size: 18px;"> <?php echo ($totalCount); ?> </strong>名合伙人，今日增加<strong style="font-size: 18px;"> <?php echo ($todayCount); ?> </strong>名。
                        </div>
                        <div class="newcearchbox">
                            <form class="form-inline" action="" method="get" name="form1">
                                <div class="input-group">
                                    <input type="text" name="nickname" value="<?php echo ($map["nickname"]); ?>" placeholder="微信昵称" class="form-control">
                                </div>
                                <div class="input-group">
                                    <input type="text" name="phone" value="<?php echo ($map["phone"]); ?>" placeholder="手机号码" class="form-control">
                                </div>
                                <div class="form-group input-daterange" data-toggle="datepicker" >
                                    <input type="text" name="start_time" class="form-control input-date" value="<?php echo ($map["start_time"]); ?>" placeholder="开始日期"/> -
                                    <input type="text" name="end_time" class="form-control input-date" value="<?php echo ($map["end_time"]); ?>" placeholder="结束日期"/>
                                </div>
                                <div class="form-group">
                                  <select name="order" class="form-control">
                                      <option value="">排序</option>
                                      <option value="1" <?php if(($map['order']) == "1"): ?>selected<?php endif; ?>>粉丝数倒序</option>
                                      <option value="2" <?php if(($map['order']) == "2"): ?>selected<?php endif; ?>>粉丝数正序</option>
                                  </select>
                                </div>
                                <div class="input-group">
                                    <select name="group_id" class="form-control">
                                        <option value="0">所有分组</option>
                                        <?php if(is_array($groups)): $i = 0; $__LIST__ = $groups;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$group): $mod = ($i % 2 );++$i;?><option value="<?php echo ($group["id"]); ?>" <?php if(($group['id']) == $map['group_id']): ?>selected<?php endif; ?>><?php echo ($group["value"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select name="tag_id" class="form-control">
                                        <option value="0" selected>标签</option>
                                        <?php if(is_array($tags)): $i = 0; $__LIST__ = $tags;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$tag): $mod = ($i % 2 );++$i;?><option value="<?php echo ($tag["id"]); ?>" <?php if(($tag['id']) == $map['tag_id']): ?>selected<?php endif; ?>><?php echo ($tag["value"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-success">查询</button>
                                <a href="<?php echo U('Admin/Partner/index?action=export', $map);?>" class="btn btn-info">导出</a>
                            </form>
                        </div>
                    </div>

                    <div class="row newcearchbox">
                        <table class="table table-bordered table-primary">
                            <thead>
                                <tr class="">
                                    <th class="center">
                                        <input id="checkedAll" type="checkbox" class="ace"> <span class="lbl"></span>
                                    </th>
                                    <th width="3%">ID</th>
                                    <th>微信头像</th>
                                    <th>昵称</th>
                                    <th>姓名|手机</th>
                                    <th>所在地区</th>
                                    <th>支付宝</th>
                                    <th>标签</th>
                                    <th>分组</th>
                                    <th>推荐人</th>
                                    <th>总消费金额</th>
                                    <th>成交订单数</th>
                                    <th>下级成交订单数</th>
                                    <th>下级成交金额</th>
                                    <th>粉丝数量</th>
                                    <th>二级合伙人数量</th>
                                    <th>成为合伙人时间</th>
                                </tr>
                            </thead>
                            <tbody>
                              <?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr>
                                      <td class="center"><input type="checkbox" class="ace checkSingle" data-uid="<?php echo ($vo["uid"]); ?>"></td>
                                      <th class="center" scope="row"><?php echo ($vo["uid"]); ?></th>
                                      <td><img src="<?php echo (avatar($vo["headimgurl"])); ?>" height="70" alt=""/></td>
                                      <td><a href="<?php echo U('Admin/Partner/fans', array('id'=>$vo['uid']));?>"><?php echo ($vo["nickname"]); ?></a></td>
                                      <td><?php echo ($vo["realname"]); ?><br><?php echo ($vo["phone"]); ?></td>
                                      <td><?php echo ($vo["country"]); echo ($vo["province"]); echo ($vo["city"]); ?></td>
                                      <td><?php echo (get_pay_account($vo["uid"])); ?><br><?php echo (get_pay_account($vo["uid"],"authen_name")); ?></td>
                                      <td>
                                          <a class="btn btn-primary btn-info auditing_1" data-toggle="modal" data-target="#toExamine_1" data-uid="<?php echo ($vo["uid"]); ?>" data-tagid="<?php echo ($vo["tag_id"]); ?>">设置标签</a><br>
                                          <?php
 $tagArr = get_tag_with_uid($vo['uid']); foreach($tagArr as $key => $value){ echo $value['value'] . '　<a href="'. U('Admin/Partner/delUserTag', array('uid'=>$vo['uid'], 'id'=>$value['id'])) .'" onclick="return confirm(\'确定要删除吗?\');">删除</a><br>'; } ?>
                                      </td>
                                      <td>
                                          <a class="btn btn-primary btn-info auditing" data-toggle="modal" data-target="#toExamine" data-uid="<?php echo ($vo["uid"]); ?>" data-groupid="<?php echo ($vo["group_id"]); ?>">设置分组</a><br>
                                          <?php echo (get_attr_title($vo["group_id"],"value")); ?>
                                      </td>
                                      <td><?php echo (get_invite_user($vo["invite_id"])); ?></td>
                                      <td><?php echo (get_total_consume_amount($vo["uid"])); ?></td>
                                      <td><?php echo (get_order_num($vo["uid"])); ?></td>
                                      <td><?php echo (get_fans_order_num($vo["uid"])); ?></td>
                                      <td><?php echo (get_fans_order_amount($vo["uid"])); ?></td>
                                      <td><?php echo (intval($vo["count_fans"])); ?></td>
                                      <td><?php echo (get_fans_num($vo["uid"],1)); ?></td>
                                      <!--<td>下级成交单数</td>-->
                                      <td><?php echo (format_date($vo["audit_time"],"Y-m-d H:i:s")); ?></td>
                                  </tr><?php endforeach; endif; else: echo "" ;endif; ?>
                            </tbody>
                        </table>
                        <a id="batchTag"  data-toggle="modal" data-target="#toExamine_1" class="btn-primary btn">设置选中标签</a>
                        <a id="batchGroup"  data-toggle="modal" data-target="#toExamine" class="btn-primary btn">设置选中分组</a>
                        <div id="page">
                          <?php echo ($page); ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/new_theme/common/sui/jquery.min.js"></script>
<script src="/new_theme/common/sui/sui.min.js"></script>
<div class="modal fade" id="toExamine" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h5 class="modal-title">设置分组</h5>
            </div>
            <form class="form-horizontal" data-toggle="validate" action="<?php echo U('Admin/Partner/setGroup');?>" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">分组操作:</label>
                        <div class="col-sm-8">
                            <input id="auditing_id" type="hidden" name="uid" value="">
                            <select name="partner_group" class="form-control input-lg">
                                <option value="">请选择</option>
                                <?php if(is_array($groups)): $i = 0; $__LIST__ = $groups;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$group): $mod = ($i % 2 );++$i;?><option value="<?php echo ($group["id"]); ?>"><?php echo ($group["value"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary btn-lg">确定</button>
                    <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="toExamine_1" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h5 class="modal-title">设置标签</h5>
            </div>
            <form class="form-horizontal" data-toggle="validate" action="<?php echo U('Admin/Partner/setTag');?>" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">标签操作:</label>
                        <div class="col-sm-8">
                            <input id="auditing_id_1" type="hidden" name="uid" value="">
                            <select name="partner_tag" class="form-control input-lg">
                                <option value="">请选择</option>
                                <?php if(is_array($tags)): $i = 0; $__LIST__ = $tags;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$tag): $mod = ($i % 2 );++$i;?><option value="<?php echo ($tag["id"]); ?>"><?php echo ($tag["value"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary btn-lg">确定</button>
                    <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    $(function(){
        $("#checkedAll").change(function(){
            if(this.checked){
                $(".checkSingle").each(function(){
                    this.checked=true;
                })
            }else{
                $(".checkSingle").each(function(){
                    this.checked=false;
                })
            }
        });

        $(".checkSingle").click(function () {
            if ($(this).is(":checked")){
                var isAllChecked = 0;
                $(".checkSingle").each(function(){
                    if(!this.checked)
                        isAllChecked = 1;
                })
                if(isAllChecked == 0){ $("#select_all").prop("checked", true); }
            }
            else {
                $("#checkedAll").prop("checked", false);
            }
        });

        // 设置分组
        $('a.auditing').click(function(){
            var uid = $(this).attr('data-uid');
            $("#auditing_id").val(uid);
        });

        // 设置标签
        $('a.auditing_1').click(function(){
            var uid = $(this).data('uid');
            $("#auditing_id_1").val(uid);
        });

        // 批量设置标签
        $('#batchTag').click(function(){
            var uid = "";
            $(".checkSingle").each(function(k,v){
                if(this.checked){
                    uid += $(this).data('uid') + ',';
                }
            });
            $("#auditing_id_1").val(uid);
        })

        // 批量设置分组
        $('#batchGroup').click(function(){
            var uid = "";
            $(".checkSingle").each(function(k,v){
                if(this.checked){
                    uid += $(this).data('uid') + ',';
                }
            });
            $("#auditing_id").val(uid);
        })
    })
</script>
</html>