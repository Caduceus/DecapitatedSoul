<?php require_once 'engine/init.php';
protect_page();
// Import from config:
$pagseguro = $config['pagseguro'];
$paypal = $config['paypal'];
$prices = $config['paypal_prices'];
// Begin processing paypal transaction request
if (empty($_POST) === false) {
	$price = intval($_POST['amount']);
	if(is_int($price) && $price > 0 && in_array($price, array_keys($prices))) {
		$points = $prices[$price];
		if ($paypal['debug']) data_dump($_REQUEST, false, "Request");
		// Init curl
		$ch = curl_init();
		// Get token
		curl_setopt($ch, CURLOPT_URL, "https://api.paypal.com/v1/oauth2/token"); // https://api.sandbox.paypal.com/v1/oauth2/token
		curl_setopt($ch, CURLOPT_HEADER, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
		curl_setopt($ch, CURLOPT_USERPWD, $paypal['client_id'].":".$paypal['secret_id']);
		curl_setopt($ch, CURLOPT_POSTFIELDS, "grant_type=client_credentials");
		
		$result = curl_exec($ch);
		$token_json = json_decode($result);
		$token = $token_json->access_token;	
		if ($paypal['debug']) data_dump($token_json, false, "Payment token");
		
		$profile_id = mysql_select_single("SELECT `value` FROM `znote_global_storage` WHERE `key`='paypal_profile_id' LIMIT 1;");
		if ($profile_id === false) {
			// Prepare profile data
			$buyer_profile = array(
				"name" => "DecapitatedProfile",
				"temporary" => false,
				"input_fields" => array(
					"no_shipping" => 1,
					"address_override" => 1
				)
			);
			// Send profile create request
			curl_setopt($ch, CURLOPT_URL, "https://api.paypal.com/v1/payment-experience/web-profiles"); //https://api.sandbox.paypal.com/v1/payment-experience/web-profiles
			curl_setopt($ch, CURLOPT_HEADER, false);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
			curl_setopt($ch, CURLOPT_POST, true);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_USERPWD, $paypal['client_id'].":".$paypal['secret_id']);
			curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($buyer_profile));
			curl_setopt($ch, CURLOPT_HTTPHEADER, array(
				"Authorization: Bearer ".$token."",
				"Content-Type: application/json"
			));
			$profile_return = json_decode(curl_exec($ch));
			//{"id":"XP-4KHA-UYPT-QNCF-7JYC","name":"webProfile","temporary":false,"input_fields":{"no_shipping":1,"address_override":1}}
			if ($paypal['debug']) data_dump($profile_return, false, "Profile return data");
			$profile_id = (isset($profile_return->id)) ? $profile_return->id : false;
			if ($profile_id !== false) {
				mysql_insert("INSERT INTO `znote_global_storage` (`key`, `value`) VALUES ('paypal_profile_id', '$profile_id');");
			}
		} else {
			$profile_id = $profile_id['value'];
		}
		// Prepare payment data
		$currency = $paypal['currency'];
		$payment = array(
			"intent" => "sale",
			"payer" => array(
				"payment_method" => "paypal"	
			),
			"transactions" => array(
				array(
					"amount" => array(
						"currency" => $currency,
						"total" => $price	
					),
					"description" => "In game store coins on ". $config['site_title'],
					"item_list" => array(
						"items" => array(
							array(
								"quantity" => "1",
								"name" => $prices[$price]." in game store coins.",
								"price" => $price,
								"currency" => $currency
							)
						)
					)
				)
			),
			"experience_profile_id" => $profile_id,
			"redirect_urls" => array(
				"return_url" => $paypal['process'],
				"cancel_url" => $paypal['failed'],
			)
		);
		if ($paypal['debug']) data_dump($payment, false, "Payment data");
		// Send payment request
		curl_setopt($ch, CURLOPT_URL, "https://api.paypal.com/v1/payments/payment"); //https://api.sandbox.paypal.com/v1/payments/payment
		curl_setopt($ch, CURLOPT_HEADER, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_USERPWD, $paypal['client_id'].":".$paypal['secret_id']);
		curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payment));
		curl_setopt($ch, CURLOPT_HTTPHEADER, array(
			"Authorization: Bearer ".$token."",
			"Content-Type: application/json"
		));
		$result = curl_exec($ch);
		$payment_link = json_decode($result);
		// Close curl
		curl_close($ch);
		// Send user to paypal to process payment
		if (isset($payment_link->links[1]->href)) {
			
			// Log the start of the payment process
			// Account ID, payment ID, price, redirect, execute, status
			$account_id = (int)$session_user_id;
			$payment_id = $payment_link->id;
			$payment_state = $payment_link->state;
			$time_created = $payment_link->create_time;
			mysql_insert("INSERT INTO `znote_paypal` (`account_id`,`payment_id`,`payment_state`,`price`,`currency`,`points`, `time_created`) VALUES ('{$account_id}','{$payment_id}','{$payment_state}','{$price}','{$currency}','{$points}','{$time_created}');");
			if ($paypal['debug']) {
				data_dump($payment_link, false, "Payment link success");
				echo "<p><a target='_BLANK' href='".$payment_link->links[1]->href."'>Click here to proceed to paypal</a></p>";
			} else {
				header("Location: ".$payment_link->links[1]->href);
				exit();
			}
		} else {
			data_dump($payment_link, false, "Payment link ERROR");
		}
	} else {
		data_dump($_REQUEST, false, "Invalid post data.");
	}
}
// Render html
include 'layout/overall/header.php'; 
// PayPal
if ($paypal['enabled']):
	?>
	<h1>Buy Coins</h1>
	<h2>Buy in game store coins using Paypal:</h2>
	<table id="buypointsTable" class="table table-striped table-hover">
		<tr class="yellow">
			<th>Price:</th>
			<th>Coins:</th>
			<?php if ($paypal['showBonus']) echo "<th>Bonus:</th>"; ?>
			<th>Action:</th>
		</tr>
			<?php
			foreach ($prices as $price => $points):
				$discount = calculate_discount(($paypal['points_per_currency'] * $price), $points);
				?>
				<tr class="special">
					<td><?php echo $price; ?>(<?php echo $paypal['currency']; ?>)</td>
					<td><?php echo $points; ?></td>
					<?php if ($paypal['showBonus']) echo '<td>'. $discount .' bonus</td>'; ?>
					<td>
						<form action="" method="POST">
							<input type="hidden" name="amount" value="<?php echo $price; ?>">
							<input type="submit" value="  PURCHASE  ">
						</form>
					</td>
				</tr>
				<?php
			endforeach;
			?>
	</table>
	<?php 
