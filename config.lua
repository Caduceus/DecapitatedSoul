-- Combat settings
-- NOTE: valid values for worldType are: pvp, no-pvp and pvp-enforced

worldType = "pvp"
hotkeyAimbotEnabled = true
protectionLevel = 100
killsToRedSkull = 3
killsToBlackSkull = 6
pzLocked = 30000
removeChargesFromRunes = true
timeToDecreaseFrags = 24 * 60 * 60 * 1000
whiteSkullTime = 15 * 60 * 1000
stairJumpExhaustion = 2000
experienceByKillingPlayers = true
expFromPlayersLevelRange = 75
allowWalkthrough = false

-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
ip = "decapitatedsoul.servegame.com" -- you must set up your own IP
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 100
motd = "Welcome to the Decapitated_Soul_Beta_0.4.0. Are you ready to die?"
onePlayerOnlinePerAccount = true
allowClones = false
serverName = "Decapitated Soul Beta_0.4.0"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = 65

-- Cast
enableLiveCasting = true
liveCastPort = 7173

-- Store Config
storeImagesUrl = "http://decapitatedsoul.servegame.com/images/store/"
storeCoinPacket = 5

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = 5

-- Houses
-- NOTE: set housePriceEachSQM to -1 to disable the ingame buy house functionality
housePriceEachSQM = 20000
-- NOTE: valid values for houseRentPeriod are: never, daily, weekly, monthly and yearly --Still up in the air.. weekly
houseRentPeriod = "never" 

-- Item Usage
timeBetweenActions = 200
timeBetweenExActions = 1000

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
mapName = "Decap"
mapAuthor = "Caduceus"

-- Market
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = false
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

-- MySQL
mysqlHost = "127.0.0.1"
mysqlUser = "root"
mysqlPass = "password"
mysqlDatabase = "forgottenserver"
mysqlPort = 3306
mysqlSock = ""
passwordType = "sha1"

-- Misc.
allowChangeOutfit = true
freePremium = true
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 4
emoteSpells = true
classicEquipmentSlots = false

-- Rates
-- NOTE: rateExp is not used if you have enabled stages in data/XML/stages.xml -- working on offlineTrainingSkill --offlinetraining.lua
rateExp = 5
rateSkill = 20
rateLoot = 2
rateMagic = 15
rateSpawn = 1

-- Monsters
deSpawnRange = 2
deSpawnRadius = 50

-- Monster Level Config - Possibly make dup monster file per elite monster <level min="1" max="100"/>
monsterLevelDamage = 0.02 -- 2% bonus damage per level
monsterLevelExp = 0.01 -- 1% bonus exp per level
monsterLevelSpeed = 0.00 -- 1% bonus speed per level
monsterLevelHealth = 0.02 -- 1% bonus health per level
monsterLevelLoot = 0.01 -- 1% bonus loot per level
monsterPrefix = "+" -- Ghoul [+100] elite status 


-- Stamina is this even working?
staminaSystem = true

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: normal, above-normal, high
defaultPriority = "high"
startupDatabaseOptimization = false

-- Status server information
ownerName = "Decapitated Soul Project"
ownerEmail = "decapitatedsoulot@gmail.com"
url = "http://decapitatedsoul.servegame.com/"
location = "USA"
