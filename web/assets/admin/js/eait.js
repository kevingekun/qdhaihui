 $(document).ready(function() {
    $("#_handle_crtsize29").click(function() {
        $("#_content_crtsize70").slideUp("fast");
        $("#_content_crtsize31").slideUp("fast");
        $("#_content_crtsize32").slideUp("fast");
        $("#_content_crtsize29").fadeToggle("3000");
        document.getElementById("crtsize0").checked = true;
        inputColor();
        //$("#crtsize0").attr("checked",'checked');
        // var a=$(this).offset().top-45;
        //  $(window).scrollTop(a); 
    });
    $("#_handle_crtsize70").click(function() {
        $("#_content_crtsize29").slideUp("fast");
        $("#_content_crtsize31").slideUp("fast");
        $("#_content_crtsize32").slideUp("fast");
        $("#_content_crtsize70").fadeToggle("3000");
        document.getElementById("crtsize3").checked = true;
        inputColor();
    });

    $("#_handle_crtsize31").click(function() {
        $("#_content_crtsize29").slideUp("fast");
        $("#_content_crtsize70").slideUp("fast");
        $("#_content_crtsize32").slideUp("fast");
        $("#_content_crtsize31").fadeToggle("3000");
        document.getElementById("crtsize4").checked = true;
        inputColor();

    });

    $("#_handle_crtsize32").click(function() {
        $("#_content_crtsize29").slideUp("fast");
        $("#_content_crtsize31").slideUp("fast");
        $("#_content_crtsize70").slideUp("fast");
        $("#_content_crtsize32").fadeToggle("3000");
        document.getElementById("crtsize5").checked = true;
        inputColor();
    });

    function inputColor() {
        $("._handle_line").css({
            'background': '#fff',
            'color': '#000'
        });
        var v = $("input[name='type']:checked");
        v.parents('._handle_line').css({
            'background': '#56BDA3',
            'color': '#fff'
        });
    };


 });
 $(function() {

    //判断浏览器是否支持placeholder属性
    supportPlaceholder = 'placeholder' in document.createElement('textarea'),

    placeholder = function(textarea) {

        var text = textarea.attr('placeholder'),
            defaultValue = textarea.defaultValue;

        if (!defaultValue) {

            textarea.val(text).addClass("phcolor");
        }

        textarea.focus(function() {

            if (textarea.val() == text) {

                $(this).val("");
            }
        });


        textarea.blur(function() {

            if (textarea.val() == "") {

                $(this).val(text).addClass("phcolor");
            }
        });

        //输入的字符不为灰色
        textarea.keydown(function() {

            $(this).removeClass("phcolor");
        });
    };

    //当浏览器不支持placeholder属性时，调用placeholder函数
    if (!supportPlaceholder) {

        $('textarea').each(function() {

            text = $(this).attr("placeholder");

            if ($(this).attr("type") == "text") {

                placeholder($(this));
            }
        });
    }
 });