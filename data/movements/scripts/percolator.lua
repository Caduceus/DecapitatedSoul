function onAddItem(moveitem, tileitem, position)
local player = Player(cid)
	if moveitem:getId() ~= 2574 then
		return false
	end
	if moveitem.type ~= 1 then
		return true
	end
    if tileitem.itemid == 6356 then
        moveitem:transform(moveitem.itemid, 20)
        position:sendMagicEffect(CONST_ME_POFF)
    elseif tileitem.itemid == 6358 then
        moveitem:transform(moveitem.itemid, 20)
        position:sendMagicEffect(CONST_ME_POFF)
     elseif tileitem.itemid == 6360 then
        moveitem:transform(moveitem.itemid, 20)
        position:sendMagicEffect(CONST_ME_POFF)
     elseif tileitem.itemid == 6362 then
        moveitem:transform(moveitem.itemid, 20)
        position:sendMagicEffect(CONST_ME_POFF)
    end
    return true
end
