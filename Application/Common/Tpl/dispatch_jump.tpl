<?php
    if(C('LAYOUT_ON')) {
        echo '{__NOLAYOUT__}';
    }
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title></title>
	<meta name="viewport" content="initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" href="/assets/mall/dist/css/sm.css">
	<link rel="stylesheet" href="/assets/mall/dist/css/sm-extend.css">
	<link rel="stylesheet" href="/assets/mall/css/css.css">
	<script src="/assets/mall/js/zepto.js"></script>
</head>
<body>
<!-- page 容器 -->
<div class="page">
	<div class="warning">
		<?php if(isset($message)) { ?>
		<img src="/assets/mall/img/warning40.png" alt=""/>
		<?php }else{ ?>
		<img src="/assets/mall/img/warning40.png" alt=""/>
		<?php } ?>
		<p>
			<?php if(isset($message)) { ?>
			<?php echo($message); ?>
			<?php }else{ ?>
			<?php echo($error); ?>
			<?php } ?>
			<br>
			自动<a class="external" id="href" href="<?php echo($jumpUrl); ?>">跳转</a>中 <b id="wait"><?php echo($waitSecond); ?></b>
		</p>
	</div>
</div>
<script type="text/javascript">
	(function(){
		var wait = document.getElementById('wait'),href = document.getElementById('href').href;
		var interval = setInterval(function(){
			var time = --wait.innerHTML;
			if(time <= 0) {
				location.href = href;
				clearInterval(interval);
			};
		}, 1000);
	})();
</script>
<script src="/assets/mall/dist/js/sm.js"></script>
<script src="/assets/mall/dist/js/sm-extend.js"></script>
</body>
</html>
