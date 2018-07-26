function onAddItem(moveitem, tileitem, position)
	if moveitem:getId() ~= 16018 then
		return false
	end
    if tileitem.itemid == 16020 then
        moveitem:transform(16022)
        tileitem:remove()
        position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    elseif tileitem.itemid == 16021 then
        moveitem:transform(16023)
        tileitem:remove()
        position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
    return true
end
