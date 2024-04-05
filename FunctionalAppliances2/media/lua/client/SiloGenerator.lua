FASiloGenerator = FASiloGenerator or {}

FASiloGenerator.doBuildMenu = function(player, menu, square, SiloGenerator)
	local NewSiloGenerator = nil

	for i=1,square:getObjects():size() do
		local thisObject = square:getObjects():get(i-1)
		local objectName = thisObject:getObjectName()
		local spriteName = thisObject:getSpriteName()

		if spriteName == "industry_02_67" and objectName == "IsoGenerator" then
			NewSiloGenerator = thisObject
			break
		end
	end

	if NewSiloGenerator == nil then
		return
	end

	local fuelAmount = SiloGenerator:getPipedFuelAmount()
	if fuelAmount < 0 then
		fuelAmount = 0
	end

	if SiloGenerator:getModData()['PoweredOn'] == false then
		menu:addOption(FA.translation.turngeneratoron,
				  nil,
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          nil,
				  "togglepower")
	else
		menu:addOption(FA.translation.turngeneratoroff,
				  nil,
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          nil,
				  "togglepower")
	end

	local dispCond = math.floor(SiloGenerator:getModData()['Condition'] * 100 + 0.5)/100

	local contextMenu = menu:addOption(FA.translation.status)
	local subContext = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu, subContext)

	if SiloGenerator then
		subContext:addOption(FA.translation.fuelamount .. ": " .. fuelAmount)
		subContext:addOption(FA.translation.condition .. ": " .. dispCond .. "%")
		
		if SiloGenerator:getModData()['AutoPowerOn'] == true then
			subContext:addOption(FA.translation.autostartactivated)
		else
			subContext:addOption(FA.translation.autostartdeactivated)
		end

		--if SiloGenerator:getModData()['Marker'] ~= nil then
		--	subContext:addOption(FA.translation.markeractivated)
		--else
		--	subContext:addOption(FA.translation.markerdeactivated)
		--end

		if SiloGenerator:getModData()['AutoPowerOn'] == true then
			menu:addOption(FA.translation.deactivateautostart,
				  nil,
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          nil,
				  "toggleautopower")
		else
			menu:addOption(FA.translation.activateautostart,
				  nil,
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          nil,
				  "toggleautopower")
		end

		--if SiloGenerator:getModData()['Marker'] ~= nil then
		--	menu:addOption(FA.translation.deactivatemarker,
		--		  nil,
		--		  FASiloGenerator.onUseSiloGenerator,
		--		  getSpecificPlayer(player),
		--		  SiloGenerator,
		--		  NewSiloGenerator,
		--	          nil,
		--		  "togglemarker")
		--else
		--	menu:addOption(FA.translation.activatemarker,
		--		  nil,
		--		  FASiloGenerator.onUseSiloGenerator,
		--		  getSpecificPlayer(player),
		--		  SiloGenerator,
		--		  NewSiloGenerator,
		--	          nil,
		--		  "togglemarker")
		--end
	end

	if NewSiloGenerator and NewSiloGenerator:isActivated() then
		local contextMenu2 = menu:addOption(FA.translation.powerconsumption .. ":")
		local subContext2 = ISContextMenu:getNew(menu)
		menu:addSubMenu(contextMenu2, subContext2)

		subContext2:addOption(math.floor(NewSiloGenerator:getTotalPowerUsing() * 100 + 0.5)/100 .. " L/h")
	
		local items = NewSiloGenerator:getItemsPowered()
		for i=0,items:size()-1 do
			subContext2:addOption(items:get(i))
		end
	end

	if SiloGenerator:getModData()['GeneratorMagazine'] == true then
		menu:addOption(FA.translation.takegeneratormagazine,
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          nil,
				  "magazine")
	end

	if SiloGenerator:getPipedFuelAmount() < 500 then
		local inv = getSpecificPlayer(player):getInventory()
		local fuelCan = inv:FindAndReturn("Base.PetrolCan")
		local fuelBleach = inv:FindAndReturn("Base.PetrolBleachBottle")
		local fuelPop = inv:FindAndReturn("Base.PetrolPopBottle")
		local fuelWater = inv:FindAndReturn("Base.WaterBottlePetrol")
		local fuelWhiskey = inv:FindAndReturn("Base.WhiskeyPetrol")
		local fuelWine = inv:FindAndReturn("Base.WinePetrol")

		local contextMenu3 = menu:addOption(FA.translation.addfuel .. ":")
		local subContext3 = ISContextMenu:getNew(menu)
		menu:addSubMenu(contextMenu3, subContext3)

		if fuelCan then
			subContext3:addOption(fuelCan:getDisplayName(),
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          fuelCan,
				  "addfuel")
		end
		if fuelBleach then
			subContext3:addOption(fuelBleach:getDisplayName(),
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          fuelBleach,
				  "addfuel")
		end
		if fuelPop then
			subContext3:addOption(fuelPop:getDisplayName(),
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          fuelPop,
				  "addfuel")
		end
		if fuelWater then
			subContext3:addOption(fuelWater:getDisplayName(),
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          fuelWater,
				  "addfuel")
		end
		if fuelWhiskey then
			subContext3:addOption(fuelWhiskey:getDisplayName(),
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          fuelWhiskey,
				  "addfuel")
		end
		if fuelWine then
			subContext3:addOption(fuelWine:getDisplayName(),
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          fuelWine,
				  "addfuel")
		end
	end

	if SiloGenerator:getModData()['PoweredOn'] == false and SiloGenerator:getModData()['Condition'] < 100 and (getSpecificPlayer(player):isRecipeKnown("Generator") or getSpecificPlayer(player):getPerkLevel(Perks.Electricity) > 3 or getSpecificPlayer(player):getPerkLevel(Perks.Mechanics) > 3) then
		menu:addOption(FA.translation.fixgenerator,
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  NewSiloGenerator,
			          nil,
				  "repair")
	end
