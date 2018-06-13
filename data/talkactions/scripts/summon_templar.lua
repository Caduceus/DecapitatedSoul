function onSay(player, words, param)
local orig = player:getPosition()
local requiredLevel = 15
local mana = 200
local vocsCanUse = {9, 10, 15}
local canBeSummoned = {"templar"}
local summons = player:getSummons()

if summons >= 1 then
player:sendCancelMessage('You may not summon more than 1 creature.')
return true
end

if player:getLevel() < requiredLevel then
player:sendCancelMessage('Your level is too low.')
return true
end

if player:getMana() < mana then
player:sendCancelMessage('You do not have enough mana.')
return true
end

if(not isInArray(vocsCanUse, player:getVocation():getId())) then
player:sendCancelMessage('Your vocation cannot use this spell.')
return true
end

--if(not isInArray(canBeSummoned, param)) then
--player:sendCancelMessage('You cannot summon this creature.')
--return true
--end
local monster = Monster("templar")
doSummonCreature((isInArray(canBeSummoned, param)), orig)
monster:setMaster(player)
orig:sendMagicEffect(CONST_ME_MAGIC_RED)
return true
end