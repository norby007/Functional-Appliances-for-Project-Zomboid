UsePopcornMachineMenu = {};
UsePopcornMachineMenu.doBuildMenu = function(player, context, worldobjects)

	local PopcornMachineObject = nil

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
	
				local customName = nil
	
				if properties:Is("CustomName") then
					customName = properties:Val("CustomName")
				end
				
				if customName == "Popcorn Machine" then
					PopcornMachineObject = thisObject
					if not PopcornMachineObject:getContainer() then
						local index = PopcornMachineObject:getObjectIndex()
               					sledgeDestroy(PopcornMachineObject)
						PopcornMachineObject:getSquare():transmitRemoveItemFromSquareOnServer(PopcornMachineObject)
						PopcornMachineObject:getSquare():transmitRemoveItemFromSquare(PopcornMachineObject)            

                				PopcornMachineObject = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
                				PopcornMachineObject:setIsContainer(true)
                				PopcornMachineObject:getContainer():setType("popcornMachine")
                				PopcornMachineObject:getContainer():setCapacity(5)

						if ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
							PopcornMachineObject:getContainer():setCustomTemperature(1.5)
						end

                				square:AddTileObject(PopcornMachineObject, index)
						square:transmitAddObjectToSquare(PopcornMachineObject, PopcornMachineObject:getObjectIndex())
						square:transmitModdata()
						PopcornMachineObject:transmitModData()	
              					PopcornMachineObject:transmitCompleteItemToServer()
                				PopcornMachineObject:transmitUpdatedSpriteToServer()
					elseif ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
						PopcornMachineObject:getContainer():setCustomTemperature(1.5)
					else
						PopcornMachineObject:getContainer():setCustomTemperature(1)
					end
					break
				end
				
			end 
		end 
	end

	if not PopcornMachineObject then 
		return 
	end

	PopcornMachineObject:getContainer():requestSync()

	local soundFile = nil
	local contextMenu = nil
	
	local spriteName = PopcornMachineObject:getSprite():getName()
	soundFile = "popcornmachine_sound"
	contextMenu = "Use Popcorn Machine"

	context:addOption(getText(contextMenu),
				  worldobjects,
				  UsePopcornMachineMenu.onUsePopcornMachine,
				  getSpecificPlayer(player),
				  PopcornMachineObject,
				  soundFile)
end

function MachineNoPower(player)
	player:Say("I should probably have a generator nearby to power it.")
end

function MachineNoPopcorn(player)
	player:Say("I'll need popcorn kernels to make popcorn.")
end

function MachineNoCanOpener(player)
	player:Say("I'll need a can opener.")
end

UsePopcornMachineMenu.getFrontSquare = function(square, facing)
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

UsePopcornMachineMenu.getFacing = function(square)

	local facing = nil

	if square:getE() then
		facing = "E"
	elseif square:getS() then
		facing = "S"
	elseif square:getW() then
		facing = "W"
	elseif square:getN() then
		facing = "N"
	end

	return facing
end

UsePopcornMachineMenu.walkToFront = function(thisPlayer, PopcornMachineObject)

	local controllerSquare = nil
	local spriteName = PopcornMachineObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = PopcornMachineObject:getSprite():getProperties()
	local facing = UsePopcornMachineMenu.getFacing(PopcornMachineObject:getSquare())
	if facing == nil then
		thisPlayer:Say("I am unable to access this machine, the path is blocked.")
		return false
	end
	
	local frontSquare = UsePopcornMachineMenu.getFrontSquare(PopcornMachineObject:getSquare(), facing)
	local turn = UsePopcornMachineMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local PopcornMachineSquare = PopcornMachineObject:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(PopcornMachineSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		if turn then
			thisPlayer:faceLocation(PopcornMachineSquare:getX(), PopcornMachineSquare:getY())
		end
		return true
	end
	return false
end


UsePopcornMachineMenu.onUsePopcornMachine = function(worldobjects, player, machine, soundFile)
	if not UsePopcornMachineMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()
	local inv = player:getInventory()
	local instantPopcorn = inv:FindAndReturn("Base.Popcorn")
	local openCanOfKernels = inv:FindAndReturn("SapphCooking.OpenCanofKernelCorn")
	local CanOfKernels = inv:FindAndReturn("SapphCooking.CanofKernelCorn")
	local canOpener = inv:FindAndReturn("Base.TinOpener")

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		MachineNoPower(player)
	elseif instantPopcorn or openCanOfKernels then
		ISTimedActionQueue.add(UsePopcornMachine:new(player, machine, soundFile, squareToTurn))
	elseif CanOfKernels and canOpener then
		inv:Remove("CanofKernelCorn")
		inv:AddItem("SapphCooking.OpenCanofKernelCorn")
		ISTimedActionQueue.add(UsePopcornMachine:new(player, machine, soundFile, squareToTurn))
	elseif CanOfKernels and not canOpener then
		MachineNoCanOpener(player)
	else
		MachineNoPopcorn(player)
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(UsePopcornMachineMenu.doBuildMenu);
