local t, i = {
"[Vlad]: !shitbroke",
"[Caduceus]: ..i..",
"[Caduceus]: shit out of luck",
"[Vlad]: That fixed yet?", 
"[Caduceus]: SHIT NOT BROKE!!!", 
}, 1

function onThink(interval)
    --broadcastMessage(t[i], MESSAGE_EVENT_ORANGE)
    sendChannelMessage(2, TALKTYPE_CHANNEL_Y, t[i])
    print("> > Caduceus: ..i.. SHIT NOT BROKE! < <")
    i = i == #t and 1 or i + 1
    return true
end

