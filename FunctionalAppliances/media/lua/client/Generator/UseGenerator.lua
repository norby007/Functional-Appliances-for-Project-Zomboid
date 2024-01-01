UseThingMenu = {};
UseThingMenu.doBuildMenu = function(player, context, worldobjects)

	local ThingObject = nil

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()

		if not square then
			return
		end
	
		for i=1,square:getObjects():size() do
			local thisObject = square:getObjects():get(i-1)
			local spr = thisObject:getSprite():getName()
			local texture = thisObject:getTextureName()

			if texture == nil then
				return
			end
			  
			if texture == "industry_02_67" then
				print("Found Silo Generator")
				ThingObject = thisObject
				--if not ThingObject:isConnected() then
					local index = ThingObject:getObjectIndex()
               				sledgeDestroy(ThingObject)
					ThingObject:getSquare():transmitRemoveItemFromSquareOnServer(ThingObject)
					ThingObject:getSquare():transmitRemoveItemFromSquare(ThingObject)            

               				ThingObject = IsoGenerator.new(nil, square:getCell(), square)  
					ThingObject:setSprite(spr)

					--SodaFountainObject:getSprite():getProperties():Set(IsoFlagType.waterPiped, "TRUE")
				
					square:AddSpecialObject(ThingObject, index)
					square:transmitAddObjectToSquare(ThingObject, ThingObject:getObjectIndex())
					square:transmitModdata()
					ThingObject:transmitModData()	
       					ThingObject:transmitCompleteItemToServer()
               				ThingObject:transmitUpdatedSpriteToServer()
				--end
				break
			end
		end 
	end 

	if not ThingObject then 
		return 
	else
		ThingObject:setCondition(100)
		ThingObject:setConnected(true)
		ThingObject:setFuel(500)
		ThingObject:setCanPassThrough(false)     
		ThingObject:setBlockAllTheSquare(true)
		ThingObject:setIsDismantable(false) 
		if isClient() then 
			ThingObject:transmitCompleteItemToServer() 
		end      
	end


	local contextMenu = nil
	local subContext = nil

	contextMenu = context:addOption("Click")
	subContext = ISContextMenu:getNew(context);

	context:addSubMenu(contextMenu, subContext)

	if ThingObject then
		subContext:addOption("fuel amount",
				  worldobjects,
				  UseThingMenu.onUseThing,
				  getSpecificPlayer(player),
				  ThingObject,
				  "amount", nil)
	end
	if ThingObject then
		subContext:addOption("Two",
				  worldobjects,
				  UseThingMenu.onUseThing,
				  getSpecificPlayer(player),
				  ThingObject,
				  "Two", nil)
	end
	if ThingObject then
		subContext:addOption("Three",
				  worldobjects,
				  UseThingMenu.onUseThing,
				  getSpecificPlayer(player),
				  ThingObject,
				  "Three", nil)
	end

	local ThingItems = nil

	if ThingObject:getContainer() then
		ThingItems = ThingObject:getItemContainer():getItems()
	end

	if ThingItems then
		local contextMenu2 = nil
		local subContext2 = nil

		contextMenu2 = context:addOption("Click On")
		subContext2 = ISContextMenu:getNew(context);

		context:addSubMenu(contextMenu2, subContext2)

			for i=0, ThingItems:size()-1 do
				local item = ThingItems:get(i)
				local itemDisplayName = nil

				if item and item:getDisplayName() then
					itemDisplayName = item:getDisplayName()
					subContext2:addOption(itemDisplayName,
						worldobjects,
				  		UseThingMenu.onUseThing,
				  		getSpecificPlayer(player),
				  		ThingObject,
				  		"My Choice", item)
				end
			end
	end
end

function MachineNoPower(player)
	player:Say("I will need a generator nearby to power it.")
end

UseThingMenu.getFrontSquare = function(square, facing)
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


UseThingMenu.getFacing = function(properties, square)

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


UseThingMenu.walkToFront = function(thisPlayer, ThingObject)

	local controllerSquare = nil
	local spriteName = ThingObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = ThingObject:getSprite():getProperties()
	local facing = UseThingMenu.getFacing(properties, ThingObject:getSquare())
	if facing == nil then
		thisPlayer:Say("I am unable to access this machine, the path is blocked.")
		return false
	end
	
	local frontSquare = UseThingMenu.getFrontSquare(ThingObject:getSquare(), facing)
	local turn = UseThingMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local ThingSquare = ThingObject:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(ThingSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		if turn then
			thisPlayer:faceLocation(ThingSquare:getX(), ThingSquare:getY())
		end
		return true
	end

	return false
end


UseThingMenu.onUseThing = function(worldobjects, player, machine, MyChoice, playItem)
	if not UseThingMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		MachineNoPower(player)
		return
	end

	square:playSound("LightSwitch")

	if machine:getContainer() then
		machineItems = machine:getItemContainer():getItems()
	else
		return
	end

	if MyChoice == "amount" then
		print("Fuel Amount: " .. machine:getFuel())
	elseif MyChoice == "Two" then
		print("Two was chosen.")
	elseif MyChoice == "Three" then
		print("Three was chosen.")
	else
		print("You have chosen: " .. playItem:getDisplayName())
		--ISTimedActionQueue.add(UseThing:new(player, machine, musicChoice, soundFile, playItem, squareToTurn))
	end
end

--Events.OnPreFillWorldObjectContextMenu.Add(UseThingMenu.doBuildMenu);