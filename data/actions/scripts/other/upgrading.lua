local conf = {
   ["level"] = {
   -- [item_level] = {successPercent= CHANCE TO UPGRADE ITEM, downgradeLevel = ITEM GETS THIS LEVEL IF UPGRADE FAILS}
     [1] = {successPercent = 85, downgradeLevel = 0},
     [2] = {successPercent = 85, downgradeLevel = 1},
     [3] = {successPercent = 85, downgradeLevel = 2},
     [4] = {successPercent = 85, downgradeLevel = 3},
     [5] = {successPercent = 85, downgradeLevel = 4},
     [6] = {successPercent = 85, downgradeLevel = 5},
     [7] = {successPercent = 85, downgradeLevel = 5},
     [8] = {successPercent = 85, downgradeLevel = 6},
     [9] = {successPercent = 85, downgradeLevel = 8},
     [10] = {successPercent = 85, downgradeLevel = 9}
   },

   ["upgrade"] = { -- how many percent attributes are rised?
     attack = 5, -- attack %
     defense = 5, -- defense %
     extraDefense = 10, -- extra defense %
     armor = 10, -- armor %
     hitChance = 5, -- hit chance %
   }
}



-- // do not touch // --
-- Upgrading system by Azi [Ersiu] --
-- Edited for TFS 1.1 by Zbizu --

local upgrading = {
  upValue = function (value, level, percent)
  if value < 0 then return 0 end
     if level == 0 then return value end
     local nVal = value
     for i = 1, level do
       nVal = nVal + (math.ceil((nVal/100*percent)))
     end
  return nVal > 0 and nVal or value
  end,

  getLevel = function (item)
  local name = Item(item):getName():split('+')
     if (#name == 1) then
       return 0
     end
  
     return math.abs(name[2])
  end,
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    cid = player:getId()
    itemEx = target
   local it = ItemType(itemEx.itemid)
  if (((it:getWeaponType() > 0 and it:getWeaponType() ~= WEAPON_WAND) or getItemAttribute(itemEx.uid, ITEM_ATTRIBUTE_ARMOR) > 0)) then 
  local level = upgrading.getLevel(itemEx.uid)
  if(level < #conf["level"])then
  local nLevel = (conf["level"][(level+1)].successPercent >= math.random(1,100)) and (level+1) or conf["level"][level].downgradeLevel
  if(nLevel > level)then
  doSendMagicEffect(toPosition, CONST_ME_MAGIC_GREEN)
  doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Upgrade to level " .. nLevel .. " successful!")
  else
  doSendMagicEffect(toPosition, CONST_ME_BLOCKHIT)
  doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Upgrade failed. Your " .. it:getName() .. " is now on level " .. nLevel .. "")
  end
  doItemSetAttribute(itemEx.uid, ITEM_ATTRIBUTE_NAME, it:getName()..((nLevel>0) and "+"..nLevel or ""))
  doItemSetAttribute(itemEx.uid, ITEM_ATTRIBUTE_ATTACK,  upgrading.upValue(it:getAttack(), nLevel, conf["upgrade"].attack))
  doItemSetAttribute(itemEx.uid, ITEM_ATTRIBUTE_DEFENSE, upgrading.upValue(it:getDefense(), nLevel, conf["upgrade"].defense))
  doItemSetAttribute(itemEx.uid, ITEM_ATTRIBUTE_EXTRADEFENSE, upgrading.upValue(it:getExtraDefense(), nLevel, conf["upgrade"].extraDefense))
  doItemSetAttribute(itemEx.uid, ITEM_ATTRIBUTE_ARMOR, upgrading.upValue(it:getArmor(), nLevel, conf["upgrade"].armor))
  doItemSetAttribute(itemEx.uid, ITEM_ATTRIBUTE_HITCHANCE, upgrading.upValue(it:getHitChance(), nLevel, conf["upgrade"].hitChance))
  doRemoveItem(item.uid, 1)
  else
  doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Your " .. it:getName() .. " is on max level already.")
  end
  else
  doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You cannot upgrade this item.")
  end
end
