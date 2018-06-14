function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item:isItem() == nil then
return false
else
	return destroyItem(player, target, toPosition)
	end
end