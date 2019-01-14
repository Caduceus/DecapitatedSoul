function onSay(player, words, param)
	if not player:getAccountId() == 1 then
		return false
	end
	local time = 1552910400 - os.time()
        local days, hours, minutes, seconds = math.floor (time / 86400), math.floor ((time - ((math.floor (time / 86400)) * 86400))/ 3600), math.floor ((time - ((math.floor (time / 3600)) * 3600))/ 60), time - ((math.floor (time/60)) * 60)
        if time >= 86400 then
            text = days.." "..(days == 1 and "day" or "days")..", "..hours.." "..(hours == 1 and "hour" or "hours")..", "..minutes.." "..(minutes == 1 and "minute" or "minutes").." and "..seconds.." "..(seconds == 1 and "second" or "seconds")
        elseif time >= 3600 then
            text = hours.." "..(hours == 1 and "hour" or "hours")..", "..minutes.." "..(minutes == 1 and "minute" or "minutes").." and "..seconds.." "..(seconds == 1 and "second" or "seconds")
        elseif time >= 60 then
            text = minutes.." "..(minutes == 1 and "minute" or "minutes").." and "..seconds.." "..(seconds == 1 and "second" or "seconds")
        else
            text = seconds.." "..(seconds == 1 and "second" or "seconds")
        end
         
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Start the Appalachian Trail: "..text..".")
        --sendChannelMessage(2, TALKTYPE_CHANNEL_R1, "Start the Appalachian Trail: "..text..".")
    return true
end
