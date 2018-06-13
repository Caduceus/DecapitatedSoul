local config = {
	deleteAccountWithNoPlayers = true,
    log = true,
    file = "data/logs/cleanplayers.txt"
}

function countRowsWhereInTable(table, field, condition)
    --local result = db.storeQuery("SELECT COUNT(" .. field .. ") as count FROM " .. table .. " WHERE " .. field .. " = '" .. condition .. "';")
    local tmp = result:getDataInt("count")
    result:free()
    return tmp
end

local function doWriteLogFile(file, text)
    local f = io.open(file, "a+")
    if not f then
        return false
    end

    f:write("[" .. os.date("%m/%d/%Y %H:%M:%S") .. "] " .. text .. "\n")
    f:close()
    return true
end

local cleanup = {
		[1] = {level = 11, time = 10 * 24 * 60 * 60},
		[2] = {level = 20, time = 20 * 24 * 60 * 60},
		[3] = {level = 50, time = 30 * 24 * 60 * 60},
		[4] = {level = 100, time = 60 * 24 * 60 * 60},
		[5] = {level = 130, time = 90 * 24 * 60 * 60},
		[6] = {level = 200, time = 120 * 24 * 60 * 60},
		[7] = {level = 300, time = 180 * 24 * 60 * 60}
	}
	

function onStartup()
local dropCount = {players={},accounts={}}
local logs = "Players Deleted:\n"
    for i = 7, #cleanup do
		resultId = db.storeQuery("SELECT `id`,`name`,`level`,`lastlogin` FROM `players` WHERE `level` <= ".. cleanup[i].level .." AND `name` NOT IN('Rook Sample', 'Sorcerer Sample', 'Druid Sample', 'Paladin Sample', 'Knight Sample', 'Templar Sample') AND `group_id` < 2 AND `lastlogin` < UNIX_TIMESTAMP() - ".. cleanup[i].time ..";")
    if resultId == false then
        logs = string.format("%sThere were no players to delete.\n", logs)
    else
        repeat
                local id = result.getNumber(resultId, "id")
                local name = result.getString(resultId, "name")
                local level = result.getNumber(resultId, "level")
                local lastLogin = result.getNumber(resultId, "lastlogin")

                logs = string.format("%s%s - %d - %s\n", logs, name, level, lastLogin ~= 0 and os.date("%a %b %d %Y %X", lastLogin) or "Never")
                db.query("DELETE FROM `players` WHERE `id` = " .. id)
                db.query("DELETE FROM `znote_players` WHERE `player_id` = " .. id)
                
            until not result.next(resultId)
            result.free(resultId)
    end
    
    --[[SELECT COUNT(id) as count FROM `players` WHERE `account_id` = '..';]]
    --[[db.query("DELETE FROM `players` WHERE `id` = " .. id)]]
    local aid = {}
    local accounts = {
			[1] = {table = "`accounts`", idField = "`id`"}
	}
    
	if config.deleteAccountWithNoPlayers then
		for acc = 1, #aid do
			result1 = db.storeQuery("SELECT `id` FROM `accounts` WHERE `id` = '" .. aid[acc] .. "';")
			if result1:getID() ~= -1 then -- check to make sure the account exists
				--result1:free()
				for i = 1, #accounts do
					result1 = db.storeQuery("SELECT COUNT(id) as count FROM `players` WHERE `account_id` = '" .. aid[acc] .. "';")
					tmp = result1:getDataInt("count")
					if(tmp <= 0) then
						dropCount.accounts[i] = ((dropCount.accounts[i] or 0) + countRowsWhereInTable(accounts[i].table, accounts[i].idField, aid[acc]))
						db.query("DELETE FROM `accounts` WHERE `id` = " .. aid[acc] .. "';")
                
					end
				end
			end
		end
	end
		

    if config.log then
        doWriteLogFile(config.file, logs)
    end

    return true
	end
end