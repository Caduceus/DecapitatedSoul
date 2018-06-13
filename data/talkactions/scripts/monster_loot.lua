local myFile = "data/monster/monsters.xml"


local function getMonsterFile(name)
local name, file = tostring(name), nil
if (io.open(myFile, "r") ~= nil) then
for line in io.lines(myFile) do
if (line:find(name) and not (line:find("<!--"))) then
	n = string.match(line, 'name=".*".*')
	_name = string.sub(n, string.find(n, '="') + 2, string.find(n, '" ') - 1)
if name:len() == _name:len() then
f = string.match(line, 'file=".*".*')
file = string.sub(f, string.find(f, '="') + 2, string.find(f, '"/') - 1)
			end
		end
	end
end
return file
end

function onSay(cid, words, param, channel)
local player = Player(cid)
		if player == nil then
			return false
		end

local file = getMonsterFile(param)
local name, file = tostring(name), nil
local loot = {}
local t = 0
local text = "Monster File: " .. file .. ""

if file then
	file = "data/monster/" .. file
end

if (io.open(file, "r") ~= nil) then
for line in io.lines(file) do
if (line:find('id=".*".*')) then
	line = string.match(line, 'id=".*".*')
	lootid = string.sub(line, string.find(line, '="') + 2, string.find(line, '" ') - 1)
	table.insert(loot, lootid)
	end
end
text = text .. "\n"
for _, i in ipairs(loot) do
t = t + 1
text = text .. "\n " .. t .. ". " .. getItemName(i)
end
player:popupFYI(text)
else
if file == nil then
player:popupFYI("Sorry, monster name is wrong.")
end
return true
	end
end
