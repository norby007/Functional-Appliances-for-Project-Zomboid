UseHotDogMachineMenu = {};
UseHotDogMachineMenu.doBuildMenu = function(player, context, worldobjects)

	local HotDogMachineObject = nil

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()

		if not square then
			return
		end
		
		for i=1,square:getObjects():size() do
			local thisObject = square:getObjects():get(i-1)
			
			if thisObject:getSprite() then
				properties = thisObject:getSprite():getProperties()
				spr = thisObject:getSprite():getName() 

				if properties == nil then
					return
				end
				
				local groupName = nil
	
				if properties:Is("GroupName") then
					groupName = properties:Val("GroupName")
				end
				
				if groupName == "Fossoil Candy" then			
					HotDogMachineObject = thisObject
					if not HotDogMachineObject:getContainer() then
						local index = HotDogMachineObject:getObjectIndex()
               					sledgeDestroy(HotDogMachineObject)
						HotDogMachineObject:getSquare():transmitRemoveItemFromSquareOnServer(HotDogMachineObject)
						HotDogMachineObject:getSquare():transmitRemoveItemFromSquare(HotDogMachineObject)            

                				HotDogMachineObject = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
                				HotDogMachineObject:setIsContainer(true)
                				HotDogMachineObject:getContainer():setType("hotdogMachine")
                				HotDogMachineObject:getContainer():setCapacity(5)

						if ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
							HotDogMachineObject:getContainer():setCustomTemperature(1.5)
						end

                				square:AddTileObject(HotDogMachineObject, index)
						square:transmitAddObjectToSquare(HotDogMachineObject, HotDogMachineObject:getObjectIndex())
						square:transmitModdata()
						HotDogMachineObject:transmitModData()	
              					HotDogMachineObject:transmitCompleteItemToServer()
                				HotDogMachineObject:transmitUpdatedSpriteToServer()
					elseif ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
						HotDogMachineObject:getContainer():setCustomTemperature(1.5)
					else
						HotDogMachineObject:getContainer():setCustomTemperature(1)
					end
					break
				end
				
			end
		end 
	end

	if not HotDogMachineObject then 
		return 
	end

	HotDogMachineObject:getContainer():requestSync()

	local soundFile = nil
	local contextMenu = nil
	
	local spriteName = HotDogMachineObject:getSprite():getName()
	soundFile = "hotdogmachine_sound"

	contextMenu = "Make A Hotdog"

	context:addOption(getText(contextMenu),
				  worldobjects,
				  UseHotDogMachineMenu.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachineObject,
				  soundFile, "Hotdog")

	local Sausage = nil
	local VSausage = nil
	local FSausage = nil
	local playerItems = getSpecificPlayer(player):getInventory():getItems()

	for i=0, playerItems:size()-1 do
        	local item = playerItems:get(i)
		local itemDisplayName = nil

		if item and item:getDisplayName() then
			itemDisplayName = item:getDisplayName()
		end

		if itemDisplayName == "Sausage" and not item:isCooked() then
			Sausage = item
		elseif itemDisplayName == "Vienna Sausage" and not item:isCooked() then
			VSausage = item
		elseif itemDisplayName == "Frankfurter Sausage" and not item:isCooked() then
			FSausage = item
		end
	end

	if Sausage or VSausage or FSausage then
		local contextMenu2 = nil
		local subContext2 = nil

		contextMenu2 = context:addOption("Cook")
		subContext2 = ISContextMenu:getNew(context);

		context:addSubMenu(contextMenu2, subContext2)

		if Sausage then
			subContext2:addOption("Sausage",
				  worldobjects,
				  UseHotDogMachineMenu.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachineObject,
				  soundFile, "Sausage")
		end	
		if VSausage then
			subContext2:addOption("Vienna Sausage",
				  worldobjects,
				  UseHotDogMachineMenu.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachineObject,
				  soundFile, "ViennaSausage")
		end
		if FSausage then
			subContext2:addOption("Frankfurter",
				  worldobjects,
				  UseHotDogMachineMenu.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachineObject,
				  soundFile, "FrankfurterSausage")
		end
	end
end


function MachineNoPower(player)
	player:Say("I will need a generator nearby to power it.")
end


function MachineNoHotDog(player)
	player:Say("I'll need a sausage to make a hotdog.")
end


function MachineNoHotDogBun(player)
	player:Say("I'll need a bun to make a hotdog, sliced bread might work.")
end


UseHotDogMachineMenu.getFrontSquare = function(square, facing)
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

UseHotDogMachineMenu.getFacing = function(properties, square)

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

UseHotDogMachineMenu.walkToFront = function(thisPlayer, HotDogMachineObject)

	local controllerSquare = nil
	local spriteName = HotDogMachineObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = HotDogMachineObject:getSprite():getProperties()
	local facing = UseHotDogMachineMenu.getFacing(properties, HotDogMachineObject:getSquare())
	if facing == nil then
		thisPlayer:Say("I am unable to access this machine, the path is blocked.")
		return false
	end
	
	local frontSquare = UseHotDogMachineMenu.getFrontSquare(HotDogMachineObject:getSquare(), facing)
	local turn = UseHotDogMachineMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local HotDogMachineSquare = HotDogMachineObject:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(HotDogMachineSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		if turn then
			thisPlayer:faceLocation(HotDogMachineSquare:getX(), HotDogMachineSquare:getY())
		end
		return true
	end

	return false
end


UseHotDogMachineMenu.onUseHotDogMachine = function(worldobjects, player, machine, soundFile, foodType)
	if not UseHotDogMachineMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()
	local inv = player:getInventory()
	local HotdogBun = inv:FindAndReturn("SapphCooking.HotdogBun")
	local BreadSlices = inv:FindAndReturn("Base.BreadSlices")
	local Sausage = inv:FindAndReturn("Base.Sausage")
	local VSausage = inv:FindAndReturn("SapphCooking.ViennaSausage")
	local FSausage = inv:FindAndReturn("SapphCooking.FrankfurterSausage")
	local ESausage = inv:FindAndReturn("SapphCooking.SausageEvolved")

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		MachineNoPower(player)
		return
	end

	if foodType == "Hotdog" and (HotdogBun or BreadSlices) and (Sausage or VSausage or FSausage or ESausage) then
		ISTimedActionQueue.add(UseHotDogMachine:new(player, machine, soundFile, foodType, squareToTurn))
	elseif foodType == "Hotdog" and not HotdogBun and not BreadSlices then
		MachineNoHotDogBun(player)
	elseif foodType == "Hotdog" then
		MachineNoHotDog(player)
	else
		ISTimedActionQueue.add(UseHotDogMachine:new(player, machine, soundFile, foodType, squareToTurn))
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(UseHotDogMachineMenu.doBuildMenu);