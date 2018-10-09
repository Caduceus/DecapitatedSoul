<?php require_once 'engine/init.php';
protect_page();
$paypal = $config['paypal'];
$payment_id = (isset($_REQUEST['paymentId'])) ? getValue($_REQUEST['paymentId']) : false;
$payer_id = (isset($_REQUEST['PayerID'])) ? getValue($_REQUEST['PayerID']) : false;
if ($payment_id === false || $payer_id === false) {
	die("Invalid data, missing payment_id or payer_id");
}
// Do local verification on payment and payer ID before we ask paypal about it
$exist = mysql_select_single("SELECT `id` FROM `znote_paypal` WHERE `payment_id`='{$payment_id}' LIMIT 1;");
if (!$exist) {
	die("This transaction is not found in our database.");
}
if ($paypal['debug']) data_dump($_REQUEST, false, "Request data");
if ($paypal['debug']) data_dump($user_data, false, "User Data");
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "https://api.paypal.com/v1/oauth2/token"); //https://api.sandbox.paypal.com/v1/oauth2/token
curl_setopt($ch, CURLOPT_HEADER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
curl_setopt($ch, CURLOPT_USERPWD, $paypal['client_id'].":".$paypal['secret_id']);
curl_setopt($ch, CURLOPT_POSTFIELDS, "grant_type=client_credentials");
		
$result = curl_exec($ch);
$token_json = json_decode($result);
$token = $token_json->access_token;	
if ($paypal['debug']) data_dump($token_json, false, "Token info");
// Execute the payment
$payment = array(
	"payer_id" => $payer_id	
);
curl_setopt($ch, CURLOPT_URL, "https://api.paypal.com/v1/payments/payment/".$payment_id."/execute/"); //https://api.sandbox.paypal.com/v1/payments/payment/".$payment_id."/execute/
curl_setopt($ch, CURLOPT_HEADER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
curl_setopt($ch, CURLOPT_USERPWD, $paypal['client_id'].":".$paypal['secret_id']);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payment));
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
	"Authorization: Bearer $token",
	"Content-Type: application/json"
));
		
$result = curl_exec($ch);
$payment_info = json_decode($result);
curl_close($ch);
if ($paypal['debug']) data_dump($payment_info, false, "payment info");
///////////////////////
// Validate response //
///////////////////////
$errors = array();
// Already done payment?
if (isset($payment_info->name) && $payment_info->name === "PAYMENT_ALREADY_DONE") {
	include 'layout/overall/header.php';
	?>
	<h1>Transaction already done</h1>
	<p>Transaction has been done already for this order.</p>
	<?php
	include 'layout/overall/footer.php';
	exit();
}
////////
// Payment ID
$paymentId = (isset($payment_info->id)) ? $payment_info->id : false;
if (!$paymentId) {
	$errors[] = "Failed to load payment ID";
}
////////
// Load transaction from SQL
$db_entry = ($paymentId !== false)
	? mysql_select_single("SELECT `id`, `account_id`, `payment_id`, `payment_state`, `points`, `transaction_state`, `payer_id`, `email` FROM `znote_paypal` WHERE `payment_id`='{$paymentId}' LIMIT 1;")
	: false;
if (!$db_entry) {
	$errors[] = "Failed to load the transaction from the database.";
} else {
	if ($paymentId !== false) mysql_update("UPDATE `znote_paypal` SET `payer_id`='{$payer_id}' WHERE `payment_id`='{$paymentId}' LIMIT 1;");
}
////////
// Payment time
$time_updated = (isset($payment_info->create_time)) ? $payment_info->create_time : false;
if (!$time_updated) {
	$errors[] = "Failed to processing timestamp";
	if ($paymentId !== false) mysql_update("UPDATE `znote_paypal` SET `time_updated`='Missing' WHERE `payment_id`='{$paymentId}' LIMIT 1;");
} else {
	if ($paymentId !== false) mysql_update("UPDATE `znote_paypal` SET `time_updated`='{$time_updated}' WHERE `payment_id`='{$paymentId}' LIMIT 1;");
}
////////
// Payment state
$paymentState = (isset($payment_info->state)) ? $payment_info->state : false;
if (!$paymentState) {
	$errors[] = "Failed to load payment state";
} elseif ($paymentState != "approved") {
	$errors[] = "Payment state is not approved, but {$paymentState}.";
	if ($paymentId !== false) mysql_update("UPDATE `znote_paypal` SET `payment_state`='{$paymentState}' WHERE `payment_id`='{$paymentId}' LIMIT 1;");
}
////////
// Transaction state
$transactionState = (isset($payment_info->transactions[0]->related_resources[0]->sale->state)) 
	? $payment_info->transactions[0]->related_resources[0]->sale->state 
	: false;
