-- Parser
dofile('data/modules/scripts/gamestore/init.lua')
-- Config
GameStore.Categories = {
{    name = "Containers",
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Anniversary Backpack (Vol:15)", thingId = 16007, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Anniversary_bp.png"}, description = "Buy this backpack to hold items!"},
            {name = "Backpack of Holding (Vol:24)", thingId = 2365, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Holding.png"}, description = "Buy this backpack to hold items!"},
            {name = "Cake Backpack (Vol:20)", thingId = 22696, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Cake_bp.png"}, description = "Buy this backpack to hold items!"},
            {name = "Crown Backpack (Vol:20)", thingId = 10522, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Crown_bp.png"}, description = "Buy this backpack to hold items!"},
            {name = "Energetic Backpack (Vol:20)", thingId = 26181, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Energetic_Backpack.png"}, description = "Buy this backpack to hold items!"},
            {name = "Heart Backpack (Vol:20)", thingId = 11119, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Heart_bp.png"}, description = "Buy this backpack to hold items!"},
            {name = "Minotaur Backpack (Vol:20)", thingId = 11244, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Minotaur_Backpack.png"}, description = "Buy this backpack to hold items!"},
            {name = "Santa Backpack (Vol:20)", thingId = 11263, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Santa_Backpack.png"}, description = "Buy this backpack to hold items!"}
            }
    },
{    name = "Enhancements",
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
            -- Item Example : thingId = itemId 1948 - Double XP Scroll (1 hour) - 15 
            {name = "Berserk Potion", thingId = 7439, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 1, icons = {"berserk_potion.png"}, description = "Drinking this potion temporarily increases your fighting skill while decreasing your defense."},
            {name = "Bullseye Potion", thingId = 7443, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 1, icons = {"bullseye_potion.png"}, description = "Drinking this potion temporarily increases your distance skill while decreasing your defense."},
            {name = "Mastermind Potion", thingId = 7440, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 1, icons = {"mastermind_potion.png"}, description = "Drinking this potion temporarily increases your magic skill while decreasing your magic defense."},
            {name = "Double XP Scroll (1 hour)", thingId = 1948, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"double_experience_grant.png"}, description = "Grants character double experience for one hour. Does not persist through death."}
            }
    },
{    name = "Furniture",
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Ferocious Cabinet", thingId = 24345, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Ferocious_Cabinet.png"}, description = "a Ferocious Cabinet (Vol:30)."},
            {name = "Ferocious Chair", thingId = 26113, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Ferocious_Chair.png"}, description = "a Ferocious Chair."},
            {name = "Ferocious Table", thingId = 26114, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Ferocious_Table.png"}, description = "a Ferocious Table."},
            {name = "Ferocious Trunk", thingId = 26129, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Ferocious_Trunk.png"}, description = "a Ferocious Trunk (Vol:20)."},
            {name = "Kidney Table", thingId = 24348, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Kidney_Table.png"}, description = "a Kidney Table."},
            {name = "Magnificent Cabinet", thingId = 24346, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Magnificent_Cabinet.png"}, description = "a Magnificent Cabinet (Vol:30)."},
            {name = "Magnificent Chair", thingId = 26114, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Magnificent_Chair.png"}, description = "a Magnificent Chair."},
            {name = "Magnificent Table", thingId = 7498, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Magnificent_Table.png"}, description = "a Magnificent Table."},
            {name = "Magnificent Trunk", thingId = 24353, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Magnificent_Trunk.png"}, description = "a Magnificent Trunk (Vol:20)."},
            {name = "Timber Chair", thingId = 24350, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Timber_Chair.png"}, description = "a timber chair."},
            {name = "Timber Stool", thingId = 24351, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Timber_Stool.png"}, description = "a timber stool."},
            {name = "Timber Taboret", thingId = 24352, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Timber_Taboret.png"}, description = "a timber taboret."},
            {name = "Venorean Chair", thingId = 24347, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Venorean_Chair.png"}, description = "a Venorean Chair."},
            {name = "Venorean Stool", thingId = 24349, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Venorean_Stool.png"}, description = "a Venorean Stool."}
        }
    },
{    name = "House Deco",
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
        	{name = "Blood Herbs", thingId = 2798, count = 10, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 5, icons = {"Blood_Herb.png"}, description = "Buy these blood herbs, some nice decoration!"},
            {name = "Blood Herbs", thingId = 2798, count = 20, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 10, icons = {"Blood_Herb.png"}, description = "Buy these blood herbs, some nice decoration!"},
            {name = "Crystal Lamp", thingId = 18389, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Crystal_Lamp.png"}, description = "Buy this item to explore the dark caves!"},
            {name = "Folded Rift Carpet", thingId = 25393, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Folded_Rift_Carpet.png"}, description = "a Folded Rift Carpet."},
            {name = "Glowing Mushroom", thingId = 18392, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Glowing_Mushroom.png"}, description = "Buy this item to explore the dark caves!"},
            {name = "Green Light", thingId = 23588, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Green_Light.png"}, description = "Buy this item to explore the dark caves!"},
            {name = "Hamster In A Wheel", thingId = 7503, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Hamster.png"}, description = "a hamster in a wheel."},
			{name = "Memory Box", thingId = 21731, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Memory_Box.png"}, description = "It is said to freeze time itself to capture your fondest memories."},
			{name = "Music Box", thingId = 13032, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Music_Box_(TibiaSpace).png"}, description = "a Music Box."},
			{name = "Music Box", thingId = 22647, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Music_Box.png"}, description = "a Music Box."},
			{name = "Predator Lamp", thingId = 24344, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Lamp_Leopard.png"}, description = "a Predator Lamp."},
            {name = "Protectress Lamp", thingId = 26116, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"Lamp_Goddess.png"}, description = "a Protectress Lamp."},
			{name = "Pumpkinhead (unlit)", thingId = 24342, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Pumpkinhead.png"}, description = "an unlit Pumpkinhead."},
			{name = "Rift Lamp", thingId = 25390, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Rift_Lamp_(Charging).png"}, description = "Buy this item to explore the dark caves!"},
			{name = "Rolled-up Void Carpet", thingId = 26192, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Folded_Void_Carpet.png"}, description = "a Rolled-up Void Carpet."},
			{name = "Rolled-up Yalaharian Carpet", thingId = 26087, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Rolled-up_Yalaharian_Carpet.png"}, description = "a Rolled-up Yalaharian Carpet."},
			{name = "Rolled-up White Fur Carpet", thingId = 26088, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Rolled-up_White_Fur_Carpet.png"}, description = "a FRolled-up White Fur Carpet."},
			{name = "Rolled-up Bamboo Mat", thingId = 26089, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Rolled-up_Bamboo_Mat.png"}, description = "a Rolled-up Bamboo Mat."},
			{name = "Sleeping Cat", thingId = 26112, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Sleeping_Cat.png"}, description = "a sleeping cat."},
			{name = "Small Lamp", thingId = 24354, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Small_Lamp.png"}, description = "a small lamp."},
			{name = "Snow Globe", thingId = 22645, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"Snow_Globe.png"}, description = "a Snow Globe."},
			{name = "Trapped Lightning", thingId = 21699, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Trapped_Lightning.png"}, description = "Buy this item to explore the dark caves!"}
        }
    },   
{    name = "Other Items",
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Crystal Coin", thingId = 2160, count = 50, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 15, icons = {"Crystal_Coin.png"}, description = "Become rich!"},
            {name = "Gold bar", thingId = 15515, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 30, icons = {"Bar_of_Gold.png"}, description = "Become rich!"},
            {name = "Gold Bars", thingId = 15515, count = 2, type = GameStore.OfferTypes.OFFER_TYPE_STACKABLE, price = 55, icons = {"Bar_of_Gold.png"}, description = "Become rich!"},
            {name = "Lottery Ticket", thingId = 5957, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 3, icons = {"lottery_ticket.png"}, description = "Chance to win daily tokens or 30 minute double xp. Rare chance of double prize"},
            {name = "Starlight Portal", thingId = 2361, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 60, icons = {"starlight_portal.png"}, description = "Buy this item to !set your teleport location."}
            }
    },    
{    name = "Outfits", -- druid hunter warrior mage knight pirate not included
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
            -- Addon Example : thingId = lookType, addon = ( 1 = addon 1, 2 = addon 2, 3 = both addons)
            {name = "Citizen Addon", thingId = {male=128,female=136}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 0, icons = {"Product_Outfit_Citizen_Male.png", "Product_Outfit_Citizen_Female.png"}},
            {name = "Nobleman/ Noblewoman Addon", thingId = {male=132,female=140}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Nobleman_Male.png", "Product_Outfit_Noblewoman_Female.png"}},
            {name = "Summoner Addon", thingId = {male=133,female=141}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Summoner_Male.png", "Product_Outfit_Summoner_Female.png"}},
            {name = "Barbarian Addon", thingId = {male=143,female=147}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Barbarian_Male.png", "Product_Outfit_Barbarian_Female.png"}},
            {name = "Wizard Addon", thingId = {male=145,female=149}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Wizard_Male.png", "Product_Outfit_Wizard_Female.png"}},
            {name = "Oriental Addon", thingId = {male=146,female=150}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Oriental_Male.png", "Product_Outfit_Oriental_Female.png"}},
            {name = "Assassin Addon", thingId = {male=152,female=156}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Assassin_Male.png", "Product_Outfit_Assassin_Female.png"}},
            {name = "Beggar Addon", thingId = {male=153,female=157}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Beggar_Male.png", "Product_Outfit_Beggar_Female.png"}},
            {name = "Shaman Addon", thingId = {male=154,female=158}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Shaman_Male.png", "Product_Outfit_Shaman_Female.png"}},
            {name = "Norseman Addon", thingId = {male=251,female=252}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Norseman_Male.png", "Product_Outfit_Norseman_Female.png"}},
            {name = "Nightmare Addon", thingId = {male=268,female=269}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Nightmare_Male.png", "Product_Outfit_Nightmare_Female.png"}},
            {name = "Jester Addon", thingId = {male=273,female=270}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Jester_Male.png", "Product_Outfit_Jester_Female.png"}},
            {name = "Brotherhood Addon", thingId = {male=278,female=279}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Brotherhood_Male.png", "Product_Outfit_Brotherhood_Female.png"}},
            {name = "Demonhunter Addon", thingId = {male=289,female=288}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Demonhunter_Male.png", "Product_Outfit_Demonhunter_Female.png"}},
            {name = "Yalaharian Addon", thingId = {male=325,female=324}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Yalaharian_Male.png", "Product_Outfit_Yalaharian_Female.png"}},
            {name = "Husband/Wife Addon", thingId = {male=328,female=329}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 20, icons = {"Product_Outfit_Husband_Male.png", "Product_Outfit_Wife_Female.png"}},
            {name = "Warmaster Addon", thingId = {male=335,female=336}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Warmaster_Male.png", "Product_Outfit_Warmaster_Female.png"}},
            {name = "Wayfarer Addon", thingId = {male=367,female=366}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 30, icons = {"Product_Outfit_Wayfarer_Male.png", "Product_Outfit_Wayfarer_Female.png"}},
            {name = "Afflicted Addon", thingId = {male=430,female=431}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 40, icons = {"Product_Outfit_Afflicted_Male.png", "Product_Outfit_Afflicted_Female.png"}},
            {name = "Elementalist Addon", thingId = {male=432,female=433}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 40, icons = {"Product_Outfit_Elementalist_Male.png", "Product_Outfit_Elementalist_Female.png"}},
            {name = "Deepling Addon", thingId = {male=463,female=464}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 40, icons = {"Product_Outfit_Deepling_Male.png", "Product_Outfit_Deepling_Female.png"}},
            {name = "Insectoid Addon", thingId = {male=465,female=466}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 40, icons = {"Product_Outfit_Insectoid_Male.png", "Product_Outfit_Insectoid_Female.png"}},
            {name = "Entrepreneur Addon", thingId = {male=472,female=471}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 40, icons = {"Product_Outfit_Entrepreneur_Male.png", "Product_Outfit_Entrepreneur_Female.png"}},
            {name = "Crystal Warlord Addon", thingId = {male=512,female=513}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 50, icons = {"Product_Outfit_Crystal_Warlord_Male.png", "Product_Outfit_Crystal_Warlord_Female.png"}},
			{name = "Soil Guardian Addon", thingId = {male=516,female=514}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 50, icons = {"Product_Outfit_Soil_Guardian_Male.png", "Product_Outfit_Soil_Guardian_Female.png"}},
			{name = "Demon Addon", thingId = {male=541,female=542}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 50, icons = {"Product_Outfit_Demon_Male.png", "Product_Outfit_Demon_Female.png"}},
			{name = "Cave Explorer Addon", thingId = {male=574,female=575}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 50, icons = {"Product_Outfit_Cave_Explorer_Male.png", "Product_Outfit_Cave_Explorer_Female.png"}},
			{name = "Dream Warden Addon", thingId = {male=577,female=578}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 50, icons = {"Product_Outfit_Dream_Warden_Male.png", "Product_Outfit_Dream_Warden_Female.png"}},
			{name = "Jersey Addon", thingId = {male=619,female=620}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_Jersey_Male.png", "Product_Outfit_Jersey_Female.png"}},
			{name = "Champion Addon", thingId = {male=633,female=632}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_Champion_Male.png", "Product_Outfit_Champion_Female.png"}},
			{name = "Conjurer Addon", thingId = {male=634,female=635}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_Conjurer_Male.png", "Product_Outfit_Conjurer_Female.png"}},
			{name = "Beastmaster Addon", thingId = {male=637,female=636}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_Beastmaster_Male.png", "Product_Outfit_Beastmaster_Female.png"}},
			{name = "Chaos Acolyte Addon", thingId = {male=665,female=664}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_ChaosAcolyte_Male.png", "Product_Outfit_ChaosAcolyte_Female.png"}},
			{name = "Death Herald Addon", thingId = {male=667,female=666}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_DeathHerald_Male.png", "Product_Outfit_DeathHerald_Female.png"}},
			{name = "Ranger Addon", thingId = {male=684,female=683}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_Ranger_Male.png", "Product_Outfit_Ranger_Female.png"}},
			{name = "Ceremonial Garb Addon", thingId = {male=695,female=694}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_CeremonialGarb_Male.png", "Product_Outfit_CeremonialGarb_Female.png"}},
			{name = "Puppeteer Addon", thingId = {male=697,female=696}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_Puppeteer_Male.png", "Product_Outfit_Puppeteer_Female.png"}},
			{name = "Spirit Caller Addon", thingId = {male=699,female=698}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 60, icons = {"Product_Outfit_SpiritCaller_Male.png", "Product_Outfit_SpiritCaller_Female.png"}},
			{name = "Evoker Addon", thingId = {male=725,female=724}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 70, icons = {"Product_Outfit_Evoker_Male.png", "Product_Outfit_Evoker_Female.png"}},
			{name = "Seaweaver Addon", thingId = {male=733,female=732}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 70, icons = {"Product_Outfit_SeaWeaver_Male.png", "Product_Outfit_SeaWeaver_Female.png"}},
			{name = "Sea Dog Addon", thingId = {male=750,female=749}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 70, icons = {"Product_Outfit_SeaDog_Male.png", "Product_Outfit_SeaDog_Female.png"}},
			{name = "Recruiter Addon", thingId = {male=746,female=745}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 70, icons = {"Product_Outfit_Recruiter_Male.png", "Product_Outfit_Recruiter_Female.png"}},
			{name = "Pumpkin Head Addon", thingId = {male=760,female=759}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 70, icons = {"Product_Outfit_RoyalPumpkin_Male.png", "Product_Outfit_RoyalPumpkin_Female.png"}},
			{name = "Rift Warrior Addon", thingId = {male=846,female=845}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 80, icons = {"Product_Outfit_Rift_Warrior_Male.png", "Product_Outfit_Rift_Warrior_Female.png"}},
			{name = "Winter Warden Addon", thingId = {male=853,female=852}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 80, icons = {"Product_Outfit_WinterWarden_Male.png", "Product_Outfit_WinterWarden_Female.png"}},
			{name = "Philosopher Addon", thingId = {male=873,female=874}, addon = 3, type = GameStore.OfferTypes.OFFER_TYPE_OUTFIT_ADDON, price = 80, icons = {"Product_Outfit_Philosopher_Male.png", "Product_Outfit_Philosopher_Female.png"}},
        }
    },
--[[{    name = "FREE Mounts",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_FreeMounts.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Donkey", thingId = 13, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 0, icons = {"Product_Mount_Titanica.png"}, description = "Free mount!"},
            {name = "War Horse", thingId = 17, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 0, icons = {"Product_Mount_Titanica.png"}, description = "Free mount!"},
            {name = "Lady Bug", thingId = 27, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 0, icons = {"Product_Mount_Titanica.png"}, description = "Free mount!"},
            {name = "War Bear", thingId = 3, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 0, icons = {"Product_Mount_Titanica.png"}, description = "Free mount!"}
        }
    },
{    name = "10.90 Mounts",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_1090Mounts.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Rift Runner", thingId = 87, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 12, icons = {"Product_Mount_Titanica.png"}, description = "New 10.90 mount!"},
            {name = "Nightdweller", thingId = 88, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 12, icons = {"Product_Mount_Titanica.png"}, description = "New 10.90 mount!"},
            {name = "Frostflare", thingId = 89, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 12, icons = {"Product_Mount_Titanica.png"}, description = "New 10.90 mount!"},
            {name = "Cinderhoof", thingId = 90, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 12, icons = {"Product_Mount_Titanica.png"}, description = "New 10.90 mount!"}
        }
    },
{    name = "10.91 Mounts",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_1091Mounts.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Mouldpincer", thingId = 91, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 15, icons = {"Product_Mount_Titanica.png"}, description = "New 10.91 mount!"},
            {name = "Bloodcurl", thingId = 92, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 15, icons = {"Product_Mount_Titanica.png"}, description = "New 10.91 mount!"},
            {name = "Leafscuttler", thingId = 93, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 15, icons = {"Product_Mount_Titanica.png"}, description = "New 10.91 mount!"}
        }
    },
{    name = "10.94 Mounts",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_1094Mounts.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Sparkion", thingId = 94, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 20, icons = {"Product_Mount_Titanica.png"}, description = "New 10.94 mount!"},
            {name = "Neon Sparkid", thingId = 95, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 20, icons = {"Product_Mount_Titanica.png"}, description = "New 10.94 mount!"},
            {name = "Vortexion", thingId = 96, type = GameStore.OfferTypes.OFFER_TYPE_MOUNT, price = 20, icons = {"Product_Mount_Titanica.png"}, description = "New 10.94 mount!"}
        }
    },]]
{   name = "VIP Tokens",
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Bronze Medal [1 day VIP]", thingId = 10135, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"bronze_medal.png"}, description = "Buy this item to grant your account VIP privileges!"},
            {name = "Silver Medal [5 days VIP]", thingId = 10134, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"silver_medal.png"}, description = "Buy this item to grant your account VIP privileges!"},
            {name = "Gold Medal [10 days VIP]", thingId = 10133, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 45, icons = {"gold_medal.png"}, description = "Buy this item to grant your account VIP privileges!"}
            }
    },
{   name = "Extra Services",
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
            -- NameChange example
            {name = "Character Name Change", type = GameStore.OfferTypes.OFFER_TYPE_NAMECHANGE, price = 25, icons = {"Name_Change.png"}},
            -- Sexchange example
            {name = "Character Sex Change", type = GameStore.OfferTypes.OFFER_TYPE_SEXCHANGE, price = 15, icons = {"Sex_Change.png"}},
            }
    },
}

-- For Explanation and information
-- view the readme.md file in github or via markdown viewer.

-- Non-Editable
local runningId = 1
for k, category in ipairs(GameStore.Categories) do
    if category.offers then
        for m, offer in ipairs(category.offers) do
            offer.id = runningId
            runningId = runningId + 1
           
            if not offer.type then
                offer.type = GameStore.OfferTypes.OFFER_TYPE_NONE
            end
        end
    end
end

--[[{    name = "Premium Items",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_Prem.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Premium Coin", thingId = 24115, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "Buy 1x premium coin and use it to receive 10 shop points!"},
            {name = "Premium Coins", thingId = 24115, count = 5, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 50, icons = {"2160.gif"}, description = "Buy 5x premium coins and use it to receive 50 shop points!"},
            {name = "Premium Scroll", thingId = 16101, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"2160.gif"}, description = "Buy 1x premium scroll and use it to receive 100 shop points!"},
            {name = "Premium Scrolls", thingId = 16101, count = 3, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 90, icons = {"2160.gif"}, description = "Buy 3x premium scrolls and use it to receive 90 shop points!"},
            {name = "Tibia Coin", thingId = 24774, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 100, icons = {"2160.gif"}, description = "Buy 1x tibia coin and use it to receive 100 shop points!"},
            {name = "Tibia Coins", thingId = 24774, count = 2, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 200, icons = {"2160.gif"}, description = "Buy 2x tibia coins and use it to receive 200 shop points!"},
           {name = "Stamina Refiller", thingId = 12328, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "Buy this item to refill your stamina!"},
            {name = "Stamina Refillers", thingId = 12328, count = 3, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 36, icons = {"2160.gif"}, description = "Buy this item to refill your stamina!"}
        }
    },
{    name = "Special Dolls",
        state = GameStore.States.STATE_NEW,
        icons = {"decap.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Addon Doll", thingId = 13559, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Addon_Doll.png"}, description = "Buy this doll to obtain a addon!"},
            {name = "Addon Dolls", thingId = 13559, count = 2, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"Addon_Doll.png"}, description = "Buy this doll to obtain a addon!"},
            {name = "Mount Doll", thingId = 13030, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"Mount_Doll.png"}, description = "Buy this doll to obtain a mount!"},
            {name = "Mount Dolls", thingId = 13030, count = 2, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"Mount_Doll.png"}, description = "Buy this doll to obtain a mount!"}
        }
    },
{    name = "Potions & Runes",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_PotsRunes.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Supreme Health Potions", thingId = 26031, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 4, icons = {"2160.gif"}, description = "Buy these potions, perfect for a Knight!"},
            {name = "Ultimate Spirit Potions", thingId = 26030, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 4, icons = {"2160.gif"}, description = "Buy these potions, perfect for a Paladin!"},
            {name = "Ultimate Mana Potions", thingId = 26029, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 4, icons = {"2160.gif"}, description = "Buy these potions, perfect for a Mage!"},
            {name = "Ultimate Health Potions", thingId = 8473, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 3, icons = {"2160.gif"}, description = "Buy these potions, perfect for a Knight!"},
            {name = "Great Health Potions", thingId = 7591, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 2, icons = {"2160.gif"}, description = "Buy these potions, perfect for a Knight!"},
            {name = "Great Spirit Potions", thingId = 8472, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 2, icons = {"2160.gif"}, description = "Buy these potions, perfect for a Paladin!"},
            {name = "Great Mana Potions", thingId = 7590, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 2, icons = {"2160.gif"}, description = "Buy these potions, perfect for a Mage!"},
            {name = "Sudden Death Rune", thingId = 2268, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 4, icons = {"2160.gif"}, description = "Buy these runes, send death to your enemies!"},
            {name = "Avalanche Rune", thingId = 2274, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 2, icons = {"2160.gif"}, description = "Buy these runes, to attack enemys all around you!"},
            {name = "Ultimate Healing Runes", thingId = 2273, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 3, icons = {"2160.gif"}, description = "Buy these runes, good for healing!"},
            {name = "Firebomb Runes", thingId = 2305, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 2, icons = {"2160.gif"}, description = "Buy these runes, to set fire fields to your enemys!"},
            {name = "Destroy Field Runes", thingId = 2261, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 1, icons = {"2160.gif"}, description = "Buy these runes, to destory enemy fields!"},
            {name = "Paralyze Runes", thingId = 2278, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "Buy these rune, to paralyze your enemies!"},
            {name = "Magic Wall Runes", thingId = 2293, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 3, icons = {"2160.gif"}, description = "Buy these rune, good for making walls!"},
            {name = "Wild Growth Runes", thingId = 2269, count = 100, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 3, icons = {"2160.gif"}, description = "Buy these rune, good for making walls!"}
        }
    },
{    name = "Knight Items",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_Knight.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Crystalline Axe (Lvl 70+)", thingId = 18451, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Shiny Blade (Lvl 70+)", thingId = 18456, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Mycological Mace (Lvl 70+)", thingId = 18452, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Crude Umbral Axe (Lvl 50+)", thingId = 22404, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Umbral Axe (Lvl 75+)", thingId = 22405, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Crude Umbral Blade (Lvl 50+)", thingId = 22398, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Umbral Blade (Lvl 75+)", thingId = 22399, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
           {name = "Crude Umbral Mace (Lvl 50+)", thingId = 22410, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Umbral Mace (Lvl 75+)", thingId = 22411, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Axe of Mayhem (Lvl 160+)", thingId = 26285, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Blade of Mayhem (Lvl 160+)", thingId = 26283, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Mace of Mayhem (Lvl 160+)", thingId = 26288, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Prismatic Shield (Lvl 80+)", thingId = 18410, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "This item is fit for a Knight!"},
            {name = "Prismatic Helmet (Lvl 80+)", thingId = 18403, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "This item is fit for a Knight!"},
            {name = "Prismatic Armor (Lvl 80+)", thingId = 18404, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "This item is fit for a Knight!"},
            {name = "Ornate Legs (Lvl 85+)", thingId = 15412, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "This item is fit for a Knight!"},
            {name = "Depth Calcei (Lvl 70+)", thingId = 15410, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "This item is fit for a Knight!"},
            {name = "Treader of Torment", thingId = 25412, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "Buy these boots, perfect for a Knight!"},
            {name = "Collar of Red Plasma (Lvl 80+)", thingId = 26487, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this amulet, gives skill and protection of physical!"},
            {name = "Ring of Red Plasma (Lvl 80+)", thingId = 26493, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this ring, gives skill and protection of physical!"}
            }
    },
{    name = "Paladin Items",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_Pally.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Crystal Crossbow (Lvl 80+)", thingId = 18453, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 6, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Crude Umbral Bow (Lvl 50+)", thingId = 22416, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Umbral Bow (Lvl 75+)", thingId = 22417, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Crude Umbral Crossbow (Lvl 50+)", thingId = 22419, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Umbral Crossbow (Lvl 75+)", thingId = 22420, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Bow of Mayhem (Lvl 140+)", thingId = 26289, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Crossbow of Mayhem (Lvl 140+)", thingId = 26290, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Elite Draken Helmet (Lvl 80+)", thingId = 12645, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 6, icons = {"2160.gif"}, description = "This item is fit for a Paladin!"},
            {name = "Prismatic Armor (Lvl 80+)", thingId = 18404, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "This item is fit for a Paladin!"},
            {name = "Prismatic Legs (Lvl 80+)", thingId = 18405, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "This item is fit for a Paladin!"},
            {name = "Prismatic Boots (Lvl 80+)", thingId = 18406, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "This item is fit for a Paladin!"},
            {name = "Badger Boots", thingId = 24742, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "This item is fit for a Paladin!"},
            {name = "Collar of Blue Plasma (Lvl 80+)", thingId = 26485, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this amulet, gives distance skill and magic level!"},
            {name = "Ring of Blue Plasma (Lvl 80+)", thingId = 26489, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "This this ring, gives distance skill and magic level!"}
        }
    },
{    name = "Sorcerer Items",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_Sorc.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Wand of Defiance (Lvl 65+)", thingId = 18390, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 4, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Wand of Mayhem (Lvl 130+)", thingId = 26291, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Yalahari Mask (Lvl 80+)", thingId = 9778, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 7, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Furious Frock (Lvl 80+)", thingId = 21725, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Gill Legs (Lvl 80+)", thingId = 18400, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Spellbook of Ancient Arcana (Lvl 100+)", thingId = 16112, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 7, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Crude Umbral Spellbook (Lvl 50+)", thingId = 18390, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Umbral Spellbook (Lvl 75+)", thingId = 18390, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Oriental Shoes", thingId = 24637, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Collar of Green Plasma (Lvl 80+)", thingId = 26486, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this amulet, gives magic level and faster regeneration!"},
            {name = "Ring of Green Plasma (Lvl 80+)", thingId = 26491, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this ring, gives magic level and faster regeneration!"}
        }
    },
{    name = "Druid Items",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_Druid.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Glacial Rod (Lvl 65+)", thingId = 18412, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 4, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Rod of Mayhem (Lvl 130+)", thingId = 26292, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 4, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Yalahari Mask (Lvl 80+)", thingId = 9778, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 7, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Furious Frock (Lvl 80+)", thingId = 21725, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Gill Legs (Lvl 80+)", thingId = 18400, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Spellbook of Ancient Arcana (Lvl 100+)", thingId = 16112, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 7, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Crude Umbral Spellbook (Lvl 50+)", thingId = 18390, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 8, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Umbral Spellbook (Lvl 75+)", thingId = 18390, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 12, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Oriental Shoes", thingId = 24637, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Collar of Green Plasma (Lvl 80+)", thingId = 26486, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this amulet, gives magic level and faster regeneration!"},
            {name = "Ring of Green Plasma (Lvl 80+)", thingId = 26491, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this ring, gives magic level and faster regeneration!"}
        }
    },
{    name = "Rings",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_Rings.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Broken Ring of Ending", thingId = 13877, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "Buy this ring to look classy!"},
            {name = "Signet Ring", thingId = 7697, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "Buy this ring to look classy!"},
            {name = "Horn", thingId = 21693, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "Buy this ring, gives magic lvel!"},
            {name = "Ring of the Sky", thingId = 2123, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 3, icons = {"2160.gif"}, description = "Buy this ring to look classy!"},
            {name = "Ring of Wishes", thingId = 2357, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "Buy this ring to look classy!"},
            {name = "Sweetheart Ring", thingId = 24324, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "Buy this ring to look classy!"},
            {name = "Magic Ring (Lvl 25+)", thingId = 2141, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this ring, gives magic level and faster regeneration!"}
            }
    },
{    name = "Amulets & Necklaces",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_AmmysNecklaces.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Koshei's Ancient Amulet", thingId = 8266, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "Buy this amulet, some good death protection!"},
            {name = "Werewolf Helmet (Lvl 20+)", thingId = 24718, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "Buy this helmet, some good death protection and speed!"},
            {name = "Enchanted Werewolf Helmet(Lvl 30+)", thingId = 24744, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"2160.gif"}, description = "Buy this helmet, some good death protection and speed!"},
            {name = "Werewolf Amulet(Lvl 20+)", thingId = 24716, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "Buy this amulet, some good death protection and speed!"},
            {name = "Enchanted Werewolf Amulet (Lvl 30+)", thingId = 24717, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"2160.gif"}, description = "Buy this amulet, some good death protection and speed!"},
            {name = "Ancient Amulet", thingId = 25402, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"2160.gif"}, description = "Buy 2x tibia coins and use it to receive 200 shop points!"},
            {name = "Beetle Necklace", thingId = 11374, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "Buy this amulet, some good speed!"},
            {name = "Ornamented Brooch", thingId = 12424, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "Buy this amulet, to check your blessings!"},
            {name = "Shrunken Head Necklace (Lvl 75+)", thingId = 21691, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 10, icons = {"2160.gif"}, description = "Buy this amulet, some good speed!"},
            {name = "Amulet of Life (Lvl 25+)", thingId = 10720, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy this amulet, gives magic level and faster regeneration!"}
            }
    },
{    name = "Crafting Materials",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_Crafting.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Dream Matters", thingId = 22397, count = 2, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 25, icons = {"2160.gif"}, description = "Buy these to create items from Eruaran!"},
            {name = "Cluster of Solaces", thingId = 22396, count = 60, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 30, icons = {"2160.gif"}, description = "Buy these to create items from Eruaran!"},
            {name = "Major Crystalline Tokens", thingId = 18423, count = 20, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 20, icons = {"2160.gif"}, description = "Buy these to buy items from Gnomally!"},
            {name = "Minor Crystalline Tokens", thingId = 18422, count = 30, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "Buy these to buy items from Gnomally!"},
            {name = "Silver Token", thingId = 25172, count = 5, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 15, icons = {"2160.gif"}, description = "Buy these tokens to craft items at the crafting station!"},
            }
    },
{    name = "Tools",
        state = GameStore.States.STATE_NEW,
        icons = {"Category_Tools.png"},
        offers = {
            -- Item Example : thingId = itemId
            {name = "Whacking Driller of Fate", thingId = 10515, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Squeezing Gear of Girlpower", thingId = 10513, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "Buy this weapon to defeat your enemies!"},
            {name = "Sneaky Stabber of Eliteness", thingId = 10511, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Blessed Wooden Stake", thingId = 5942, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            {name = "Obsidian Knife", thingId = 5908, count = 1, type = GameStore.OfferTypes.OFFER_TYPE_ITEM, price = 5, icons = {"2160.gif"}, description = "This item is fit for a Sorcerer!"},
            }
    },]]--