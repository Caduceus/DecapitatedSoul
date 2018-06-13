local storage = 15009
local t = {
{x = 455, y = 1286, z = 9},
{x = 444, y = 1270, z = 9},
{x = 536, y = 1274, z = 9},
{x = 547, y = 1259, z = 9},
{x = 551, y = 1290, z = 10},
{x = 568, y = 1232, z = 10}
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