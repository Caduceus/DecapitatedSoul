
			<div class="Item" onclick="location.href='admin.php';" onmouseover="show2(33)" onmouseout="hide2(33)">
                <div class="Img">
                    <img id="33img" src="layout/images/dot_light.png" alt="">
                </div>
                <div id="33txtL" class="TextL">
                    Admin Page
                </div>
            </div>

            <div class="Item" onclick="location.href='admin_news.php';" onmouseover="show2(34)" onmouseout="hide2(34)">
                <div class="Img">
                    <img id="34img" src="layout/images/dot_light.png" alt="">
                </div>
                <div id="34txtL" class="TextL">
                    Admin News
                </div>
            </div>
            
            <div class="Item" onclick="location.href='admin_helpdesk.php';" onmouseover="show2(38)" onmouseout="hide2(38)">
                <div class="Img">
                    <img id="38img" src="layout/images/dot_light.png" alt="">
                </div>
                <div id="38txtL" class="TextL">
                    Admin Helpdesk
                </div>
            </div>
            
			<div class="Item" onclick="location.href='admin_skills.php';" onmouseover="show2(36)" onmouseout="hide2(36)">
                <div class="Img">
                    <img id="36img" src="layout/images/dot_light.png" alt="">
                </div>
                <div id="36txtL" class="TextL">
                    Admin Skills
                </div>
            </div>
            
            <?php
			$new = 0;
			$threads = mysql_select_multi("SELECT `id`, `name` FROM `player_reports` WHERE `status`='0';");
			if ($threads !== false) {
				$staffs = mysql_select_multi("SELECT `id` FROM `players` WHERE `group_id` > '3';");
				
				foreach($threads as $thread) {
					$response = false;
					$posts = mysql_select_multi("SELECT `id`, `name` FROM `player_reports` WHERE `status`='0';");
					if ($posts !== false) {
						foreach($posts as $post) {
							foreach ($staffs as $staff) {
								if ($post['id'] == $staff['id']) $response = true;
							}
						}
					}

					if (!$response) $new++;
				}
			}
			?>

            <div class="Item" onclick="location.href='admin_reports.php';" onmouseover="show2(37)" onmouseout="hide2(37)">
                <div class="Img">
                    <img id="37img" src="layout/images/dot_light.png" alt="">
                </div>
                <div id="37txtL" class="TextL">
                    Reports: [<?php echo $new; ?>] new
                </div>
            </div>

			<div class="Item" onclick="location.href='admin_gallery.php';" onmouseover="show2(35)" onmouseout="hide2(35)">
                <div class="Img">
                    <img id="35img" src="layout/images/dot_light.png" alt="">
                </div>
                <div id="35txtL" class="TextL">
                    Admin Gallery
                </div>
            </div>

			<div class="Item" onclick="location.href='admin_shop.php';" onmouseover="show2(39)" onmouseout="hide2(39)">
                <div class="Img">
                    <img id="39img" src="layout/images/dot_light.png" alt="">
                </div>
                <div id="39txtL" class="TextL">
                    Admin Shop
                </div>
            </div>

			<?php
			$new = 0;
			$cat = 4; //Category ID for feedback section
			$threads = mysql_select_multi("SELECT `id`, `player_id` FROM `znote_forum_threads` WHERE `forum_id`='$cat' AND `closed`='0';");
			if ($threads !== false) {
				$staffs = mysql_select_multi("SELECT `id` FROM `players` WHERE `group_id` > '3';");
				
				foreach($threads as $thread) {
					$response = false;
					$posts = mysql_select_multi("SELECT `id`, `player_id` FROM `znote_forum_posts` WHERE `thread_id`='". $thread['id'] ."';");
					if ($posts !== false) {
						foreach($posts as $post) {
							foreach ($staffs as $staff) {
								if ($post['player_id'] == $staff['id']) $response = true;
							}
						}
					}

					if (!$response) $new++;
				}
			}
			?>

			<div class="Item" onclick="location.href='forum.php?cat=4';" onmouseover="show2(40)" onmouseout="hide2(40)">
                <div class="Img">
                    <img id="40img" src="layout/images/dot_light.png" alt="">
                </div>
                <div id="40txtL" class="TextL">
                    Feedback: [<?php echo $new; ?>] new
                </div>
            </div>
            
           