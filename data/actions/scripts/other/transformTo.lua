local transformTo = {
    [18551] = 18550,    				 -- Noble Sword
    [27867] = 27868,[27868] = 27866,     -- Vengothic Lamp
    [28829] = 28831,[28830] = 28832,     -- Demon Pet
    [29629] = 29630,[29630] = 29631,	 -- torch of change
    [29631] = 29629,	 				 -- torch of change
    [30329] = 30331,[30331] = 30329,	 -- Desk lamp
    [30330] = 30332,[30332] = 30330,     -- Desk lamp
    [34719] = 34721,[34721] = 34719,     -- Model Ship Lamp
    [34720] = 34722,[34722] = 34720,     -- Model Ship Lamp
    [34723] = 34725,[34725] = 34723,     -- Model Ship Lamp
    [34724] = 34726,[34726] = 34724,     -- Model Ship Lamp
    [34913] = 34922,[34922] = 34913,     -- Blue Diner Candelabra
    [34914] = 34923,[34923] = 34914,     -- Blue Diner Candelabra
    [34915] = 34919,[34919] = 34915,     -- Red Diner Candelabra
    [34916] = 34920,[34920] = 34916,     -- Blue Diner Candelabra
    [34917] = 34921,[34921] = 34917,     -- Green Diner Candelabra
    [34918] = 34924,[34924] = 34918,     -- Green Diner Candelabra
    [35364] = 35890,[35365] = 35364,     -- Sweatheart lamp (heart)
    [35366] = 35891,[35367] = 35366,     -- Swaetheart lamp large
    [35368] = 35892,[35369] = 35368,     -- Swaetheart lamp small
    [35593] = 35595,[35595] = 35593,     -- Idol Lamp
    [35594] = 35596,[35596] = 35594      -- Idol Lamp
}
 
function onUse(player, item, fromPosition, target, toPosition, isHotkey)

local transformItem = transformTo[item.itemid]
    if not transformItem then
		return false
	end
 
    item:transform(transformItem)
    return true
end
