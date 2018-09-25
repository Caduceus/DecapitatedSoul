local looktypes = {
	128, 136, 129, 137, 130, 138, 131, 139, 132, 140, 133, 141, 134, 142,
	143, 147, 144, 148, 145, 149, 146, 150, 151, 155, 152, 156, 153, 157,
	154, 158, 251, 252, 268, 269, 273, 270, 278, 279, 289, 288, 325, 324,
	335, 336, 366, 367, 328, 329, 430, 431, 432, 433, 463, 464, 465, 466,
	471, 472, 512, 513, 514, 516, 541, 542, 574, 575, 577, 578, 619, 620,
	632, 633, 634, 635, 636, 637, 664, 665, 666, 667, 683, 684, 694, 695, 
	696, 697, 698, 699, 724, 725, 732, 733, 749, 750, 745, 746, 759, 760, 
	845, 846, 852, 853, 873, 874, 899, 900, 908, 909, 929, 931, 955, 956,
    958, 1022, 1023, 1025, 1026
} 

function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local target
	if param == '' then
		target = player:getTarget()
		if not target then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Gives players the ability to wear all addons. Usage: /addons <player name>')
			return false
		end
	else
		target = Player(param)
	end

	if not target then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Player ' .. param .. ' is currently not online.')
		return false
	end

	if target:getAccountType() > player:getAccountType() then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Cannot perform action.')
		return false
	end

	for i = 1, #looktypes do
		target:addOutfitAddon(looktypes[i], 3)
	end

	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'All addons unlocked for ' .. target:getName() .. '.')
	target:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, '[Server] All addons unlocked.')
	return false
end
