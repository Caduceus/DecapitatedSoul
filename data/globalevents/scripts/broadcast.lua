local t, i = {
"[Server]: Please refrain from the use of Cavebots. If you choose to break the rules, then your character becomes fair game to any and all forms of Admin Power Abuse.",
"[Server]: Set your Ambient Light to approximately 10-15%, for best visual experience.",
--"[Server]: Decapitated Soul needs your help! The server cannot continue without donations to cover host cost. Without your help, we cannot stay alive! ",
"[Server]: Knight: weapons are setup as follows: Axe (pure dmg), Club (defensive), & Sword (neutral)",
"[Server]: Sorcerer|Druid: Wands|Rods allow the use several damage types by right clicking on your weapon. ", 
"[Server]: Blessings - [Free until level 80] Blessing Runes can be purchased from Brevans, located in the bottom of Purgatory Isle Temple. ", 
}, 1

function onThink(interval)
    broadcastMessage(t[i], MESSAGE_EVENT_ORANGE)
    --sendChannelMessage(3, TALKTYPE_CHANNEL_Y, t[i])
    i = i == #t and 1 or i + 1
    return true
end

