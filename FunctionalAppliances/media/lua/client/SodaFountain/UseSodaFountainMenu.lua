UseSodaFountainMenu = {};
UseSodaFountainMenu.doBuildMenu = function(player, context, worldobjects)

	local sodaFountainName = nil
	local SodaFountainObject = nil
	local fountainCounter = nil
	local counterItems = nil
	local foundCO2 = nil
	local foundSyrup1 = nil
	local foundSyrup2 = nil
	local foundSyrup3 = nil
	local foundSyrup4 = nil

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()

		if not square then
			return
		end
	
		for i=1,square:getObjects():size() do
			local thisObject = square:getObjects():get(i-1)
			
			if thisObject:getSprite() then
				local properties = thisObject:getSprite():getProperties()
				local spr = thisObject:getSprite():getName()  

				if properties == nil then
					return
				end
				
				local groupName = nil
				
				if properties:Is("GroupName") then
					groupName = properties:Val("GroupName")
				end
				
				if groupName == "Tabletop Soda" then				
					SodaFountainObject = thisObject
					SodaFountainName = "Tabletop Soda Machine"
					SodaFountainObject:getSprite():getProperties():Set(IsoFlagType.waterPiped, "TRUE")
					break
				end

				if groupName == "SlurpBurp" then				
					SodaFountainObject = thisObject
					SodaFountainName = "Slurp Burp Soda Machine"
					SodaFountainObject:getSprite():getProperties():Set(IsoFlagType.waterPiped, "TRUE")
					if not SodaFountainObject:getContainer() then
						local index = SodaFountainObject:getObjectIndex()
               					sledgeDestroy(SodaFountainObject)
						SodaFountainObject:getSquare():transmitRemoveItemFromSquareOnServer(SodaFountainObject)
						SodaFountainObject:getSquare():transmitRemoveItemFromSquare(SodaFountainObject)            

                				SodaFountainObject = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
                				SodaFountainObject:setIsContainer(true)
                				SodaFountainObject:getContainer():setType("slurpNBurp")
                				SodaFountainObject:getContainer():setCapacity(100)
						SodaFountainObject:getSprite():getProperties():Set(IsoFlagType.waterPiped, "TRUE")

                				square:AddTileObject(SodaFountainObject, index)
						square:transmitAddObjectToSquare(SodaFountainObject, SodaFountainObject:getObjectIndex())
						square:transmitModdata()
						SodaFountainObject:transmitModData()	
              					SodaFountainObject:transmitCompleteItemToServer()
                				SodaFountainObject:transmitUpdatedSpriteToServer()
					end
					break
				end
				
			end 
		end 
	end

	if not SodaFountainObject then 
		return 
	end

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()
		if not square then
			return
		end
		
		for i=1,square:getObjects():size() do
			local thisObject = square:getObjects():get(i-1)
		
			if thisObject:getSprite() then
				local properties = thisObject:getSprite():getProperties()
				if properties == nil then
					return
				end
			
				local customName = nil
	
				if properties:Is("CustomName") then
					customName = properties:Val("CustomName")
				end
				
				if customName == "Counter" or customName == "Square Theater Counter" or customName == "Soda Machine" then	
					fountainCounter = thisObject
					break
				end
			end 
		end
	end

	if not fountainCounter then 
		return 
	end

	if fountainCounter:getContainer() then
		counterItems = fountainCounter:getItemContainer():getItems()
		fountainCounter:getContainer():requestSync()
	else
		return
	end

	for i=0, counterItems:size()-1 do
        	local item = counterItems:get(i)
		local itemDisplayName = nil

		if item and item:getDisplayName() then
			itemDisplayName = item:getDisplayName()
		end

		if itemDisplayName == "CO2 Tank" or itemDisplayName == "DIY CO2 Tank" then
			foundCO2 = item
		end

		if (itemDisplayName == "Box of Orange Soda Syrup" or itemDisplayName == "Box of Lemon Lime Soda Syrup" or itemDisplayName == "Box of Root Beer Soda Syrup" or itemDisplayName == "Box of KY Cola Soda Syrup" or itemDisplayName == "Box of Soda Syrup" or itemDisplayName == "Empty Box of Soda Syrup" or itemDisplayName == "Box of Berry Flavored Soda Syrup") then
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
	end

	if not foundCO2 then 
		return 
	end

	if not foundSyrup1 then 
		return 
	end

	local soundFile = nil
	local contextMenu = nil
	local subContext = nil
	
	soundFile = "sodafountain_sound"

	local syrupName1 = nil
	local syrupName2 = nil
	local syrupName3 = nil
	local syrupName4 = nil

	if foundSyrup1 then
		syrupName1 = foundSyrup1:getDisplayName()
	end
	if foundSyrup2 then
		syrupName2 = foundSyrup2:getDisplayName()
	end
	if foundSyrup3 then
		syrupName3 = foundSyrup3:getDisplayName()
	end
	if foundSyrup4 then
		syrupName4 = foundSyrup4:getDisplayName()
	end

	if syrupName1 == "Box of Orange Soda Syrup" then
		syrupName1 = "Orange Soda"
	elseif syrupName1 == "Box of Lemon Lime Soda Syrup" then
		syrupName1 = "Lemon Lime Soda"
	elseif syrupName1 == "Box of Root Beer Soda Syrup" then
		syrupName1 = "Root Beer"
	elseif syrupName1 == "Box of KY Cola Soda Syrup" then
		syrupName1 = "KY Cola"
	elseif syrupName1 == "Box of Berry Flavored Soda Syrup" then
		syrupName1 = "Homemade Berry Flavored Soda"
	else	
		syrupName1 = "Carbonated Water"
	end

	if syrupName2 == "Box of Orange Soda Syrup" then
		syrupName2 = "Orange Soda"
	elseif syrupName2 == "Box of Lemon Lime Soda Syrup" then
		syrupName2 = "Lemon Lime Soda"
	elseif syrupName2 == "Box of Root Beer Soda Syrup" then
		syrupName2 = "Root Beer"
	elseif syrupName2 == "Box of KY Cola Soda Syrup" then
		syrupName2 = "KY Cola"
	elseif syrupName2 == "Box of Berry Flavored Soda Syrup" then
		syrupName2 = "Homemade Berry Flavored Soda"
	else	
		syrupName2 = "Carbonated Water"
	end

	if syrupName3 == "Box of Orange Soda Syrup" then
		syrupName3 = "Orange Soda"
	elseif syrupName3 == "Box of Lemon Lime Soda Syrup" then
		syrupName3 = "Lemon Lime Soda"
	elseif syrupName3 == "Box of Root Beer Soda Syrup" then
		syrupName3 = "Root Beer"
	elseif syrupName3 == "Box of KY Cola Soda Syrup" then
		syrupName3 = "KY Cola"
	elseif syrupName3 == "Box of Berry Flavored Soda Syrup" then
		syrupName3 = "Homemade Berry Flavored Soda"
	else	
		syrupName3 = "Carbonated Water"
	end

	if syrupName4 == "Box of Orange Soda Syrup" then
		syrupName4 = "Orange Soda"
	elseif syrupName4 == "Box of Lemon Lime Soda Syrup" then
		syrupName4 = "Lemon Lime Soda"
	elseif syrupName4 == "Box of Root Beer Soda Syrup" then
		syrupName4 = "Root Beer"
	elseif syrupName4 == "Box of KY Cola Soda Syrup" then
		syrupName4 = "KY Cola"
	elseif syrupName4 == "Box of Berry Flavored Soda Syrup" then
		syrupName4 = "Homemade Berry Flavored Soda"
	else	
		syrupName4 = "Carbonated Water"
	end

	contextMenu = context:addOption("Dispense")
	subContext = ISContextMenu:getNew(context);

	context:addSubMenu(contextMenu, subContext)

	if foundSyrup1 then
		subContext:addOption(syrupName1,
				  worldobjects,
				  UseSodaFountainMenu.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountainObject,
				  soundFile, "Soda", foundSyrup1, foundCO2)
	end
	if foundSyrup2 then
		subContext:addOption(syrupName2,
				  worldobjects,
				  UseSodaFountainMenu.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountainObject,
				  soundFile, "Soda", foundSyrup2, foundCO2)
	end
	if foundSyrup3 then
		subContext:addOption(syrupName3,
				  worldobjects,
				  UseSodaFountainMenu.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountainObject,
				  soundFile, "Soda", foundSyrup3, foundCO2)
	end
	if foundSyrup4 then
		subContext:addOption(syrupName4,
				  worldobjects,
				  UseSodaFountainMenu.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountainObject,
				  soundFile, "Soda", foundSyrup4, foundCO2)
	end

	local contextMenu2 = nil
	local subContext2 = nil

	contextMenu2 = context:addOption("Refill Soda Bottle With")
	subContext2 = ISContextMenu:getNew(context);

	context:addSubMenu(contextMenu2, subContext2)

	if foundSyrup1 then
		subContext2:addOption(syrupName1,
				  worldobjects,
				  UseSodaFountainMenu.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountainObject,
				  soundFile, "RefillSodaBottle", foundSyrup1, foundCO2)
	end
	if foundSyrup2 then
		subContext2:addOption(syrupName2,
				  worldobjects,
				  UseSodaFountainMenu.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountainObject,
				  soundFile, "RefillSodaBottle", foundSyrup2, foundCO2)
	end
	if foundSyrup3 then
		subContext2:addOption(syrupName3,
				  worldobjects,
				  UseSodaFountainMenu.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountainObject,
				  soundFile, "RefillSodaBottle", foundSyrup3, foundCO2)
	end
	if foundSyrup4 then
		subContext2:addOption(syrupName4,
				  worldobjects,
				  UseSodaFountainMenu.onUseSodaFountain,
				  getSpecificPlayer(player),
				  SodaFountainObject,
				  soundFile, "RefillSodaBottle", foundSyrup4, foundCO2)
	end
