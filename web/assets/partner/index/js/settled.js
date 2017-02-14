/**
 * 已结算佣金
 * Created by yanhuaitang on 2015/11/5.
 */
var end = false;
var send = false;
var page = 1 ;

$(function(){
    $('.share_box').on('click', function () {
        loadPostList();
    })

    $(window).on("load", function(){
        loadPostList();
    })
})

function loadPostList() {
    $('#loading_span').html("加载中...") ;
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
            success: function(data) {
                $('.waterfall_tip').addClass('hidden') ;
                end = data.end ;

                if (!$.isEmptyObject(data.data)) {
                    var html = '';
                    $.each(data.data, function (k, v) {
                        html += '<div class="comm-list">' +
                            '       <span>' + v.pay_time + '</span>' +
                            '       <span>' + v.type + '</span>' +
                            '       <span>￥' + v.money + '</span>' +
                            '       <span>' + v.fans_id + '</span>' +
                            '    </div>';
                    });

                    $('.comm-item').append(html);
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
            error: function(){
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
