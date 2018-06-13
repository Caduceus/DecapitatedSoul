local config = {
  ["medusa snake"] = {chance = 50000, boss = "Snake God Essence", msg = "How Dare You!"}, --100k = 100%
}

function onDeath(creature, target, player, corpse, mostDamage)
local random_chance = math.random(100000)
local targetPosition = target:getPosition()
   if creature:isMonster() then
     local Monster = config[creature:getName():lower()]
     if Monster then
         if Monster.chance >= random_chance then
             target:getPosition():sendMagicEffect(CONST_ME_POFF)
             Game.createMonster(Monster.boss:lower(), targetPosition)
             --player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, Monster.msg)
             player:sendTextMessage(MESSAGE_EVENT_ADVANCE, Monster.msg)
         end
     end
 end
   return true
 end