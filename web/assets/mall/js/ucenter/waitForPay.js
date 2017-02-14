/**
 * 个人中心 - 订单相关
 * Created by yanhuaitang on 2015/11/8.
 */
var end = false;
var send = false;
var page = 1;

$(function () {
    // 删除订单
    $(document).on("click", ".delOrder", function () {
        var obj = $(this)
        var id = obj.data("id");
        $.confirm('确定要取消该订单吗?', function () {
            $.showPreloader();
            $.ajax({
                type: "post",
                url: delUrl,
                async:false,
                timeout: 20000,
                data: {id: id},
                success: function (data) {
                    $.hidePreloader();
                    if (data.code != 0) {
                        $.toast(data.msg);
                    } else {
                        $.toast(data.msg);
                        obj.parent().parent().parent().parent().remove();
                    }
                },
                complete: function (XMLHttpRequest, textStatus) {
                    if (textStatus != 'success') {
                        $.hidePreloader();
                    }
                },
                error: function (xhr, status, type) {
                    if (status == "timeout") {
                        $.toast("请求超时");
                    }
                    $.hidePreloader();
                }
            });
        });
    });

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

                                    '           <a class="photo external" href="' + orderDetailUrl + '">' +
                                    '               <img src="/uploads/' + v2.image + '">' +
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
                        '                   <div class="col-50"><a data-id="' + v.id + '" class="delOrder button button-del active">取消订单</a></div>' +
                        '                   <div class="col-50"><a href="' + payUrl + '/order_num/' + v.order_number + '" class="button button-del external">立即付款</a></div>' +
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

//function paynow(id){
//
//    $.post(buyUrl,{id:id},function(data){
//
//        return_data=eval(data);
//        if (return_data.status==1){
//            str='<scr'+'ipt type="text/javascript">';
//            str=str+'function jsApiCall(){';
//            str=str+'WeixinJSBridge.invoke(';
//            str=str+'"getBrandWCPayRequest",';
//            str=str+''+return_data.remark+',';
//            str=str+'function(res){';
//            str=str+'WeixinJSBridge.log(res.err_msg);';
//            str=str+'if (res.err_msg=="get_brand_wcpay_request:ok"){';
//            str=str+'alert("支付成功");window.location.href="'+successUrl+'"';
//            str=str+';}else{';
//            str=str+'alert("支付失败，请重试");window.location.href="'+failUrl+'"';
//            str=str+'}});}';
//            str=str+'</scr'+'ipt>';
//            document.write(str);
//            callpay();
//        }else{
//            $.toast(return_data.remark);
//        }
//
//    });
//
//
//}
