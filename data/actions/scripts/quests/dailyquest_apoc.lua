local config = {
     storage = 45393,
     exstorage = 40823,
     days = {
         ["Monday"] = {
             {itemid = 2804, count = {1, 3}}, --shadow herb.
             {itemid = 13581, count = {1}},  --dread doll
             {itemid = 18422, count = {4, 8}}, --daily token
             {itemid = 7591, count = {1, 30}} --scaling health potion
         },
         ["Tuesday"] = {
             {itemid = 7591, count = {1, 30}}, --scaling health potion.
             {itemid = 6500, count = {1, 10}}, --demonic essence.
             {itemid = 2390, count = {1}}, --magic longsword
             {itemid = 18422, count = {2, 4}}, --daily token
             {itemid = 2130, count = {1}} --golden amulet.
         },
         ["Wednesday"] = {
             {itemid = 8472, count = {1, 30}}, --scaling spirit potion.
             {itemid = 18422, count = {2, 4}}, --daily token
             {itemid = 7890, count = {100, 200}}, --magma amulet
             {itemid = 5080, count = {1}} --panda teddy
         },
         ["Thursday"] = {
             {itemid = 8472, count = {1, 30}}, --scaling spirit potion.
             {itemid = 2447, count = {1}}, --twin axe
             {itemid = 2798, count = {1, 10}}, --blood herb
             {itemid = 18422, count = {2, 4}}, --daily token
             {itemid = 7590, count = {1, 30}} --scaling mana potion
         },
         ["Friday"] = {
			 {itemid = 8472, count = {1, 30}}, --scaling spirit potion.
             {itemid = 2804, count = {1, 3}}, --shadow herb.
             {itemid = 18422, count = {4, 8}}, --daily token
             {itemid = 20129, count = {1}} --skull shatterer
         },
         ["Saturday"] = {
             {itemid = 6553, count = {1}}, --ruthless axe 
             {itemid = 18422, count = {4, 8}}, --daily token
             {itemid = 7591, count = {1, 30}} --scaling health potion
         },
         ["Sunday"] = {
			 {itemid = 7590, count = {1, 30}}, --scaling mana potion
             {itemid = 7894, count = {1}}, --magma legs 
             {itemid = 22612, count = {1}}, --demonic tapestry.
             {itemid = 18422, count = {2, 4}}, --daily token
         }
     }
}

function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey)
     local player = Player(cid)
     local x = config.days[os.date("%A")]
     if player:getStorageValue(config.storage) == tonumber(os.date("%w")) and player:getStorageValue(config.exstorage) > os.time() then
         return player:sendCancelMessage("The chest is empty, come back tomorrow for a new reward.")
     end
     if math.random(25) == 1 then -- 10% chance to fail
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
