local function scanContainer(cid, position)
    local player = Player(cid)
    if not player then
        return
    end
    local corpse = Tile(position):getTopDownItem()
    if not corpse or not corpse:isContainer() then
        return
    end
    if corpse:getType():isCorpse() and corpse:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == cid then
        for a = corpse:getSize() - 1, 0, -1 do
            local containerItem = corpse:getItem(a)
            if containerItem then
                for b = AUTOLOOT_STORAGE_START, AUTOLOOT_STORAGE_END do
                    if player:getStorageValue(b) == containerItem:getId() then
                        containerItem:moveTo(player)
                    end
                end
                
    local g1 = containerItem:getCount()
    local g2 = containerItem:getCount() * 1.1 / 10
    local g3 = (containerItem:getCount() * 100) * 1.1 / 10
    local g4 = (containerItem:getCount() * 1000) * 1.1 / 10
    local g5 = (containerItem:getCount() * 10000) * 1.1 / 10
        
        if player:isVip() then
                if isItemStackable(containerItem:getId()) then
                                       
 
                    if containerItem:getId() == 2148 then
                        containerItem:remove()
                        doPlayerSetBalance(player, getPlayerBalance(player) + (containerItem:getCount() * 1.1))
                    player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Gold Coins: "..g1.." (+ "..g2.." Vip Bonus).")
 
                    end
                    if containerItem:getId() == 2152 then
                        containerItem:remove()
                        doPlayerSetBalance(player, getPlayerBalance(player) + ((containerItem:getCount() * 100) * 1.1))
                        player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Platinum Coins: "..g1.." (+ "..g3.." Vip Bonus).")
 
 
                    end
                    if containerItem:getId() == 2160 then
                        containerItem:remove()
                        doPlayerSetBalance(player, getPlayerBalance(player) + ((containerItem:getCount() * 1000) * 1.1))
                    player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Crystal Coins: "..g1.." (+ "..g4.." Vip Bonus).")
 
 
                    end
                    if containerItem:getId() == 15515 then
                        containerItem:remove()
                        doPlayerSetBalance(player, getPlayerBalance(player) + ((containerItem:getCount() * 10000) * 1.1))
                    player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Gold Bar: "..g1.." (+ "..g5.." Vip Bonus).")
 
 
                    end
            end
        end
       
        if not player:isVip() then
                if isItemStackable(containerItem:getId()) then	
						
 
                   if containerItem:getId() == 2148 then
                        containerItem:remove()
                        doPlayerSetBalance(player, getPlayerBalance(player) + containerItem:getCount())
                    player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Gold Coins: "..g1.." deposited.")
                    end
                    if containerItem:getId() == 2152 then
                        containerItem:remove()
                        doPlayerSetBalance(player, getPlayerBalance(player) + (containerItem:getCount() * 100))
                        player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Platinum Coins: "..g1.." deposited.")
                    end
                    if containerItem:getId() == 2160 then
                        containerItem:remove()
                        doPlayerSetBalance(player, getPlayerBalance(player) + (containerItem:getCount() * 1000))
                    player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Crystal Coins: "..g1.." deposited.")
                    end
            end
        end
           
           
           
           
        end
    end
end
end
function onKill(player, target)
    if not target:isMonster() then
        return true
    end
    addEvent(scanContainer, 100, player:getId(), target:getPosition())
    return true
end