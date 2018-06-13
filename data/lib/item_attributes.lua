function getItemAttribute(uid, key)
   local i = ItemType(Item(uid):getId())
   local string_attributes = {
     [ITEM_ATTRIBUTE_NAME] = i:getName(),
     [ITEM_ATTRIBUTE_ARTICLE] = i:getArticle(),
     [ITEM_ATTRIBUTE_PLURALNAME] = i:getPluralName(),
     ["name"] = i:getName(),
     ["article"] = i:getArticle(),
     ["pluralname"] = i:getPluralName()
   }

   local numeric_attributes = {
     [ITEM_ATTRIBUTE_WEIGHT] = i:getWeight(),
     [ITEM_ATTRIBUTE_ATTACK] = i:getAttack(),
     [ITEM_ATTRIBUTE_DEFENSE] = i:getDefense(),
     [ITEM_ATTRIBUTE_EXTRADEFENSE] = i:getExtraDefense(),
     [ITEM_ATTRIBUTE_ARMOR] = i:getArmor(),
     [ITEM_ATTRIBUTE_HITCHANCE] = i:getHitChance(),
     [ITEM_ATTRIBUTE_SHOOTRANGE] = i:getShootRange(),
     ["weight"] = i:getWeight(),
     ["attack"] = i:getAttack(),
     ["defense"] = i:getDefense(),
     ["extradefense"] = i:getExtraDefense(),
     ["armor"] = i:getArmor(),
     ["hitchance"] = i:getHitChance(),
     ["shootrange"] = i:getShootRange()
   }
   
   local attr = Item(uid):getAttribute(key)
   if tonumber(attr) then
     if numeric_attributes[key] then
       return attr ~= 0 and attr or numeric_attributes[key]
     end
   else
     if string_attributes[key] then
       if attr == "" then
         return string_attributes[key]
       end
     end
   end
return attr
end

function doItemSetAttribute(uid, key, value)
   return Item(uid):setAttribute(key, value)
end

function doItemEraseAttribute(uid, key)
   return Item(uid):removeAttribute(key)
end