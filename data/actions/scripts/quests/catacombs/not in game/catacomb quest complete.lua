local pos = {
    altar = Position({x=1239, y=1099, z=10}),
    stand = Position({x = 1238, y = 1099, z = 10}),
    teleportTo = Position({x = 1160, y = 1070, z = 8})
}

function onUse(creature, item, fromPosition, target, toPosition, isHotkey)
    if item.itemid == 1945 and creature:isPlayer() then
        local topItem = Tile(pos.altar):getTopVisibleThing(creature)
        if topItem.itemid == 5943 then
            if creature:getPosition():getDistance(pos.stand) == 0 then
                topItem:remove()
                creature:addItem(24774, 1)
                creature:sendTextMessage(MESSAGE_INFO_DESCR, "You have completed the Catacombs Quest!")
                creature:teleportTo(pos.teleportTo)
                Game.broadcastMessage("Congratulations to ".. creature:getName() .." for completing the Catacombs Quest")
            end
        end
    end
    item:transform(item.itemid == 1945 and 1946 or 1945)
    return true
end