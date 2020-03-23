function onSay(player, words, param)
	local count = getPlayerInstantSpellCount(player)
	local text = ""
	local t = {}
	for i = 0, count - 1 do
		local spell = getPlayerInstantSpellInfo(player, i)
		if spell.level ~= 0 then
			if spell.manapercent > 0 then
				spell.mana = spell.manapercent .. "%"
			end
			t[#t+1] = spell
		end
	end
	table.sort(t, function(a, b) return a.level < b.level end)
	for i, spell in ipairs(t) do
		local line = ""
		if spell.level <= player:getLevel() then
			if i ~= 1 then
				line = "\n"
			end
			line = line .. "Spells for Level " .. spell.level .. "\n"
			prevLevel = spell.level
		end
		text = text .. line .. "  " .. spell.words .. " - " .. spell.name .. "\n"
	end
	player:showTextDialog(2175, text)
	return false
end

