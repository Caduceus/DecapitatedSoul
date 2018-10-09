<?php
	$cache = new Cache('engine/cache/topPlayer');
	if ($cache->hasExpired()) {
		$players = mysql_select_multi('SELECT `name`, `level`, `experience` FROM `players` WHERE `group_id` < ' . $config['highscore']['ignoreGroupId'] . ' ORDER BY `experience` DESC LIMIT 10;');
		
		$cache->setContent($players);
		$cache->save();
	} else {
		$players = $cache->load();
	}

	if ($players) {
		$count = 1;
		$topid = 80;
		foreach($players as $player) {
			echo "<div class='Item' style='font-size: 12px;><font color='green'>
			<div class='Img'><img id='".$topid."img' src='layout/images/dot_light.png' alt=''></div><div id='".$topid."txtL' class='TextL'><a href='characterprofile.php?name=". $player['name']. "' onmouseover='show2(".$topid.")' onmouseout='hide2(".$topid.")'>". $player['name']. "</a></div>
			<div id='".$topid."txtR class='TextR' style='color: #fff;'>".$player['level']." lvl</div></div>";
			$count++;
			$topid++;
		}
	}
	echo '<div class="ItemLast"></div>';
?>