local CHANNEL_HELP = 3

local muted = Condition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT)
muted:setParameter(CONDITION_PARAM_SUBID, CHANNEL_HELP)
muted:setParameter(CONDITION_PARAM_TICKS, 3600000)

function onSpeak(player, type, message)
    local playerAccountType = player:getAccountType()
    local staff = player:getGroup():getAccess()
    local guild = player:getGuild()
    type = TALKTYPE_CHANNEL_Y

    if player:getCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_HELP) then
        player:sendCancelMessage("You are muted from the World Chat for using it inappropriately.")
        return false
    end

    if playerAccountType >= ACCOUNT_TYPE_TUTOR then
        if string.sub(message, 1, 6) == "!mute " then
            local targetName = string.sub(message, 7)
            local target = Player(targetName)
            if target ~= nil then
                if playerAccountType > target:getAccountType() then
                    if not target:getCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_HELP) then
                        target:addCondition(muted)
                        sendChannelMessage(CHANNEL_HELP, TALKTYPE_CHANNEL_R1, target:getName() .. " has been muted by " .. player:getName() .. " for using the World Chat inappropriately.")
                    else
                        player:sendCancelMessage("That player is already muted.")
                    end
                else
                    player:sendCancelMessage("You are not authorized to mute that player.")
                end
            else
                player:sendCancelMessage(RETURNVALUE_PLAYERWITHTHISNAMEISNOTONLINE)
            end
            return false
        elseif string.sub(message, 1, 8) == "!unmute " then
            local targetName = string.sub(message, 9)
            local target = Player(targetName)
            if target ~= nil then
                if playerAccountType > target:getAccountType() then
                    if target:getCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_HELP) then
                        target:removeCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_HELP)
                        sendChannelMessage(CHANNEL_HELP, TALKTYPE_CHANNEL_R1, target:getName() .. " has been unmuted by " .. player:getName() .. ".")
                    else
                        player:sendCancelMessage("That player is not muted.")
                    end
                else
                    player:sendCancelMessage("You are not authorized to unmute that player.")
                end
            else
                player:sendCancelMessage(RETURNVALUE_PLAYERWITHTHISNAMEISNOTONLINE)
            end
            return false
        end
    end

    local nameTags = ""
    --if playerAccountType >= ACCOUNT_TYPE_GAMEMASTER then
    if player:getAccountId() == 1 then
        nameTags = nameTags .. " † ".. player:getLevel() .." † [Dev]"
			type = TALKTYPE_CHANNEL_R1
		end
    
    --if playerAccountType == ACCOUNT_TYPE_SENIORTUTOR then
    if player:getAccountId() == 2 then
        nameTags = nameTags .. " † ".. player:getLevel() .." † [Staff]" 
            type = TALKTYPE_CHANNEL_O
        end
        
    if playerAccountType == ACCOUNT_TYPE_TUTOR then
        nameTags = nameTags .. " † ".. player:getLevel() .." † [Tutor]" 
            type = TALKTYPE_CHANNEL_Y
        end
        
    if playerAccountType < ACCOUNT_TYPE_TUTOR then
		if guild then
        nameTags = nameTags .. " [".. player:getLevel() .."] ["..guild:getName().."]" 
    else
        nameTags = nameTags .. " [".. player:getLevel() .."]"
        end 
     end

    sendChannelMessage(3, type, player:getName() .. nameTags .. ": " .. message)
    return false

end