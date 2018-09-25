local transformTo = {
    [27667] = 27665,     --Vengothic Lamp
    [18551] = 18550     --Noble Sword
}
 
function onUse(player, item, fromPosition, target, toPosition, isHotkey)

local transformItem = transformTo[item.itemid]
    if not transformItem then
		return false
	end
 
    item:transform(transformItem)
    return true
end
