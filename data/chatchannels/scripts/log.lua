function canJoin(player)
	return player:getAccountType() >= ACCOUNT_TYPE_TUTOR
end

function onSpeak(player, type, message)
	local playerAccountType = player:getAccountType()
    local staff = player:getGroup():getAccess()
    local guild = player:getGuild()
    type = TALKTYPE_CHANNEL_Y
    
	 local nameTags = ""
    if playerAccountType >= ACCOUNT_TYPE_GAMEMASTER then
        nameTags = nameTags .. " † ".. player:getLevel() .." † [Dev]"
			type = TALKTYPE_CHANNEL_R1
		end
    
    if playerAccountType == ACCOUNT_TYPE_SENIORTUTOR then
        nameTags = nameTags .. " † ".. player:getLevel() .." † [Senior Tutor]" 
            type = TALKTYPE_CHANNEL_O
        end
        
    if playerAccountType == ACCOUNT_TYPE_TUTOR then
        nameTags = nameTags .. " † ".. player:getLevel() .." † [Tutor]" 
     end

    sendChannelMessage(2, type, player:getName() .. nameTags .. ": " .. message)
    return false

end
