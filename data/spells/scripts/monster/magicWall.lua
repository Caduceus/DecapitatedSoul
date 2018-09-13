local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_MAGICWALL)

function onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end
local id = 8753
local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_CREATEITEM, id)

function tile_timer(id, pos, delay, color)
	if getTileItemById(pos, id).uid == 0 then
		return true
	end
	
	if delay ~= 1 then
		addEvent(tile_timer, 1000, id, pos, delay - 1, color)
	end
   
	local people = Game.getSpectators(pos, 7, 7, 5, 5, false, true)
	if not people then
		return true
	end
	
function onCastSpell(creature, var, isHotkey)
	local c = combat:execute(creature, var)
	if c then
		local pos = variantToPosition(var)
	end
	return c
end
