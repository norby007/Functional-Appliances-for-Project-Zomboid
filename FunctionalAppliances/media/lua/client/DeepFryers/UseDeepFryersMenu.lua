UseDeepFryersMenu = {};
UseDeepFryersMenu.doBuildMenu = function(player, context, worldobjects)

	local DeepFryers = nil

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
				local groupName = nil

				if properties:Is("CustomName") then
					customName = properties:Val("CustomName")
				end

				if properties:Is("GroupName") then
					groupName = properties:Val("GroupName")
				end
			
				if customName == "Industrial 2000" and groupName == "Fryers Club" then				
					DeepFryers = thisObject
					DeepFryers:getModData()['VatOil'] = "VegetableOil"
					square:transmitModdata()
					DeepFryers:transmitModData()	
					break
				end
			end 
		end 
	end

	if not DeepFryers then 
		return 
	end

	local Oil = nil
	local OilSapphs = nil
	local OnionRings = nil
	local OnionBlooming = nil
	local PotatoCut = nil
	local PotatoPeels = nil
	local ShrimpBattered = nil
	local SmallBirdMeatBattered = nil
	local ChickenBattered = nil
	local ChickenFilletBattered = nil
	local ChickenSlicesBattered = nil
	local SausageBattered = nil
	local CutTortillas = nil
	local FishBattered = nil
	local Dough = nil
	local DoughnutDough = nil
	local ChurrosDough = nil
	local CheeseBattered = nil

	local playerItems = getSpecificPlayer(player):getInventory():getItems()

	for i=0, playerItems:size()-1 do
        	local item = playerItems:get(i)
		local itemDisplayName = nil

		if item and item:getDisplayName() then
			itemDisplayName = item:getDisplayName()
		end

		if itemDisplayName == "Cut Potatoes" or itemDisplayName == "Potato Wedges" then
			PotatoCut = item
		end
		if itemDisplayName == "Potato Peel" or itemDisplayName == "Potato Skins" then
			PotatoPeels = item
		end
		if itemDisplayName == "Fried Onion Rings" and not item:isCooked() then
			OnionRings = item
		end
		if itemDisplayName == "Battered Blooming Onion" then
			OnionBlooming = item
		end
		if itemDisplayName == "Cut Tortillas" then
			CutTortillas = item
		end
		if itemDisplayName == "Fried Shrimp" and not item:isCooked() then
			ShrimpBattered = item
		end
		if itemDisplayName == "Fish Fillet in Batter" then
			FishBattered = item
		end
		if itemDisplayName == "Sausage in Batter" then
			SausageBattered = item
		end
		if itemDisplayName == "Battered Chicken" then
			ChickenBattered = item
		end
		if itemDisplayName == "Battered Chicken Fillet" then
			ChickenFilletBattered = item
		end
		if itemDisplayName == "Sliced Chicken in Batter" then
			ChickenSlicesBattered = item
		end
		if itemDisplayName == "Small Bird Meat in Batter" then
			SmallBirdMeatBattered = item
		end
		if itemDisplayName == "Bread Dough" or itemDisplayName == "Small Dough" or itemDisplayName == "Pastry Dough" or itemDisplayName == "Dough" then
			Dough = item
		end
		if itemDisplayName == "Pastry Dough" or itemDisplayName == "Small Dough" or itemDisplayName == "Doughnut Shaped Dough" or itemDisplayName == "Dough" then
			DoughnutDough = item
		end
		if itemDisplayName == "Pastry Dough" or itemDisplayName == "Small Dough" or itemDisplayName == "Dough" then
			ChurrosDough = item
		end
		if itemDisplayName == "Cheese in Batter" then
			CheeseBattered = item
		end
		if itemDisplayName == "Vegetable Oil" then
			Oil = item
		end
		if itemDisplayName == "Cooking Oil" then
			OilSapphs = item
		end
	end

	soundFile = "industrial_fryer_sound"

	local contextMenu = nil
	local subContext = nil

	contextMenu = context:addOption("Vat Oil Level")
	subContext = ISContextMenu:getNew(context);

	context:addSubMenu(contextMenu, subContext)

	if DeepFryers:getModData()['VatOil'] == "VegetableOil" then
		subContext:addOption("[Currently Full] Remove Vegetable Oil",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Empty Vat")
	elseif DeepFryers:getModData()['VatOil'] == "CookingOil" then
		subContext:addOption("[Currently Full] Remove Cooking Oil",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Empty Vat")
	elseif Oil and DeepFryers:getModData()['VatOil'] == "Empty" then
		subContext:addOption("[Currently Empty] Add Vegetable Oil",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Fill Vat")
	elseif OilSapphs and DeepFryers:getModData()['VatOil'] == "Empty" then
		subContext:addOption("[Currently Empty] Add Cooking Oil",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Fill Vat")
	else
		subContext:addOption("[Currently Empty] Needs Vegetable Oil",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Full Stop")
	end

	local contextMenu2 = nil
	local subContext2 = nil

	--if DeepFryers:getModData()['VatOil'] == "VegetableOil" or DeepFryers:getModData()['VatOil'] == "CookingOil" then
		contextMenu2 = context:addOption("Fry")
		subContext2 = ISContextMenu:getNew(context);

		context:addSubMenu(contextMenu2, subContext2)

		if PotatoCut then
			subContext2:addOption("Potato Wedges",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "French Fries")
		end
		if PotatoPeels then
			subContext2:addOption("Potato Skins",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Potato Skins")
		end
		if OnionRings then
			subContext2:addOption("Battered Onion Rings",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Onion Rings")
		end
		if OnionBlooming then
			subContext2:addOption("Battered Blooming Onion",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Blooming Onion")
		end
		if CutTortillas then
			subContext2:addOption("Cut Tortillas",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Tortillas")
		end
		if ShrimpBattered then
			subContext2:addOption("Battered Shrimp",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Shrimp")
		end
		if FishBattered then
			subContext2:addOption("Battered Fish Fillet",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Fish Fillet")
		end
		if SausageBattered then
			subContext2:addOption("Battered Sausage",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Corndog")
		end
		if ChickenBattered then
			subContext2:addOption("Battered Chicken",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Fried Chicken")
		end
		if ChickenFilletBattered then
			subContext2:addOption("Battered Chicken Fillet",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Chicken Fillet")
		end
		if ChickenSlicesBattered then
			subContext2:addOption("Battered Sliced Chicken",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Chicken Tenders")
		end
		if SmallBirdMeatBattered then
			subContext2:addOption("Battered Chicken Nuggets",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Chicken Nuggets")
		end
		if Dough then
			subContext2:addOption("Doughboys",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Doughboy")
		end
		if DoughnutDough then
			subContext2:addOption("Doughnuts",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Doughnut")
		end
		if ChurrosDough then
			subContext2:addOption("Churros",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Churros")
		end
		if CheeseBattered then
			subContext2:addOption("Battered Cheese Sticks",
				  worldobjects,
				  UseDeepFryersMenu.onUseDeepFryers,
				  getSpecificPlayer(player),
				  DeepFryers, soundFile,
				  "Cheese Sticks")
		end
	--end
end

function MachineNoPower(player)
	player:Say("I will need a generator nearby to power it.")
end

function MachineNotOn(player)
	player:Say("The fry vats need to be turned on first.")
end

function MachineNoOil(player)
	player:Say("The oil vats are empty. I'll need to find some vegetable oil.")
end

UseDeepFryersMenu.getFrontSquare = function(square, facing)
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

UseDeepFryersMenu.getFacing = function(properties, square)

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


UseDeepFryersMenu.walkToFront = function(thisPlayer, DeepFryers)

	local controllerSquare = nil
	local spriteName = DeepFryers:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = DeepFryers:getSprite():getProperties()
	local facing = UseDeepFryersMenu.getFacing(properties, DeepFryers:getSquare())
	if facing == nil then
		thisPlayer:Say("I am unable to access this machine, the path is blocked.")
		return false
	end
	
	local frontSquare = UseDeepFryersMenu.getFrontSquare(DeepFryers:getSquare(), facing)
	local turn = UseDeepFryersMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local DeepFryersSquare = DeepFryers:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(DeepFryersSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		if turn then
			thisPlayer:faceLocation(DeepFryersSquare:getX(), DeepFryersSquare:getY())
		end
		return true
	end

	return false
end


UseDeepFryersMenu.onUseDeepFryers = function(worldobjects, player, machine, soundFile, foodChoice)
	if not UseDeepFryersMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()
	local inv = player:getInventory()
	local Oil = inv:FindAndReturn("Base.OilVegetable")
	local OilSapphs = inv:FindAndReturn("SapphCooking.PeanutOil")

	if foodChoice == "Full Stop" then
		MachineNoOil(player)
		return
	elseif foodChoice == "Empty Vat" and machine:getModData()['VatOil'] == "VegetableOil" then
		player:Say("This option is currently unavailible.")
		--machine:getModData()['VatOil'] = "Empty"
		--player:getInventory():AddItem("Base.OilVegetable")
		return
	elseif foodChoice == "Empty Vat" and machine:getModData()['VatOil'] == "CookingOil" then
		player:Say("This option is currently unavailible.")
		--machine:getModData()['VatOil'] = "Empty"
		--player:getInventory():AddItem("SapphCooking.PeanutOil")
		return
	elseif foodChoice == "Fill Vat" and machine:getModData()['VatOil'] == "Empty" then
		if Oil then
			machine:getModData()['VatOil'] = "VegetableOil"
			player:getInventory():Remove("OilVegetable")
		else
			machine:getModData()['VatOil'] = "CookingOil"
			player:getInventory():Remove("PeanutOil")
		end				
		return
	end

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		MachineNoPower(player)
		return
	end

	if not machine:Activated() then
		MachineNotOn(player)
		return
	end

	square:transmitModdata()
	machine:transmitModData()

	ISTimedActionQueue.add(UseDeepFryers:new(player, machine, soundFile, foodChoice, squareToTurn))	
end

Events.OnPreFillWorldObjectContextMenu.Add(UseDeepFryersMenu.doBuildMenu);