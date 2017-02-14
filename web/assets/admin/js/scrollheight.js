$(function(){
	// 获取窗口宽度
    function scrollHeight(){
       if (window.innerWidth)
        winWidth = window.innerWidth;
        else if ((document.body) && (document.body.clientWidth))
        winWidth = document.body.clientWidth;
        // 获取窗口高度
        if (window.innerHeight)
        winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;
        // 通过深入 Document 内部对 body 进行检测，获取窗口大小
        if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth)
        {
        winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        }
        var HW=winHeight-87;
        var WH=HW+'px';
        document.getElementById("main").style.height=WH;
        document.getElementById("main").style.overflow='auto';
    }
    scrollHeight();
    $(window).resize(function(){
        scrollHeight();
    });
});
    