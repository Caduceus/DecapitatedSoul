local fromPositions = {
{x = 1013, y = 952, z = 7},
{x = 1022, y = 952, z = 7},
{x = 1013, y = 959, z = 7},
{x = 1022, y = 959, z = 7}
}

local targetPosition = {x = 1019, y = 957, z = 7}
local targetPosition2 = {x = 1019, y = 957, z = 4}
function onThink(interval, lastExecution)
for _, fromPosition in pairs(fromPositions) do
doSendMagicEffect(fromPosition, CONST_ME_POFF)
doSendDistanceShoot(fromPosition, targetPosition, CONST_ANI_ENERGY)
doSendDistanceShoot(fromPosition, targetPosition2, CONST_ANI_ENERGY)
end
doSendMagicEffect(targetPosition, CONST_ME_YELLOWENERGY)
doSendMagicEffect(targetPosition2, CONST_ME_HOLYAREA)
return true
end