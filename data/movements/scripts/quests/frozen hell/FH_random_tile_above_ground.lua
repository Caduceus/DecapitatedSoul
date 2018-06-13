local storage = 15009
local t = {
{x = 537, y = 1188, z = 8},
{x = 542, y = 1238, z = 8},
{x = 471, y = 1284, z = 8},
{x = 541, y = 1346, z = 8}
}
function onStepIn(cid, item, position, fromPosition)
 local player = Player(cid)
    if not player then
        return true
    end

if player:getStorageValue(storage) == 1 then
			return true
		end
    
local v = t[math.random(#t)]
player:teleportTo(v)
player:getPosition():sendMagicEffect(CONST_ME_STUN)
player:sendCancelMessage('You better watch your step.')
end