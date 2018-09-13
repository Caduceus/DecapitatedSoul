function onThink(creature)
--local soul = creature:getSoul()
	if creature:getIp() == 0 then
		creature:teleportTo(creature:getTown():getTemplePosition())
		--creature:addSoul(-soul)
		sendChannelMessage(9, TALKTYPE_CHANNEL_R1, ">> " .. creature:getName() .. " was kicked for X log or lost connection. " .. os.date("%m/%d/%Y at %H:%M:%S") .. "")
		print(">> " .. creature:getName() .. " was kicked for X log or lost connection. " .. os.date("%m/%d/%Y at %H:%M:%S") .. "")
		creature:remove()
	end
	return true
end