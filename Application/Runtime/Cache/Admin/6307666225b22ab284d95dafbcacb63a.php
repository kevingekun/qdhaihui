<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <title>首页</title>
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


<?php define('DEFINE_SIDE_MENU_CURRENT', 'index'); ?>
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
    <div class="main-container">
        <div class="contentpanel">
            <!--<div class="alert alert-info alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                【公告】即日起，消费保障已升级，请及时关注和处理买家退款、退换货申请，如逾期未处理将视作默认同意买家诉求。
                <a href="#" class="alert-link">查看详情</a>
            </div>-->
            <div class="row">
                <div class="col-sm-6 col-md-3">
                    <div class="panel default-success panel-stat">
                        <div class="panel-heading">
                            <div class="stat">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <img src="/new_theme/common/img/is-document.png" alt="">
                                    </div>
                                    <div class="col-xs-8">
                                        <small class="stat-label">今日访问PV</small>
                                        <h1 id="days_pv"></h1>
                                    </div>
                                </div>
                                <div class="mb15"></div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <small class="stat-label">访客UV</small>
                                        <h4 id="days_uv"></h4>
                                    </div>

                                    <div class="col-xs-6">
                                        <small class="stat-label">较昨日UV</small>
                                        <h4 id="uv_yestday_today_growth_rate">+76.43%</h4i>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="panel default-danger panel-stat">
                        <div class="panel-heading">

                            <div class="stat">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <img src="/new_theme/common/img/is-money.png" alt="">
                                    </div>
                                    <div class="col-xs-8">
                                        <small class="stat-label">今日成交金额</small>
                                        <h1 id="sum_real_price">0</h1>
                                    </div>
                                </div>

                                <div class="mb15"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <small class="stat-label">商城订单数</small>
                                        <h4 id="days_pay_start">0</h4i>
                                    </div>

                                    <div class="col-xs-6">
                                        <small class="stat-label">合伙人成交额</small>
                                        <h4 id="sum_partner_real_price">0</h4i>
                                    </div>
                                </div>


                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="panel default-primary panel-stat">
                        <div class="panel-heading">

                            <div class="stat">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <img src="/new_theme/common/img/is-user.png" alt="">
                                    </div>
                                    <div class="col-xs-8">
                                        <small class="stat-label">今日新增合伙人</small>
                                        <h1 id="new_partner">0</h1i>
                                    </div>
                                </div>

                                <div class="mb15"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <small class="stat-label">新增粉丝数</small>
                                        <h4 id="new_fans">0</h4i>
                                    </div>

                                    <div class="col-xs-6">
                                        <small class="stat-label">粉丝成交额</small>
                                        <h4 id="sum_fans_real_price">0</h4>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="panel default-dark panel-stat">
                        <div class="panel-heading">

                            <div class="stat">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <img src="/new_theme/common/img/is-attention.png" alt="">
                                    </div>
                                    <div class="col-xs-8">
                                        <small class="stat-label">今日新增关注</small>
                                        <h1 id="days_subscribe">0</h1i>
                                    </div>
                                </div>

                                <div class="mb15"></div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <small class="stat-label">分享次数</small>
                                        <h4 id="days_shared_to">0</h4i>
                                    </div>

                                    <!--<div class="col-xs-6">
                                        <small class="stat-label">分享点击量</small>
                                        <h4 id="days_click_shared">0</h4>
                                    </div>-->
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="panel">
                <div class="panel-heading">
                    <h3>流量趋势
                        <small>
                                <span class="round" data-toggle="tooltip" data-placement="bottom"
                                      data-original-title="为减少系统消耗,此数据有延迟">？</span>
                        </small>
                    </h3>
                </div>
                <div class="panel-body">
                    <div id="chartline" style="height:400px"></div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-6 col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3>合伙人上月佣金真实排名</h3>
                        </div>

                        <table class="table table-hover" id="month_commission_ranking">
                            <thead>
                            <tr>
                                <th>排名</th>
                                <th>昵称/手机号</th>
                                <th>收入佣金</th>

                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                        <!--<div class="panel-footer"><a href="<?php echo U('Admin/Statistics/index');?>">更多</a></div>-->
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3>合伙人总佣金真实排名</h3>
                        </div>
                        <table class="table table-hover" id="all_commission_ranking">
                            <thead>
                            <tr>
                                <th>排名</th>
                                <th>昵称/手机号</th>
                                <th>收入佣金</th>

                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                        <!--<div class="panel-footer"><a href="<?php echo U('Admin/Statistics/index');?>">更多</a></div>-->
                    </div>
                </div>
                <div class="col-sm-6 col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3>合伙人粉丝数排名</h3>
                        </div>
                        <table class="table table-hover" id="fans_ranking">
                            <thead>
                            <tr>
                                <th>排名</th>
                                <th>昵称/手机号</th>
                                <th>粉丝+合伙人数量</th>


                            </tr>
                            </thead>
                            <tbody>


                            </tbody>
                        </table>
                        <!--<div class="panel-footer"><a href="<?php echo U('Admin/Statistics/index');?>">更多</a></div>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/new_theme/common/sui/jquery.min.js"></script>
<script src="/new_theme/common/sui/sui.min.js"></script>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script>


    function BulldEcharts(option) {
        // 路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        // 使用
        require(
                [
                    'echarts',
                    'echarts/chart/line' // 图形模块，按需加载
                ],
                function (ec) {
                    // 基于准备好的dom，初始化echarts图表
                    var myChart = ec.init(document.getElementById('chartline'));
                    myChart.setOption(option);

                    // 为echarts对象加载数据

                }
        );
    }

    $( document ).ready(function() {
        $.getJSON("<?php echo U('Admin/Statistics/Ajax4Home');?>", function (data) {
            BulldEcharts(data.echarts);
            $.each(data.common_data, function (name, value) {
                if(value == false){
                    value = 0;
                }

                $("#"+name).text(value);
            });
            $.each(data.money_data, function (name, value) {
                if(value == false){
                    value = 0;
                }

                $("#"+name).text(value);
            });
            $.each(data.people_data, function (name, value) {
                if(value == false){
                    value = 0;
                }
                $("#"+name).text(value);
            });
            $.each(data.rank_data, function (name, value) {
                var $i= 0;
                $.each(value,function (name2,value2){
                    $i++;
                    if(value2 == false){
                        value = 0;
                    }
                    $("#"+name).append( "<tr><th>"+ $i +"</th><td><a href='<?php echo U('Admin/Partner/fans/id/','',false,false);?>/"+ value2.uid +".html'>"+ value2.nickname + " / " + value2.phone + "</a></td><td>"+ value2.field_3 +"</td></tr>" );
                });

            });
        });
    });

</script>
        </div>
    </body>
    <script src="/assets/common/My97DatePicker/WdatePicker.js" type="text/javascript" charset="utf-8"></script>
</html>