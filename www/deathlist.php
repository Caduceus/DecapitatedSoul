<?php
    require_once 'engine/init.php'; include 'layout/overall/header.php';
    $cache = new Cache('engine/cache/deaths');
    if ($cache->hasExpired()) {
        if ($config['TFSVersion'] == 'TFS_02' || $config['TFSVersion'] == 'TFS_10') {
            $deaths = fetchLatestDeaths();
        } else if ($config['TFSVersion'] == 'TFS_03') {
            $deaths = fetchLatestDeaths_03(30);
        }
        $cache->setContent($deaths);
        $cache->save();
    } else {
        $deaths = $cache->load();
    }
    if ($deaths) {
?>
        <h1>Latest Deaths</h1>
        <table id="deathsTable" class="table table-striped">
        <tr class="yellow">
            <th>Victim</th>
            <th>Level</th>
            <th>Time</th>
            <th>Killer</th>
        </tr>
<?php
        foreach ($deaths as $death) {
            echo '<tr>';
            echo "<td><b><a href='characterprofile.php?name=". $death['victim'] ."'>". $death['victim'] ."</b></a></td>";
            echo "<td> ". $death['level'] ."</b></a></td>";
            echo "<td>". getClock($death['time'], true) ."</td>";
            unset($death['time']); // added this to delete the value stored in here?
            if ($death['is_player'] == 1) echo "<td>Player: <a href='characterprofile.php?name=". $death['killed_by'] ."'>". $death['killed_by'] ."</a></td>";
            else if ($death['is_player'] == 0) {
                if ($config['TFSVersion'] == 'TFS_03') echo "<td>Monster: ". ucfirst(str_replace("a ", "", $death['killed_by'])) ."</td>";
                else echo "<td>Monster: <b>". ucfirst($death['killed_by']) ."</b></td>";
            }
            else echo "<td>". $death['killed_by'] ."</td>";
            echo '</tr>';
        }
?>
        </table>
<?php
    } else echo 'No deaths exist.';
    include 'layout/overall/footer.php';
?>