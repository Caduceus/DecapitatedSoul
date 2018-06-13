local config = {
     storage = 45395,
     exstorage = 40825,
     days = {
         ["Monday"] = {
             {itemid = 7737, count = {1}}, --purple bag.
             {itemid = 9076, count = {1}},  --red bag
             {itemid = 7739, count = {1}}, --golden bag
         },
         ["Tuesday"] = {
             {itemid = 7737, count = {1}}, --purple bag.
             {itemid = 9076, count = {1}},  --red bag
             {itemid = 7739, count = {1}}, --golden bag
         },
         ["Wednesday"] = {
             {itemid = 7737, count = {1}}, --purple bag.
             {itemid = 9076, count = {1}},  --red bag
             {itemid = 7739, count = {1}}, --golden bag
         },
         ["Thursday"] = {
             {itemid = 7737, count = {1}}, --purple bag.
             {itemid = 9076, count = {1}},  --red bag
             {itemid = 7739, count = {1}}, --golden bag
         },
         ["Friday"] = {
			{itemid = 7737, count = {1}}, --purple bag.
             {itemid = 9076, count = {1}},  --red bag
             {itemid = 7739, count = {1}}, --golden bag
         },
         ["Saturday"] = {
             {itemid = 7737, count = {1}}, --purple bag.
             {itemid = 9076, count = {1}},  --red bag
             {itemid = 7739, count = {1}}, --golden bag
         },
         ["Sunday"] = {
			 {itemid = 7737, count = {1}}, --purple bag.
             {itemid = 9076, count = {1}},  --red bag
             {itemid = 7739, count = {1}}, --golden bag
         }
     }
}

function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey)
     local player = Player(cid)
     local x = config.days[os.date("%A")]
     if player:getStorageValue(config.storage) == tonumber(os.date("%w")) and player:getStorageValue(config.exstorage) > os.time() then
         return player:sendCancelMessage("Come back tomorrow.")
     end
     if math.random(25) == 1 then -- 10% chance to fail
		 doPlayerSendCancel(cid, "No treat for you. Only trick..")
		 setPlayerStorageValue(cid, config.storage, tonumber(os.date("%w")))
		 exhaustion.set(cid, config.exstorage, 24*60*60)
     return true
	 end
     local c = math.random(#x)
     local info, count = ItemType(x[c].itemid), x[c].count[2] and math.random(x[c].count[1], x[c].count[2]) or x[c].count[1]
     if count > 1 then
         text = count .. " " .. info:getPluralName()
     else
         text = info:getArticle() .. " " .. info:getName()
     end
     local itemx = Game.createItem(x[c].itemid, count)
     if player:addItemEx(itemx) ~= RETURNVALUE_NOERROR then
         player:getPosition():sendMagicEffect(CONST_ME_POFF)
         text = "You have found a reward weighing " .. itemx:getWeight() .. " oz. It is too heavy or you have not enough space."
     else
         text = "You have received " .. text .. "."
         player:setStorageValue(config.storage, tonumber(os.date("%w")))
         player:setStorageValue(config.exstorage, os.time() + 24*60*60)
     end
     player:sendTextMessage(MESSAGE_INFO_DESCR, text)
     return true
end