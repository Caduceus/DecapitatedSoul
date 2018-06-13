local config = {
	[7737] = { -- loot bags halloween
		{itemid = 2687, count = {2, 10}}, --cookies
		{itemid = 9005, count = {2, 10}}, --gummy worm
		{itemid = 6569, count = {2, 10}}, --candy
		{itemid = 2097, count = {1}}, --pumpkin head
		{itemid = 2683, count = {1}}, --pumpkin
		{itemid = 6574, count = {1, 10}} --choc bars (do not stack)
	},
	[7739] = { -- loot bags halloween
		{itemid = 2687, count = {2, 10}}, --cookies
		{itemid = 9005, count = {2, 10}}, --gummy worm
		{itemid = 6569, count = {2, 10}}, --candy
		{itemid = 2097, count = {1}}, --pumpkin head
		{itemid = 2683, count = {1}}, --pumpkin
		{itemid = 6574, count = {1, 10}}, --choc bars (do not stack)
		{itemid = 24740, count = {1}} --wolf backpack 
	},
	[9076] = { -- loot bags halloween
		{itemid = 2687, count = {2, 10}}, --cookies
		{itemid = 9005, count = {2, 10}}, --gummy worm
		{itemid = 6569, count = {2, 10}}, --candy
		{itemid = 2097, count = {1}}, --pumpkin head
		{itemid = 2683, count = {1}}, --pumpkin
		{itemid = 6574, count = {1, 10}}, --choc bars (do not stack)
		{itemid = 10570, count = {1}} --witch hat
	}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local present = config[item.itemid]
	if not present then
		return false
	end

local x = config[item.itemid]
local c = math.random(#x)
     local info, count = ItemType(x[c].itemid), x[c].count[2] and math.random(x[c].count[1], x[c].count[2]) or x[c].count[1]
     if count > 1 then
         text = count .. " " .. info:getPluralName()
     else
         text = info:getArticle() .. " " .. info:getName()
     end
     --local itemx = Game.createItem(x[c].itemid, count)
     if player:addItem(present, count) ~= RETURNVALUE_NOERROR then
		player:addItem(x[c].itemid, count)
         player:getPosition():sendMagicEffect(CONST_ME_SMALLCLOUDS)
         item:remove(1)
     else
         text = "You have received " .. text .. "."
     end
     player:sendTextMessage(MESSAGE_INFO_DESCR, text)
     return true
end