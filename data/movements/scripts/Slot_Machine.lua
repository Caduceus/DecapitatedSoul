function onAddItem(moveitem, tileitem, position)
    if not isInArray({100,101,102,103,104}, moveitem.actionid) then
        doRemoveItem(moveitem.uid)
        doSendMagicEffect(position, CONST_ME_POFF)
    end
    return TRUE
end