end

FASiloGenerator.onUseSiloGenerator = function(junk, player, SiloGenerator, NewSiloGenerator, fuelCan, MyChoice)
	if not FA.walkToFront(player, SiloGenerator) then
		return
	end

	local square = SiloGenerator:getSquare()
	local inv = player:getInventory()

	if MyChoice == "addfuel" then
		if fuelCan ~= nil then
			ISTimedActionQueue.add(SiloGeneratorAddFuel:new(player, SiloGenerator, fuelCan, 100))
		else
			player:Say(FA.translation.sayneedcanoffuel)
		end
		return
	elseif MyChoice == "repair" then
		if SiloGenerator:getModData()['PoweredOn'] == false then
			local scrapItemE = player:getInventory():getFirstTypeRecurse("ElectronicsScrap")
			local scrapItemM = player:getInventory():getFirstTypeRecurse("ScrapMetal")
			if scrapItemE ~= nil or scrapItemM ~= nil then
				ISTimedActionQueue.add(SiloGeneratorFix:new(player, SiloGenerator, 150))
			else
				player:Say(FA.translation.sayneedscrap)
			end
		else
			player:Say(FA.translation.sayneedturngeneratoroff)
		end
		return
	elseif MyChoice == "magazine" then
		SiloGenerator:getModData()['GeneratorMagazine'] = false
		square:transmitModdata()
		SiloGenerator:transmitModData()
		inv:AddItem("Base.ElectronicsMag4")
		return
	elseif MyChoice == "toggleautopower" then
		if SiloGenerator:getModData()['AutoPowerOn'] == true then
			SiloGenerator:getModData()['AutoPowerOn'] = false
			square:transmitModdata()
			SiloGenerator:transmitModData()
		else
			SiloGenerator:getModData()['AutoPowerOn'] = true
			square:transmitModdata()
			SiloGenerator:transmitModData()
		end
		return
	elseif MyChoice == "togglemarker" then
		if SiloGenerator:getModData()['Marker'] ~= nil then
			getWorldMarkers():removeGridSquareMarker(SiloGenerator:getModData()['Marker'])
			SiloGenerator:getModData()['Marker'] = nil
		else
			local r = 0.1
			local g = 0.3
			local b = 0.6
			SiloGenerator:getModData()['Marker'] = getWorldMarkers():addGridSquareMarker(square, r, g, b, true, 29)
		end
		return
	end
	
	if MyChoice == "togglepower" and SiloGenerator:getPipedFuelAmount() > 0 and SiloGenerator:getModData()['Condition'] > 0 then
		if SiloGenerator:getModData()['PoweredOn'] == true then
			SiloGenerator:getModData()['PoweredOn'] = false
			NewSiloGenerator:setConnected(true)
			NewSiloGenerator:setActivated(false)
			NewSiloGenerator:setSurroundingElectricity() 
		else
			SiloGenerator:getModData()['PoweredOn'] = true
			NewSiloGenerator:setConnected(true)
			if not NewSiloGenerator:isActivated() then
        			NewSiloGenerator:setActivated(true)
			end
			NewSiloGenerator:setSurroundingElectricity() 
			if square:getBuilding() then
				--print("start toxic off")
				square:getBuilding():setToxic(false)
			end
		end
	elseif MyChoice == "togglepower" then
		SiloGenerator:getModData()['PoweredOn'] = false
		square:playSound("GeneratorFailedToStart")
	end

	square:transmitModdata()
	SiloGenerator:transmitModData()
	NewSiloGenerator:transmitModData()
