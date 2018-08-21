local destination = Position(1083, 996, 8)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  if isInArray({3058, 3059, 3065, 3066}, target.itemid) then
    target:moveTo(destination, false)
    --player:addItem(6500, math.random(1, 2)) 
    player:sendTextMessage(MESSAGE_INFO_DESCR, "This corpse went into Caduceus Manor basement!")
    return true
  end
  return false
end
