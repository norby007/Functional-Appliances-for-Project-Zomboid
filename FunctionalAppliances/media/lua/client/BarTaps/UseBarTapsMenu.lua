UseBarTapsMenu = {};
UseBarTapsMenu.doBuildMenu = function(player, context, worldobjects)

	local BarTapsObject = nil
	local tapCounter = nil
	local foundKeg1 = nil
	local foundKeg2 = nil
	local foundKeg3 = nil
	local foundKeg4 = nil
	local kegName1 = nil
	local kegName2 = nil
	local kegName3 = nil
	local kegName4 = nil

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
				
				local groupName = nil

				if properties:Is("GroupName") then
					groupName = properties:Val("GroupName")
				end
				
				if groupName == "Bar Tap" then				
					BarTapsObject = thisObject
					break
				end
				
			end 
		end 
	end

	if not BarTapsObject then 
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
				
				if customName == "Counter" then	
					tapCounter = thisObject
					break
				end
			end 
		end
	end

	if not tapCounter then 
		return 
	end

	tapCounter:getContainer():requestSync()

	local counterItems = tapCounter:getItemContainer():getItems()

	for i=0, counterItems:size()-1 do
        	local item = counterItems:get(i)
		local itemDisplayName = nil

		if item and item:getDisplayName() then
			itemDisplayName = item:getDisplayName()
		end

		if (itemDisplayName == "Keg of Bub Beer" or itemDisplayName == "Keg of Bub Lite Beer" or itemDisplayName == "Keg of Swiller Beer" or itemDisplayName == "Keg of Swiller Lite Beer" or itemDisplayName == "Keg of Home Brew Beer" or itemDisplayName == "Empty Keg") or
			(itemDisplayName == "Keg of Beer [American Lager]" or itemDisplayName == "Keg of Beer [Dark American Pale Ale]" or itemDisplayName == "Keg of Beer [Light American Pale Ale]" or itemDisplayName == "Keg of Beer [Light India Pale Ale]" or itemDisplayName == "Keg of Beer [Dark India Pale Ale]") or
			(itemDisplayName == "Keg of Beer [Light Lager]" or itemDisplayName == "Keg of Beer [Pilsner]" or itemDisplayName == "Keg of Beer [Porter]" or itemDisplayName == "Keg of Beer [Stout]" or itemDisplayName == "Keg of Beer [Skunked]") then
			if not foundKeg1 then
				foundKeg1 = item
				kegName1 = itemDisplayName
			elseif not foundKeg2 then
				foundKeg2 = item
				kegName2 = itemDisplayName
			elseif not foundKeg3 then
				foundKeg3 = item
				kegName3 = itemDisplayName
			elseif not foundKeg4 then
				foundKeg4 = item
				kegName4 = itemDisplayName
			end
		end
	end

	if not foundKeg1 then 
		return 
	end

	local soundFile = nil
	local contextMenu = nil
	local subContext = nil
	
	soundFile = "sodafountain_sound"
	
	contextMenu = context:addOption("Dispense From")
	subContext = ISContextMenu:getNew(context);

	context:addSubMenu(contextMenu, subContext)

	if foundKeg1 then
		subContext:addOption(kegName1,
				  worldobjects,
				  UseBarTapsMenu.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTapsObject,
				  soundFile, "Beer", foundKeg1)
	end
	if foundKeg2 then
		subContext:addOption(kegName2,
				  worldobjects,
				  UseBarTapsMenu.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTapsObject,
				  soundFile, "Beer", foundKeg2)
	end
	if foundKeg3 then
		subContext:addOption(kegName3,
				  worldobjects,
				  UseBarTapsMenu.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTapsObject,
				  soundFile, "Beer", foundKeg3)
	end
	if foundKeg4 then
		subContext:addOption(kegName4,
				  worldobjects,
				  UseBarTapsMenu.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTapsObject,
				  soundFile, "Beer", foundKeg4)
	end

	local contextMenu2 = nil
	local subContext2 = nil

	contextMenu2 = context:addOption("Refill Beer Bottle From")
	subContext2 = ISContextMenu:getNew(context);

	context:addSubMenu(contextMenu2, subContext2)

	if foundKeg1 then
		subContext2:addOption(kegName1,
				  worldobjects,
				  UseBarTapsMenu.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTapsObject,
				  soundFile, "RefillBeerBottle", foundKeg1)
	end
	if foundKeg2 then
		subContext2:addOption(kegName2,
				  worldobjects,
				  UseBarTapsMenu.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTapsObject,
				  soundFile, "RefillBeerBottle", foundKeg2)
	end
	if foundKeg3 then
		subContext2:addOption(kegName3,
				  worldobjects,
				  UseBarTapsMenu.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTapsObject,
				  soundFile, "RefillBeerBottle", foundKeg3)
	end
	if foundKeg4 then
		subContext2:addOption(kegName4,
				  worldobjects,
				  UseBarTapsMenu.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTapsObject,
				  soundFile, "RefillBeerBottle", foundKeg4)
	end


	local contextMenu3 = nil
	local subContext3 = nil

	contextMenu3 = context:addOption("Correct Bar Tap Facing")
	subContext3 = ISContextMenu:getNew(context);

	context:addSubMenu(contextMenu3, subContext3)

	subContext3:addOption("Pour from East",
				  worldobjects,
				  FixBarTapFacing,
				  getSpecificPlayer(player),
				  BarTapsObject, "E")
	subContext3:addOption("Pour from West",
				  worldobjects,
				  FixBarTapFacing,
				  getSpecificPlayer(player),
				  BarTapsObject, "W")

