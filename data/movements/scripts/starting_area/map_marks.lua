local storage = 45555
local marks = {
    [1]={{x=1018,y=939,z=7},"Temple",MAPMARK_TEMPLE},
    [2]={{x=1057,y=931,z=7},"Cyclops",MAPMARK_STAR},
    [3]={{x=1054,y=1158,z=7},"Hatchlings",MAPMARK_STAR},
    [4]={{x=1136,y=1152,z=7},"Dragons",MAPMARK_STAR},
    [5]={{x=941,y=1136,z=7},"Vampires",MAPMARK_STAR},
    [6]={{x=1163,y=1184,z=7},"Dragon Lords",MAPMARK_STAR},
    [7]={{x=1041,y=903,z=8},"Catacombs Entrance",MAPMARK_EXCLAMATION},
    [8]={{x=970,y=1050,z=7},"Heros",MAPMARK_STAR},
    [9]={{x=1015,y=933,z=7},"Shops - Upstairs",MAPMARK_BAG},
    [10]={{x=1031,y=940,z=9},"Banker",MAPMARK_DOLLAR},
    
}

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
     
     
	if player:getStorageValue(storage) == 3 then
		return false
	end
	if player:getStorageValue(storage) <= 2 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Your map has been marked with points of interest.")
		player:setStorageValue(storage, 3)
				
		for i = 1, #marks do
			player:addMapMark(marks[i][1],marks[i][3],marks[i][2])
		end
		end
end