endif;
// PagseGuro
if ($config['pagseguro']['enabled'] == true):
	?>
	<h2>Buy points using Pagseguro:</h2>
	<form target="pagseguro" action="https://<?=$pagseguro['urls']['www']?>/checkout/checkout.jhtml" method="post">
		<input type="hidden" name="email_cobranca" value="<?=$pagseguro['email']?>">
		<input type="hidden" name="tipo" value="CP">
		<input type="hidden" name="moeda" value="<?=$pagseguro['currency']?>">
		<input type="hidden" name="ref_transacao" value="<?php echo (int)$session_user_id; ?>">
		<input type="hidden" name="item_id_1" value="1">
		<input type="hidden" name="item_descr_1" value="<?=$pagseguro['product_name']?>">
		<input type="number" name="item_quant_1" min="1" step="4" value="1">
		<input type="hidden" name="item_peso_1" value="0">
		<input type="hidden" name="item_valor_1" value="<?=$pagseguro['price']?>">
		<input type="submit" value="  PURCHASE  ">
	</form>
	<br>
	<?php 
endif;
// PayGol
if ($config['paygol']['enabled'] == true):
	$paygol = $config['paygol'];
	?>
	<!-- PayGol Form using Post method -->
	<h2>Buy points using Paygol:</h2>
	<p><?php echo $paygol['price'] ." ". $paygol['currency'] ."~ for ". $paygol['points'] ." points:"; ?></p>
	<form name="pg_frm" method="post" action="http://www.paygol.com/micropayment/paynow" >
		<input type="hidden" name="pg_serviceid" value="<?php echo $paygol['serviceID']; ?>">
		<input type="hidden" name="pg_currency" value="<?php echo $paygol['currency']; ?>">
		<input type="hidden" name="pg_name" value="<?php echo $paygol['name']; ?>">
		<input type="hidden" name="pg_custom" value="<?php echo $session_user_id; ?>">
		<input type="hidden" name="pg_price" value="<?php echo $paygol['price']; ?>">
		<input type="hidden" name="pg_return_url" value="<?php echo $paygol['returnURL']; ?>">
		<input type="hidden" name="pg_cancel_url" value="<?php echo $paygol['cancelURL']; ?>">
		<input type="image" name="pg_button" src="http://www.paygol.com/micropayment/img/buttons/150/black_en_pbm.png" border="0" alt="Make payments with PayGol: the easiest way!" title="Make payments with PayGol: the easiest way!">
	</form>
	<?php
endif;
if (!$config['paypal']['enabled'] && !$config['paygol']['enabled'] && !$config['pagseguro']['enabled']):
	?>
	<h1>Buy Points system disabled.</h1>
	<p>Sorry, this functionality is disabled.</p>
	<?php
endif;
include 'layout/overall/footer.php';
?>