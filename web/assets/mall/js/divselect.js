jQuery.divselect = function(divselectid) {

	$(divselectid+" cite").click(function(){
		var ul = $(divselectid+" ul");
		if(ul.css("display")=="none"){
			ul.slideDown("fast");
		}else{
			ul.slideUp("fast");
		}
	});
	$(divselectid+" ul li").click(function(){
		$this = $(this);
		var txt = $(this).text();
		$this.addClass('.selected');
		$this.siblings().removeClass('.selected');
		$(divselectid+" cite").html(txt);
		var value = $(this).attr("selectid");
		$(divselectid+" ul").hide();
		
	});
	$(document).click(function(){
		$(divselectid+" ul").hide();
	});
};