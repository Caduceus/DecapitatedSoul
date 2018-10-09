		<div class="Login">	
			<form action="login.php" method="post">
                <div>
                	<input class="LoginInput1" type="text" name="username">
                    <!--<input class="LoginInput1" type="text" name="account_login" value="Account name" onfocus="this.value=''" onblur="if(this.value=='') { this.value='Account name'};">-->
                </div>
                <div>
                	<input class="LoginInput2" type="password" name="password">
                    <!--<input class="LoginInput2" type="password" name="password_login" value="Account password" onfocus="this.value=''" onblur="if(this.value=='') { this.value='Account password'};"> -->
                </div>
                <div class="LoginInput3" onclick="location.href='recovery.php';">
                    <b><font color="white">Lost Account?</font></b>
                </div>
                <input type="submit" name="Submit" class="LoginInput4" value=""/>                                   
			<?php
				/* Form file */
				Token::create();
			?>
			</form>
		</div>