local id = ITEM_WILDGROWTH
local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
combat:setParameter(COMBAT_PARAM_CREATEITEM, id)

function onCastSpell(creature, var, isHotkey)
	local c = combat:execute(creature, var)
	if c then
		local pos = variantToPosition(var)
		addEvent(removeMw, 40000, pos, id)
		tile_timer(id, pos, 40, TEXTCOLOR_LIGHTGREEN)
	end
	return c
end