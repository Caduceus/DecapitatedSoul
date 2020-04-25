function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local addCoins = math.random(1, 10)
	local function addScroll()
		player:addItem(1948, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Since You Only Won " ..addCoins .." Coin, Have A Free Double Experience Grant, On Us.")
		end
		
		if addCoins == 1 then
			addEvent(addScroll, 5 * 1000)
		end 
		
		player:setCoinsBalance(player:getCoinsBalance() + addCoins)
		player:setCoinsCareer(player:getCoinsCareer() + addCoins)
		player:say('' ..addCoins ..' Coins!', TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "" ..addCoins .." Coins Were Deposited Into Your Decapitated Soul Store Account.")
		Item(item.uid):remove(1)
		return true
	end
	