local aurastr = 25950 -- storage of aura
local estr = 25951 -- storage for exhaust
local porcentagem = 50 -- chance to heal in every turn of the aura, in percentage
local quantheal = 20 -- max health will be divided by this number
local tempo = 1180 -- time to go around the player (this time was what I found most visually pleasing, it is recommended not to change)
local tipoaura = 38 -- effect of number aura (distance effect, can be identified by !x in the game) 37
local efeitocura = 49 -- effect curing when the number reaches the player (fixed position effect, can be identified with !z in the game)

-- calling function the aura
function Aura(i,tm, cid)
    local player = Player(cid)
    if not player then
        return
    end
   
    local atual = player:getPosition()
    local posaura = {
        {x=(atual.x)-1, y=(atual.y)-1, z=atual.z},
        {x=atual.x, y=(atual.y)-1, z=atual.z},
        {x=(atual.x)+1, y=(atual.y)-1, z=atual.z},
        {x=(atual.x)+1, y=atual.y, z=atual.z},
        {x=(atual.x)+1, y=(atual.y)+1, z=atual.z},
        {x=atual.x, y=(atual.y)+1, z=atual.z},
        {x=(atual.x)-1, y=(atual.y)+1, z=atual.z},
        {x=(atual.x)-1, y=atual.y, z=atual.z},
    }
    local chances = math.random(100)
    if(chances<=porcentagem/8 and player:getHealth() < player:getMaxHealth()) then
        player:addHealth(player:getMaxHealth()/quantheal)
        local pos
        if(i<=8 and i>1) then
            pos = Position({x=posaura[i].x, y=posaura[i].y, z=posaura[i].z})
        else
            pos = Position({x=posaura[1].x, y=posaura[1].y, z=posaura[1].z})
        end
        if pos then
            pos:sendDistanceEffect(atual, tipoaura)
        end
        atual:sendMagicEffect(efeitocura)
    end
    local pos
    if(i==8) then
        pos = Position({x=posaura[i].x, y=posaura[i].y, z=posaura[i].z})
        pos:sendDistanceEffect(Position({x=posaura[1].x, y=posaura[1].y, z=posaura[1].z}), tipoaura)
    elseif(i<8) then
        pos = Position({x=posaura[i].x, y=posaura[i].y, z=posaura[i].z})
        pos:sendDistanceEffect(Position({x=posaura[i+1].x, y=posaura[i+1].y, z=posaura[i+1].z}), tipoaura)
    end
    if(i<=8 and player:getStorageValue(aurastr)==2) then
        i = i+1
        tm = tempo/8
        return addEvent(Aura,tm,i,tm,player:getId())
    elseif(i>8 and player:getStorageValue(aurastr)==2) then
        return Aura(1,0,player)
    else
        return true
    end
    return true
end

function checkExhausted(cid, storage, seconds)
	local player = Player(cid)
		if not player then
			return
	end
    local v = exhaustion.get(cid, storage)
    if(not v) then
        exhaustion.set(cid, storage, seconds)
    else
        player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Please wait " .. v .. " seconds before using this spell again.")
        return false
    end
 
    return true
end

-- main Function
function onCastSpell(player, variant)
if(not checkExhausted(player, 554, 20)) then
    return false
end

	local pos = player:getPosition()
	if getTilePzInfo(pos) == true then 
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your cannot use your aura in a protection zone!")
	return false
    end
            if(player:getStorageValue(aurastr)==2) then
                player:sendCancelMessage("Your aura is already activated.")
            elseif(player:getStorageValue(aurastr)==-1) then
				player:addMana(-400)
                player:sendCancelMessage("Aura activated!")
                player:setStorageValue(aurastr, 2)
                player:setStorageValue(estr, os.time()+ 90)
                Aura(1,tempo/8, player:getId())
                player:registerEvent('AuraTimer')
                player:registerEvent('AuraPz')
            end
        end