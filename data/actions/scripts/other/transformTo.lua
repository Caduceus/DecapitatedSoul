local transformTo = {
    [18551] = 18550,    				 -- Noble Sword
    [28829] = 28831,[28830] = 28832,     -- Demon Pet
    [35926] = 35927,[35928] = 35929,     -- Baby Bonelord
}
 
function onUse(player, item, fromPosition, target, toPosition, isHotkey)

local transformItem = transformTo[item.itemid]
    if not transformItem then
		return false
	end
 
    item:transform(transformItem)
    return true
end
