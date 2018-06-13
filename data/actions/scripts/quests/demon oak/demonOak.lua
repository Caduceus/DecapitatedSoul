local config = {
	demonOakIds = {8288, 8289, 8290, 8291},
	sounds = {
		'MY ROOTS ARE SHARP AS A SCYTHE! FEEL IT?!?',
		'CURSE YOU!',
		'RISE, MINIONS, RISE FROM THE DEAD!!!!',
		'AHHHH! YOUR BLOOD MAKES ME STRONG!',
		'GET THE BONES, HELLHOUND! GET THEM!!',
		'GET THERE WHERE I CAN REACH YOU!!!',
		'ETERNAL PAIN AWAITS YOU! NICE REWARD, HUH?!?!',
		'YOU ARE GOING TO PAY FOR EACH HIT WITH DECADES OF TORTURE!!',
		'ARGG! TORTURE IT!! KILL IT SLOWLY MY MINION!!'
	},
	bonebeastChance = 90,
	bonebeastCount = 2,
	waves = 10,
	questArea = {
		fromPosition = {x = 1078, y = 1200, z = 7},
		toPosition = {x = 1096, y = 1211, z = 7}
	},
	summonPositions = {
		{x = 1086, y = 1203, z = 7},
		{x = 1084, y = 1204, z = 7},
		{x = 1084, y = 1209, z = 7},
		{x = 1085, y = 1209, z = 7},
		{x = 1088, y = 1209, z = 7},
		{x = 1091, y = 1209, z = 7},
		{x = 1092, y = 1205, z = 7},
		{x = 1091, y = 1203, z = 7}
	},
	-- *demon skeleton, *diabolic imp, *Braindeath, *Hand of Cursed Fate, *Destroyer, *souleater, hellspawn, *hellhound  -- *Lestat
	summons = {
		[8288] = {
			[5] = {'demon skeleton2',  'diabolic imp', 'demon skeleton2', 'hellspawn'},
			[10] = {'Betrayed Wraith', 'Betrayed Wraith', 'Destroyer'}
		},
		[8289] = {
			[5] = {'diabolic imp', 'diabolic imp', 'diabolic imp'},
			[10] = {'Braindeath', 'Blightwalker', 'Braindeath'}
		},
		[8290] = {
			[5] = {'Vampire', 'Vampire Bride', 'Vampire'},
			[10] = {'hellhound', 'Destroyer', 'hellhound'}
		},
		[8291] = {
			[5] = {'hellspawn', 'demon skeleton2', 'hellspawn'},
			[10] = {'Hand of Cursed Fate', 'souleater', 'Hand of Cursed Fate'}
		}
	},
	storages = {
		[8288] = Storage.DemonOak.AxeBlowsBird,
		[8289] = Storage.DemonOak.AxeBlowsLeft,
		[8290] = Storage.DemonOak.AxeBlowsRight,
		[8291] = Storage.DemonOak.AxeBlowsFace
	}
}

local function getRandomSummonPosition()
	return config.summonPositions[math.random(#config.summonPositions)]
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not isInArray(config.demonOakIds, target.itemid) then
		return true
	end

	local totalProgress = 0
	for _, cStorage in pairs(config.storages) do
		totalProgress = totalProgress + math.max(0, player:getStorageValue(cStorage))
	end

	local spectators, hasMonsters = Game.getSpectators(DEMON_OAK_POSITION, false, false, 9, 9, 6, 6), false
	for i = 1, #spectators do
		if spectators[i]:isMonster() then
			hasMonsters = true
			break
		end
	end

	local isDefeated = totalProgress == (#config.demonOakIds * (config.waves + 1))
	if (config.killAllBeforeCut or isDefeated)
			and hasMonsters then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You need to kill all monsters first.')
		return true
	end
	
	--[[if isDefeated and player:getStorageValue(Storage.DemonOak.Done) == 3 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Now you are just showing off!')
		player:teleportTo(DEMON_OAK_KICK_POSITION)
		return true
	end]]

	if isDefeated then
		if player:getStorageValue(Storage.DemonOak.Done) < 3 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Tell Oldrak about your great victory against the demon oak.')
				player:setStorageValue(Storage.DemonOak.Done, 1)
				player:setStorageValue(Storage.DemonOak.Progress, 3)
				player:teleportTo(DEMON_OAK_KICK_POSITION)
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Now you are just showing off!')
				player:teleportTo(DEMON_OAK_KICK_POSITION)
				return true
			end
		end		

	local cStorage = config.storages[target.itemid]
	local progress = math.max(player:getStorageValue(cStorage), 1)
	if progress >= config.waves + 1 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local isLastCut = totalProgress == (#config.demonOakIds * (config.waves + 1) - 1)
	local summons = config.summons[target.itemid]
	if summons and summons[progress] then
		-- Summon a single lestat on the last hit
		if isLastCut then
			Game.createMonster('Lestat de Lioncourt', getRandomSummonPosition(), false, true)

		-- Summon normal monsters otherwise
		else
			for i = 1, #summons[progress] do
				Game.createMonster(summons[progress][i], getRandomSummonPosition(), false, true)
			end
		end

	-- if it is not the 5th or 10th there is only a chance to summon demon
	elseif math.random(100) >= config.bonebeastChance then
		for i = 1, config.bonebeastCount do
			Game.createMonster('demon', getRandomSummonPosition(), false, true)
		end
	end

	player:say(isLastCut and 'HOW IS THAT POSSIBLE?!? MY MASTER WILL CRUSH YOU!! AHRRGGG!' or config.sounds[math.random(#config.sounds)], TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
	toPosition:sendMagicEffect(CONST_ME_DRAWBLOOD)
	player:setStorageValue(cStorage, progress + 1)
	player:say('-krrrrak-', TALKTYPE_MONSTER_YELL, false, player, toPosition)
	doTargetCombatHealth(0, player, COMBAT_EARTHDAMAGE, -1000, -1210, CONST_ME_BIGPLANTS)
	return true
end