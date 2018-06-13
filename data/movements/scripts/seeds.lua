function onAddItem(moveitem, tileitem, position)
		if moveitem:getId() ~= 7732 then
		return false
	end
    if tileitem.itemid == 7655 then
        moveitem:transform(7673)
        tileitem:remove()
        position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
    return true
end