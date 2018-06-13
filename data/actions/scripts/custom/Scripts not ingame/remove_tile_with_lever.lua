Tiles = {}

function Tiles:new(pos)
    local mt = setmetatable(pos, {__index = Tiles})
    return mt
end

function Tiles:storeID(tab)
    if not self.storedID then
        local tile = Tile(self)
        local tileitem = tile:getGround()
        self.storedID =    tileitem:getId()
        self.tileitem = tileitem
        self.storedtab = {}
        if tab then
            for i, id in ipairs(tab) do
                local item = tile:getItemById(id)
                if item and item:getId() > 1 then
                    self.storedtab[item:getId()] = {item, item:getPosition()}
                end
            end
        end
    end
end

function Tiles:changeID(itemid, count)
    if self.tileitem then
        self.tileitem:transform(itemid, count)
        for id, item in pairs(self.storedtab) do
            item[1]:remove()
        end
    end
end

function Tiles:restoreID()
    if self.tileitem and self.storedID then
        self.tileitem:transform(self.storedID)
        for id, item in pairs(self.storedtab) do
            self.storedtab[id] = {Item(doCreateItem(id, 1, item[2])), item[2]}
        end
        return self.storedID
    end
end

local postable = {
[1] = Tiles:new({x=129, y = 422, z=7}),
[2] = Tiles:new({x=130, y = 422, z=7}),
[3] = Tiles:new({x=129, y = 423, z=7}),
[4] = Tiles:new({x=130, y = 423, z=7})
}
local levers = {
[1] = {x=128, y=425, z=7},
[2] = {x=128, y=420, z=7},
}

function getLever(pos)
    local lever = Tile(pos):getItemById(1945) or Tile(pos):getItemById(1946) or false
    return lever
end

local bridgeId = 5770

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
    local item = item
    if item:getId() == 1945 then
        for i, tile in ipairs(postable) do
            tile:storeID({7666, 7834})
            tile:changeID(bridgeId)
        end
        getLever(levers[1]):transform(1946)
        getLever(levers[2]):transform(1946)
    elseif item:getId() == 1946 then
        for i, tile in ipairs(postable) do
            tile:restoreID()
        end
        getLever(levers[1]):transform(1945)
        getLever(levers[2]):transform(1945)
    end
    return true
end