local position = {
	Position(513, 1372, 10),
	Position(527, 1373, 10),
	Position(502, 1357, 10),
	Position(535, 1357, 10),
	Position(514, 1344, 10),
	Position(534, 1350, 10)

}

local creatureNames = {
	'ice witch',
	'ice demon',
	'frost dragon',
	'frost giant',
	'frost giantess',
	'frost troll',
	'crystal spider',
	'soul reaper',
	'soul reaper',
	'soul reaper',
	'soul reaper',
	'soul reaper',
	'soul reaper',
	'soul reaper',
	'soul reaper'
}

local time_ = 5 * 60 -- 5 min

local function summonMonster(name, position)
	Game.createMonster(name, position)
	position:sendMagicEffect(CONST_ME_TELEPORT)
end

local function getRandomSummonPosition()
	return config.position[math.random(#config.position)]
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local function reset()
		item:transform(3697)
	if not item.itemid == 5468 then
		return false
	end
end

	if player:getStorageValue(Storage.TheirMastersVoice.SlimeGobblerTimeout) < os.time() then
		item:transform(3698)
		addEvent(reset, time_ * 1000)
		player:setStorageValue(Storage.TheirMastersVoice.SlimeGobblerTimeout, os.time() + 15)
		toPosition:sendMagicEffect(CONST_ME_POFF)
			for i = 1, #position do
				addEvent(summonMonster, 5 * 1000, creatureNames[math.random(#creatureNames)], position[i])
			end
			player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
			player:say('COME! My servants! RISE!', TALKTYPE_MONSTER_SAY)
			Game.setStorageValue(GlobalStorage.TheirMastersVoice.ServantsKilled, 0)
			Game.setStorageValue(GlobalStorage.TheirMastersVoice.CurrentServantWave, 0)
	end
	return true
end
