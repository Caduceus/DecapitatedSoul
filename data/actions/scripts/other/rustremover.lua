function onUse(cid, item, frompos, item2, topos)
    local effect_renew = 28
    local effect_broke = 3
    local storage = 0
    local const = item2.itemid
    local pos = getCreaturePosition(cid)
    local itemy = {
                    [9808] = {
                                [1] = {id = 2464, name = "Chain Armor", chance = 6966},
                                [2] = {id = 2483, name = "Scale Armor", chance = 3952},
                                [3] = {id = 2465, name = "Brass Armor", chance = 1502},
                                [4] = {id = 2463, name = "Plate Armor", chance = 197}
                            },
                           
                    [9809] = {
                                [1] = {id = 2483, name = "Scale Armor", chance = 6437},                   
                                [2] = {id = 2464, name = "Chain Armor", chance = 4606},
                                [3] = {id = 2465, name = "Brass Armor", chance = 3029},
                                [4] = {id = 2463, name = "Plate Armor", chance = 1559},
                                [5] = {id = 2476, name = "Knight Armor", chance = 595},
                                [6] = {id = 2487, name = "Crown Armor", chance = 499},
                                [7] = {id = 2466, name = "Golden Armor", chance = 100},
                                [8] = {id = 11301, name = "Zaoan armor", chance = 100}
                            },
                           
                    [9810] = {
                                [1] = {id = 2463, name = "Plate Armor", chance = 3767},
                                [2] = {id = 2476, name = "Knight Armor", chance = 1832},
                                [3] = {id = 2487, name = "Crown Armor", chance = 1177},
                                [4] = {id = 2466, name = "Golden Armor", chance = 1000},
                                [5] = {id = 11301, name = "Zaoan armor", chance = 1000},
                                [6] = {id = 8889, name = "Skullcracker Armor", chance = 200},
                                [7] = {id = 8891, name = "Paladin Armor", chance = 40},
                                [8] = {id = 8878, name = "Crystalline Armor", chance = 30},
                                [9] = {id = 12725, name = "Furious Frock", chance = 30}                            },
                           
                    [9811] = {
                                [1] = {id = 2648, name = "Chain Legs", chance = 6949},                   
                                [2] = {id = 2468, name = "Studded Legs", chance = 3692},
                                [3] = {id = 2478, name = "Brass Legs", chance = 1307},
                                [4] = {id = 2647, name = "Plate Legs", chance = 533}
                            },
                           
                    [9812] = {
                                [1] = {id = 2468, name = "Studded Legs", chance = 5962},
                                [2] = {id = 2648, name = "Chain Legs", chance = 4037},
                                [3] = {id = 2478, name = "Brass Legs", chance = 2574},
                                [4] = {id = 2647, name = "Plate Legs", chance = 2242},
                                [5] = {id = 2477, name = "Knight Legs", chance = 2186},
                                [6] = {id = 2488, name = "Crown Legs", chance = 1186},
                                [7] = {id = 2470, name = "Golden Legs", chance = 900},
                                [8] = {id = 11304, name = "Zaoan Legs", chance = 250}
                            },
                           
                    [9813] = {
                                [1] = {id = 2478, name = "Brass Legs", chance = 6500},
                                [2] = {id = 2647, name = "Plate Legs", chance = 3800},
                                [3] = {id = 2477, name = "Knight Legs", chance = 2500},
                                [4] = {id = 2488, name = "Crown Legs", chance = 2000},
                                [5] = {id = 2470, name = "Golden Legs", chance = 1800},
                                [6] = {id = 7895, name = "Lightning Legs", chance = 1500},
                                [7] = {id = 11304, name = "Zaoan Legs", chance = 1250},
                                [8] = {id = 7894, name = "Magma Legs", chance = 1000},
                                [9] = {id = 2495, name = "Demon Legs", chance = 200},
                            },
                            
                     [9814] = {
                                [1] = {id = 2530, name = "Copper Shield", chance = 6949},                   
                                [2] = {id = 2510, name = "Plate Shield", chance = 3692},
                                [3] = {id = 2509, name = "Steel Shield", chance = 2307},
                                [4] = {id = 2511, name = "Brass Shield", chance = 1233},
                                [5] = {id = 2519, name = "Crown Shield", chance = 833}
                            }, 
                            
                      [9815] = {
                                [1] = {id = 2511, name = "Brass Shield", chance = 6949},                   
                                [2] = {id = 2516, name = "Dragon Shield", chance = 5692},
                                [3] = {id = 2528, name = "Tower Shield", chance = 5307},
                                [4] = {id = 2533, name = "Griffin Shield", chance = 5233},
                                [5] = {id = 2519, name = "Crown Shield", chance = 4833},
                                [6] = {id = 2534, name = "Vampire Shield", chance = 3500},
                                [7] = {id = 2536, name = "Medusa Shield", chance = 2500},
                                [8] = {id = 2514, name = "Mastermind Shield", chance = 1200},
                            }, 
                            
                       [9816] = {
                                [1] = {id = 2519, name = "Crown Shield", chance = 6949},                   
                                [2] = {id = 2534, name = "Vampire Shield", chance = 5692},
                                [3] = {id = 2536, name = "Medusa Shield", chance = 5307},
                                [4] = {id = 2520, name = "Demon Shield", chance = 5233},
                                [5] = {id = 2539, name = "Phoenix Shield", chance = 4833},
                                [6] = {id = 2517, name = "Shield of honour", chance = 3500},
                                [7] = {id = 2514, name = "Mastermind Shield", chance = 2500},
                                [8] = {id = 6391, name = "Nightmare Shield", chance = 300},
                                [8] = {id = 7460, name = "Norse Shield", chance = 200}
                            },
                            
                        [9817] = {
                                [1] = {id = 2643, name = "Leather Boots", chance = 6949},                   
                                [2] = {id = 2195, name = "Boots of Haste", chance = 3692},
                                [3] = {id = 2644, name = "Bunnyslippers", chance = 1500}
                            },   
                            
                        [9818] = {
                                [1] = {id = 2643, name = "Leather Boots", chance = 6949},                   
                                [2] = {id = 2195, name = "Boots of Haste", chance = 5692},
                                [3] = {id = 2645, name = "Steel Boots", chance = 4500},
                                [4] = {id = 7893, name = "Lightning Boots", chance = 3692},
                                [5] = {id = 7886, name = "Terra Boots", chance = 2692},
                                [6] = {id = 11240, name = "Guardian Boots", chance = 1200}
                            },  
                            
                        [9819] = {
                                [1] = {id = 2195, name = "Boots of Haste", chance = 6949},                   
                                [2] = {id = 2645, name = "Steel Boots", chance = 5692},
                                [3] = {id = 7893, name = "Lightning Boots", chance = 4500},
                                [4] = {id = 7886, name = "Terra Boots", chance = 3692},
                                [5] = {id = 11240, name = "Guardian Boots", chance = 2692},
                                [6] = {id = 11240, name = "Crystal Boots", chance = 692}      
                            },
                            
                        [9820] = {
                                [1] = {id = 2473, name = "Viking Helmet", chance = 6949},                   
                                [2] = {id = 2480, name = "Legion Helmet", chance = 5692},
                                [3] = {id = 2457, name = "Steel Helmet", chance = 5500},
                                [4] = {id = 2458, name = "Chain Helmet", chance = 4500},
                                [5] = {id = 2460, name = "Brass Helmet", chance = 4500}
                            }, 
                            
                        [9821] = {
                                [1] = {id = 2473, name = "Viking Helmet", chance = 7949},                   
                                [2] = {id = 2480, name = "Legion Helmet", chance = 6692},
                                [3] = {id = 2457, name = "Steel Helmet", chance = 5500},
                                [4] = {id = 2490, name = "Dark Helmet", chance = 5000},
                                [5] = {id = 2491, name = "Crown Helmet", chance = 4500},
                                [6] = {id = 2498, name = "Royal Helmet", chance = 3500},
                                [7] = {id = 11302, name = "Zaoan Helmet", chance = 2500},
                                [8] = {id = 7903, name = "Terra Hood", chance = 2000}
                            },  
                            
                        [9822] = {
                                [1] = {id = 2473, name = "Viking Helmet", chance = 7949},                   
                                [2] = {id = 2490, name = "Dark Helmet", chance = 7692},
                                [3] = {id = 2491, name = "Crown Helmet", chance = 6500},
                                [4] = {id = 2498, name = "Royal Helmet", chance = 5000},
                                [5] = {id = 7903, name = "Terra Hood", chance = 4500},
                                [6] = {id = 11302, name = "Zaoan Helmet", chance = 3500},
                                [7] = {id = 11368, name = "Jade Hat", chance = 2500},
                                [8] = {id = 2506, name = "Dragon Scale Helmet", chance = 1500},
                                [9] = {id = 2493, name = "Demon Helmet", chance = 1000},
                                [10] = {id = 2471, name = "Golden Helmet", chance = 500}
                            }                
                } 

                local random_item = math.random(10000)
    if itemy[const] then
        for i = 1, #itemy[const] do
            if random_item <= itemy[const][i].chance then
                storage = i
            end
        end  
       
        if storage > 0 then
            doSendMagicEffect(topos, effect_renew)
            doTransformItem(item2.uid, itemy[const][storage].id)
            doCreatureSay(cid, "You have renewed the ".. itemy[const][storage].name .." !", TALKTYPE_ORANGE_1)
            doRemoveItem(item.uid, 1)
        else
            doSendMagicEffect(topos, effect_broke)
            doRemoveItem(item2.uid, 1)
            doRemoveItem(item.uid, 1)
            doCreatureSay(cid, "The armor was already damaged so badly that it broke when you tried to clean it.", TALKTYPE_ORANGE_1)
            return 0
        end
    else
        return 0
    end
return true
end