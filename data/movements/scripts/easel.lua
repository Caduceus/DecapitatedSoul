function onAddItem(moveitem, tileitem, position)
	if moveitem:getId() ~= 16018 then
		return false
	end
    if tileitem.itemid == 16020 then
        tileitem:transform(16022)
        moveitem:remove(1)
        position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    elseif tileitem.itemid == 16021 then
        tileitem:transform(16023)
        moveitem:remove(1)
        position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
    return true
end
