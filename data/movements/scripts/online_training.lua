local training_exit = {
   [831] = {x = 1036, y = 933, z = 9, free = false}, -- Drogheda Trainers
   [832] = {x = 1280, y = 1178, z = 3}, -- Port Lonrich Temple
   [833] = {x = 98, y = 95, z = 6, free = false} -- no sp will be charged, useful if you want to execute anti-exit only
}
local confirm = false -- anti-exit
local usecode = false -- confirm with code
local antiafk_interval = 15 * 60 * 1000 -- 20 minutes after training started
local words = "!continue" -- command to continue
local prefix = "[AntiAfk]: "
local minutes_to_reply = 5 -- minutes to rewrite code
local code_storage = 800 -- code storage

-- should not be changed
local sid = 831 -- session id storage
local antiafk_marks = {"e", "€", "ó", "s", "z", "z", "c", "n", "~", "@", "#", "&", "_", "\"", "|", "`", ";", "'", ",", "E", "Ó", "A", "S", "L", "Z", "Z", "C", "N", "z", "s", "ß", "¸", "¨", "´", "·", "`", "°", "?", "?", "~", "¦", "d", "Ð", "§"}
antiafk_word = {}
local antiafk_string = {}

function onlineTraining_talkaction(cid, words, param)
   local p = Player(cid)
   local pos = p:getPosition()

   if not usecode then
     p:setStorageValue(sid, p:getStorageValue(sid) + 1)
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, prefix .. "Training time extended.")
     local ground = Tile(pos):getGround():getActionId()
     if training_exit[ground] then
       addEvent(skillAntiExit, antiafk_interval, cid, pos, p:getStorageValue(sid))
       p:addSoul(-1)
       checkTrainingTile(cid, pos, p:getStorageValue(sid), ground)
     end
     return true
   end
   
   if p:getStorageValue(code_storage) < 1 then
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "No code to rewrite.")
     return true
   end

   local pnum = tonumber(param) and tonumber(param) or 0
   if pnum ~= p:getStorageValue(code_storage) then
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, prefix .. "Incorrect code!")
     return true
   else
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, prefix .. "Code accepted.")
     p:setStorageValue(sid, p:getStorageValue(sid) + 1)
     p:setStorageValue(code_storage, 0)
     local ground = training_exit[Tile(pos):getGround():getActionId()]
     if ground then
       addEvent(skillAntiExit, antiafk_interval, cid, pos, p:getStorageValue(sid))
       addEvent(checkTrainingTile, 60000, cid, pos, p:getStorageValue(sid), ground)
     end
     return true
   end

   return true
end

function showTimeLeft(number, usewords)
   local number = tonumber(number)
   if not number then
     return "error"
   end

   if number < 0 then
     return "expired"
   end

   local clocknum = os.date("!%X",number):split(":") -- h:m:s
   local day = math.modf(number / 86400)
   local hour = clocknum[1]
   local minute = clocknum[2]
   local second = clocknum[3]

   if not usewords then
     return table.concat({day, hour, minute, second}, ":")
   end

   local text = {}
   if day > 0 then
     table.insert(text, tonumber(day) .. " day" .. (day > 1 and "s" or ""))
   end

   if hour ~= "00" then
     table.insert(text, tonumber(hour) .. " hour" .. (tonumber(hour) > 1 and "s" or ""))
   end

   if minute ~= "00" then
     table.insert(text, tonumber(minute) .. " minute" .. (tonumber(minute) > 1 and "s" or ""))
   end

   if second ~= "00" then
     table.insert(text, tonumber(second) .. " second" .. (tonumber(second) > 1 and "s" or ""))
   end

   countdown_text = ""
   if #text > 0 then
     countdown_text = text[1]
     for i = 2, #text - 1 do
       countdown_text = countdown_text .. ", " .. text[i]
     end
     if #text > 1 then
       countdown_text = countdown_text .. " and " .. text[#text]
     end
   else
     countdown_text = "expired"
   end
return countdown_text
end

function checkTrainingTile(cid, pos, nsid, actionid)
   local p = Player(cid)
   if not p then return true end
   local condition = p:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
    if condition and math.floor(condition:getTicks() / 1000 + 30 * 20) < 1200 then
		p:say('Chomp Chomp Chomp!', TALKTYPE_MONSTER_SAY)
		p:feed(30 * 20)
	end
   if getTopCreature(pos).uid == p:getId() and p:getStorageValue(sid) == nsid then
     if p:getSoul() < 1 then
       p:teleportTo(training_exit[actionid], false)
       Position(pos):sendMagicEffect(CONST_ME_TELEPORT)
       p:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You have used all of your available Soul Points.")
       Position(p:getPosition()):sendMagicEffect(CONST_ME_TELEPORT)
       p:remove()
       return true
     end
     p:addSoul(-1)
     addEvent(checkTrainingTile, 60000, cid, pos, nsid, actionid)
     return true
   end
   return true
end

function checkTrainingPlayer(cid, minutes, pos, nsid)
   local minutes = minutes - 1
   local p = Player(cid)
   if not p then
     return true
   end

   if p:getStorageValue(sid) ~= nsid then
     return true
   end

   if minutes < 1 then
     local npos = p:getPosition()
       if pos.x == npos.x and pos.y == npos.y and pos.z == npos.z then
         p:setStorageValue(code_storage, 0)
         p:remove()
       end
     return true
   end

   local bot_min_s = ""
   if antiafk_word[cid] and usecode then
     if minutes ~= 1 then bot_min_s = "s" end
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, prefix .. "Anti-afk test launched. You have " .. minutes .. " minute" .. bot_min_s .. " to prove that you are a human.")
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, prefix .. "Code: " .. table.concat(antiafk_word[cid]))
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, prefix .. "Type " .. words .. " with numbers only. Example: " .. words .. " 4502")
     addEvent(checkTrainingPlayer, 60000, cid, minutes, pos, nsid)
     return true
   else
     if minutes ~= 1 then bot_min_s = "s" end
     p:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, prefix .. "Type " .. words .. " or move your character or you will be kicked out in " .. minutes .. " minute" .. bot_min_s .. ".")
     addEvent(checkTrainingPlayer, 60000, cid, minutes, pos, nsid)
     return true
   end
