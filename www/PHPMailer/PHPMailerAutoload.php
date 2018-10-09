<?php
// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

//Load Composer's autoloader
require 'vendor/autoload.php';

$mail = new PHPMailer(true);                              // Passing `true` enables exceptions
try {
    //Server settings
    $mail->SMTPDebug = 0;                                 // Enable verbose debug output
    $mail->isSMTP();                                      // Set mailer to use SMTP
    $mail->Host = 'smtp.gmail.com';  					  // Specify main and backup SMTP servers
    $mail->SMTPAuth = true;                               // Enable SMTP authentication
    $mail->Username = 'decapitatedsoulot@gmail.com';      // SMTP username
    $mail->Password = 'Brandy2012';                       // SMTP password
    $mail->SMTPSecure = 'ssl';                            // Enable TLS encryption, `ssl` also accepted
    $mail->Port = 465;                                    // TCP port to connect to

    //Recipients
    $mail->setFrom('decapitatedsoulot@gmail.com', 'Decapitated Soul');
    $mail->addAddress($email, '');    						 // Add a recipient
    
    //Attachments
    //$mail->addAttachment('C:\wamp\www\images\grim-reaper-calling.png');         // Add attachments

    //Content
    $mail->isHTML(true);                                  // Set email format to HTML
    $mail->Subject = 'Welcome to Decapitated Soul!';
    $mail->Body    = 'Thank you for choosing <b>Decapitatedsoul.servegame.com!</b>';
    $mail->AltBody = 'Thank you for choosing Decapitatedsoul.servegame.com!';

    $mail->send();
    echo 'Email has been sent';
} catch (Exception $e) {
    echo 'Email could not be sent. Mailer Error: ', $mail->ErrorInfo;
}