<?php require_once 'engine/init.php'; include 'layout/overall/header.php'; ?>

<h1>Downloads</h1>
<p>In order to play, you need a compatible IP changer and Tibia client.</p>

<p>Download IP changer <a href="https://github.com/jo3bingham/tibia-ip-changer/releases/latest"><font color="red">Here</a></font>.</p>
<p>Download Tibia client <a href="http://decapitatedsoul.servegame.com/download/decapitated_soul_tibiaClient.rar?>"><font color="red">Here</a></font>.</p>
<p>Download dat|spr replacements: <a href="http://decapitatedsoul.servegame.com/download/1095.rar"><font color="red"> Latest update 10_8_18</a></font></p>

<h2>How to connect and play: Tibia Client</h2>
<ol>
	<li>
		<a href="http://decapitatedsoul.servegame.com/download/decapitated_soul_tibiaClient.rar?>">Download</a> and install the tibia client if you havent already. This Client is custom. Normal tibia clients will debug anytime a new sprite is in range.
	</li>
	<li>
		<a href="https://github.com/jo3bingham/tibia-ip-changer/releases/latest">Download</a> and run the IP changer.
	</li>
	<li>
		In the IP changer, change Client Path to the tibia.exe file where you installed the client.</strong>
	</li>
	<li>
		In the IP changer, write this in the IP field: <?php echo $_SERVER['SERVER_NAME']; ?>
	</li>
	<li>
		Now you can successfully login on the tibia client and play clicking on <strong>Apply</strong>.<br>
	</li>
</ol>

<h2>How to connect and play: OTClient</h2>
<p><font color="red"><strong>DISCLAIMER: The Decapitated Soul version of OTClient is Experimental. There is not a functioning ingame store within the client at this time. You will still have to use Tibia Client, in order to redeem your coins.</font></p></strong>
<ol>
	<li>
		<a href="http://decapitatedsoul.servegame.com/download/Decapitated_soul_otclient.rar?>">Download</a> the Decapitated Soul version of OTClient.
	</li>
	<li>
		Unzip the .rar file to your desired location (Program recommended: <a href="https://www.win-rar.com/download.html?&L=0 ?>">winrar</a>).
	</li>
	<li>
		Please be aware: Your anti-virus program, may detect this as a virus. I ensure you, this is only because of being an open source program. To properly open this program, please add the <strong>decapitated_soul.exe</strong> and <strong>decap_engine.exe</strong> files to your anti-virus safe list. 
	</li>
	<li>
		Inside the otclient folder, you will see the <strong>decapitated_soul.exe</strong>. Open this file!
	</li>
	<li>
		If there are updates available, they will apply directly through OTClient, by selecting <strong>Yes</strong> if prompted. If no updates are available, then select <strong>Play</strong>.
	</li>
	<li>
		On the login screen, place your <strong>Account/ password.</strong> Options to "Remember password" and "Auto login" are also available. Select <strong>Ok</strong>.
	</li>
	<li>
		Now that you have successfully logged on the server. Select the chracter you wish to play, then hit <strong>Ok</strong>.<br>
	</li>
	<li>
		<strong>Recommended:</strong> Open Options (wrench, top left) Select <strong>"Graphics"</strong>: Check enable lights, Game framerate limit: 30%, Interface framerate limit: 20%, and Ambient lient: 10%.
	</li>
		<li>
		Inside the <strong>Module Manager</strong>, select the <strong>Reload All</strong> button! Scroll to the main bottom. Any red modules, select load, on the right panel.
	</li>

</ol>

<?php 
include 'layout/overall/footer.php'; ?>
