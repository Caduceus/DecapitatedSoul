                        </div>
                    </div>
                    <div class="Bottom"></div>
                </div>    
            </div>
            
            <div id="MainCenterRight">
                            <div class="Box">
                                <?php if (user_logged_in() === true) {
                                    include 'layout/widgets/loggedin.php';
                                } else {
                                    include 'layout/widgets/login.php';
                                }
                                ?>
                            </div>
                            
                            <div id='timer' style="display: none;"></div><script type="text/javascript">window.onload = CreateTimer("timer", 4);</script>
                            <?php include 'layout/slideshow.php'; ?>

                <div class="Box">
                    <div class="TopExperience">
                    </div>
                        <?php include 'layout/widgets/topplayers.php'; ?>
                </div>
                </div>
            </div>
        </div>
            
        <div id="MainBottom">
            <div id="MainBottomB"></div>
            <div id="MainBottomContent">
                
                <div class="BotBut">
                    <img src="layout/images/bottom_button.png" alt="" onclick="scroll(0,0)">
                </div>
                
                <div class="BotTxt1">
                    &copy; <?php echo $config['site_title'];?>.
                    <?php 
                        echo 'Server date and clock is: '. getClock(false, true) .' Page generated in '. elapsedTime() .' seconds. Q: '.$aacQueries;
                    ?>
                    

                    <br>Engine: <a href="credits.php"><font color="white">Znote AAC</font></a>  | Converted to ZnoteAAC by <a href="https://otland.net/members/halfaway.142275/"><font color="white">HalfAway</font></a> | Modified by <a href="https://otland.net/members/decapitated-sou.86434/"><font color="white">Caduceus</a></font>
                </div>
                
                <div class="BotTxt2">
                    SOCIAL NETWORKS
                </div>
                
                <div class="BotMenu">
                    <?php include 'layout/bottommenu.php'; ?>
                </div>
                
                <?php include 'layout/social.php'; ?>
            </div>
        </div>
    </div>
</body>
</html>