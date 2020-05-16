local transformTo = {
	[1479] = 1480,[1480] = 1479,         -- Street Lamp
	[2037] = 2038,[2038] = 2037,         -- Wall Lamp
	[2039] = 2040,[2040] = 2039,         -- Wall Lamp
	[2058] = 2059,[2059] = 2058,         -- Torch Bearer
	[2060] = 2061,[2061] = 2060,         -- Torch Bearer
	[2064] = 2065,[2065] = 2064,         -- Table Lamp
	[2066] = 2067,[2067] = 2066,         -- Wall Lamp
	[2068] = 2069,[2069] = 2068,         -- Wall Lamp
	[3943] = 3944,[3944] = 3943,         -- torch bearer
	[3945] = 3946,[3946] = 3945,         -- torch bearer
	[3947] = 3948,[3948] = 3947,         -- Bamboo Wall Lamp
	[3949] = 3950,[3950] = 3949,         -- Bamboo Wall Lamp
	[9575] = 9576,[9576] = 9575,         -- Street lamp
	[9577] = 9578,[9578] = 9577,         -- Street lamp
	[9579] = 9580,[9580] = 9579,         -- Street lamp
	[9581] = 9582,[9582] = 9581,         -- Street lamp
	[9747] = 9748,[9748] = 9747,         -- Wall lamp
	[9749] = 9750,[9750] = 9749,         -- Wall lamp
	[9838] = 9839,[9839] = 9838,         -- Wall Lamp
	[9840] = 9841,[9841] = 9840,         -- Wall Lamp
	[9842] = 9843,[9843] = 9842,         -- Wall Lamp
	[9844] = 9845,[9845] = 9844,         -- Wall Lamp
	[9972] = 9973,[9973] = 9972,	     -- small lamp
	[10971] = 10972,[10972] = 10971,     -- Wall lamp
    [10973] = 10974,[10974] = 10973,     -- Wall lamp
    [11995] = 11996,[11996] = 11995,     -- Wall lamp
    [11997] = 11998,[11998] = 11997,     -- Wall lamp
    [12191] = 12192,[12192] = 12191,     -- Wall Torch
    [12200] = 12201,[12201] = 12200,     -- Wall Torch
    [12208] = 12209,[12209] = 12208,     -- Wall Torch
    [12210] = 12211,[12211] = 12210,     -- Wall Torch
    [13688] = 13689,[13689] = 13688,     -- Wall Torch
    [13690] = 13691,[13691] = 13690,     -- Wall Torch
    [15121] = 15124,[15124] = 15121,     -- Wall lamp
    [15122] = 15123,[15123] = 15122,     -- Wall lamp
    [15125] = 15126,[15126] = 15125,     -- Strange lamp
    [15127] = 15128,[15128] = 15127,     -- Strange lamp
    [15129] = 15130,[15130] = 15129,     -- lamp
    [15131] = 15132,[15132] = 15131,     -- lamp
    [15133] = 15134,[15134] = 15133,     -- lamp
    [15135] = 15136,[15136] = 15135,     -- lamp
    [19695] = 19696,[19696] = 19695,     -- candle
    [18049] = 18050,[18050] = 18049,	 -- light source
    [18051] = 18052,[18052] = 18051,	 -- light source
    [18388] = 18389,[18389] = 18388,	 -- crystal lamp
    [18391] = 18392, -- Item decays	     -- glowing mushroom
	[19689] = 19690,[19690] = 19689,     -- street lamp
	[19691] = 19692,[19692] = 19691,	 -- glowing mushroom
    [19695] = 19696,[19696] = 19695,     -- candle
	[19697] = 19698,[19698] = 19697,     -- candle
    [22429] = 22430,[22430] = 22429,     -- bamboo wall lamp
    [22431] = 22432,[22432] = 22431,     -- bamboo wall lamp
    [22614] = 22615,[22615] = 22614,     -- nightmare beacon
    [22868] = 22869,[22869] = 22868,     -- street lamp
    [22870] = 22871,[22871] = 22870,     -- street lamp
    [22872] = 22873,[22873] = 22872,     -- candle
    [22874] = 22875,[22875] = 22874,     -- candle
    [25390] = 25391,[25391] = 25390,     -- rift lamp
    [27090] = 27091,[27091] = 27090,     -- black skull candle
    [27867] = 27889,[27868] = 27866,     -- Vengothic Lamp
    [29628] = 29629,[29629] = 29630,	 -- torch of change
    [29630] = 29631,[29631] = 29628,	 -- torch of change
    [29643] = 29644,[29644] = 29643,	 -- pile of alchemistic books
    [30286] = 30269,[30269] = 30286,	 -- Hand lamp
    [30287] = 30285,[30285] = 30287,	 -- Hand lamp
    [30305] = 30283,[30283] = 30305,	 -- Hand lamp
    [30306] = 30284,[30284] = 30306,	 -- Hand lamp
    [30329] = 30331,[30331] = 30329,	 -- Desk lamp
    [30330] = 30332,[30332] = 30330,     -- Desk lamp
    [30730] = 30731,[30731] = 30730,     -- angler fish lamp
    [30960] = 30961,[30961] = 30960,	 -- fluorescent fungi
    [30962] = 30963,[30963] = 30962,	 -- luminescent fungi
    [30964] = 30965,[30965] = 30964,	 -- glowing sulpher fungi
    [30966] = 30967,[30967] = 30966,	 -- gloomy sulpher fungi
    [31521] = 31522,[31522] = 31521,	 -- street lamp
    [34651] = 34652,[34652] = 34651,	 -- curly hortensis lamp
    [34653] = 34654,[34654] = 34653,	 -- little big flower lamp
    [34673] = 34674,[34674] = 34673,	 -- wall lamp
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
    [35335] = 35336,[35336] = 35335,     -- ice chandelier
    [35356] = 35357,[35357] = 35356,     -- wall lamp
    [35358] = 35359,[35359] = 35358,     -- torch bearer
    [35360] = 35361,[35361] = 35360,     -- bamboo wall lamp
    [35362] = 35363,[35363] = 35362,     -- wall candle
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
	if player:getGroup():getAccess() then
		item:transform(transformItem)
		--player:sendTextMessage(MESSAGE_INFO_DESCR, "Admin Access! No Storage Value.")
		return true
	elseif player:getStorageValue(Storage.lightBearerComplete) ~= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "SoL! Try after Lightbringer quest!")
		return false
	end

    item:transform(transformItem)
    return true
end
