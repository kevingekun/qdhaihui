/**
 * 个人中心 - 订单相关
 * Created by yanhuaitang on 2015/11/8.
 */
var end = false;
var send = false;
var page = 1;

$(function () {
    $('.share_box').on('click', function () {
        loadPostList();
    });
    $(window).on("load", function () {
        loadPostList();
    });
});

function loadPostList() {
    $('#loading_span').html("加载中...");
    if (!end && !send) {
        send = true;
        $('#click_for_more_sec').hide();
        $('#loading_box').show();
        $.ajax({
            url: URL,
            type: "post",
            dataType: "json",
            //默认查所有
            data: {p: page},
            success: function (data) {
                $('.waterfall_tip').addClass('hidden');
                end = data.end;
                if (!$.isEmptyObject(data.data)) {
                    var html = '';
                    $.each(data.data, function (k, v) {
                        var buyUrl = '';
                        var orderDetailUrl = v.orderDetailUrl;

                        html += '<li class="main">' +
                            '       <div class="order-num">' +
                            '           <p>订单编号：<span>' + v.order_number + '</span></p>' +
                            '           <p>订单时间：<span>' + v.create_time + '</span></p>' +
                            '           <p>订单状态：<span>' + v.order_status_string + '</span></p>' +
                            '       </div>';

                        if (!$.isEmptyObject(v.cart_data_list)) {
                            $.each(v.cart_data_list, function (k2, v2) {
                                buyUrl = v2.url;
                                html += '<div class="order-table">' +
                                    '       <div class="url">' +
                                    '           <label class="cat-item">' +
                                    '               <input type="checkbox" name="checkbox">' +
                                    '               <div class="item-media"><i class="icon cat-icon-checkbox"></i></div>' +
                                    '           </label>' +
                                    '           <a class="photo external" href="' + orderDetailUrl + '">' +
                                    '               <img src="' + v2.image + '">' +
                                    '           </a>' +
                                    '           <a class="info external" href="' + orderDetailUrl + '">' +
                                    '               <h3 class="tit">' + v2.name + '</h3>' +
                                    '               <div class="item-subtitle red-label">' + v2.name + '</div>' +
                                    '               <div class="item-subtitle spec">产品规格：' + v2.spec + '</div>' +
                                    '               <div class="desc"></div>' +
                                    '               <p class="price">' +
                                    '                   <span class="price-1">' + v2.price + '</span><i>￥</i><br>' +
                                    '                   <span>X<span class="countNum">' + v2.num + '</span></span>' +
                                    '               </p>' +
                                    '           </a>' +
                                    '       </div>' +
                                    '   </div>';
                            });
                        }

                        html += '   <div class="order-etc">' +
                            '               <p>' +
                            '                   共<span>' + v.count + '</span>件商品 合计：<i class="blue">￥</i><span class=" blue">' + v.total + '</span>' +
                            '               </p>' +
                            '               <div class="row order-bottom">' +
                            '                   <div class="col-50">　</div>' +
                            '                   <div class="col-50"><a href="' + serviceUrl + '?order_id=' + v.id + '" class="button button-del external">申请售后</a></div>' +
                            '               </div>' +
                            '           </div>' +
                            '       </li>';
                    });

                    $('#ordersList > ul').append(html);
                }

                $('#loading_box').hide();
                send = false;

                if (!end) {
                    $('#click_for_more_sec').show();
                    page++;
                } else {
                    $('#click_for_more_sec').hide();
                    $('.waterfall_tip').text('了解更多').removeClass('hidden');
                }
            },
            error: function () {
                $('#loading_box').hide();
                $('.waterfall_tip').text('网络异常，请检查网络连接！').removeClass('hidden')
                send = false;
            }
        })
    } else if (end) {
        $('#loading_box').hide();
        $('#click_for_more_sec').hide();
        $('.waterfall_tip').text('没有更多了！').removeClass('hidden')
    }
}
