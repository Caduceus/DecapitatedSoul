			<div class="Box">
                <div class="Latest">
                </div>
                <div class="Item" onclick="location.href='index.php';" onmouseover="show(1)" onmouseout="hide(1)">
                    <div class="Img">
                        <img id="1img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="1txt" class="Text">
                        Latest News
                    </div>
                </div>
                
                <div class="Item" onclick="location.href='changelog.php';" onmouseover="show(2)" onmouseout="hide(2)">
                    <div class="Img">
                        <img id="2img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="2txt" class="Text">
                        Changelog
                    </div>
                </div>
                <div class="ItemLast">
					<div class="Item" onclick="location.href='forum.php';" onmouseover="show(3)" onmouseout="hide(3)">
						<div class="Img">
                        	<img id="3img" src="layout/images/dot_light.png" alt="">
                    	</div>
                    	<div id="3txt" class="Text">
                        	Forum
                    	</div>
					</div>
                </div>
            </div>
            
            <div class="Box">			
                <div class="Account">
                </div>
                <?php if (user_logged_in() === true) { ?>
                <div class="Item" onclick="location.href='buypoints.php';" onmouseover="show(11)" onmouseout="hide(11)">
                    <div class="Img">
                        <img id="11img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="11txt" class="Text">
                        Donate
                    </div>
                </div>
                <?php
                }
                    
                    if (user_logged_in() === true) { ?>
                    <div class="Item" onclick="location.href='myaccount.php';" onmouseover="show(30)" onmouseout="hide(30)">
                        <div class="Img">
                            <img id="30img" src="layout/images/dot_light.png" alt="">
                        </div>
                        <div id="30txt" class="Text">
                            My Account
                         </div>
                     </div>
                <?php
                }
                    if (user_logged_in() === true) { ?>
                    <div class="Item" onclick="location.href='createcharacter.php';" onmouseover="show(15)" onmouseout="hide(15)">
                        <div class="Img">
                            <img id="15img" src="layout/images/dot_light.png" alt="">
                        </div>
                        <div id="15txt" class="Text">
                            Create Character
                         </div>
                     </div>
                <?php
                }
                    if (user_logged_in() === true) { ?>
                    <div class="Item" onclick="location.href='settings.php';" onmouseover="show(12)" onmouseout="hide(12)">
                        <div class="Img">
                            <img id="12img" src="layout/images/dot_light.png" alt="">
                        </div>
                        <div id="12txt" class="Text">
                            Settings
                         </div>
                     </div>
                <?php
               } 
                if (user_logged_in() === true) { ?>
                    <div class="Item" onclick="location.href='downloads.php';" onmouseover="show(13)" onmouseout="hide(13)">
                        <div class="Img">
                            <img id="13img" src="layout/images/dot_light.png" alt="">
                        </div>
                        <div id="13txt" class="Text">
                            Downloads
                         </div>
                     </div>
                <?php
               }
					 ?>
					<div class="ItemLast">
                <div class="Item" onclick="location.href='register.php';" onmouseover="show(14)" onmouseout="hide(14)">
                    <div class="Img">
                        <img id="14img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="14txt" class="Text">
                        Create Account
						</div>
					</div>
				</div>
            </div>
            
            <div class="Box">
                <div class="Community">
                </div>
                <div class="Item" onclick="location.href='onlinelist.php';" onmouseover="show(21)" onmouseout="hide(21)">
                    <div class="Img">
                        <img id="21img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="21txt" class="Text">
                        Who is online?
                    </div>
                </div>
                
                 <div class="Item" onclick="location.href='highscores.php';" onmouseover="show(23)" onmouseout="hide(23)">
                    <div class="Img">
                        <img id="23img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="23txt" class="Text">
                        Highscores
                    </div>
                </div>
                
                 <div class="Item" onclick="location.href='deathlist.php';" onmouseover="show(25)" onmouseout="hide(25)">
                    <div class="Img">
                        <img id="25img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="25txt" class="Text">
                        Latest Deaths
                    </div>
                </div>
                
                <div class="Item" onclick="location.href='http://decapitatedsoul.servegame.com/forum.php?cat=6/';" onmouseover="show(31)" onmouseout="hide(31)">
                    <div class="Img">
                        <img id="31img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="31txt" class="Text">
                        Photo Gallery
                    </div>
                </div>
                
                <div class="Item" onclick="location.href='powergamers.php';" onmouseover="show(27)" onmouseout="hide(27)">
                    <div class="Img">
                        <img id="27img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="27txt" class="Text">
                        Powergamers
                    </div>
                </div>	
                <div class="Item" onclick="location.href='houses.php';" onmouseover="show(24)" onmouseout="hide(24)">
                    <div class="Img">
                        <img id="24img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="24txt" class="Text">
                        Houses
                    </div>
                </div>
                <div class="Item" onclick="location.href='killers.php';" onmouseover="show(32)" onmouseout="hide(32)">
                    <div class="Img">
                        <img id="25img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="32txt" class="Text">
                        Latest Frags
                    </div>
                </div>
                <div class="Item" onclick="location.href='guilds.php';" onmouseover="show(26)" onmouseout="hide(26)">
                    <div class="Img">
                        <img id="26img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="26txt" class="Text">
                        Guilds
                    </div>
                </div>
                <div class="Item" onclick="location.href='serverinfo.php';" onmouseover="show(28)" onmouseout="hide(28)">
                    <div class="Img">
                        <img id="28img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="28txt" class="Text">
                        Server Info
                    </div>
                </div>
                <!--<div class="Item" onclick="location.href='guildwar.php';" onmouseover="show(27)" onmouseout="hide(27)">
                    <div class="Img">
                        <img id="27img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="27txt" class="Text">
                        Guild Wars
                    </div>
                </div>-->
                <div class="ItemLast">
					<div class="Item" onclick="location.href='helpdesk.php';" onmouseover="show(29)" onmouseout="hide(29)">
						<div class="Img">
                        	<img id="29img" src="layout/images/dot_light.png" alt="">
                    	</div>
                    	<div id="29txt" class="Text">
                        	Help
                    	</div>
					</div>
                </div>
            </div>
          <!--  <div class="Box">
                <div class="Shop">
                </div>
                <div class="Item" onclick="location.href='buypoints.php';" onmouseover="show(888)" onmouseout="hide(888)">
                    <div class="Img">
                        <img id="888img" src="layout/images/dot_light.png" alt="">
                    </div>
                    <div id="888txt" class="Text">
                        Buy Points
                    </div>
                </div>
                <div class="ItemLast">
					<div class="Item" onclick="location.href='shop.php';" onmouseover="show(999)" onmouseout="hide(999)">
						<div class="Img">
                        	<img id="999img" src="layout/images/dot_light.png" alt="">
                    	</div>
                    	<div id="999txt" class="Text">
                        	Shop
                    	</div>
					</div>
                </div>
            </div>-->