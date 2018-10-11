local t, i = {
--"[Server]: Please refrain from the use of Cavebots. If you choose to break the rules, then your character becomes fair game to any and all forms of Admin Power Abuse.",
--"[Server]: Set your Ambient Light to approximately 10-15%, for best visual experience.",
--"[Server]: Decapitated Soul needs your help! The server cannot continue without donations to cover host cost. Without your help, we cannot stay alive! ",
"[Server]: Melee weapons are setup as follows: Axe (pure dmg), Club (defensive), & Sword (neutral)",
"[Server]: Wands|Rods allow the use of several damage types by right clicking on the weapon. ", 
"[Server]: Blessings - [Free until level 80] Blessing Runes can be purchased from Brevans, located in the bottom of Purgatory Isle Temple. ", 
"[Server]: Daily Tokens can be used to purchase Bless and VIP. See Adonai or Zagorim to earn tokens!",
"[Server]: Coin timer will reset if logged out for more than 5 minutes. ",
"[Server]: Please check our downloads page for up to date spr/dat packs. OTC launcher will not update sprites. http://decapitatedsoul.servegame.com/downloads.php ",
"[Server]: Daily restarts at 12am server time. Check the clock in Drogheda temple for our current time. ",
}, 1

function onThink(interval)
    broadcastMessage(t[i], MESSAGE_EVENT_ORANGE)
    --sendChannelMessage(3, TALKTYPE_CHANNEL_R1, t[i])
    i = i == #t and 1 or i + 1
    return true
end

