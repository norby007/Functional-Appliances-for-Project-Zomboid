FASiloGenerator = FASiloGenerator or {}

FASiloGenerator.gridTiles = {
    	industry_02_64 = {0,1},
    	industry_02_65 = {1,1},
    	industry_02_66 = {2,1},
    	industry_02_67 = {3,1},
    	industry_02_68 = {0,0},
    	industry_02_69 = {1,0},
    	industry_02_70 = {2,0},
    	industry_02_71 = {3,0},
}

FASiloGenerator.LoadedTiles = function(SiloGenerator)
    	local spriteGrid = IsoSpriteGrid.new(4,2)

    	for k,v in pairs(FASiloGenerator.gridTiles) do
        	local spr = SiloGenerator:getSprite(k)
        	spriteGrid:setSprite(v[1],v[2],spr)
        	spr:setSpriteGrid(grid)
    	end
end

Events.OnLoadedTileDefinitions.Add(FASiloGenerator.LoadedTiles)

FASiloGenerator.doBuildMenu = function(player, menu, square, SiloGenerator)
	if SiloGenerator:getModData()['Loaded'] ~= true then
		SiloGenerator:getModData()['Loaded'] = true 
		SiloGenerator:getModData()['PoweredOn'] = false
		SiloGenerator:getModData()['Condition'] = ZombRand(0,100)
		SiloGenerator:setPipedFuelAmount(ZombRand(0,500))
	end 

	if SiloGenerator:getModData()['PoweredOn'] == false then
		menu:addOption("Turn Generator On",
				  nil,
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  "togglepower")
	else
		menu:addOption("Turn Generator Off",
				  nil,
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  "togglepower")
	end

	local contextMenu = menu:addOption("Status")
	local subContext = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu, subContext)

	if SiloGenerator then
		subContext:addOption("Fuel Amount: " .. SiloGenerator:getPipedFuelAmount())
		subContext:addOption("Condition: " .. SiloGenerator:getModData()['Condition'] .. "%")
	end

	if SiloGenerator:getPipedFuelAmount() < 500 then
		menu:addOption("Add Fuel",
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  "addfuel")
	end

	if SiloGenerator:getPipedFuelAmount() > 0 then
		menu:addOption("Take Fuel",
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  "takefuel")
	end

	if SiloGenerator:getModData()['PoweredOn'] == false and SiloGenerator:getModData()['Condition'] < 100 then
		menu:addOption("Fix Generator",
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  "repair")
	end
end

FASiloGenerator.onUseSiloGenerator = function(junk, player, SiloGenerator, MyChoice)
	if not FA.walkToFront(player, SiloGenerator) then
		return
	end

	local square = SiloGenerator:getSquare()
	local inv = player:getInventory()

	if MyChoice == "addfuel" then
		local fuelCan = inv:FindAndReturn("Base.PetrolCan")
		if fuelCan ~= nil then
			ISTimedActionQueue.add(SiloGeneratorAddFuel:new(player, SiloGenerator, fuelCan, 100))
		else
			player:Say("I will need an empty fuel can.")
		end
	elseif MyChoice == "takefuel" then
		local fuelCan = inv:FindAndReturn("Base.EmptyPetrolCan")
		if fuelCan ~= nil then
			ISTimedActionQueue.add(SiloGeneratorTakeFuel:new(player, SiloGenerator, fuelCan, 100))
		else
			player:Say("I will need an empty fuel can.")
		end
	elseif MyChoice == "repair" then
		if SiloGenerator:getModData()['PoweredOn'] == false then
			local scrapItemE = player:getInventory():getFirstTypeRecurse("ElectronicsScrap")
			local scrapItemM = player:getInventory():getFirstTypeRecurse("ScrapMetal")
			if scrapItemE ~= nil or scrapItemM ~= nil then
				ISTimedActionQueue.add(SiloGeneratorFix:new(player, SiloGenerator, 150))
			else
				player:Say("You will need electronics scrap or scrap metal to repair this generator.")
			end
		else
			player:Say("You will need to turn the generator off first.")
		end
	elseif MyChoice == "togglepower" and SiloGenerator:getPipedFuelAmount() > 0 and SiloGenerator:getModData()['Condition'] > 0 then
		if SiloGenerator:getModData()['PoweredOn'] == true then
			SiloGenerator:getModData()['PoweredOn'] = false
			FASiloGenerator.onPowerChangeOff(SiloGenerator)
			square:playSound("GeneratorStopping")
		else
			SiloGenerator:getModData()['PoweredOn'] = true
			FASiloGenerator.onPowerChangeOn(SiloGenerator)
			square:playSound("GeneratorStarting")
		end
	elseif MyChoice == "togglepower" then
		SiloGenerator:getModData()['PoweredOn'] = false
		FASiloGenerator.onPowerChangeOff(SiloGenerator)
		square:playSound("GeneratorFailedToStart")
	end
