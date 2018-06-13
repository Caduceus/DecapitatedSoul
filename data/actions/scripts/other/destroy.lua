function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
if item:isItem() == nil then
return false
else
	return destroyItem(cid, target, toPosition)
	end
end
