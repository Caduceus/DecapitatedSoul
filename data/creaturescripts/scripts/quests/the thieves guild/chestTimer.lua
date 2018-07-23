local storage = Storage.thievesGuild.BarbarianQueenChest
local cooldownStorage = Storage.thievesGuild.BarbarianQueenCooldown
function onThink(creature)
	if creature:getStorageValue(storage) == os.time() then
			creature:teleportTo(Position(1068, 1005, 10))
			creature:setStorageValue(cooldownStorage, os.time() + 24*60*60)
			creature:sendTextMessage(MESSAGE_INFO_DESCR, "Your 5 minutes are up! You may try again tomorrow.") 
		return true
    end
end
    