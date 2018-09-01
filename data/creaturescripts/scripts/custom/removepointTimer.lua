function onThink(creature)
local offlinePlayer = creature:getId()
local lastLogout = creature:getLastLogout()
local offlineTime = lastLogout ~= 0 and math.min(os.time() - lastLogout, 86400 * 21) or 0
	if offlineTime < 3 then
		offlinePlayer:setStorageValue(455577, -1)
		print(creature:getStorageValue(455577))
	return true
	end
end