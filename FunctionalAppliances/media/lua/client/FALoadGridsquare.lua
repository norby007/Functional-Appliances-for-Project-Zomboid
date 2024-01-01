FA = FA or {}

FA.isModEnabled = function(modname)
    local actmods = getActivatedMods()
    for i=0, actmods:size()-1, 1 do
        if actmods:get(i) == modname then
            return true
        end
    end
    return false
end

FA.replaceHotDogMachine = function(HotDogMachineObject)
	if not HotDogMachineObject:getContainer() then
		local square = HotDogMachineObject:getSquare()
		local spr = HotDogMachineObject:getSprite():getName()  
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

		local FAFreshTheatreSpawnChance = SandboxVars.FunctionalAppliances.FAFreshTheatreChance

		if FAFreshTheatreSpawnChance == 6 then
			FAFreshTheatreSpawnChance = 0
		end

		local RollRand = ZombRand(1,100)+(FAFreshTheatreSpawnChance*10)
		if RollRand >= 101 then
			local addItem1 = HotDogMachineObject:getContainer():AddItem("Base.Sausage")
			if isClient() then
				HotDogMachineObject:getItemContainer():addItemOnServer(addItem1)
			end
			if RollRand >= 121 then
				local addItem2 = HotDogMachineObject:getContainer():AddItem("Base.Sausage")
				if isClient() then
					HotDogMachineObject:getItemContainer():addItemOnServer(addItem2)
				end
				if RollRand >= 131 then
					local addItem3 = HotDogMachineObject:getContainer():AddItem("FunctionalAppliances.FAHotdog")
					if isClient() then
						HotDogMachineObject:getItemContainer():addItemOnServer(addItem3)
					end
				end
			end
		end

		local FASapphsCookingFreshTheatreSpawnChance = SandboxVars.FunctionalAppliances.FASapphsCookingFreshTheatreChance 

		if FASapphsCookingFreshTheatreSpawnChance == 6 then
			FASapphsCookingFreshTheatreSpawnChance = 0
		end

		if FA.isModEnabled("sapphcooking") then
			local RollRand = ZombRand(1,100)+(FASapphsCookingFreshTheatreSpawnChance*10)
			if RollRand >= 101 then
				local addItem4 = HotDogMachineObject:getContainer():AddItem("SapphCooking.HotdogBun")
				if isClient() then
					HotDogMachineObject:getItemContainer():addItemOnServer(addItem4)
				end
				if RollRand >= 121 then
					local addItem5 = HotDogMachineObject:getContainer():AddItem("SapphCooking.HotdogBun")
					if isClient() then
						HotDogMachineObject:getItemContainer():addItemOnServer(addItem5)
					end
					if RollRand >= 131 then
						local addItem6 = HotDogMachineObject:getContainer():AddItem("SapphCooking.HotdogBun")
						if isClient() then
							HotDogMachineObject:getItemContainer():addItemOnServer(addItem6)
						end
					end
				end
			end		
		end
	end 
end

FA.replaceNapkinDispensers = function(NapkinDispensersObject)
	if not NapkinDispensersObject:getContainer() then
		local square = NapkinDispensersObject:getSquare()
		local spr = NapkinDispensersObject:getSprite():getName()  
		local index = NapkinDispensersObject:getObjectIndex()
          	sledgeDestroy(NapkinDispensersObject)
		NapkinDispensersObject:getSquare():transmitRemoveItemFromSquareOnServer(NapkinDispensersObject)
		NapkinDispensersObject:getSquare():transmitRemoveItemFromSquare(NapkinDispensersObject)            

          	NapkinDispensersObject = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
            	NapkinDispensersObject:setIsContainer(true)
		NapkinDispensersObject:getContainer():setType("napkinDispenser")
             	NapkinDispensersObject:getContainer():setCapacity(5)

             	square:AddTileObject(NapkinDispensersObject, index)
		square:transmitAddObjectToSquare(NapkinDispensersObject, NapkinDispensersObject:getObjectIndex())
		square:transmitModdata()
		NapkinDispensersObject:transmitModData()	
            	NapkinDispensersObject:transmitCompleteItemToServer()
             	NapkinDispensersObject:transmitUpdatedSpriteToServer()


		local addItem1 = NapkinDispensersObject:getContainer():AddItem("Base.PaperNapkins")
		if isClient() then
			NapkinDispensersObject:getItemContainer():addItemOnServer(addItem1)
		end
		local RollRand = ZombRand(1,100)
		if RollRand >= 30 then
			local addItem2 = NapkinDispensersObject:getContainer():AddItem("Base.PaperNapkins")
			if isClient() then
				NapkinDispensersObject:getItemContainer():addItemOnServer(addItem2)
			end
			if RollRand >= 60 then
				local addItem3 = NapkinDispensersObject:getContainer():AddItem("Base.PaperNapkins")
				if isClient() then
					NapkinDispensersObject:getItemContainer():addItemOnServer(addItem3)
				end
				if RollRand >= 90 then
					local addItem4 = NapkinDispensersObject:getContainer():AddItem("Base.PaperNapkins")
					if isClient() then
						NapkinDispensersObject:getItemContainer():addItemOnServer(addItem4)
					end
				end
			end
		end
	end 
