local config = {
    godCommands = {
		'/ban playerName, reason',
		'/ipban playerName, reason',
		'/unban',
		'/up',
        '/down',
        '/c',
        '/goto',
        '/owner',
        '/t',
        '/town',
        '/a',
        '/pos',
        '/info',
        '/r',
        '/kick',
        '/openserver',
        '/closeserver',
        '/closeserver shutdown',
        '/shutdown #',
        '/B',
        '/m',
        '/i',
        '/s',
        '/addtutor',
        '/removetutor',
        '/looktype',
        '/summon',
        '/chameleon',
        '/addskill name, skill',
        '/mccheck',
        '/ghost',
        '/clean',
        '/hide',
        '/vip adddays, playerName, #',
		'/vip removedays, playerName, #',
		'/vip remove, playerName',
		'/vip check, playerName',
		'/vip addinfinite, playerName',
		'/jail playerName',
        '/unjail playerName',
        '!zombie start, min,max,start time',
        ' '
    },
    playerCommands = {
		'!afk (on/off)',
		'!autoloot add, itemId or name',
		'!autoloot remove, itemId or name',
		'!autoloot show',
		'!autoloot clear',
		'!buyhouse',
		'!coin',
		'!checkvip',
		'!deathlist playerName',
		'!cast (pasword optional)',
		'!kills',
        '!leavehouse',
        '!online',
        '!report (add message)',
        '!save',
        '!serverinfo',
        '!shop',
        '!spells',
        '!stopcast',
        '!uptime',
        '!zombie join',
        ' ',
        'VIP Only:',
        '!aol',
        '!bless',
		'!t',
		'!portal'
    },
}

function onSay(cid, words, param)
    local player = Player(cid)
    local storeCommands = {}
    local text = ''
    local line = ''

    if player:getGroup():getId() == 4 then
		for i = 1, #config.godCommands do
            storeCommands[#storeCommands + 1] = config.godCommands[i]
		end
		
        for i = 1, #config.playerCommands do
            storeCommands[#storeCommands + 1] = config.playerCommands[i]
        end       

        text = text .. 'Commands:'
        for _, t in ipairs(storeCommands) do
            --line = line + 1
            text = text ..'\n '.. line ..' '.. t ..''
        end
        player:showTextDialog(6103, text)
    else
        for i = 1, #config.playerCommands do
            storeCommands[#storeCommands + 1] = config.playerCommands[i]
        end
        text = text .. 'Commands:'
        for _, t in ipairs(storeCommands) do
            --line = line + 1
            --text = text ..'\n '.. line ..'. '.. t ..''
            text = text ..'\n '.. line ..' '.. t ..''
        end
        player:showTextDialog(6103, text)   
    end
    return false
	end