end

FASiloGenerator.onPowerChangeOn = function(SiloGenerator)
	local NewSiloGenerator = nil
	local square = SiloGenerator:getSquare()
	local thisSquare = square
      	local count = 0
	local countS = 0
	local countF = 0
	local west = square:getX() - 40
	local east = square:getX() + 40
	local south = square:getY() - 40
	local north = square:getY() + 40

	-- build in this square up and down if possible
	for thisZ = 0, 8 do
		thisSquare = getSquare(square:getX(), square:getY(), thisZ)
		if thisSquare ~= nil then
        		NewSiloGenerator = IsoGenerator.new(nil, thisSquare:getCell(), thisSquare)                 
        		NewSiloGenerator:setConnected(true)
        		NewSiloGenerator:setFuel(100)
        		NewSiloGenerator:setCondition(100)
        		NewSiloGenerator:setActivated(true)
			NewSiloGenerator:setSurroundingElectricity() 
        		NewSiloGenerator:remove()
			if thisSquare:getBuilding() then
				thisSquare:getBuilding():setToxic(false)
			end
			print("Installed: " .. square:getX() .. " " .. square:getY() .. " " .. thisZ)
			countS = countS + 1
			count = count + 1
		else
			print("Failed: " .. square:getX() .. " " .. square:getY() .. " " .. thisZ)
			countF = countF + 1
			count = count + 1
		end
	end

	-- build on the ground floor wide if possible
	for thisX = west, east, 20 do
		for thisY = south, north, 20 do
			thisSquare = getSquare(thisX, thisY, 0)
			if thisSquare ~= nil then
        			NewSiloGenerator = IsoGenerator.new(nil, thisSquare:getCell(), thisSquare)                 
        			NewSiloGenerator:setConnected(true)
        			NewSiloGenerator:setFuel(100)
        			NewSiloGenerator:setCondition(100)
        			NewSiloGenerator:setActivated(true)
				NewSiloGenerator:setSurroundingElectricity() 
        			NewSiloGenerator:remove()
				if thisSquare:getBuilding() then
					thisSquare:getBuilding():setToxic(false)
				end
				print("Installed: " .. thisX .. " " .. thisY .. " " .. 0)
				countS = countS + 1
				count = count + 1
			else
				print("Failed: " .. thisX .. " " .. thisY .. " " .. 0)
				countF = countF + 1
				count = count + 1
			end
		end
	end

	-- if silo generator is not on the ground floor build wide if possible at that level
	if square:getZ() > 0 then
		for thisX = west, east, 20 do
			for thisY = south, north, 20 do
				thisSquare = getSquare(thisX, thisY, square:getZ())
				if thisSquare ~= nil then
        				NewSiloGenerator = IsoGenerator.new(nil, thisSquare:getCell(), thisSquare)                 
        				NewSiloGenerator:setConnected(true)
        				NewSiloGenerator:setFuel(100)
        				NewSiloGenerator:setCondition(100)
 	       				NewSiloGenerator:setActivated(true)
					NewSiloGenerator:setSurroundingElectricity() 
        				NewSiloGenerator:remove()
					if thisSquare:getBuilding() then
						thisSquare:getBuilding():setToxic(false)
					end
					print("Installed: " .. thisX .. " " .. thisY .. " " .. square:getZ())
					countS = countS + 1
					count = count + 1
				else
					print("Failed: " .. thisX .. " " .. thisY .. " " .. square:getZ())
					countF = countF + 1
					count = count + 1
				end
			end
		end
	end
	print("Installed Successfully: " .. countS .. " Failed: " .. countF .. " Total: " .. count)
