/**
 * 粉丝列表
 * Created by yanhuaitang on 2015/11/24.
 */
var end = false;
var send = false;
var page = 1 ;
var key = 1;

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
                        html += '<li class="item-content">' +
                            '       <div class="item-media start">';
                        if(key < 6) {
                            html += '   <div style="width:38px"></div>' +
                                '       <div class="crown crown' + key + '"></div>';
                        }
                        html += '   </div>' +
                            '       <div class="num">' + key + '</div>' +
                            '       <div class="item-media push-image">' +
                            '           <img src="' + v.headimgurl + '" alt="" width="100%"/>' +
                            '       </div>' +
                            '       <div class="item-inner">' +
                            '           <div class="item-title ' + v.color + '">' + v.nickname + '</div>' +
                            '       </div>' +
                            '   </li>';

                        key++;
                    });

                    $('#list').append(html);
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
