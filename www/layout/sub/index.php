<?php
// Front page server information box by Raggaer. Improved by Znote. (Using cache system and Znote SQL functions)
// Create a cache system
$infoCache = new Cache('engine/cache/serverInfo');
$infoCache->setExpiration(60); // This will be a short cache (60 seconds)
if ($infoCache->hasExpired()) {

    // Fetch data from database
    $data = array(
        'newPlayer' => mysql_select_single("SELECT `name` FROM `players` ORDER BY `id` DESC LIMIT 1"),
        'bestPlayer' => mysql_select_single('SELECT `name`, `level`, `experience` FROM `players` WHERE `group_id` < ' . $config['highscore']['ignoreGroupId'] . ' ORDER BY `experience` DESC LIMIT 1;'),
        'playerCount' => mysql_select_single("SELECT COUNT(`id`) as `count` FROM `players`"),
        'accountCount' => mysql_select_single("SELECT COUNT(`id`) as `count` FROM `accounts`"),
        'guildCount' => mysql_select_single("SELECT COUNT(`id`) as `count` FROM `guilds`")
    );

    // Initiate default values where needed
    if ($data['playerCount'] !== false && $data['playerCount']['count'] > 0) $data['playerCount'] = $data['playerCount']['count'];
    else $data['playerCount'] = 0;
    if ($data['accountCount'] !== false && $data['accountCount']['count'] > 0) $data['accountCount'] = $data['accountCount']['count'];
    else $data['accountCount'] = 0;
    if ($data['guildCount'] !== false && $data['guildCount']['count'] > 0) $data['guildCount'] = $data['guildCount']['count'];
    else $data['guildCount'] = 0;

    // Store data to cache
    $infoCache->setContent($data);
    $infoCache->save();
} else {
    // Load data from cache
    $data = $infoCache->load();
}
?>

<b><center> Join us on Discord</center></b>
    <center><iframe src="https://discordapp.com/widget?id=500101864357101578&theme=dark" width="520" height="400" allowtransparency="true" frameborder="0"></iframe></center>
<br>
	
<!-- Render HTML for server information -->
<table border="0" cellspacing="0">
    <!--tr class="yellow">
        <td><center>Server Stats</center></td>
    </tr-->
   
        <tr>
        <td>
			<?php
			echo nl2br("\n");
			?>
            <center>There are <b><?php echo $data['playerCount']; ?> characters</b> on <b><?php echo $data['accountCount']; ?> accounts</b> registered on <b>decapitatedsoul.servegame.com</b> </center>
            <?php
			echo nl2br("\n");
			?>
            <center><b><a href="register.php" style="color: darkorange;">Join Decapitated Soul!</a></b></font color></center>
            <?php
			echo nl2br("\n");
			?>
           <!--?php echo $data['guildCount']; </b> guilds </center-->
        </td>
    </tr>
    <tr>
        <td>
            <center>Welcome to our newest player:
                <a href="characterprofile.php?name=<?php echo $data['newPlayer']['name']; ?>">
                    <b><?php echo $data['newPlayer']['name']; ?></b>
                </a>
            </center>
        </td>
    </tr>
    <tr>
        <td>
           <?php
			echo nl2br("\n");
			?>
        </td>
    </tr>
    <!--tr>
        <td>
            <center>Our highest level player is
                <a href="characterprofile.php?name=<?php echo $data['bestPlayer']['name']; ?>">
                    <font color='darkorange'><b><?php echo $data['bestPlayer']['name']; ?></a></b></font color>.
                 &nbsp;level:<font color='darkorange'><b><?php echo $data['bestPlayer']['level']; ?></b></font color>
            </center>
        </td>
    </tr-->

</table>
<?php
if ($config['UseChangelogTicker']) {
	//////////////////////
	// Changelog ticker //
	// Load from cache
	$changelogCache = new Cache('engine/cache/changelog');
	$changelogs = $changelogCache->load();

	if (isset($changelogs) && !empty($changelogs) && $changelogs !== false) {
		?>
		<table id="changelogTable">
			<tr class="yellow">
				<td colspan="2">Latest Changelog Updates (<a href="changelog.php" style="color: darkorange;">Click here to see full changelog</a>)</td>
			</tr>
			<?php
			for ($i = 0; $i < count($changelogs) && $i < 5; $i++) {
				?>
				<tr>
					<td><?php echo getClock($changelogs[$i]['time'], true, true); ?></td>
					<td><?php echo $changelogs[$i]['text']; ?></td>
				</tr>
				<?php
			}
			?>
		</table>

		<?php
	} else echo "No changelogs submitted.";
}

$cache = new Cache('engine/cache/news');
if ($cache->hasExpired()) {
	$news = fetchAllNews();
	
	$cache->setContent($news);
	$cache->save();
} else {
	$news = $cache->load();
}

// Design and present the list
if ($news) {
	function TransformToBBCode($string) {
		$tags = array(
			'[center]{$1}[/center]' => '<center>$1</center>',
			'[b]{$1}[/b]' => '<b>$1</b>',
			'[size={$1}]{$2}[/size]' => '<font size="$1">$2</font>',
			'[img]{$1}[/img]'    => '<a href="$1" target="_BLANK"><img src="$1" alt="image" style="width: 100%"></a>',
			'[link]{$1}[/link]'    => '<a href="$1">$1</a>',
			'[link={$1}]{$2}[/link]'   => '<a href="$1" target="_BLANK">$2</a>',
			'[color={$1}]{$2}[/color]' => '<font color="$1">$2</font>',
			'[*]{$1}[/*]' => '<li>$1</li>',
		);

		foreach ($tags as $tag => $value) {
			$code = preg_replace('/placeholder([0-9]+)/', '(.*?)', preg_quote(preg_replace('/\{\$([0-9]+)\}/', 'placeholder$1', $tag), '/'));
			$string = preg_replace('/'.$code.'/i', $value, $string);
		}

		return $string;
	}
	echo '<div id="newz">';
	foreach ($news as $n) {
		?>
		<div class="ContentNext"><div style="margin-left: 65px; line-height: 95px;"><?php echo TransformToBBCode($n['title']) .' by <a href="characterprofile.php?name='. $n['name'] .'">'. $n['name'] .'</a>'; ?><span style="float: right; margin-right: 35px;"><?php echo getClock($n['date'], true); ?></span></div></div>
		<div class="news_mid"><?php echo TransformToBBCode(nl2br($n['text'])); ?></div>
		<div class="news_bot"></div>
		<?php
	}
	echo '</div>';
}
?>