end

FA.replacePaperTowelDispensers = function(PaperTowelDispensersObject)
	if not PaperTowelDispensersObject:getContainer() then
		local square = PaperTowelDispensersObject:getSquare()
		local spr = PaperTowelDispensersObject:getSprite():getName()  
		local index = PaperTowelDispensersObject:getObjectIndex()
          	sledgeDestroy(PaperTowelDispensersObject)
		PaperTowelDispensersObject:getSquare():transmitRemoveItemFromSquareOnServer(PaperTowelDispensersObject)
		PaperTowelDispensersObject:getSquare():transmitRemoveItemFromSquare(PaperTowelDispensersObject)            

          	PaperTowelDispensersObject = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
            	PaperTowelDispensersObject:setIsContainer(true)
		PaperTowelDispensersObject:getContainer():setType("papertowelDispenser")
             	PaperTowelDispensersObject:getContainer():setCapacity(5)

             	square:AddTileObject(PaperTowelDispensersObject, index)
		square:transmitAddObjectToSquare(PaperTowelDispensersObject, PaperTowelDispensersObject:getObjectIndex())
		square:transmitModdata()
		PaperTowelDispensersObject:transmitModData()	
            	PaperTowelDispensersObject:transmitCompleteItemToServer()
             	PaperTowelDispensersObject:transmitUpdatedSpriteToServer()

		local addItem1 = PaperTowelDispensersObject:getContainer():AddItem("Base.PaperNapkins")
		if isClient() then
			PaperTowelDispensersObject:getItemContainer():addItemOnServer(addItem1)
		end
		local RollRand = ZombRand(1,100)
		if RollRand >= 30 then
			local addItem2 = PaperTowelDispensersObject:getContainer():AddItem("Base.PaperNapkins")
			if isClient() then
				PaperTowelDispensersObject:getItemContainer():addItemOnServer(addItem2)
			end
			if RollRand >= 60 then
				local addItem3 = PaperTowelDispensersObject:getContainer():AddItem("Base.PaperNapkins")
				if isClient() then
					PaperTowelDispensersObject:getItemContainer():addItemOnServer(addItem3)
				end
				if RollRand >= 90 then
					local addItem4 = PaperTowelDispensersObject:getContainer():AddItem("Base.PaperNapkins")
					if isClient() then
						PaperTowelDispensersObject:getItemContainer():addItemOnServer(addItem4)
					end
				end
			end
		end
	end 
end

FA.DoesItRing = function(PayPhones)
	if PayPhones and SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier then
		local randomNumb = ZombRand(1,100)
		if randomNumb < 20 then
			PayPhones:getModData()['Ring'] = "TRUE"
		else
			PayPhones:getModData()['Ring'] = "FALSE"
		end
	else
		PayPhones:getModData()['Ring'] = "FALSE"
	end

	PayPhones:transmitModData()
end

