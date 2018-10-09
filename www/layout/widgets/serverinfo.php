<?php
	$status = true;
	if ($config['status']['status_check']) {
		@$sock = fsockopen ($config['status']['status_ip'], $config['status']['status_port'], $errno, $errstr, 1);
		if(!$sock) {
			echo '<img class="Offline" src="layout/images/offline.png" alt="" style="display: block;">';
			$status = false;
		} else {
			$info = chr(6).chr(0).chr(255).chr(255).'info';
			fwrite($sock, $info);
			$data='';
			while (!feof($sock))$data .= fgets($sock, 1024);
			fclose($sock);
			echo '<img class="Online" src="layout/images/online.png" alt="" style="display: block;">';
		}
	}
	if ($status) { ?>
		<div class="Players">
			<a href="onlinelist.php">
				<?php echo user_count_online(); ?>
			</a>
		</div>
	<?php } else { ?>
		<div class="Players">
			0
		</div>
		
<?php
	}
?>