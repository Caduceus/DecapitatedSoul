local waterIds = {493, 4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625}

local special_fishes = {2669, 7158,7159,}

local monsters = {
"Crab",
"Tortoise",
"Blood Crab",
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
   
   if not isInArray(waterIds, target.itemid) then
       return false
   end
   
   toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
   if player:getItemCount(3976) >= 1 then
       player:addSkillTries(SKILL_FISHING, 1)
   else
       return true
   end
   player_skill = player:getEffectiveSkillLevel(SKILL_FISHING)
   if math.random(1, 100) <= math.min(math.max(10 + (player_skill - 10) * 0.597, 10), 50) then
       if not player:removeItem(3976, 1) then
           return true
       end
       
       if math.random <= 100 then
           Game.createMonster(monsters[math.random(#monsters)], player:getPosition())
       else
           if item.itemid == 2580 then
               special_chance = player_skill*0.1
           elseif item.itemid == 10223 then
               special_chance = player_skill*0.3
           end
           if math.random(1, 100) <= special_chance then
               player:addItem(special_fishes[math.random(#special_fishes)], 1)
           else
               player:addItem(2667, 1)
           end
       end
       
   end
   return true
end