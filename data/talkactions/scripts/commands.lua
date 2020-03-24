local config = {
    staffCommands = {
		'/ban playerName, reason',
		'/ipban playerName, reason',
		'/unban playerName',
		'/up',
        '/down',
        '/c',
        '/goto',
        '/t',
        '/town',
        '/a',
        '/pos',
        '/info',
        '/r',
        '/kick',
        '/B',
        '/looktype',
        '/chameleon',
        '/mccheck',
        '/clean',
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
		'!dps',
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

    if player:getGroup():getAccess() then
        for i = 1, #config.staffCommands do
            storeCommands[#storeCommands + 1] = config.staffCommands[i]
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