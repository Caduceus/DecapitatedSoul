local storage = 0000
function onUse(cid, item, fromPosition, itemEx, toPosition)
    if getPlayerStorageValue(cid, storage) == 1 then
        doPlayerSendTextMessagel(cid, MESSAGE_STATUS_SMALL, 'You have already completed this quest.)
        return false
    end
    return true
end