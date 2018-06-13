local config = {
  level = 30,
  storage = 30018
}

function onAdvance(player, skill, oldlevel, newlevel)
  local vocation = player:getVocation()
  local promotion = vocation:getPromotion()
  
if player:getStorageValue(config.storage) == 1 then
  return false
else
  if player:isPlayer() and skill == SKILL_LEVEL then
      if player:getLevel() >= config.level then
          player:setVocation(promotion)
          player:setStorageValue(config.storage, 1)
          player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have gained an outstanding amount of trust with Soraya, young adventurer.\nShe has awarded you with a promotion to ".. player:getVocation():getName() .."!")
          player:save()
         end
      end
   end
end

