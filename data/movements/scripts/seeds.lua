function onAddItem(moveitem, tileitem, position)
	if moveitem:getId() ~= 7732 then
		return false
	end
    if tileitem.itemid == 7655 then
        tileitem:transform(7673)
        moveitem:remove(1)
        position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
    return true
end
