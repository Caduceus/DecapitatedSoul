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

local myTable = {}

function getXMLValues(str, values, ignored)
if type(values) == 'table' then
for _, i in ipairs(values) do
for _, x in ipairs(ignored) do
if not (str:find(x)) then
if (str:find(i)) then
t = string.match(str, i .. '=".*".*')
_t = string.find(t, '" ') or string.find(t, '"/') or string.find(t, '">')
info = string.sub(t, string.find(t, '="') + 2, _t - 1)
table.insert(myTable, info)
end
end
end
end
end
return myTable
end

function onSay(cid, words, param, channel)
local file, txt = getMonsterFile(param), "Monster Info\n\n"
if file then
file = "data/monster/" .. file
if (io.open(file, "r") ~= nil) then
for line in io.lines(file) do
vals = 
{
'<monster name', 
'race',
'experience',
'speed',
'manacost',
'<health now',
'<flag summonable',
'<flag convinceable'
}
ignore = 
{
'name="speed"'
}
info = getXMLValues(line, vals, ignore)
end
infos = 
{
"Name = ",
"Race = ",
"Base Experience = ",
"Speed = "
}
for _i, i in ipairs(infos) do
txt = txt .. i .. info[_i] .. "\n"
end
txt = txt .. "Hitpoints = " .. info[6] .. "\n"
s, c = tonumber(info[7]), tonumber(info[8])
txt = txt .. "Summoneable = " .. (s == 1 and "Yes" or "No") .. "\n"
txt = txt .. "Convinceable = " .. (c == 1 and "Yes" or "No") .. "\n"
if (s == 1 or c == 1) then
txt = txt .. "Mana cost = " .. info[5] .. "\n"
end
doPlayerPopupFYI(cid, txt)
myTable = {}
end
else
doPlayerPopupFYI(cid, "Sorry, monster name is wrong.")
end
return true
end