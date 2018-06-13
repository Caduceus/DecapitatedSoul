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
    [1] = {element = "Holy"},
    [2] = {element = "Fire"},
    [3] = {element = "Death"},
    [4] = {element = "Poison"},
    [5] = {element = "Energy"},
    [6] = {element = "Earth"},
    [7] = {element = "Ice"},
}
 
function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    player:sendDamageWindow(config)
    return true
end