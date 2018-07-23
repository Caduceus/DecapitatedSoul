local notePos = Position(1273, 1178, 3)

local function removeNote(position)
	local noteItem = Tile(position):getItemById(6122)
	if noteItem then
		noteItem:remove()
	end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.actionid ~= 12509 then
		return false
	end

local note = Game.createItem(6122, 1, notePos)
	if player:getStorageValue(Storage.thievesGuild.Mission08) == 1 then
		--player:removeItem(8701, 1)
		note:setAttribute(ITEM_ATTRIBUTE_TEXT, "Decapitated Soul Bish!")
		--player:setStorageValue(Storage.thievesGuild.Mission08, 2)
		addEvent(removeNote, 5 * 60 * 1000, notePos)
	end
	return true
end