end

FA.checkSiloGeneratorStatus = function()
	local EnableSiloGenerators = SandboxVars.FunctionalAppliances.FAEnableSiloGenerators

	if not EnableSiloGenerators then
		return
	end

	if #FA.SiloGeneratorList < 1 then
		return
	end

	local removedFromSquare = nil

	for index,t in ipairs(FA.SiloGeneratorList) do
		local square = getSquare(t.x, t.y, t.z)
		if square ~= nil then 
			local SiloGenerator = nil
			local NewSiloGenerator = nil
			local BogusGenerator = nil
			local objects = square:getObjects()

        		for i=1, objects:size()-1 do
        			local thisObject = objects:get(i)
				local texture = thisObject:getTextureName() or nil
				local objectName = thisObject:getObjectName() or nil
				local spriteName = thisObject:getSpriteName() or nil

               			if texture == "industry_02_67" and objectName ~= "IsoGenerator" then
					SiloGenerator = thisObject
					--print("found silo")
                		end
				if spriteName == "industry_02_67" and objectName == "IsoGenerator" then
					NewSiloGenerator = thisObject
					--print("found generator")
				end
				if texture == "appliances_misc_01_0" and objectName == "IsoGenerator" then
					BogusGenerator = thisObject
				end
				if SiloGenerator and NewSiloGenerator and BogusGenerator then
					print("we have an imposter!")
					break
				end
        		end

			if SiloGenerator ~= nil and NewSiloGenerator ~= nil then
				if SiloGenerator:getModData()['Marker'] ~= nil then 
					local markerDist = math.sqrt((getPlayer():getX() - t.x) ^ 2 + (getPlayer():getY() - t.y) ^ 2 + (getPlayer():getZ() - t.z) ^ 2)
					if markerDist > 50 then
						--print("turning off marker distance at: " .. markerDist)
						getWorldMarkers():removeGridSquareMarker(SiloGenerator:getModData()['Marker'])
						SiloGenerator:getModData()['Marker'] = nil
					end
				end
				if not square:haveElectricity() and not (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier) then
					--print("no power side")
					if SiloGenerator:getModData()['PoweredOn'] == true and SiloGenerator:getModData()['Condition'] > 0 and SiloGenerator:getPipedFuelAmount() > 0 then
						NewSiloGenerator:setActivated(true)
						NewSiloGenerator:setSurroundingElectricity() 
					elseif SiloGenerator:getModData()['AutoPowerOn'] == true and SiloGenerator:getModData()['Condition'] > 0 and SiloGenerator:getPipedFuelAmount() > 0 then
						SiloGenerator:getModData()['PoweredOn'] = true
						NewSiloGenerator:setActivated(true)
						NewSiloGenerator:setSurroundingElectricity() 
					elseif SiloGenerator:getModData()['PoweredOn'] == true and (SiloGenerator:getModData()['Condition'] <= 0 or SiloGenerator:getPipedFuelAmount() <= 0) then
						SiloGenerator:getModData()['PoweredOn'] = false
						NewSiloGenerator:setActivated(false)
						NewSiloGenerator:setSurroundingElectricity() 
						if SiloGenerator:getModData()['Condition'] <= 0 then
							square:playSound("BurnedObjectExploded")
							addSound(SiloGenerator, square:getX(), square:getY(), square:getZ(), 40, 60)
							SiloGenerator:getModData()['Condition'] = 0
						end
					elseif SiloGenerator:getModData()['PoweredOn'] == false then
						NewSiloGenerator:setActivated(false)
						NewSiloGenerator:setSurroundingElectricity() 
					end
				elseif SiloGenerator:getModData()['PoweredOn'] == true then
					--print("power side")
					if SiloGenerator:getModData()['PoweredOn'] == true and SiloGenerator:getModData()['Condition'] > 0 and SiloGenerator:getPipedFuelAmount() > 0 then
						NewSiloGenerator:setActivated(true)
						NewSiloGenerator:setSurroundingElectricity() 
					end
					if SiloGenerator:getModData()['Condition'] <= 0 or SiloGenerator:getPipedFuelAmount() <= 0 then
						SiloGenerator:getModData()['PoweredOn'] = false
						NewSiloGenerator:setActivated(false)
						NewSiloGenerator:setSurroundingElectricity() 
						if SiloGenerator:getModData()['Condition'] <= 0 then
							square:playSound("BurnedObjectExploded")
							addSound(SiloGenerator, square:getX(), square:getY(), square:getZ(), 40, 60)
							SiloGenerator:getModData()['Condition'] = 0
						end
					end
					--print("Condition: " .. NewSiloGenerator:getCondition())
					if NewSiloGenerator:getCondition() <= 98 then
						local conditionUsed = math.floor(100 - NewSiloGenerator:getCondition())
						--print("Lower condition on generator by " .. conditionUsed)
						SiloGenerator:getModData()['Condition'] = SiloGenerator:getModData()['Condition'] - conditionUsed
						if SiloGenerator:getModData()['Condition'] < 0 then
							SiloGenerator:getModData()['Condition'] = 0
						end
						NewSiloGenerator:setCondition(NewSiloGenerator:getCondition() + conditionUsed)
					end
					--print("Fuel: " .. NewSiloGenerator:getFuel())
					if NewSiloGenerator:getFuel() <= 90 then
						local fuelUsed = math.floor((100 - NewSiloGenerator:getFuel())/10)
						--print("Lower fuel on generator by " .. fuelUsed)
						SiloGenerator:setPipedFuelAmount(SiloGenerator:getPipedFuelAmount() - fuelUsed)
						if SiloGenerator:getPipedFuelAmount() < 0 then
							SiloGenerator:setPipedFuelAmount(0)
						end
						NewSiloGenerator:setFuel(NewSiloGenerator:getFuel() + fuelUsed * 10)
						SiloGenerator:getModData()['Condition'] = SiloGenerator:getModData()['Condition'] - 0.1
					end
				end
				if square:getBuilding() then
					--print("tick toxic off")
					square:getBuilding():setToxic(false)
				end
				t.poweredon = SiloGenerator:getModData()['PoweredOn']
				SiloGenerator:transmitModData()	
				NewSiloGenerator:transmitModData()
			else
				removedFromSquare = square
			end

			if BogusGenerator ~= nil then
				if BogusGenerator ~= NewSiloGenerator and BogusGenerator ~= SiloGenerator then
					sledgeDestroy(BogusGenerator)
					BogusGenerator:getSquare():transmitRemoveItemFromSquareOnServer(BogusGenerator)
					BogusGenerator:getSquare():transmitRemoveItemFromSquare(BogusGenerator) 
				end
			end

			if SiloGenerator == nil and NewSiloGenerator ~= nil then
				removedFromSquare = square
				NewSiloGenerator:setActivated(false)
				NewSiloGenerator:setSurroundingElectricity() 
				sledgeDestroy(NewSiloGenerator)
				NewSiloGenerator:getSquare():transmitRemoveItemFromSquareOnServer(NewSiloGenerator)
				NewSiloGenerator:getSquare():transmitRemoveItemFromSquare(NewSiloGenerator)
			end
			square:transmitModdata()
		end
	end
	if #FA.SiloGeneratorList > 0 and removeFromSquare ~= nil then
		for index,x in ipairs(FA.SiloGeneratorList) do
			if x.x == removedFromSquare:getX() and x.y == removedFromSquare:getY() and x.z == removedFromSquare:getZ() then
				table.remove(FA.SiloGeneratorList, index)
				break
			end
		end
	end
end

Events.EveryOneMinute.Add(FA.checkSiloGeneratorStatus)