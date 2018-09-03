local destination = Position(1040, 952, 8)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  if isInArray({3058, 3059, 3065, 3066}, target.itemid) then
    target:moveTo(destination, false)
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Corpse sent to storage.")
    return true
  end
  return false
end
