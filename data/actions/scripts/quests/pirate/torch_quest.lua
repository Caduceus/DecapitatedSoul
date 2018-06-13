local marks = {
    [1]={{x=1151,y=1238,z=7},"Map",MAPMARK_STAR},
    [2]={{x=1194,y=1243,z=7},"Map",MAPMARK_STAR},
    [3]={{x=1218,y=1288,z=7},"Map",MAPMARK_STAR},
    [4]={{x=1145,y=1320,z=7},"Map",MAPMARK_STAR}    
}


--item:setAttribute(ITEM_ATTRIBUTE_TEXT, "type something here")
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
--[[if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:say('You cant teleport whilst in battle!', TALKTYPE_MONSTER_SAY)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end]]
    
    if player:getStorageValue(2239) < 3 or player:getStorageValue(2239) > 3 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "This chest is locked.")
    elseif player:getStorageValue(2239) == 3 then
        player:addItem(9956, 1)
        player:addItem(2239, 1):setAttribute(ITEM_ATTRIBUTE_TEXT,"You have found a magical torch! Use it to burn maps, which are scattered throughout the Bay.")
        player:setStorageValue(2239, 4)
        
        for i = 1, #marks do
        player:addMapMark(marks[i][1],marks[i][3],marks[i][2])
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end
