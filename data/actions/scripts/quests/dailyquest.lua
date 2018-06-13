local config = {
     storage = 45392,
     exstorage = 40822,
     days = {
         ["Monday"] = {
             {itemid = 8839, count = {1, 3}},
             {itemid = 12418, count = {1}},
             {itemid = 2362, count = {1, 3}},
             {itemid = 12639, count = {1, 10}},
             {itemid = 18422, count = {1, 2}}, --daily token
             {itemid = 8472, count = {1, 30}} --scaling spirit potion
         },
         ["Tuesday"] = {
             {itemid = 2681, count = {1}},
             {itemid = 2682, count = {1}},
             {itemid = 2683, count = {1}},
             {itemid = 12415, count = {1}},
             {itemid = 18422, count = {1, 2}}, --daily token
             {itemid = 7590, count = {1, 30}} --scaling mana potion
         },
         ["Wednesday"] = {
             {itemid = 2674, count = {1, 10}},
             {itemid = 2675, count = {1, 10}},
             {itemid = 2676, count = {1, 10}},
             {itemid = 2673, count = {1, 10}},
             {itemid = 18422, count = {1, 2}} --daily token
         },
         ["Thursday"] = {
             {itemid = 2679, count = {2, 15}},
             {itemid = 2680, count = {1, 5}},
             {itemid = 18422, count = {1, 2}}, --daily token
             {itemid = 8472, count = {1, 30}} --scaling spirit potion
         },
         ["Friday"] = {
             {itemid = 2788, count = {1, 3}},
             {itemid = 18397, count = {1}},
             {itemid = 18422, count = {1, 2}}, --daily token
             {itemid = 7591, count = {1, 30}} --scaling health potion
         },
         ["Saturday"] = {
             {itemid = 6393, count = {1}},
             {itemid = 6574, count = {1}},
             {itemid = 18422, count = {1, 2}}, --daily token
             {itemid = 7590, count = {1, 30}} --scaling mana potion
         },
         ["Sunday"] = {
             {itemid = 9114, count = {2, 12}},
             {itemid = 2690, count = {1, 5}},
             {itemid = 18422, count = {1, 2}}, --daily token
             {itemid = 7591, count = {1, 30}} --scaling health potion
         }
     }
}

function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey)
     local player = Player(cid)
     local x = config.days[os.date("%A")]
     if player:getStorageValue(config.storage) == tonumber(os.date("%w")) and player:getStorageValue(config.exstorage) > os.time() then
         return player:sendCancelMessage("The chest is empty, come back tomorrow for a new reward.")
     end
     if math.random(10) == 1 then -- 10% chance to fail
		 doPlayerSendCancel(cid, "Sorry, no reward today, come back tomorrow.")
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
