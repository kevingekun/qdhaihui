/**
 * 申请成为合伙人
 * Created by yanhuaitang on 2015/11/5.
 */
$(function () {
    $("#submit").click(function () {
        $.showPreloader();
        $.ajax({
            type: "post",
            url: submitUrl,
            //async:false,
            timeout: 20000,
            data: $("#form1").serialize(),
            success: function (data) {
                $.hidePreloader();
                if(data.code != 0){
                    $.toast(data.msg);
                } else {
                    window.location.href = data.url;
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


function getMobileCode() {
    var reg = /^0?1[3|4|5|7|8][0-9]\d{8}$/;
    var phone = $.trim($('#phone').val());
    if (!reg.test(phone)) {
        $.toast('请正确填写手机号');
        return false;
    }
    $.post(smsUrl, {tel: phone, style:'update_profile'},
        function (data) {
            RemainTime();
        });
};
var iTime = 59;
var Account;
function RemainTime() {
    document.getElementById('sendcode').disabled = true;
    var iSecond, sSecond = "", sTime = "";
    if (iTime >= 0) {
        iSecond = parseInt(iTime % 60);
        iMinute = parseInt(iTime / 60)
        if (iSecond >= 0) {
            if (iMinute > 0) {
                sSecond = iMinute + "分" + iSecond + "秒";
            } else {
                sSecond = iSecond + "秒";
            }
        }
        sTime = sSecond;
        if (iTime == 0) {
            clearTimeout(Account);
            sTime = '验证';
            iTime = 59;
            document.getElementById('sendcode').disabled = false;

        } else {
            Account = setTimeout("RemainTime()", 1000);
            iTime = iTime - 1;
        }
    } else {
        sTime = '没有倒计时';
    }
    document.getElementById('sendcode').value = sTime;
}