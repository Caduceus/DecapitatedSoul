local quest_storage = 45556
local t = {
{x = 655, y = 1349, z = 10},
{x = 670, y = 1407, z = 10},
{x = 599, y = 1426, z = 8},
{x = 540, y = 1385, z = 8},
{x = 540, y = 1385, z = 8},
{x = 540, y = 1385, z = 8}
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local v = t[math.random(#t)]
if player:getStorageValue(quest_storage) < 10 then 
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "Your soul is not yet attuned to an evil of this caliber!")
				doSendMagicEffect(pos, CONST_ME_POOF)
else
if item.itemid == 1945 then
	player:teleportTo(v)
	player:getPosition():sendMagicEffect(CONST_ME_STUN)
	player:sendCancelMessage('Are you there yet?')
	end
	item:transform(item.itemid == 1945 and 1946 or 1945)
    return true 
    end
end