end

FASiloGenerator.onPowerChangeOff = function(SiloGenerator)
	local NewSiloGenerator = nil
	local square = SiloGenerator:getSquare()
	local thisSquare = square
      	local count = 0
	local countS = 0
	local countF = 0
	local west = square:getX() - 40
	local east = square:getX() + 40
	local south = square:getY() - 40
	local north = square:getY() + 40

	-- build in this square up and down if possible
	for thisZ = 0, 8 do
		thisSquare = getSquare(square:getX(), square:getY(), thisZ)
		if thisSquare ~= nil then
        		NewSiloGenerator = IsoGenerator.new(nil, thisSquare:getCell(), thisSquare)                 
        		NewSiloGenerator:setConnected(false)
        		NewSiloGenerator:setFuel(0)
        		NewSiloGenerator:setCondition(0)
        		NewSiloGenerator:setActivated(false)
        		NewSiloGenerator:setSurroundingElectricity()
        		NewSiloGenerator:remove()
			if thisSquare:getBuilding() then
				thisSquare:getBuilding():setToxic(false)
			end
			print("Installed: " .. square:getX() .. " " .. square:getY() .. " " .. thisZ)
			countS = countS + 1
			count = count + 1
		else
			print("Failed: " .. square:getX() .. " " .. square:getY() .. " " .. thisZ)
			countF = countF + 1
			count = count + 1
		end
	end

	-- build on the ground floor wide if possible
	for thisX = west, east, 20 do
		for thisY = south, north, 20 do
			thisSquare = getSquare(thisX, thisY, 0)
			if thisSquare ~= nil then
        			NewSiloGenerator = IsoGenerator.new(nil, thisSquare:getCell(), thisSquare)                 
        			NewSiloGenerator:setConnected(false)
        			NewSiloGenerator:setFuel(0)
        			NewSiloGenerator:setCondition(0)
        			NewSiloGenerator:setActivated(false)
        			NewSiloGenerator:setSurroundingElectricity()
        			NewSiloGenerator:remove()
				if thisSquare:getBuilding() then
					thisSquare:getBuilding():setToxic(false)
				end
				print("Installed: " .. thisX .. " " .. thisY .. " " .. 0)
				countS = countS + 1
				count = count + 1
			else
				print("Failed: " .. thisX .. " " .. thisY .. " " .. 0)
				countF = countF + 1
				count = count + 1
			end
		end
	end


	-- if silo generator is not on the ground floor build wide if possible at that level mostly for rooftops
	if square:getZ() > 0 then
		for thisX = west, east, 20 do
			for thisY = south, north, 20 do
				thisSquare = getSquare(thisX, thisY, square:getZ())
				if thisSquare ~= nil then
        				NewSiloGenerator = IsoGenerator.new(nil, thisSquare:getCell(), thisSquare)                 
        				NewSiloGenerator:setConnected(false)
        				NewSiloGenerator:setFuel(0)
        				NewSiloGenerator:setCondition(0)
        				NewSiloGenerator:setActivated(false)
        				NewSiloGenerator:setSurroundingElectricity()
        				NewSiloGenerator:remove()
					if thisSquare:getBuilding() then
						thisSquare:getBuilding():setToxic(false)
					end
					print("Installed: " .. thisX .. " " .. thisY .. " " .. square:getZ())
					countS = countS + 1
					count = count + 1
				else
					print("Failed: " .. thisX .. " " .. thisY .. " " .. square:getZ())
					countF = countF + 1
					count = count + 1
				end
			end
		end
	end
	print("Installed Successfully: " .. countS .. " Failed: " .. countF .. " Total: " .. count)
end