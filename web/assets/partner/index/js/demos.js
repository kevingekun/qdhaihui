$(function () {
  'use strict';

  $(function() {
    $(".swiper-container").swiper({
      loop: true,
      autoplay: 5000,
    });
  });

  //购物车
  var $carlist = $("#carlist");
  var carlis = $("#carlist ul li");
  var selectInputs = $("#carlist label")

  function getTotal(){
    var selected = 0;
    var price = 0;
    for (var i = 0; i < carlis.length; i++) {

      var newValue = carlis[i].getElementsByClassName('count-input');
      var newMoney = carlis[i].getElementsByClassName('price-1');
      var numInput = carlis[i].getElementsByClassName('count-input');
      var checkInput = carlis[i].getElementsByTagName('input')[0];
      if(checkInput.checked){
        selected += parseInt(newValue[0].value); //计算已选商品数目
        price += parseFloat(newMoney[0].innerHTML)*numInput[0].value; //计算总计价格
      }else{
        $('#checkAll').find('input')[0].checked = false;
      }
    }
    $('#selectedTotal').html(selected);
    $('#priceTotal').html(price.toFixed(2));
    if($('#selectedTotal').html()==0){
      $('.closing').removeClass("active");
      $('#chackClosing')[0].disabled = true;
      $('#settlement')[0].disabled = true;
    }else{
      $('#chackClosing').attr("disabled",null);
      $('#settlement').attr("disabled",null);
      $('.closing').addClass("active");
    }
  }
  for(var i=0;i<carlis.length;i++) {
    selectInputs[i].onclick = function(){
      getTotal();
    }
    carlis[i].onclick = function(e){
      e = e || window.event;
      var el = e.srcElement;
      var cls = el.className;
      var numInput = this.getElementsByClassName('count-input');
      var val = parseInt(numInput[0].value);
      var reduce = this.getElementsByClassName('reduce')[0];
      switch(cls){
        case 'reduce':
          if (val>1) {
            numInput[0].value = val-1;
          };
          if (val<=1) {
            reduce.innerHTML = '';
          };
          break;
        case 'add':
          numInput[0].value = val+1;
          reduce.innerHTML = '-';
          break;
          defaule:
              break;
      }
      getTotal();
    }
    carlis[i].getElementsByClassName('count-input')[0].onkeyup = function  () {
      var val = parseInt(this.value);
      var lis = this.parentNode.parentNode.parentNode;
      var reduce = lis.getElementsByClassName('reduce')[0];
      if (isNaN(val) || val<1) {
        val = 1;
      };
      this.value = val;
      if (val <=1 ) {
        reduce.innerHTML = '';
      }else{
        reduce.innerHTML = '-';
      };
      getTotal();
    }
  }
  $('#checkAll').on('click',function(){
    if($('#checkAll').find('input')[0].checked){
      for (var i = 0; i < carlis.length; i++) {
        var checkInput = carlis[i].getElementsByTagName('input')[0];
        checkInput.checked = true;
      }
      getTotal();
    }else{
      for (var i = 0; i < carlis.length; i++) {
        var checkInput = carlis[i].getElementsByTagName('input')[0];
        checkInput.checked = false;
      }
      getTotal();
    }
  })
  $('#chackClosing').on('click',function(){
    $.confirm('确定删除?', function () {
    for (var i = 0; i < carlis.length; i++) {
      var checkInput = carlis[i].getElementsByTagName('input')[0];
        if(checkInput.checked){
          carlis[i].remove();
        }
      }
    })
  })
  $('#settlement').on('click',function(){
    window.location.href="commodity/订单确认_购买.html";
  })

  //下拉刷新页面
  $(document).on("pageInit", "#page-ptr", function(e, id, page) {
    var $content = $(page).find(".content").on('refresh', function(e) {
      // 模拟2s的加载过程
      setTimeout(function() {
        var cardHTML = '<div class="card">' +
          '<div class="card-header">标题</div>' +
          '<div class="card-content">' +
          '<div class="card-content-inner">内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容' +
          '</div>' +
          '</div>' +
          '</div>';

        $content.find('.card-container').prepend(cardHTML);
        // 加载完毕需要重置
        $.pullToRefreshDone($content);
      }, 2000);
    });
  });

  //无线滚动
  $(document).on("pageInit", "#page-infinite-scroll", function(e, id, page) {
    function addItems(number, lastIndex) {
      // 生成新条目的HTML
      var html = '';
      for (var i = 0; i < 20; i++) {
        html += '<li class="item-content"><div class="item-inner"><div class="item-title">新条目</div></div></li>';
      }
      // 添加新条目
      $('.infinite-scroll .list-container').append(html);
    }
    var loading = false;
    $(page).on('infinite', function() {

      // 如果正在加载，则退出
      if (loading) return;

      // 设置flag
      loading = true;

      // 模拟1s的加载过程
      setTimeout(function() {
        // 重置加载flag
        loading = false;

        addItems();
        $.refreshScroller();
      }, 1000);
    });
  });


  //图片浏览器
  $(document).on("pageInit", "#page-photo-browser", function(e, id, page) {
    var myPhotoBrowserStandalone = $.photoBrowser({
      photos : [
        '../../../img.alicdn.com/tps/i3/TB1kt4wHVXXXXb_XVXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i3/TB1kt4wHVXXXXb_XVXX0HY8HXXX-1024-1024.jpeg*/,
        '../../../img.alicdn.com/tps/i1/TB1SKhUHVXXXXb7XXXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i1/TB1SKhUHVXXXXb7XXXX0HY8HXXX-1024-1024.jpeg*/,
        '../../../img.alicdn.com/tps/i4/TB1AdxNHVXXXXasXpXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i4/TB1AdxNHVXXXXasXpXX0HY8HXXX-1024-1024.jpeg*/,
      ]
    });
    //点击时打开图片浏览器
    $(page).on('click','.pb-standalone',function () {
      myPhotoBrowserStandalone.open();
    });
    /*=== Popup ===*/
    var myPhotoBrowserPopup = $.photoBrowser({
      photos : [
        '../../../img.alicdn.com/tps/i3/TB1kt4wHVXXXXb_XVXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i3/TB1kt4wHVXXXXb_XVXX0HY8HXXX-1024-1024.jpeg*/,
        '../../../img.alicdn.com/tps/i1/TB1SKhUHVXXXXb7XXXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i1/TB1SKhUHVXXXXb7XXXX0HY8HXXX-1024-1024.jpeg*/,
        '../../../img.alicdn.com/tps/i4/TB1AdxNHVXXXXasXpXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i4/TB1AdxNHVXXXXasXpXX0HY8HXXX-1024-1024.jpeg*/,
      ],
      type: 'popup'
    });
    $(page).on('click','.pb-popup',function () {
      myPhotoBrowserPopup.open();
    });
    /*=== 有标题 ===*/
    var myPhotoBrowserCaptions = $.photoBrowser({
      photos : [
        {
          url: '../../../img.alicdn.com/tps/i3/TB1kt4wHVXXXXb_XVXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i3/TB1kt4wHVXXXXb_XVXX0HY8HXXX-1024-1024.jpeg*/,
          caption: 'Caption 1 Text'
        },
        {
          url: '../../../img.alicdn.com/tps/i1/TB1SKhUHVXXXXb7XXXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i1/TB1SKhUHVXXXXb7XXXX0HY8HXXX-1024-1024.jpeg*/,
          caption: 'Second Caption Text'
        },
        // 这个没有标题
        {
          url: '../../../img.alicdn.com/tps/i4/TB1AdxNHVXXXXasXpXX0HY8HXXX-1024-1024.jpeg'/*tpa=http://img.alicdn.com/tps/i4/TB1AdxNHVXXXXasXpXX0HY8HXXX-1024-1024.jpeg*/,
        },
      ],
      theme: 'dark',
      type: 'standalone'
    });
    $(page).on('click','.pb-standalone-captions',function () {
      myPhotoBrowserCaptions.open();
    });
  });


  //对话框
  $(document).on("pageInit", "#page-modal", function(e, id, page) {
    var $content = $(page).find('.content');
    $content.on('click','.alert-text',function () {
      $.alert('这是一段提示消息');
    });

    $content.on('click','.alert-text-title', function () {
      $.alert('这是一段提示消息', '这是自定义的标题!');
    });

    $content.on('click', '.alert-text-title-callback',function () {
      $.alert('这是自定义的文案', '这是自定义的标题!', function () {
        $.alert('你点击了确定按钮!')
      });
    });
    $content.on('click','.confirm-ok', function () {
      $.confirm('你确定吗?', function () {
        $.alert('你点击了确定按钮!');
      });
    });
    $content.on('click','.prompt-ok', function () {
      $.prompt('你叫什么问题?', function (value) {
        $.alert('你输入的名字是"' + value + '"');
      });
    });
  });

  //操作表
  $(document).on("pageInit", "#page-action", function(e, id, page) {
    $(page).on('click','.create-actions', function () {
      var buttons1 = [
        {
          text: '请选择',
          label: true
        },
        {
          text: '卖出',
          bold: true,
          color: 'danger',
          onClick: function() {
            $.alert("你选择了“卖出“");
          }
        },
        {
          text: '买入',
          onClick: function() {
            $.alert("你选择了“买入“");
          }
        }
      ];
      var buttons2 = [
        {
          text: '取消',
          bg: 'danger'
        }
      ];
      var groups = [buttons1, buttons2];
      $.actions(groups);
    });
  });

  //加载提示符
  $(document).on("pageInit", "#page-preloader", function(e, id, page) {
    $(page).on('click','.open-preloader-title', function () {
      $.showPreloader('加载中...')
      setTimeout(function () {
        $.hidePreloader();
      }, 2000);
    });
    $(page).on('click','.open-indicator', function () {
      $.showIndicator();
      setTimeout(function () {
        $.hideIndicator();
      }, 2000);
    });
  });


  //选择颜色主题
  $(document).on("click", ".select-color", function(e) {
    var b = $(e.target);
    document.body.className = "theme-" + (b.data("color") || "");
    b.parent().find(".active").removeClass("active");
    b.addClass("active");
  });

  //picker
  $(document).on("pageInit", "#page-picker", function(e, id, page) {
    $("#picker").picker({
      toolbarTemplate: '<header class="bar bar-nav">\
        <button class="button button-link pull-left">\
      按钮\
      </button>\
      <button class="button button-link pull-right close-picker">\
      确定\
      </button>\
      <h1 class="title">标题</h1>\
      </header>',
      cols: [
        {
          textAlign: 'center',
          values: ['iPhone 4', 'iPhone 4S', 'iPhone 5', 'iPhone 5S', 'iPhone 6', 'iPhone 6 Plus', 'iPad 2', 'iPad Retina', 'iPad Air', 'iPad mini', 'iPad mini 2', 'iPad mini 3']
        }
      ]
    });
    $("#picker-name").picker({
      toolbarTemplate: '<header class="bar bar-nav">\
      <button class="button button-link pull-right close-picker">确定</button>\
      <h1 class="title">请选择称呼</h1>\
      </header>',
      cols: [
        {
          textAlign: 'center',
          values: ['赵', '钱', '孙', '李', '周', '吴', '郑', '王']
        },
        {
          textAlign: 'center',
          values: ['杰伦', '磊', '明', '小鹏', '燕姿', '菲菲', 'Baby']
        },
        {
          textAlign: 'center',
          values: ['先生', '小姐']
        }
      ]
    });
  });
  $(document).on("pageInit", "#page-datetime-picker", function(e) {
    $("#datetime-picker").datetimePicker({
      toolbarTemplate: '<header class="bar bar-nav">\
      <button class="button button-link pull-right close-picker">确定</button>\
      <h1 class="title">选择日期和时间</h1>\
      </header>'
    });
  });
  $(document).on("pageInit", "#page-city-picker", function(e) {
    $("#city-picker").cityPicker({});
  });

  $.init();
});
