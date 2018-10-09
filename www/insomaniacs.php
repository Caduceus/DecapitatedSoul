<?php
/* Assumed SQL table structure:
CREATE TABLE IF NOT EXISTS `player_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
*/
require_once 'engine/init.php';
include 'layout/overall/header.php';
// One week is 7 days
$week = 7 * 24 * 60 * 60;
// This is the timestamp of one week ago.
$weekAgo = time() - $week;
// Lets grab all login data from a week ago to today
$insomniacs = mysql_select_multi("SELECT `player_id`, `date`, `type` FROM `player_logins` WHERE `date` > '{$weekAgo}' ORDER BY `date` ASC;");
// Lets create a unique list sorted by player ID, and query for their names.
$player_data = array();
foreach ($insomniacs as $ins) {
	// Avoid duplicate player ids.
	if (!in_array($ins['player_id'], array_keys($player_data))) {
		$player_data[$ins['player_id']] = false;
	}
}
$playernames = mysql_select_multi("SELECT `id`, `name` FROM `players` WHERE `id` IN(". implode(',', array_keys($player_data)) .");");
// Populate the player_data list with their names.
foreach ($playernames as $player) {
	if (isset($player_data[$player['id']]) && $player_data[$player['id']] === false) {
		$player_data[$player['id']] = $player['name'];
	}
}
// Lets save insomniacs data to player_data
for ($i = 0; $i < count($insomniacs); $i++) {
	$player_data[$insomniacs[$i]['player_id']]['records'][] = $insomniacs[$i];
}
// Lets start calculating online session durations of the players
for ($i = 0; $i < count($player_data); $i++) {
	//$player_data[$i]
	$player_data[$i]['total_online'] = 0;
	for ($x = 0; $x < count($player_data[$i]['records']); $x++) {
		// If this is the first record, and it is an logout event, count the seconds since timestamp of a week ago.
		if ($x === 0 && $player_data[$i]['records'][$x]['type'] == 0) {
			$player_data[$i]['total_online'] += $player_data[$i]['records'][$x]['date'] - $weekAgo;
		}
		// If this is a login event, check if the next index is a logout event, and calculate the time between them
		if ($player_data[$i]['records'][$x]['type'] == 1) {
			$login = $player_data[$i]['records'][$x]['date'];
			// next event should be logout if it exist, else grab today (they are considered still online):
			$logout = (isset($player_data[$i]['records'][$x+1])) ? $player_data[$i]['records'][$x+1]['date'] : time();
			$player_data[$i]['total_online'] += $logout - $login;
		}
	}
}
// Todo: Sort the array by $player_data[array][total_online]
?>

<h1>Insomniacs</h1>
<table>
	<tr>
		<td>Player name</td>
		<td>Seconds online past 7 days</td>
	</tr>
	<?php foreach($player_data as $player): ?>
	<tr>
		<td><?php echo $player['name']; ?></td>
		<td><?php echo $player['total_online']; ?></td>
	</tr>
	<?php endforeach; ?>
</table>

<?php include 'layout/overall/footer.php';
// Alternative query for insomniacs which includes the player names
// $insomniacs = mysql_select_multi("SELECT `pl`.`player_id`, `pl`.`date`, `pl`.`type`, `p`.`name` FROM `player_logins` as `pl` INNER JOIN `players` AS `p` ON `p`.`id` = `pl`.`player_id` WHERE `pl`.`date` > '{$weekAgo}'");
?>