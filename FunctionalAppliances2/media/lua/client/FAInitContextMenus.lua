FA = FA or {}

FA.doBuildMenu = function(player, menu, worldObjects)
	if #worldObjects == 0 then 
		return 
	end

	local EnableSiloGenerators = SandboxVars.FunctionalAppliances.FAEnableSiloGenerators
	
	local object = worldObjects[1]
	local square = object:getSquare()
	local thisPlayer = getSpecificPlayer(player)

	if FA.getJoypadData(playerIndex) then
		local direction = thisPlayer:getForwardDirection()
		local x = thisPlayer:getX() + direction:getX()
		local y = thisPlayer:getY() + direction:getY()
		square = getSquare(x, y, thisPlayer:getZ())
	end

	for i=1,square:getObjects():size() do
		local thisObject = square:getObjects():get(i-1)

		if thisObject:getSprite() then
			local properties = thisObject:getSprite():getProperties()
			local texture = thisObject:getTextureName() or nil
			local spriteName = thisObject:getSpriteName() or nil
			local objectName = thisObject:getObjectName() or nil
			local customName = nil
			local groupName = nil
	
			if properties ~= nil then
				if properties:Is("CustomName") then
					customName = properties:Val("CustomName")
				end

				if properties:Is("GroupName") then
					groupName = properties:Val("GroupName")
				end
			end

			if customName == "Clock" and groupName == "Wall" then	
				FAWallClock.doBuildMenu(player, menu, square, thisObject)
			elseif groupName == "Pay" and customName == "Phones" then	
				thisObject = FA.updatePayPhones(thisObject)
				FAPayPhones.doBuildMenu(player, menu, square, thisObject)
			elseif customName == "Counter" and (groupName == "Corner A" or groupName == "Corner B" or groupName == "Middle") then	
				thisObject = FA.updateMachineTemp(thisObject)
				FAHeatedCounter.doBuildMenu(player, menu, square, thisObject)
			elseif texture == "location_restaurant_generic_01_16" or texture == "location_restaurant_generic_01_17" or texture == "location_restaurant_generic_01_18" or texture == "location_restaurant_generic_01_19" or texture == "location_restaurant_generic_01_20" or texture == "location_restaurant_generic_01_21" or texture == "location_restaurant_generic_01_22" or texture == "location_restaurant_generic_01_23" then
				thisObject = FA.updateMachineTemp(thisObject)
				FAHeatedCounter.doBuildMenu(player, menu, square, thisObject)
			elseif (customName == "Counter" or customName == "Stand" or customName == "Display") and (groupName == "Rounded Glass Display" or groupName == "Glass Display" or groupName == "Seahorse Coffee Glass") then	
				thisObject = FA.updateMachineTemp(thisObject)
				FADisplayCounter.doBuildMenu(player, menu, square, thisObject)
			elseif customName == "Machine" and (groupName == "Large" or groupName == "Small Soda") then	
				thisObject = FA.updateMachineTemp(thisObject)
				FAVendingMachine.doBuildMenu(player, menu, square, thisObject)
			elseif groupName == "Fossoil Candy" then	
				FAHotDogMachine.doBuildMenu(player, menu, square, thisObject)
			elseif customName == "Popcorn Machine" then
				FAPopcornMachine.doBuildMenu(player, menu, square, thisObject)
			elseif groupName == "Bar Tap" then	
				FABarTaps.doBuildMenu(player, menu, square, thisObject)
			elseif groupName == "Tabletop Soda" or groupName == "SlurpBurp" then	
				FASodaFountain.doBuildMenu(player, menu, square, thisObject)
			elseif customName == "Industrial 2000" and groupName == "Fryers Club" then
				thisObject = FA.updateDeepFryers(thisObject)	
				FADeepFryers.doBuildMenu(player, menu, square, thisObject)
			elseif customName == "Deluxe" and groupName == "Espresso" then
				FACoffeeMachine.doBuildMenu(player, menu, square, thisObject)
			elseif customName == "X-press" and groupName == "Coffee" then
				FACoffeeMachine.doBuildMenu(player, menu, square, thisObject)
			elseif texture == "industry_02_67" and objectName ~= "IsoGenerator" and EnableSiloGenerators then
				if thisObject:getModData()['Loaded'] ~= true then
					thisObject:getModData()['Loaded'] = true
					thisObject:getModData()['PoweredOn'] = false
					thisObject:getModData()['GeneratorMagazine'] = false
					thisObject:getModData()['AutoPowerOn'] = false
					thisObject:setPipedFuelAmount(0)
					thisObject:getModData()['Condition'] = 0

					local spr = thisObject:getSprite():getName()

			       		local NewSiloGenerator = IsoGenerator.new(nil, square:getCell(), square)  
					NewSiloGenerator:setSprite(spr)  
					NewSiloGenerator:transmitCompleteItemToServer()
			       		NewSiloGenerator:setCondition(100)
			       		NewSiloGenerator:setFuel(100)
			       		NewSiloGenerator:setConnected(true)
					NewSiloGenerator:setActivated(false)
					NewSiloGenerator:setSurroundingElectricity()  

					square:transmitModdata()
					thisObject:transmitModData()	
					NewSiloGenerator:transmitModData()
				end
				thisObject = FA.updateSiloGenerator(thisObject)
				FASiloGenerator.doBuildMenu(player, menu, square, thisObject)
			end
		end
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(FA.doBuildMenu)

FA.removeGeneratorMenu = function(player, menu, worldObjects)
	local EnableSiloGenerators = SandboxVars.FunctionalAppliances.FAEnableSiloGenerators

	if not EnableSiloGenerators then
		return
	end

	if #worldObjects == 0 then 
		return 
	end
	
	local object = worldObjects[1]
	local square = object:getSquare()
	local thisPlayer = getSpecificPlayer(player)

	if FA.getJoypadData(playerIndex) then
		local direction = thisPlayer:getForwardDirection()
		local x = thisPlayer:getX() + direction:getX()
		local y = thisPlayer:getY() + direction:getY()
		square = getSquare(x, y, thisPlayer:getZ())
	end

	for i=1,square:getObjects():size() do
		local thisObject = square:getObjects():get(i-1)
		local objectName = thisObject:getObjectName()

		if thisObject:getSprite() then
			local spriteName = thisObject:getSpriteName() or nil

			if spriteName == "industry_02_67" and objectName == "IsoGenerator" then
				menu:removeOptionByName(getText("ContextMenu_GeneratorInfo"))
				menu:removeOptionByName(getText("ContextMenu_Turn_Off"))
				menu:removeOptionByName(getText("ContextMenu_Turn_On"))
				menu:removeOptionByName(getText("ContextMenu_GeneratorPlug"))
				menu:removeOptionByName(getText("ContextMenu_GeneratorUnplug"))
				menu:removeOptionByName(getText("ContextMenu_GeneratorAddFuel"))
				menu:removeOptionByName(getText("ContextMenu_GeneratorFix"))
			end
		end
	end

end

Events.OnFillWorldObjectContextMenu.Add(FA.removeGeneratorMenu)