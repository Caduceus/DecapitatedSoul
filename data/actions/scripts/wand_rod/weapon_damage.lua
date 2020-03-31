-- Config
 
-- Set wand how the wand deals damage
DamageTypeWand = {
    values = true, -- If this is set to true then it will use the min and max values. If set to false the wand will use the formula
   
    -- Damage Values min/max
    wandMinDam = 2000,
    wandMaxDam = 5000,
   
    -- Damage Formula
    formula = {
        wandMinDam = function(level, maglevel) return -((level / 5) + (maglevel * 1.4) + 8) end,
        wandMaxDam = function(level, maglevel) return -((level / 5) + (maglevel * 2.2) + 14) end,
    }
}
 
-- Modal window config and storage id
local config = {
    storage = "10009",
    titleMsg = "Change Weapon Damage Type",
    mainMsg = "Choose a damage type from the list",
-- End Config
 
    -- Damage Table
    [1] = {element = "Death"},
    [2] = {element = "Earth"},
    [3] = {element = "Energy"},
    [4] = {element = "Fire"},
    [5] = {element = "Holy"},
    [6] = {element = "Ice"},
    [7] = {element = "Poison"},
}
 
 

 
 
function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    player:sendDamageWindow(config)
    return true
end
