<?php

$id = $_REQUEST['id'];

switch ($id) {
    case "GetChangelog":
        $file = file_get_contents('./Changelog.txt', true);
        echo"$file";
        break;
    case "GetNews":
        echo "Decapitated Soul";
        break;
    case "GetNewsColor":
        echo 1;
        break;
    case "GetFileListPath":
        echo "http://decapitatedsoul.servegame.com/LunaUpdater/FileList.xml";
        break;
    case "GetDeleteListPath":
        echo "http://decapitatedsoul.servegame.com/LunaUpdater/DeleteList.xml";
        break;
    case "InfoWindowState":
        echo 0;
        break;
    case "GetInfoHtmlPath":
        echo "";
        break;
}
?>