local storage = Storage.thievesGuild.BarbarianQueenChest
function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
    if item.actionid == 16022 then
		if player:getStorageValue(storage) > os.time() then
			return true
	elseif player:getStorageValue(storage) < os.time() then
		player:setStorageValue(storage, os.time() + 2*10)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have 5 minutes to open the chest. Better hurry!")
		return true
		end
	end
end
