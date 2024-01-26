FASodaFountain = FASodaFountain or {}

FASodaFountain.doBuildMenu = function(player, menu, square, SodaFountain)
	local foundCO2 = nil
	local foundSyrup1 = nil
	local foundSyrup2 = nil
	local foundSyrup3 = nil
	local foundSyrup4 = nil
	local foundWaterJug = nil

	for index=1,square:getObjects():size() do
		local thisObject = square:getObjects():get(index-1)
		local containerItems = nil
		
		if thisObject:getContainer() then
			containerItems = thisObject:getItemContainer():getItems()
		end

		if containerItems ~= nil then
			for i=0, containerItems:size()-1 do
        			local item = containerItems:get(i)
				local itemType = nil

				if item and item:getType() then
					itemType = item:getType()
				end

				if itemType == "WaterJugWaterFull" and not foundWaterJug and item:getRemainingUses() > 0 then
					foundWaterJug = item
				end

				if itemType == "FACO2Tank" or itemType == "FADIYCO2Tank" and not foundCO2 then
					foundCO2 = item
				end

				if (itemType == "FAOrangeSodaSyrupBox" or itemType == "FALemonLimeSodaSyrupBox" or itemType == "FARootBeerSodaSyrupBox" or itemType == "FAColaSodaSyrupBox" or itemType == "FAMixedBerriesSodaSyrupBox" or itemType == "FAEmptySodaSyrupBox") then
					if not foundSyrup1 then
						foundSyrup1 = item
					elseif not foundSyrup2 then
						foundSyrup2 = item
					elseif not foundSyrup3 then
						foundSyrup3 = item
					elseif not foundSyrup4 then
						foundSyrup4 = item	
					end
				end
				
				if foundCO2 and foundSyrup4 and foundWaterJug then
					break
				end
			end
		end
		if foundCO2 and foundSyrup4 and foundWaterJug then
			break
		end
	end
	
	local facing = SodaFountain:getSprite():getProperties():Val("Facing")
	local rearSquare = FA.getRearSquare(square, facing)

	if (not foundCO2 or not foundSyrup4) and rearSquare then
		for index=1,rearSquare:getObjects():size() do
			local thisObject = rearSquare:getObjects():get(index-1)
			local containerItems = nil
		
			if thisObject:getContainer() then
				containerItems = thisObject:getItemContainer():getItems()
			end

			if containerItems ~= nil then
				for i=0, containerItems:size()-1 do
        				local item = containerItems:get(i)
					local itemType = nil

					if item and item:getType() then
						itemType = item:getType()
					end

					if itemType == "WaterJugWaterFull" and not foundWaterJug and item:getRemainingUses() > 0 then
						foundWaterJug = item
					end

					if itemType == "FACO2Tank" or itemType == "FADIYCO2Tank" and not foundCO2 then
						foundCO2 = item
					end

					if (itemType == "FAOrangeSodaSyrupBox" or itemType == "FALemonLimeSodaSyrupBox" or itemType == "FARootBeerSodaSyrupBox" or itemType == "FAColaSodaSyrupBox" or itemType == "FAMixedBerriesSodaSyrupBox" or itemType == "FAEmptySodaSyrupBox") then
						if not foundSyrup1 then
							foundSyrup1 = item
						elseif not foundSyrup2 then
							foundSyrup2 = item
						elseif not foundSyrup3 then
							foundSyrup3 = item
						elseif not foundSyrup4 then
							foundSyrup4 = item	
						end
					end
					
					if foundCO2 and foundSyrup4 and foundWaterJug then
						break
					end
				end
			end
			if foundCO2 and foundSyrup4 and foundWaterJug then
				break
			end
		end
	end

	if not foundCO2 and not foundSyrup1 then
		menu:addOptionOnTop(FA.translation.nosyrupboxesconnected)
		menu:addOptionOnTop(FA.translation.noco2tankconnected)
		return
	elseif not foundCO2 then
		menu:addOptionOnTop(FA.translation.noco2tankconnected)
		return 
	elseif not foundSyrup1 then 
		menu:addOptionOnTop(FA.translation.nosyrupboxesconnected)
		return 
	end

	local soundFile = "sodafountain_sound"

	local syrupName1 = nil
	local syrupName2 = nil
	local syrupName3 = nil
	local syrupName4 = nil

	if foundSyrup1 then
		if foundSyrup1:getType() == "FAMixedBerriesSodaSyrupBox" then
			syrupName1 = FA.translation.homemadeberryflavoredsoda
		elseif foundSyrup1:getType() == "FAOrangeSodaSyrupBox" then
			syrupName1 = FA.translation.orangesoda
		elseif foundSyrup1:getType() == "FALemonLimeSodaSyrupBox" then
			syrupName1 = FA.translation.lemonlimesoda
		elseif foundSyrup1:getType() == "FARootBeerSodaSyrupBox" then
			syrupName1 = FA.translation.rootbeer
		elseif foundSyrup1:getType() == "FAColaSodaSyrupBox" then
			syrupName1 = FA.translation.kycola
		else
			syrupName1 = FA.translation.carbonatedwater
		end
	end
	if foundSyrup2 then
		if foundSyrup2:getType() == "FAMixedBerriesSodaSyrupBox" then
			syrupName2 = FA.translation.homemadeberryflavoredsoda
		elseif foundSyrup2:getType() == "FAOrangeSodaSyrupBox" then
			syrupName2 = FA.translation.orangesoda
		elseif foundSyrup2:getType() == "FALemonLimeSodaSyrupBox" then
			syrupName2 = FA.translation.lemonlimesoda
		elseif foundSyrup2:getType() == "FARootBeerSodaSyrupBox" then
			syrupName2 = FA.translation.rootbeer
		elseif foundSyrup2:getType() == "FAColaSodaSyrupBox" then
			syrupName2 = FA.translation.kycola
		else
			syrupName2 = FA.translation.carbonatedwater
		end
	end
	if foundSyrup3 then
		if foundSyrup3:getType() == "FAMixedBerriesSodaSyrupBox" then
			syrupName3 = FA.translation.homemadeberryflavoredsoda
		elseif foundSyrup3:getType() == "FAOrangeSodaSyrupBox" then
			syrupName3 = FA.translation.orangesoda
		elseif foundSyrup3:getType() == "FALemonLimeSodaSyrupBox" then
			syrupName3 = FA.translation.lemonlimesoda
		elseif foundSyrup3:getType() == "FARootBeerSodaSyrupBox" then
			syrupName3 = FA.translation.rootbeer
		elseif foundSyrup3:getType() == "FAColaSodaSyrupBox" then
			syrupName3 = FA.translation.kycola
		else
			syrupName3 = FA.translation.carbonatedwater
		end
	end
	if foundSyrup4 then
		if foundSyrup4:getType() == "FAMixedBerriesSodaSyrupBox" then
			syrupName4 = FA.translation.homemadeberryflavoredsoda
		elseif foundSyrup4:getType() == "FAOrangeSodaSyrupBox" then
			syrupName4 = FA.translation.orangesoda
		elseif foundSyrup4:getType() == "FALemonLimeSodaSyrupBox" then
			syrupName4 = FA.translation.lemonlimesoda
		elseif foundSyrup4:getType() == "FARootBeerSodaSyrupBox" then
			syrupName4 = FA.translation.rootbeer
		elseif foundSyrup4:getType() == "FAColaSodaSyrupBox" then
			syrupName4 = FA.translation.kycola
		else
			syrupName4 = FA.translation.carbonatedwater
		end
	end

	local contextMenu = menu:addOption(FA.translation.dispense)
	local subContext = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu, subContext)

	if foundSyrup1 then
		subContext:addOption(syrupName1,
				  nil,	
				  FASodaFountain.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountain,
				  soundFile, "Soda", foundSyrup1, foundCO2, foundWaterJug)
	end
	if foundSyrup2 then
		subContext:addOption(syrupName2,
				  nil,	
				  FASodaFountain.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountain,
				  soundFile, "Soda", foundSyrup2, foundCO2, foundWaterJug)
	end
	if foundSyrup3 then
		subContext:addOption(syrupName3,
				  nil,	
				  FASodaFountain.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountain,
				  soundFile, "Soda", foundSyrup3, foundCO2, foundWaterJug)
	end
	if foundSyrup4 then
		subContext:addOption(syrupName4,
				  nil,	
				  FASodaFountain.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountain,
				  soundFile, "Soda", foundSyrup4, foundCO2, foundWaterJug)
	end

	local contextMenu2 = menu:addOption(FA.translation.refillsodabottlewith)
	local subContext2 = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu2, subContext2)

	if foundSyrup1 then
		subContext2:addOption(syrupName1,
				  nil,	
				  FASodaFountain.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountain,
				  soundFile, "RefillSodaBottle", foundSyrup1, foundCO2, foundWaterJug)
	end
	if foundSyrup2 then
		subContext2:addOption(syrupName2,
				  nil,	
				  FASodaFountain.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountain,
				  soundFile, "RefillSodaBottle", foundSyrup2, foundCO2, foundWaterJug)
	end
	if foundSyrup3 then
		subContext2:addOption(syrupName3,
				  nil,	
				  FASodaFountain.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountain,
				  soundFile, "RefillSodaBottle", foundSyrup3, foundCO2, foundWaterJug)
	end
	if foundSyrup4 then
		subContext2:addOption(syrupName4,
				  nil,	
				  FASodaFountain.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountain,
				  soundFile, "RefillSodaBottle", foundSyrup4, foundCO2, foundWaterJug)
	end
