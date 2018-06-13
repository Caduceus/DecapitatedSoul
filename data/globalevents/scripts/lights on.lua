local t, msg = {
        {x = 934, y = 954, z = 14, stackpos = 2}, -- Street Lights on the Map
        {x = 934, y = 964, z = 14, stackpos = 2},
        {x = 934, y = 975, z = 14, stackpos = 2} -- No Comma Needed on the Last Light
}, " "
 
function onTime()
        for i = 1, #t do
                local light = getTileItemById(t[i], 1479).uid
                if(light > 0) then
                        doTransformItem(light, 1480)
                end
        end
 
        addEvent(broadcastMessage, 150, t.msg, MESSAGE_STATUS_DEFAULT)
        return true
end