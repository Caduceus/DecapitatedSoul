local effects = {
    --{position = Position(1095, 1053, 7), text = '<-This Way'}, -- text only 
    {position = Position(1037, 904, 6), text = 'Bacchus Landing Gate'},
    {position = Position(832, 878, 6), text = '', effect = CONST_ME_STUN}, --Checkers
    {position = Position(1022, 931, 8), text = 'Teleport Room'},
    {position = Position(1024, 931, 8), text = 'Home'},
    {position = Position(1097, 994, 9), text = 'Teleport Room'},--Test arena portal
    {position = Position(1039, 910, 8), text = '', effect = CONST_ME_TUTORIALARROW},
    {position = Position(1046, 862, 7), text = 'Free Items'}, -- starting area
    {position = Position(1024, 880, 5), text = 'Skill Rewards'}, --starting rats
    {position = Position(1046, 880, 5), text = 'Quest Rewards'}, --starting rats
    {position = Position(1062, 995, 6), text = 'Skill Rewards'}, --Caduceus House
    {position = Position(1068, 995, 6), text = 'Quest Rewards'}, --Caduceus House
	{position = Position(1150, 818, 6), text = '', effect = CONST_ME_STUN},
	{position = Position(1025, 1022, 15), text = 'Drogheda'}, --Teleport Room
	{position = Position(1028, 1022, 15), text = 'Queimada'}, --Teleport Room
	{position = Position(1031, 1022, 15), text = 'Purgatory Isle'}, --Teleport Room
	{position = Position(1035, 1022, 15), text = 'Frozen Wastes'}, --Teleport Room
	{position = Position(1038, 1022, 15), text = 'Port Lonrich'}, --Teleport Room
	{position = Position(1041, 1022, 15), text = 'PVP Arena'}, -- Teleport Room
	--{position = Position(1047, 939, 10), text = 'Checkers'}, -- Game Room | depot
	{position = Position(1101, 1199, 7), text = '', effect = CONST_ME_FIREATTACK},  --Demon Oak
	{position = Position(1088, 1215, 7), text = '', effect = CONST_ME_FIREATTACK},  --Demon Oak
	{position = Position(1074, 1205, 7), text = '', effect = CONST_ME_FIREATTACK}, --Demon Oak
	{position = Position(1078, 1197, 7), text = '', effect = CONST_ME_FIREATTACK}, --Demon Oak
	{position = Position(1085, 1194, 7), text = '', effect = CONST_ME_FIREATTACK}, --Demon Oak
	{position = Position(1019, 935, 8), text = '', effect = CONST_ME_STUN}, -- Drogheda Temple Spawn
	{position = Position(705, 708, 7), text = 'Demon Helmet Quest'}, --Demon Helmet quest
	{position = Position(704, 708, 7), text = '', effect = CONST_ME_FIREATTACK}, --Demon Helmet quest
	{position = Position(706, 708, 7), text = '', effect = CONST_ME_FIREATTACK}, --Demon Helmet quest
	{position = Position(705, 683, 6), text = 'Annihilator Quest'}, -- Annihilator Quest
	{position = Position(701, 683, 6), text = '', effect = CONST_ME_FIREATTACK}, -- Annihilator Quest
	{position = Position(702, 683, 6), text = '', effect = CONST_ME_FIREATTACK}, -- Annihilator Quest
	{position = Position(703, 683, 6), text = '', effect = CONST_ME_FIREATTACK}, -- Annihilator Quest
	{position = Position(704, 683, 6), text = '', effect = CONST_ME_FIREATTACK}, -- Annihilator Quest
	{position = Position(1039, 929, 10), text = 'Place Bet', effect = CONST_ME_STUN}, -- Gambler
	{position = Position(1039, 935, 10), text = 'Place Bet', effect = CONST_ME_STUN}, -- Gambler
	{position = Position(1130, 1056, 9), text = 'Balance'}, --Cata quest sword
	{position = Position(1132, 1056, 9), text = 'Defense'}, --Cata quest club
	{position = Position(1134, 1056, 9), text = 'Pure Damage'}, --Cata quest sword
	{position = Position(1136, 1056, 9), text = 'Healing'}, --Cata quest templar sword
	{position = Position(547, 1331, 10), text = 'Balance'}, --FH quest sword
	{position = Position(549, 1331, 10), text = 'Defense'}, --FH quest club
	{position = Position(551, 1331, 10), text = 'Pure Damage'}, --FH quest sword
	{position = Position(553, 1331, 10), text = 'Healing'}, --FH quest templar sword
	{position = Position(1011, 926, 8), text = 'Take A Ride!', effect = CONST_ME_THUNDER}, -- Temple Train
	{position = Position(1041, 903, 8), text = 'WARNING!'}, --Catacombs Entrance
}

function onThink(interval)
    for i = 1, #effects do
        local settings = effects[i]
        local spectators = Game.getSpectators(settings.position, false, true, 6, 6, 4, 4)
        if #spectators > 0 then
            if settings.text then
                for i = 1, #spectators do
                    spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
                end
            end
            if settings.effect then
                settings.position:sendMagicEffect(settings.effect)
            end
        end
    end
   return true
end