end

UseSodaFountainMenu.getFrontSquare = function(square, facing)
	local value = nil
	
	if facing == "S" then
		value = square:getS()
	elseif facing == "E" then
		value = square:getE()
	elseif facing == "W" then
		value = square:getW()
	elseif facing == "N" then
		value = square:getN()
	end
	
	return value
end

UseSodaFountainMenu.getFacing = function(properties, square)

	local facing = nil

	if properties:Is("Facing") then
		facing = properties:Val("Facing")
	end

	if square:getE() and facing == "E" then
		facing = "E"
	elseif square:getS() and facing == "S" then
		facing = "S" 
	elseif square:getW() and facing == "W" then
		facing = "W"
	elseif square:getN() and facing == "N" then
		facing = "N"
	else 
		facing = nil
	end

	return facing
end

UseSodaFountainMenu.walkToFront = function(thisPlayer, SodaFountainObject)

	local controllerSquare = nil
	local spriteName = SodaFountainObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = SodaFountainObject:getSprite():getProperties()
	local facing = UseSodaFountainMenu.getFacing(properties, SodaFountainObject:getSquare())
	if facing == nil then
		thisPlayer:Say("I am unable to access this machine, the path is blocked.")
		return false
	end
	
	local frontSquare = UseSodaFountainMenu.getFrontSquare(SodaFountainObject:getSquare(), facing)
	local turn = UseSodaFountainMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local SodaFountainSquare = SodaFountainObject:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(SodaFountainSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		if turn then
			thisPlayer:faceLocation(SodaFountainSquare:getX(), SodaFountainSquare:getY())
		end
		return true
	end

	return false
end

UseSodaFountainMenu.onUseSodaFountain = function(worldobjects, player, machine, soundFile, flavorChoice, foundSyrup, foundCO2)
	if not UseSodaFountainMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()
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

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		player:Say("I will need a generator nearby to power it.")
		return
	end

	--if not (SandboxVars.WaterShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.WaterShutModifier and square:isOutside() == false) and (machine:getSprite():getProperties():Is(IsoFlagType.waterPiped) == false or machine:getWaterAmount() < changeWaterAmount) then
	--	player:Say("This machine needs more water.")
	--	return
	--end

	if machine:getWaterAmount() < changeWaterAmount then
		player:Say("This machine needs more water.")
		return
	elseif not machine:getSprite():getProperties():Is(IsoFlagType.waterPiped) then
		player:Say("This machine needs to be plumbed first.")
		return
	end
	--elseif not (SandboxVars.WaterShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.WaterShutModifier and square:isOutside() == false) then
	--	player:Say("This machine needs more water.")
	--	return
	--end

	if flavorChoice == "Soda" and (vanillaFountainCup or FAFountainCup) then
		ISTimedActionQueue.add(UseSodaFountain:new(player, machine, soundFile, flavorChoice, foundSyrup, foundCO2, squareToTurn))
	elseif flavorChoice == "RefillSodaBottle" and (emptyPopBottle or emptyWaterBottle) then
		ISTimedActionQueue.add(UseSodaFountain:new(player, machine, soundFile, flavorChoice, foundSyrup, foundCO2, squareToTurn))
	elseif flavorChoice == "RefillSodaBottle" then
		player:Say("I'll need an empty water or soda bottle to fill.")
	elseif flavorChoice == "Soda" then
		player:Say("I'll need a fountain cup to fill.")
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(UseSodaFountainMenu.doBuildMenu);