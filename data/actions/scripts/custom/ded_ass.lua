local destination = Position(1066, 990, 3)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  if isInArray({3058, 3059, 3065, 3066}, target.itemid) then
    target:moveTo(destination, false)
    --player:addItem(6500, math.random(1, 2)) 
    player:sendTextMessage(MESSAGE_INFO_DESCR, "This item is disabled until further notice!")
    return true
  end
  return false
end