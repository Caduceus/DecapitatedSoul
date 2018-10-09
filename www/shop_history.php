<?php require_once 'engine/init.php';
protect_page();
include 'layout/overall/header.php';
$session_user_id = (int)$session_user_id;
$paypal_transactions = mysql_select_multi("SELECT `account_id`, `payment_state`, `transaction_state`, `price`, `currency`, `points`, `email`, `time_created`, `time_updated` FROM `znote_paypal` WHERE `account_id`='{$session_user_id}';");
// data_dump($paypal_transactions, false, "data");
?>

<h1>Shop history</h1>
<p>This is an overview of your shopping history with us.</p>

<h2>Paypal transactions</h2>
<table class="table tbl-hover">
	<tbody>
		<tr class="yellow">
			<td>Created</td>
			<td>Payment</td>
			<td>Transaction</td>
			<td>Price</td>
			<td>Email</td>
			<td>Updated</td>
		</tr>
		<?php
		foreach ($paypal_transactions as $transaction):
			$state = ($transaction['transaction_state'] !== null) ? $transaction['transaction_state'] : 'waiting for user';
			$email = ($transaction['email'] !== null) ? $transaction['email'] : 'Unknown';
			?>
			<tr>
				<td><?php echo getClock(strtotime($transaction['time_created']), true); ?></td>
				<td><?php echo $transaction['payment_state']; ?></td>
				<td><?php echo $state; ?></td>
				<td><?php echo $transaction['points']." coins for ".$transaction['price']." ".$transaction['currency']; ?></td>
				<td><?php echo $email; ?></td>
				<td><?php echo getClock(strtotime($transaction['time_updated']), true); ?></td>
			</tr>
			<?php
		endforeach;
		?>
	</tbody>
</table>

<?php include 'layout/overall/footer.php'; ?>