function onAddItem(moveitem, tileitem, position)
		if moveitem:getId() ~= 2051 then
		return false
	end
    if tileitem.itemid == 24342 then
        moveitem:transform(24343)
        tileitem:remove()
        position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
    return true
end