end

function FixBarTapFacing(worldobjects, player, machine, direction)
	local properties = machine:getSprite():getProperties()

	if properties:Is("Facing") then
		machine:getSprite():getProperties():Set("Facing", direction)
	end
end


function MachineNoPower(player)
	player:Say("I will need a generator nearby to power it.")
end

function MachineNoKeg(player)
	player:Say("This bar tap is not connected to a keg.")
end

function MachineEmptyKeg(player)
	player:Say("This bar tap is connected to an empty keg.")
end

function MachineNoBottle(player)
	player:Say("I'll need an empty bottle to fill.")
end

function MachineNoMug(player)
	player:Say("I'll need a plastic cup or beer mug to fill.")
end

UseBarTapsMenu.getFrontSquare = function(square, facing)
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


UseBarTapsMenu.getFacing = function(properties, square)

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

UseBarTapsMenu.walkToFront = function(thisPlayer, BarTapsObject)
	local controllerSquare = nil
	local spriteName = BarTapsObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = BarTapsObject:getSprite():getProperties()
	local facing = UseBarTapsMenu.getFacing(properties, BarTapsObject:getSquare())
	if facing == nil then
		thisPlayer:Say("I am unable to access this machine, the path is blocked.")
		return false
	end
	
	local frontSquare = UseBarTapsMenu.getFrontSquare(BarTapsObject:getSquare(), facing)
	local turn = UseBarTapsMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local BarTapsSquare = BarTapsObject:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(BarTapsSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		if turn then
			thisPlayer:faceLocation(BarTapsSquare:getX(), BarTapsSquare:getY())
		end
		return true
	end

	return false
end


UseBarTapsMenu.onUseBarTaps = function(worldobjects, player, machine, soundFile, flavorChoice, foundKeg)
	if not UseBarTapsMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()
	local inv = player:getInventory()

	local FABeerMug = inv:FindAndReturn("FunctionalAppliances.FABeerMug")
	local vanillaPlasticCup = inv:FindAndReturn("Base.PlasticCup")
	local FAPlasticCup = inv:FindAndReturn("FunctionalAppliances.FAPlasticCup")
	local emptyBeerBottle = inv:FindAndReturn("Base.BeerEmpty")
		
	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		MachineNoPower(player)
	elseif (flavorChoice == "Beer" or flavorChoice == "RefillBeerBottle") and not foundKeg then
		MachineNoKeg(player)
	elseif (flavorChoice == "Beer" or flavorChoice == "RefillBeerBottle") and foundKeg:getDisplayName() == "Empty Keg" then
		MachineEmptyKeg(player)
	elseif flavorChoice == "Beer" and (vanillaPlasticCup or FAPlasticCup or FABeerMug) then
		ISTimedActionQueue.add(UseBarTaps:new(player, machine, soundFile, flavorChoice, foundKeg, squareToTurn))
	elseif flavorChoice == "RefillBeerBottle" and emptyBeerBottle then
		ISTimedActionQueue.add(UseBarTaps:new(player, machine, soundFile, flavorChoice, foundKeg, squareToTurn))
	elseif flavorChoice == "RefillBeerBottle" then
		MachineNoBottle(player)
	elseif flavorChoice == "Beer" then
		MachineNoMug(player)
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(UseBarTapsMenu.doBuildMenu)