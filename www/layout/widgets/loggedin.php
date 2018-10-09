				<div class="Account1"></div>
                <div class="Item" onclick="location.href='myaccount.php';" onmouseover="show2(30)" onmouseout="hide2(30)">
                    <div class="Img">
                        <img id="30img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="30txtL" class="TextL">
                        My Account
                    </div>
                </div>
                <?php
                    if (user_logged_in() && is_admin($user_data)) {
                		include 'layout/widgets/Wadmin.php';
                    } 
                ?>
                <!--div class="Item" onclick="location.href='register.php';" onmouseover="show2(31)" onmouseout="hide2(31)">
                    <div class="Img">
                        <img id="31img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="31txtL" class="TextL">
                        --Register Account
                    </div>
                </div-->

             	<div class="ItemLast1">
                	<div class="Item" onclick="location.href='logout.php';" onmouseover="show2(32)" onmouseout="hide2(32)">
	                    <div class="Img">
	                        <img id="32img" src="layout/images/dot_light.png" alt="">
	                    </div>
	                    <div id="32txtL" class="TextL">
	                        Logout
	                    </div>
                	</div>
                </div>