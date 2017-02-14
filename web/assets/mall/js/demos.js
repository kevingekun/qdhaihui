$(function () {
    'use strict';

    //购物车
    var $carlist = $("#carlist");
    var carlis = $("#carlist ul li");
    var selectInputs = $("#carlist label")

    function getTotal() {
        var selected = 0;
        var price = 0;
        for (var i = 0; i < carlis.length; i++) {

            var newValue = carlis[i].getElementsByClassName('count-input');
            var newMoney = carlis[i].getElementsByClassName('price-1');
            var numInput = carlis[i].getElementsByClassName('count-input');
            var checkInput = carlis[i].getElementsByTagName('input')[0];
            if (checkInput.checked) {
                selected += parseInt(newValue[0].value); //计算已选商品数目
                price += parseFloat(newMoney[0].innerHTML) * numInput[0].value; //计算总计价格
            } else {
                $('#checkAll').find('input')[0].checked = false;
            }
        }
        $('#selectedTotal').html(selected);
        $('#priceTotal').html(price.toFixed(2));
        if ($('#selectedTotal').html() == 0) {
            $('.closing').removeClass("active");
            $('#chackClosing')[0].disabled = true;
            $('#settlement')[0].disabled = true;
        } else {
            $('#chackClosing').attr("disabled", null);
            $('#settlement').attr("disabled", null);
            $('.closing').addClass("active");
        }
    }

    for (var i = 0; i < carlis.length; i++) {
        selectInputs[i].onclick = function () {
            getTotal();
        }
        carlis[i].onclick = function (e) {
            e = e || window.event;
            var el = e.srcElement;
            var cls = el.className;
            var numInput = this.getElementsByClassName('count-input');
            var val = parseInt(numInput[0].value);
            var reduce = this.getElementsByClassName('reduce')[0];
            switch (cls) {
                case 'reduce':
                    if (val > 1) {
                        numInput[0].value = val - 1;
                    };
                    break;
                case 'add':
                    numInput[0].value = val + 1;
                    reduce.innerHTML = '-';
                    break;
                    defaule:
                        break;
            }
            getTotal();
        }
        carlis[i].getElementsByClassName('count-input')[0].onkeyup = function () {
            var val = parseInt(this.value);
            var lis = this.parentNode.parentNode.parentNode;
            var reduce = lis.getElementsByClassName('reduce')[0];
            if (isNaN(val) || val < 1) {
                val = 1;
            };
            this.value = val;
            getTotal();
        }
    }
    $('#checkAll').on('click', function () {
        if ($('#checkAll').find('input')[0].checked) {
            for (var i = 0; i < carlis.length; i++) {
                var checkInput = carlis[i].getElementsByTagName('input')[0];
                checkInput.checked = true;
            }
            getTotal();
        } else {
            for (var i = 0; i < carlis.length; i++) {
                var checkInput = carlis[i].getElementsByTagName('input')[0];
                checkInput.checked = false;
            }
            getTotal();
        }
    })
    $('#chackClosing').on('click', function () {
        $.confirm('确定删除?', function () {
            for (var i = 0; i < carlis.length; i++) {
                var checkInput = carlis[i].getElementsByTagName('input')[0];
                if (checkInput.checked) {
                    carlis[i].remove();
                }
            }
        })
    })
    $('#settlement').on('click', function () {
        window.location.href = "commodity/订单确认_购买.html";
    })

    //订单确认
    var $buyList = $("#buyList");
    var buyList = $("#buyList ul li");
    buyTotal();
    function buyTotal() {
        var selected = 0;
        var price = 0;
        for (var i = 0; i < buyList.length; i++) {
            var newMoney = buyList[i].getElementsByClassName('price-1');
            var numInput = buyList[i].getElementsByClassName('count-input');
            price += parseFloat(newMoney[0].innerHTML) * numInput[0].value; //计算总计价格
            $('#buyMay').html(price.toFixed(2));
            gocheck();
        }
    }

    for (var i = 0; i < buyList.length; i++) {
        buyList[i].onclick = function (e) {
            e = e || window.event;
            var el = e.srcElement;
            var cls = el.className;
            var numInput = this.getElementsByClassName('count-input');
            var val = parseInt(numInput[0].value);
            var reduce = this.getElementsByClassName('reduce')[0];
            switch (cls) {
                case 'reduce':
                    if (val > 1) {
                        numInput[0].value = val - 1;
                    }
                    ;
                    if (val <= 1) {
                        reduce.innerHTML = '';
                    }
                    ;
                    break;
                case 'add':
                    numInput[0].value = val + 1;
                    reduce.innerHTML = '-';
                    break;
                    defaule:
                        break;
            }
            buyTotal();
        }
        buyList[i].getElementsByClassName('count-input')[0].onkeyup = function () {
            var val = parseInt(this.value);
            var lis = this.parentNode.parentNode.parentNode;
            var reduce = lis.getElementsByClassName('reduce')[0];
            if (isNaN(val) || val < 1) {
                val = 1;
            }
            ;
            this.value = val;
            if (val <= 1) {
                reduce.innerHTML = '';
            } else {
                reduce.innerHTML = '-';
            }
            ;
            buyTotal();
        }
    }
    function gocheck() {
        if ($('#buychecked input')[0].checked) {
            var buycheapNum = $('#buyMay').html() - $('#cheapNum').html();
            $('#buyMay').html(buycheapNum.toFixed(2));
        }
    }

    $('#buychecked').on('click', function () {
        gocheck()
    });


    //优惠券
    for (var i = 0; i < $('#welfareNum .voucher-text').length; i++) {
        var nums = $('#welfareNum h2').text();
        var biaoDa1 = /[0-9]+(\.[0-9]+)?/;
        var str = nums.match(biaoDa1);
        if (str[0] > 999) {
            $('#welfareNum h2')[i].style.fontSize = "1.2rem";
        }
    }
    ;

    $(document).on('click', '.openRule', function () {
        $.popup('.popup-about');
    });
    //发票
    $(document).on('click', '#ticketItem', function () {
        if ($('#tickeRadio').checked) {
            $('#ticketList').show();
        } else {
            $('#ticketList').hide();
        }
    });
    var spanLong = $('#longSide').width();
    $('#ticketList_company label').width(spanLong);

    $.init();
});