if (!$transactionState) {
	$errors[] = "Failed to load Transaction state";
} elseif ($transactionState != "completed") {
	$errors[] = "Transaction state is not completed, but {$transactionState}.";
	if ($paymentId !== false) mysql_update("UPDATE `znote_paypal` SET `transaction_state`='{$transactionState}' WHERE `payment_id`='{$paymentId}' LIMIT 1;");
}
////////
// Paypal Email
$paypalEmail = (isset($payment_info->payer->payer_info->email)) ? $payment_info->payer->payer_info->email : false;
if (!$paypalEmail) {
	$errors[] = "Failed to load payer email address";
} else {
	if ($paymentId !== false) mysql_update("UPDATE `znote_paypal` SET `email`='{$paypalEmail}' WHERE `payment_id`='{$paymentId}' LIMIT 1;");
}
////////
// Paypal verified
$paypalVerified = (isset($payment_info->payer->status)) ? $payment_info->payer->status : false;
if (!$paypalVerified) {
	$errors[] = "Failed to load payer status";
} elseif ($paypalVerified != "VERIFIED") {
	$errors[] = "Paypal account is not verified, and thus considered untrusted.";
	if ($paymentId !== false) 
		mysql_update("UPDATE `znote_paypal` SET `transaction_state`='{$transactionState} (untrusted)' WHERE `payment_id`='{$paymentId}' LIMIT 1;");
}
////////
// Price
$prices = $config['paypal_prices'];
$price = (isset($payment_info->transactions[0]->amount->total))
	? $payment_info->transactions[0]->amount->total
	: false;
if (!$price) {
	$errors[] = "Failed to load Transaction price";
} elseif (!in_array($price, array_keys($prices))) {
	if (!in_array((int)$price, array_keys($prices))) {
		$errors[] = "Price {$price} mismatch paypal_prices shop configuration.";
	} else {
		$price = (int)$price;
	}
}
////////
// Currency
$currency = (isset($payment_info->transactions[0]->amount->currency))
	? $payment_info->transactions[0]->amount->currency
	: false;
if (!$currency) {
	$errors[] = "Failed to load Transaction currency";
} elseif ($currency !== $paypal['currency']) {
	$errors[] = "Currency {$currency} mismatch paypal shop configuration (".$paypal['currency'].").";
}
if (!empty($errors)) {
	foreach ($errors as $number => $error) {
		echo '<p style="font-weight: bold; color: red;">Error '.$number.': '.$error.'</p>';
	}
	data_dump($payment_info, false, "Response dump:");
} else {
	// Figure out which fields we need to update
	$update = array();
	if(isset($_POST['price']) && isset($_POST['currency'])){
	if ($db_entry['payment_state'] !== $paymentState) $update['payment_state'] = $paymentState;
	if ($db_entry['transaction_state'] !== $transactionState) $update['transaction_state'] = $transactionState;
	if ($db_entry['price'] != $price) $update['price'] = $price;
	if ($db_entry['currency'] !== $currency) $update['currency'] = $currency;
	if ($db_entry['payer_id'] !== $payer_id) $update['payer_id'] = $payer_id;
	if ($db_entry['email'] !== $paypalEmail) $update['email'] = $paypalEmail;}
	if (!empty($update)) {
		$setString = array();
		foreach ($update as $column => $value) {
			$setString[] = "`{$column}`='{$value}'";
		}
		$setString = implode(',', $setString);
		mysql_update("UPDATE `znote_paypal` SET $setString WHERE `payment_id`='{$paymentId}' LIMIT 1;");
	}
	include 'layout/overall/header.php';
	// Add points to the account
	if ($db_entry['transaction_state'] !== "completed" && $transactionState === "completed") {
		$new_points = $db_entry['points'];
		$account_id = $db_entry['account_id'];
		// Fetch points
		$account = mysql_select_single("SELECT `coins` FROM `accounts` WHERE `id`='{$account_id}' LIMIT 1;");
		// Calculate new points
		$new_points = $account['coins'] + $new_points;
		// Update new points
		mysql_update("UPDATE `accounts` SET `coins`='{$new_points}' WHERE `id`='{$account_id}' LIMIT 1;");
		?>
		<h2>Thank You For Your Contribution To Decapitated Soul.</h2>
		<p>You now have <b><?php echo $new_points; ?></b> in game store coins.</p>
		<?php
	} else {
		?>
		<h1>Processing error</h1>
		<p>This payment is already processed. You should already have gotten the points.</p>
		<p>Failed operation: <?php echo $db_entry['transaction_state']; ?> !== completed && <?php echo $transactionState; ?> === completed</p>
		<?php
	}
	include 'layout/overall/footer.php';
}