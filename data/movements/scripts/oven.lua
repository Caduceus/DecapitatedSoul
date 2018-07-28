function onAddItem(moveitem, tileitem, position)
	if moveitem:getId() ~= 13757 then
		return false
	end
    if tileitem.itemid == 6357 then
        tileitem:transform(6356)
        moveitem:remove(1)
        position:sendMagicEffect(CONST_ME_FIREAREA)
    elseif tileitem.itemid == 6359 then
        tileitem:transform(6358)
        moveitem:remove(1)
        position:sendMagicEffect(CONST_ME_FIREAREA)
     elseif tileitem.itemid == 6361 then
        tileitem:transform(6360)
        moveitem:remove(1)
        position:sendMagicEffect(CONST_ME_FIREAREA)
     elseif tileitem.itemid == 6363 then
        tileitem:transform(6362)
        moveitem:remove(1)
        position:sendMagicEffect(CONST_ME_FIREAREA)
    end
    return true
end