FA.replacePopcornMachine = function(PopcornMachineObject)
	if not PopcornMachineObject:getContainer() then
		local square = PopcornMachineObject:getSquare()
		local spr = PopcornMachineObject:getSprite():getName()  
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

		local FAFreshTheatreSpawnChance = SandboxVars.FunctionalAppliances.FAFreshTheatreChance

		if (FAFreshTheatreSpawnChance == 6) then
			FAFreshTheatreSpawnChance = 0
		end

		local RollRand = ZombRand(1,100)+(FAFreshTheatreSpawnChance*10)
		if RollRand >= 101 then
			local addItem1 = PopcornMachineObject:getContainer():AddItem("FunctionalAppliances.FATheaterPopcorn")
			if isClient() then
				PopcornMachineObject:getItemContainer():addItemOnServer(addItem1)
			end
			if RollRand >= 121 then
				local addItem2 = PopcornMachineObject:getContainer():AddItem("FunctionalAppliances.FAButteredPopcorn")
				if isClient() then
					PopcornMachineObject:getItemContainer():addItemOnServer(addItem2)
				end
				if RollRand >= 131 then
					local addItem3 = PopcornMachineObject:getContainer():AddItem("FunctionalAppliances.FAButteredPopcorn")
					if isClient() then
						PopcornMachineObject:getItemContainer():addItemOnServer(addItem3)
					end
				end
			end
		end
	end
end

FA.depleteTank = function(tank)
	local filledAmount = SandboxVars.FunctionalAppliances.SyrupsFilledAmount
	local randomNumb = 0

	if filledAmount == 6 then
		randomNumb = ZombRand(2,100)
	elseif filledAmount == 5 then
		randomNumb = 100
	elseif filledAmount == 4 then
		randomNumb = ZombRand(73,98)
	elseif filledAmount == 3 then
		randomNumb = ZombRand(48,77)
	elseif filledAmount == 2 then
		randomNumb = ZombRand(23,52)
	elseif filledAmount == 1 then
		randomNumb = ZombRand(2,27)
	end

	local tankDelta = tank:getUseDelta()
	local newWeightAmount = 5 + (randomNumb * 0.05)

	tank:setDelta(randomNumb * tankDelta)
	tank:setActualWeight(newWeightAmount)
	tank:setCustomWeight(true)
end

FA.depleteSyrup = function(syrup)
	local filledAmount = SandboxVars.FunctionalAppliances.SyrupsFilledAmount
	local randomNumb = 0

	if filledAmount == 6 then
		randomNumb = ZombRand(2,48)
	elseif filledAmount == 5 then
		randomNumb = 48
	elseif filledAmount == 4 then
		randomNumb = ZombRand(30,47)
	elseif filledAmount == 3 then
		randomNumb = ZombRand(20,32)
	elseif filledAmount == 2 then
		randomNumb = ZombRand(10,22)
	elseif filledAmount == 1 then
		randomNumb = ZombRand(2,12)
	end

	local syrupDelta = syrup:getUseDelta()
	local newWeightAmount = 1 + (randomNumb * 0.1875)

	syrup:setDelta(randomNumb * syrupDelta)
	syrup:setActualWeight(newWeightAmount)
	syrup:setCustomWeight(true)
end

FA.SyrupPickOne = function(index)
	return ZombRand(index)+1
end

local FASyrupsList = {
	"FunctionalAppliances.FAOrangeSodaSyrupBox",
	"FunctionalAppliances.FALemonLimeSodaSyrupBox",
	"FunctionalAppliances.FARootBeerSodaSyrupBox",
	"FunctionalAppliances.FAColaSodaSyrupBox",
}

