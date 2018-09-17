function canJoin(player)
	return player:getAccountType() >= ACCOUNT_TYPE_TUTOR
end

function onSpeak(player, type, message)
	local playerAccountType = player:getAccountType()
    type = TALKTYPE_CHANNEL_Y
    
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
     end

    sendChannelMessage(2, type, player:getName() .. nameTags .. ": " .. message)
    return false

end
