local ipBanDays = 7

function onSay(player, words, param)

	if not player:getGroup():getAccess() then
		return true
	end
	
	local resultId = db.storeQuery("SELECT `account_id`, `lastip` FROM `players` WHERE `name` = " .. db.escapeString(param))
	if resultId == false then
		return false
	end

	local ip = result.getDataLong(resultId, "lastip")
	result.free(resultId)

	local target = Player(param)
	if target:getAccountId() == 1 then
		player:sendCancelMessage('You cannot ip ban ' .. target:getName() .. '.')
		player:sendCancelMessage('' .. player:getName() .. ' tried to  ip ban you.')
		return false
	end

	local targetCid = getPlayerByName(param)
	if targetCid ~= false then
		ip = getIpByName(param)
		doRemoveCreature(targetCid)
	end

	if ip == 0 then
		return false
	end

	resultId = db.storeQuery("SELECT 1 FROM `ip_bans` WHERE `ip` = " .. ip)
	if resultId ~= false then
		result.free(resultId)
		return false
	end

	local timeNow = os.time()
	db.query("INSERT INTO `ip_bans` (`ip`, `reason`, `banned_at`, `expires_at`, `banned_by`) VALUES (" ..
			ip .. ", '', " .. timeNow .. ", " .. timeNow + (ipBanDays * 86400) .. ", " .. player:getGuid() .. ")")
	return false
end