end

FASodaFountain.onUseSodaFountain = function(junk, player, SodaFountain, soundFile, flavorChoice, foundSyrup, foundCO2, foundWaterJug)
	if not FA.walkToFront(player, SodaFountain) then
		return
	end

	local square = SodaFountain:getSquare()
	local inv = player:getInventory()
	local emptyPopBottle = inv:FindAndReturn("Base.PopBottleEmpty")
	local emptyWaterBottle = inv:FindAndReturn("Base.WaterBottleEmpty")
	local vanillaFountainCup = inv:FindAndReturn("Base.FountainCup")
	local FAFountainCup = inv:FindAndReturn("FunctionalAppliances.FAFountainCup")
	local changeWaterAmount = 2

	if flavorChoice == "RefillSodaBottle" then
		changeWaterAmount = 4
	end

	local changeCO2Amount = 1

	if flavorChoice == "RefillSodaBottle" then
		changeCO2Amount = 2
	end

	local waterJugAmount = 0

	if foundWaterJug ~= nil then
		waterJugAmount = foundWaterJug:getRemainingUses()
	end

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		player:Say(FA.translation.sayneedagenerator)
		return
	end

	if square:isOutside() then
		player:Say(FA.translation.saysodafountainmustbeinside)
		return
	end

	if SodaFountain:getWaterAmount() < changeWaterAmount and waterJugAmount == 0 then
		player:Say(FA.translation.saysodafountainneedsmorewater)
		return
	elseif not SodaFountain:getSprite():getProperties():Is(IsoFlagType.waterPiped) and waterJugAmount == 0 then
		player:Say(FA.translation.saysodafountainneedsplumbing)
		return
	elseif foundWaterJug ~= nil and waterJugAmount < changeWaterAmount then
		player:Say(FA.translation.saysodafountainneedswaterinjug)
		return
	end

	if flavorChoice == "Soda" and (vanillaFountainCup or FAFountainCup) then
		ISTimedActionQueue.add(UseSodaFountain:new(player, SodaFountain, soundFile, flavorChoice, foundSyrup, foundCO2, foundWaterJug, squareToTurn))
	elseif flavorChoice == "RefillSodaBottle" and (emptyPopBottle or emptyWaterBottle) then
		ISTimedActionQueue.add(UseSodaFountain:new(player, SodaFountain, soundFile, flavorChoice, foundSyrup, foundCO2, foundWaterJug, squareToTurn))
	elseif flavorChoice == "RefillSodaBottle" then
		player:Say(FA.translation.sayneedsemptywaterorsodabottle)
	elseif flavorChoice == "Soda" then
		player:Say(FA.translation.sayneedfountaincup)
	end
end