<html>
<?php 
	$time = microtime();
	$time = explode(' ', $time);
	$time = $time[1] + $time[0];
	$start = $time;
?>
<head>
    <title><?php echo $config['site_title']; ?></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta name="Description" content="" />
	<meta name="Keywords" content="" />
	<meta name="Author" content="" />
	<link rel="stylesheet" href="layout/css/style.css"/>
	<link rel="stylesheet" href="layout/css/basic.css"/>
	<script src="layout/js/main.js"></script>
</head>
<body>
	<div id="Main">
	    <div id="MainTop">
					<div class="PL" onclick="location.href='#';">
	            <img src="" alt="">
	        </div>
					<div class="GB" onclick="location.href='#';">
	            <img src="" alt="">
	        </div>
	    </div>
	    
	    <div id="MainCenter">
	        <div id="MainCenterLeft">
	            <?php include 'layout/leftmenu.php'; ?>
	        </div>
	        
	        <div id="MainCenterMiddle">
				<div class="Top">
					<?php include 'layout/widgets/serverinfo.php'; ?>
	            </div>
							
				<div class="Content">
					<div class="ContentTopFirst"></div>
						<div class="ContentTop">
							<div class="TextFull">