return true
end

function skillAntiExit(cid, pos, nsid)
   local p = Player(cid)
   if not p then return true end
   if p:getStorageValue(sid) == nsid then
     local npos = p:getPosition()
     if pos.x == npos.x and pos.y == npos.y and pos.z == npos.z then
       if usecode then
         math.randomseed(os.time())
         antiafk_word[cid] = {}
         for i = 1, 6 do
           antiafk_word[cid][i] = antiafk_marks[math.random(1, #antiafk_marks)]
         end
      
         antiafk_string[cid] = {}
         for i = 1, 4 do
           table.insert(antiafk_word[cid], math.random(1, #antiafk_word[cid]), math.random(0, 9))
         end

         for i = 1, #antiafk_word[cid] do
           if tonumber(antiafk_word[cid][i]) ~= nil then
             table.insert(antiafk_string[cid], antiafk_word[cid][i])
           end
         end
      
         p:setStorageValue(code_storage, tonumber(table.concat(antiafk_string[cid])))
       end    
       checkTrainingPlayer(cid, minutes_to_reply + 1, pos, nsid)
     end
   end
   return true
end

local waitTime = os.time() + 10
function onStepIn(player, item, position, fromPosition)

if player:getGroup():getAccess() then
		return true
	end
	
if player:getStorageValue(830) > os.time() then
		player:teleportTo(fromPosition, false)
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You cannot enter yet!")
				doSendMagicEffect(pos, CONST_ME_POOF)
		return false
	end
	 
   local cid = player:getId()
   local p = player
   if not p then return true end
   local pos = p:getPosition()

   p:setStorageValue(sid, p:getStorageValue(sid) + 1)
   if confirm then
     addEvent(skillAntiExit, antiafk_interval, cid, pos, p:getStorageValue(sid))
   end

   if training_exit[item.actionid].free then
     return true
   end

   if p:getSoul() < 1 then
     p:teleportTo(training_exit[item.actionid], false)
     Position(pos):sendMagicEffect(CONST_ME_POFF)
     p:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have enough Soul Points to train.")
     Position(p:getPosition()):sendMagicEffect(CONST_ME_TELEPORT)
     return true
   end

   Position(pos):sendMagicEffect(CONST_ME_MAGIC_GREEN)
   p:sendTextMessage(MESSAGE_INFO_DESCR, "Training started.\nCost: 1 SP per minute.\nYou have " .. showTimeLeft(p:getSoul() * 60, true) .. " of training time left.")
   p:addSoul(-1)
   addEvent(checkTrainingTile, 60000, cid, pos, p:getStorageValue(sid), item.actionid)
   return true
end

function onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player == nil then
		return true
	end
	if player:getGroup():getAccess() then
		return true
	end

	player:setStorageValue(830, os.time() + 10)
	return true
end