FA.replaceSlurpBurp = function(SlurpBurp)
	if not SlurpBurp:getContainer() then
		local square = SlurpBurp:getSquare()
		local spr = SlurpBurp:getSprite():getName()  
		local index = SlurpBurp:getObjectIndex()
          	sledgeDestroy(SlurpBurp)
		SlurpBurp:getSquare():transmitRemoveItemFromSquareOnServer(SlurpBurp)
		SlurpBurp:getSquare():transmitRemoveItemFromSquare(SlurpBurp)            

          	SlurpBurp = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
            	SlurpBurp:setIsContainer(true)
             	SlurpBurp:getContainer():setType("slurpNBurp")
             	SlurpBurp:getContainer():setCapacity(100)
		SlurpBurp:getSprite():getProperties():Set(IsoFlagType.waterPiped, "TRUE")

             	square:AddTileObject(SlurpBurp, index)
		square:transmitAddObjectToSquare(SlurpBurp, SlurpBurp:getObjectIndex())
		square:transmitModdata()
		SlurpBurp:transmitModData()	
            	SlurpBurp:transmitCompleteItemToServer()
             	SlurpBurp:transmitUpdatedSpriteToServer()

		local FASyrupsSpawnChance = SandboxVars.FunctionalAppliances.SyrupsChance

		if (FASyrupsSpawnChance == 6) then
			FASyrupsSpawnChance = 0
		end

		if FASyrupsSpawnChance > 0 then
			local addItem1 = SlurpBurp:getContainer():AddItem("FunctionalAppliances.FACO2Tank")
			local addItem2 = SlurpBurp:getContainer():AddItem(FASyrupsList[FA.SyrupPickOne(#FASyrupsList)])
			if isClient() then
				SlurpBurp:getItemContainer():addItemOnServer(addItem1)
				SlurpBurp:getItemContainer():addItemOnServer(addItem2)
			end
			FA.depleteTank(addItem1)
			FA.depleteSyrup(addItem2)
		end

		local RollRand = ZombRand(1,100)+(FASyrupsSpawnChance*10)
		if RollRand >= 101 then
			local addItem3 = SlurpBurp:getContainer():AddItem(FASyrupsList[FA.SyrupPickOne(#FASyrupsList)])
			if isClient() then
				SlurpBurp:getItemContainer():addItemOnServer(addItem3)
			end
			FA.depleteSyrup(addItem3)
			if RollRand >= 121 then
				local addItem4 = SlurpBurp:getContainer():AddItem(FASyrupsList[FA.SyrupPickOne(#FASyrupsList)])
				if isClient() then
					SlurpBurp:getItemContainer():addItemOnServer(addItem4)
				end
				FA.depleteSyrup(addItem4)
			end
		end
	end
end

FA.onLoadGridsquare = function(square)
	local SodaFountain = nil
	local SlurpBurp = nil
	local PopcornMachine = nil
	local PayPhones = nil
	local PaperTowelDispensersObject = nil
	local NapkinDispensersObject = nil
	local HotDogMachine = nil
	local objects = square:getObjects()

        for i=1, objects:size()-1 do
        	local thisObject = objects:get(i)
        	local spr = thisObject:getSprite()
        	if spr then
			local properties = spr:getProperties()
              		local groupName = properties:Val("GroupName")
              		local customName = properties:Val("CustomName")
               		if groupName == "SlurpBurp" then
				SlurpBurp = thisObject
			elseif groupName == "Tabletop Soda" then
				SodaFountain = thisObject
          		elseif customName == "Popcorn Machine" then
				PopcornMachine = thisObject
               		elseif groupName == "Pay" and customName == "Phones" then
				PayPhones = thisObject
               		elseif groupName == "Air" and customName == "Blower" then
				PaperTowelDispensersObject = thisObject
               		elseif groupName == "Shop" and customName == "Dispenser" then
				NapkinDispensersObject = thisObject
                	elseif groupName == "Fossoil Candy" then
				HotDogMachine = thisObject
                	end
            	end
        end

	if SlurpBurp then
		FA.replaceSlurpBurp(SlurpBurp)
	end
	if SodaFountain then
		SodaFountain:getSprite():getProperties():Set(IsoFlagType.waterPiped, "TRUE")
	end
	if PopcornMachine then
		FA.replacePopcornMachine(PopcornMachine)
	end
	if PayPhones then
		FA.DoesItRing(PayPhones)
	end
	if PaperTowelDispensersObject then
		FA.replacePaperTowelDispensers(PaperTowelDispensersObject)
	end
	if NapkinDispensersObject then
		FA.replaceNapkinDispensers(NapkinDispensersObject)
	end
	if HotDogMachine then
		FA.replaceHotDogMachine(HotDogMachine)
	end
end

Events.LoadGridsquare.Add(FA.onLoadGridsquare)