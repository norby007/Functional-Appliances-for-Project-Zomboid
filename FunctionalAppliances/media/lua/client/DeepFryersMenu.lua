FADeepFryers = FADeepFryers or {}

FADeepFryers.doBuildMenu = function(player, menu, square, DeepFryers)
	--DeepFryers:getModData()['VatOil'] = "VegetableOil"
	local VatStatus = DeepFryers:getModData()['VatOil']

	local thisPlayer = getSpecificPlayer(player)
	local inv = thisPlayer:getInventory()
	local Oil = inv:FindAndReturn("Base.OilVegetable")
	local OilSapphs = inv:FindAndReturn("SapphCooking.PeanutOil")

	local soundFile = "industrial_fryer_sound"

	local contextMenu = menu:addOption(FA.translation.vatoillevel)
	local subContext = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu, subContext)

	if VatStatus == "VegetableOil" then
		subContext:addOption(FA.translation.currentlyfullremovevegetableoil,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Empty Vat")
	elseif VatStatus == "CookingOil" then
		subContext:addOption(FA.translation.currentlyfullremovecookingoil,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Empty Vat")
	elseif VatStatus == "Empty" and Oil ~= nil then
		subContext:addOption(FA.translation.currentlyemptyaddvegetableoil,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Fill Vat")
	elseif VatStatus == "Empty" and OilSapphs ~= nil then
		subContext:addOption(FA.translation.currentlyemptyaddcookingoil,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Fill Vat")
	else
		DeepFryers:getModData()['VatOil'] = "Empty"
		subContext:addOption(FA.translation.currentlyemptyneedsoil,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Full Stop")
	end

	local PotatoCut = nil
	local PotatoPeels = nil
	local OnionRings = nil
	local OnionBlooming = nil
	local CutTortillas = nil
	local ShrimpBattered = nil
	local FishBattered = nil
	local SausageBattered = nil
	local ChickenBattered = nil
	local ChickenFilletBattered = nil
	local ChickenSlicesBattered = nil
	local SmallBirdMeatBattered = nil
	local Dough = nil
	local DoughnutDough = nil
	local ChurrosDough = nil
	local CheeseBattered = nil

	local playerItems = getSpecificPlayer(player):getInventory():getItems()

	for i=0, playerItems:size()-1 do
        	local item = playerItems:get(i)
		local itemType = nil

		if item and item:getType() then
			itemType = item:getType()
		end

		if itemType == "CutPeeledPotato" or itemType == "FAPotatoWedges" then
			PotatoCut = item
		end
		if itemType == "PotatoPeel" or itemType == "FAPotatoSkins" then
			PotatoPeels = item
		end
		if itemType == "FriedOnionRingsCraft" and not item:isCooked() then
			OnionRings = item
		end
		if itemType == "FABatteredBloomingOnion" then
			OnionBlooming = item
		end
		if itemType == "CutTortilla" then
			CutTortillas = item
		end
		if itemType == "ShrimpFriedCraft" and not item:isCooked() then
			ShrimpBattered = item
		end
		if itemType == "FishFilletinBatter" then
			FishBattered = item
		end
		if itemType == "SausageinBatter" then
			SausageBattered = item
		end
		if itemType == "FABatteredChicken" then
			ChickenBattered = item
		end
		if itemType == "FABatteredChickenFillet" then
			ChickenFilletBattered = item
		end
		if itemType == "SlicedChickenBatter" then
			ChickenSlicesBattered = item
		end
		if itemType == "SmallBirdMeatinBatter" then
			SmallBirdMeatBattered = item
		end
		if itemType == "BreadDough" or itemType == "Dough" or itemType == "SmallDough" or itemType == "PastryDough" then
			Dough = item
		end
		if itemType == "DoughnutShapedDough" or itemType == "Dough" or itemType == "SmallDough" or itemType == "PastryDough" then
			DoughnutDough = item
		end
		if itemType == "PastryDough" or itemType == "Dough" or itemType == "SmallDough" then
			ChurrosDough = item
		end
		if itemType == "FABatteredCheese" then
			CheeseBattered = item
		end
	end

	local contextMenu2 = menu:addOption(FA.translation.fry)
	local subContext2 = ISContextMenu:getNew(menu);
	menu:addSubMenu(contextMenu2, subContext2)

	if PotatoCut then
		subContext2:addOption(FA.translation.potatowedges,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "French Fries")
	elseif PotatoCut == nil then
		subContext2:addOption(FA.translation.potatowedges,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found French Fries")
	end
	if PotatoPeels then
		subContext2:addOption(FA.translation.potatoskins,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Potato Skins")
	elseif PotatoPeels == nil then
		subContext2:addOption(FA.translation.potatoskins,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Potato Skins")
	end
	if OnionRings then
		subContext2:addOption(FA.translation.batteredonionrings,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Onion Rings")
	elseif OnionRings == nil then
		subContext2:addOption(FA.translation.batteredonionrings,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Onion Rings")
	end
	if OnionBlooming then
		subContext2:addOption(FA.translation.batteredbloomingonion,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Blooming Onion")
	elseif OnionBlooming == nil then
		subContext2:addOption(FA.translation.batteredbloomingonion,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Blooming Onion")
	end
	if CutTortillas then
		subContext2:addOption(FA.translation.cuttortillas,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Tortillas")
	elseif CutTortillas == nil then
		subContext2:addOption(FA.translation.cuttortillas,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Tortillas")
	end
	if ShrimpBattered then
		subContext2:addOption(FA.translation.batteredshrimp,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Shrimp")
	elseif ShrimpBattered == nil then
		subContext2:addOption(FA.translation.batteredshrimp,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Shrimp")
	end
	if FishBattered then
		subContext2:addOption(FA.translation.batteredfishfillet,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Fish Fillet")
	elseif FishBattered == nil then
		subContext2:addOption(FA.translation.batteredfishfillet,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Fish Fillet")
	end
	if SausageBattered then
		subContext2:addOption(FA.translation.batteredsausage,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Corndog")
	elseif SausageBattered == nil then
		subContext2:addOption(FA.translation.batteredsausage,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Corndog")
	end
	if ChickenBattered then
		subContext2:addOption(FA.translation.batteredchicken,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Fried Chicken")
	elseif ChickenBattered == nil then
		subContext2:addOption(FA.translation.batteredchicken,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Fried Chicken")
	end
	if ChickenFilletBattered then
		subContext2:addOption(FA.translation.batteredchickenfillet,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Chicken Fillet")
	elseif ChickenFilletBattered == nil then
		subContext2:addOption(FA.translation.batteredchickenfillet,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Chicken Fillet")
	end
	if ChickenSlicesBattered then
		subContext2:addOption(FA.translation.batteredslicedchicken,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Chicken Tenders")
	elseif ChickenSlicesBattered == nil then
		subContext2:addOption(FA.translation.batteredslicedchicken,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Chicken Tenders")
	end
	if SmallBirdMeatBattered then
		subContext2:addOption(FA.translation.batteredchickennuggets,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Chicken Nuggets")
	elseif SmallBirdMeatBattered == nil then
		subContext2:addOption(FA.translation.batteredchickennuggets,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Chicken Nuggets")
	end
	if Dough then
		subContext2:addOption(FA.translation.doughboys,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Doughboy")
	elseif Dough == nil then
		subContext2:addOption(FA.translation.doughboys,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Doughboy")
	end
	if DoughnutDough then
		subContext2:addOption(FA.translation.doughnuts,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Doughnut")
	elseif DoughnutDough == nil then
		subContext2:addOption(FA.translation.doughnuts,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Doughnut")
	end
	if ChurrosDough then
		subContext2:addOption(FA.translation.churros,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Churros")
	elseif ChurrosDough == nil then
		subContext2:addOption(FA.translation.churros,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Churros")
	end
	if CheeseBattered then
		subContext2:addOption(FA.translation.batteredcheesesticks,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Cheese Sticks")
	elseif CheeseBattered == nil then
		subContext2:addOption(FA.translation.batteredcheesesticks,
				  nil,	
				  FADeepFryers.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Not Found Cheese Sticks")
	end
end

FADeepFryers.onUseDeepFryers = function(junk, player, DeepFryers, soundFile, foodChoice)
	if not FA.walkToFront(player, DeepFryers) then
		return
	end

	local VatStatus = DeepFryers:getModData()['VatOil']
	local square = DeepFryers:getSquare()
	local inv = player:getInventory()
	local Oil = inv:FindAndReturn("Base.OilVegetable")
	local OilSapphs = inv:FindAndReturn("SapphCooking.PeanutOil")

	if foodChoice == "Full Stop" then
		player:Say(FA.translation.sayvatsemptyneedoil)
		return
	elseif foodChoice == "Empty Vat" and VatStatus == "VegetableOil" then
		--player:Say(FA.translation.sayoptionunavailable)
		DeepFryers:getModData()['VatOil'] = "Empty"
		inv:AddItem("Base.OilVegetable")
		square:transmitModdata()
		DeepFryers:transmitModData()
		return
	elseif foodChoice == "Empty Vat" and VatStatus == "CookingOil" then
		--player:Say(FA.translation.sayoptionunavailable)
		DeepFryers:getModData()['VatOil'] = "Empty"
		inv:AddItem("SapphCooking.PeanutOil")
		square:transmitModdata()
		DeepFryers:transmitModData()
		return
	elseif foodChoice == "Fill Vat" and VatStatus == "Empty" then
		if Oil ~= nil then
			DeepFryers:getModData()['VatOil'] = "VegetableOil"
			inv:Remove("OilVegetable")
		else
			DeepFryers:getModData()['VatOil'] = "CookingOil"
			inv:Remove("PeanutOil")
		end	
		square:transmitModdata()
		DeepFryers:transmitModData()			
		return
	end

	if VatStatus == "Empty" then
		player:Say(FA.translation.sayvatsemptyneedoil)
		return
	end

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		player:Say(FA.translation.sayneedagenerator)
		return
	end

	if not DeepFryers:Activated() then
		player:Say(FA.translation.sayneedstobeturnedon)
		return
	end

	if foodChoice == "Not Found French Fries" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.potatowedges .. " or " .. FA.translation.cutpotatoes)
		return
	elseif foodChoice == "Not Found Potato Skins" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.potatoskins .. " or " .. FA.translation.potatopeels)
		return
	elseif foodChoice == "Not Found Onion Rings" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredonionrings)
		return
	elseif foodChoice == "Not Found Blooming Onion" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredbloomingonion)
		return
	elseif foodChoice == "Not Found Tortillas" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.cuttortillas)
		return
	elseif foodChoice == "Not Found Shrimp" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredshrimp)
		return
	elseif foodChoice == "Not Found Fish Fillet" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredfishfillet)
		return
	elseif foodChoice == "Not Found Corndog" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredsausage)
		return
	elseif foodChoice == "Not Found Fried Chicken" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredchicken)
		return
	elseif foodChoice == "Not Found Chicken Fillet" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredchickenfillet)
		return
	elseif foodChoice == "Not Found Chicken Tenders" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredslicedchicken)
		return
	elseif foodChoice == "Not Found Chicken Nuggets" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredchickennuggets)
		return
	elseif foodChoice == "Not Found Doughboy" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.breaddough .. " or " .. FA.translation.smalldough .. " or " .. FA.translation.dough .. " or " .. FA.translation.pastrydough)
		return
	elseif foodChoice == "Not Found Doughnut" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.donutshapeddough .. " or " .. FA.translation.pastrydough .. " or " .. FA.translation.smalldough .. " or " .. FA.translation.dough)
		return
	elseif foodChoice == "Not Found Churros" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.pastrydough .. " or " .. FA.translation.dough .. " or " .. FA.translation.smalldough)
		return
	elseif foodChoice == "Not Found Cheese Sticks" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.batteredcheesesticks)
		return
	end

	ISTimedActionQueue.add(UseDeepFryers:new(player, DeepFryers, soundFile, foodChoice, squareToTurn))	
end