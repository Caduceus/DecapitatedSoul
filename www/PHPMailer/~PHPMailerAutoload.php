<?php

  require("/wamp/www/PHPMailer/src/PHPMailer.php");
  require("/wamp/www/PHPMailer/src/SMTP.php");

    $mail = new PHPMailer\PHPMailer\PHPMailer();
    $mail->IsSMTP(); // enable SMTP

    $mail->SMTPDebug = 1; // debugging: 1 = errors and messages, 2 = messages only
    $mail->SMTPAuth = true; // authentication enabled
    $mail->SMTPSecure = 'ssl'; // secure transfer enabled REQUIRED for Gmail
    $mail->Host = "smtp.gmail.com";
    $mail->Port = 465; // or 587
    $mail->IsHTML(true);
    $mail->Username = "decapitatedsoulot@gmail.com";
    $mail->Password = "Brandy2012";
    $mail->setFrom('decapitatedsoulot@gmail.com', 'Decapitated Soul');
    $mail->Subject = "Test";
    $mail->Body = "hello";
    $mail->AddAddress($email);

     if(!$mail->Send()) {
        echo "Mailer Error: " . $mail->ErrorInfo;
     } else {
        echo "Message has been sent";
     }
?>