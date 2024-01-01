UseHeatedCounterMenu = {};
UseHeatedCounterMenu.doBuildMenu = function(player, context, worldobjects)

	local HeatedCounterObject = nil

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
				local groupName = nil

				if properties:Is("CustomName") then
					customName = properties:Val("CustomName")
				end

				if properties:Is("GroupName") then
					groupName = properties:Val("GroupName")
				end
				
				if properties:Val("CustomName") == "Counter" and (properties:Val("GroupName") == "Corner A" or properties:Val("GroupName") == "Corner B" or properties:Val("GroupName") == "Middle") then				
					HeatedCounterObject = thisObject
					if HeatedCounterObject:getModData()['CustomTemp'] == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
						HeatedCounterObject:getContainer():setCustomTemperature(1.5) 	-- just below cooking
						HeatedCounterObject:getModData()['CustomTemp'] = "Warm" 
					elseif HeatedCounterObject:getModData()['CustomTemp'] == "Hot" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
						HeatedCounterObject:getContainer():setCustomTemperature(1.61) 	-- just enough to start cooking
						HeatedCounterObject:getModData()['CustomTemp'] = "Hot" 
					elseif HeatedCounterObject:getModData()['CustomTemp'] == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
						HeatedCounterObject:getContainer():setCustomTemperature(0.25) 	-- cold
						HeatedCounterObject:getModData()['CustomTemp'] = "Cold" 
					else
						HeatedCounterObject:getContainer():setCustomTemperature(1) -- room temp
						HeatedCounterObject:getModData()['CustomTemp'] = "Off"
					end
					square:transmitModdata()
					HeatedCounterObject:transmitModData()	
					break
				end
				
			end 
		end 
	end

	if not HeatedCounterObject then 
		return 
	end

	HeatedCounterObject:getContainer():requestSync()

	local contextMenu = nil
	local subContext = nil

	contextMenu = context:addOption("Change Setting")
	subContext = ISContextMenu:getNew(context);

	context:addSubMenu(contextMenu, subContext)

	if HeatedCounterObject:getModData()['CustomTemp'] == "Off" then
		subContext:addOption("[Currently Off] Set To Warm",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Warm")
		subContext:addOption("[Currently Off] Set To Hot",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Hot")
		subContext:addOption("[Currently Off] Set To Cold",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Cold")
	elseif HeatedCounterObject:getModData()['CustomTemp'] == "Warm" then
		subContext:addOption("[Currently Warm] Set To Off",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Off")
		subContext:addOption("[Currently Warm] Set To Hot",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Hot")
		subContext:addOption("[Currently Warm] Set To Cold",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Cold")
	elseif HeatedCounterObject:getModData()['CustomTemp'] == "Hot" then
		subContext:addOption("[Currently Hot] Set To Off",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Off")
		subContext:addOption("[Currently Hot] Set To Warm",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Warm")
		subContext:addOption("[Currently Hot] Set To Cold",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Cold")
	elseif HeatedCounterObject:getModData()['CustomTemp'] == "Cold" then
		subContext:addOption("[Currently Cold] Set To Off",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Off")
		subContext:addOption("[Currently Cold] Set To Warm",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Warm")
		subContext:addOption("[Currently Cold] Set To Hot",
				  worldobjects,
				  UseHeatedCounterMenu.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounterObject,
				  "Hot")
	end

end


UseHeatedCounterMenu.getFrontSquare = function(square, facing)
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


UseHeatedCounterMenu.getFacing = function(properties, square)

	local facing = nil

	if properties:Is("Facing") then
		facing = properties:Val("Facing")
	end

	if square:getE() and facing == "E" then
		facing = "W" 
	elseif square:getS() and facing == "S" then
		facing = "N" 
	elseif square:getW() and facing == "W" then
		facing = "E"
	elseif square:getN() and facing == "N" then
		facing = "S"
	else 
		facing = nil
	end

	return facing
end


UseHeatedCounterMenu.walkToFront = function(thisPlayer, HeatedCounterObject)

	local controllerSquare = nil
	local spriteName = HeatedCounterObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = HeatedCounterObject:getSprite():getProperties()
	local facing = UseHeatedCounterMenu.getFacing(properties, HeatedCounterObject:getSquare())
	if facing == nil then
		thisPlayer:Say("I am unable to access this machine, the path is blocked.")
		return false
	end
	
	local frontSquare = UseHeatedCounterMenu.getFrontSquare(HeatedCounterObject:getSquare(), facing)
	local turn = UseHeatedCounterMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local HeatedCounterSquare = HeatedCounterObject:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(HeatedCounterSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		if turn then
			thisPlayer:faceLocation(HeatedCounterSquare:getX(), HeatedCounterSquare:getY())
		end
		return true
	end

	return false
end

UseHeatedCounterMenu.onUseHeatedCounter = function(worldobjects, player, machine, tempSetting)
	if not UseHeatedCounterMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()

	if tempSetting == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		machine:getContainer():setCustomTemperature(1.5) 	-- just below cooking
		machine:getModData()['CustomTemp'] = "Warm" 
	elseif tempSetting == "Hot" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		machine:getContainer():setCustomTemperature(1.61) 	-- just enough to start cooking
		machine:getModData()['CustomTemp'] = "Hot" 
	elseif tempSetting == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		machine:getContainer():setCustomTemperature(0.25) 	-- cold
		machine:getModData()['CustomTemp'] = "Cold" 
	elseif tempSetting == "Off" then
		machine:getContainer():setCustomTemperature(1) -- room temp
		machine:getModData()['CustomTemp'] = "Off"
	else
		machine:getContainer():setCustomTemperature(1) -- room temp
		machine:getModData()['CustomTemp'] = "Off"
		player:Say("I will need a generator nearby to power it.")
	end		

	machine:getContainer():requestSync()
	square:transmitModdata()
	machine:transmitModData()	
       	--machine:transmitCompleteItemToServer()
	--machine:transmitUpdatedSpriteToServer()
end

Events.OnPreFillWorldObjectContextMenu.Add(UseHeatedCounterMenu.doBuildMenu);