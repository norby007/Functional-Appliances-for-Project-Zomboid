FA = FA or {}

FA.replaceHotDogMachine = function(HotDogMachineObject, fill)
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
	
		if fill == true then
			local FAFreshTheatreSpawnChance = SandboxVars.FunctionalAppliances.FAFreshTheatreChance

			if FAFreshTheatreSpawnChance == 6 then
				FAFreshTheatreSpawnChance = 0
			end

			local RollRand = ZombRand(1,100)+(FAFreshTheatreSpawnChance*10)
			if RollRand >= 101 then
				local addItem1 = HotDogMachineObject:getContainer():AddItem("Base.Sausage")
				addItem1:setCooked(true)
				if isClient() then
					HotDogMachineObject:getItemContainer():addItemOnServer(addItem1)
				end
				if RollRand >= 121 then
					local addItem2 = HotDogMachineObject:getContainer():AddItem("Base.Sausage")
					addItem2:setCooked(true)
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
	return HotDogMachineObject
end

FA.replaceNapkinDispensers = function(NapkinDispensersObject, fill)
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
	
		if fill == true then
			local addItem1 = NapkinDispensersObject:getContainer():AddItem("FunctionalAppliances.FAPaperNapkins")
			if isClient() then
				NapkinDispensersObject:getItemContainer():addItemOnServer(addItem1)
			end
			local RollRand = ZombRand(1,100)
			if RollRand >= 30 then
				local addItem2 = NapkinDispensersObject:getContainer():AddItem("FunctionalAppliances.FAPaperNapkins")
				if isClient() then
					NapkinDispensersObject:getItemContainer():addItemOnServer(addItem2)
				end
				if RollRand >= 60 then
					local addItem3 = NapkinDispensersObject:getContainer():AddItem("FunctionalAppliances.FAPaperNapkins")
					if isClient() then
						NapkinDispensersObject:getItemContainer():addItemOnServer(addItem3)
					end
					if RollRand >= 90 then
						local addItem4 = NapkinDispensersObject:getContainer():AddItem("FunctionalAppliances.FAPaperNapkins")
						if isClient() then
							NapkinDispensersObject:getItemContainer():addItemOnServer(addItem4)
						end
					end
				end
			end
		end
	end 
end

FA.replacePaperTowelDispensers = function(PaperTowelDispensersObject, fill)
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
	
		if fill == true then
			local addItem1 = PaperTowelDispensersObject:getContainer():AddItem("FunctionalAppliances.FAPaperNapkins")
			if isClient() then
				PaperTowelDispensersObject:getItemContainer():addItemOnServer(addItem1)
			end
			local RollRand = ZombRand(1,100)
			if RollRand >= 30 then
				local addItem2 = PaperTowelDispensersObject:getContainer():AddItem("FunctionalAppliances.FAPaperNapkins")
				if isClient() then
					PaperTowelDispensersObject:getItemContainer():addItemOnServer(addItem2)
				end
				if RollRand >= 60 then
					local addItem3 = PaperTowelDispensersObject:getContainer():AddItem("FunctionalAppliances.FAPaperNapkins")
					if isClient() then
						PaperTowelDispensersObject:getItemContainer():addItemOnServer(addItem3)
					end
					if RollRand >= 90 then
						local addItem4 = PaperTowelDispensersObject:getContainer():AddItem("FunctionalAppliances.FAPaperNapkins")
						if isClient() then
							PaperTowelDispensersObject:getItemContainer():addItemOnServer(addItem4)
						end
					end
				end
			end
		end
	end 
end

FA.replaceBulletinBoard = function(BulletinBoard, fill)
	local square = BulletinBoard:getSquare()
	if not BulletinBoard:getContainer() then
		local spr = BulletinBoard:getSprite():getName()  
		local index = BulletinBoard:getObjectIndex()
          	sledgeDestroy(BulletinBoard)
		BulletinBoard:getSquare():transmitRemoveItemFromSquareOnServer(BulletinBoard)
		BulletinBoard:getSquare():transmitRemoveItemFromSquare(BulletinBoard)            

          	BulletinBoard = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
            	BulletinBoard:setIsContainer(true)
		BulletinBoard:getContainer():setType("bulletinBoard")
             	BulletinBoard:getContainer():setCapacity(5)

             	square:AddTileObject(BulletinBoard, index)
		square:transmitAddObjectToSquare(BulletinBoard, BulletinBoard:getObjectIndex())
		square:transmitModdata()
		BulletinBoard:transmitModData()	
            	BulletinBoard:transmitCompleteItemToServer()
             	BulletinBoard:transmitUpdatedSpriteToServer()
	else
		local containerItems = BulletinBoard:getItemContainer():getItems():size() or 0
		local textureName = BulletinBoard:getTextureName()
		
		if containerItems < 1 then
			local destroyThis = nil
			local objects = square:getObjects()
	  	      	for i=1, objects:size()-1 do
       				local thisObject = objects:get(i)
				local texture = thisObject:getTextureName()
				if textureName == "location_business_office_generic_01_15" and texture == "papernotices_01_8" then
					destroyThis = thisObject
					break
				elseif textureName == "location_business_office_generic_01_7" and texture == "papernotices_01_9" then
					destroyThis = thisObject
					break
				end
			end
			if destroyThis then
				return destroyThis
			end
		else
			local foundPapers = nil
			if textureName == "location_business_office_generic_01_15" then 
				local objects = square:getObjects()
		   	     	for i=1, objects:size()-1 do
        				local thisObject = objects:get(i)
					local texture = thisObject:getTextureName() or nil
					if texture == "papernotices_01_8" then
						foundPapers = thisObject
						break
					end
				end
				if not foundPapers then 
					print("add north papernotices_01_8")
					local papers = IsoThumpable.new(getCell(), square, "papernotices_01_8", false, {})
             				square:AddTileObject(papers, papers:getObjectIndex())
					square:transmitAddObjectToSquare(papers, papers:getObjectIndex())
					square:transmitModdata()
					papers:transmitModData()	
            				papers:transmitCompleteItemToServer()
             				papers:transmitUpdatedSpriteToServer()	
				end
			else
				local objects = square:getObjects()
		   	     	for i=1, objects:size()-1 do
        				local thisObject = objects:get(i)
					local texture = thisObject:getTextureName() or nil
					if texture == "papernotices_01_9" then
						print("found: papernotices_01_9 do not make another")
						foundPapers = thisObject
						break
					end
				end
				if not foundPapers then
					print("add west papernotices_01_9")
					local papers = IsoThumpable.new(getCell(), square, "papernotices_01_9", false, {})
             				square:AddTileObject(papers, papers:getObjectIndex())
					square:transmitAddObjectToSquare(papers, papers:getObjectIndex())
					square:transmitModdata()
					papers:transmitModData()	
            				papers:transmitCompleteItemToServer()
             				papers:transmitUpdatedSpriteToServer()	
				end
			end
		end
	end 
end

FA.updatePayPhones = function(PayPhones)
	if PayPhones:getModData()['Loaded'] ~= true then
		if SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier then
			local randomNumb = ZombRand(1,100)
			if randomNumb < 20 then
				PayPhones:getModData()['Ring'] = true
			else
				PayPhones:getModData()['Ring'] = false
			end
		else
			PayPhones:getModData()['Ring'] = false
		end
		PayPhones:getModData()['Loaded'] = true
	end

	PayPhones:transmitModData()
	return PayPhones
end

FA.replacePopcornMachine = function(PopcornMachineObject, fill)
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
	
		if fill == true then
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
	return PopcornMachineObject
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

FA.replaceSlurpBurp = function(SlurpBurp, fill)
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
		SlurpBurp:getSprite():getProperties():Set(IsoFlagType.waterPiped, "true")

             	square:AddTileObject(SlurpBurp, index)
		square:transmitAddObjectToSquare(SlurpBurp, SlurpBurp:getObjectIndex())
		square:transmitModdata()
		SlurpBurp:transmitModData()	
            	SlurpBurp:transmitCompleteItemToServer()
             	SlurpBurp:transmitUpdatedSpriteToServer()
	
		if fill == true then
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

	SlurpBurp:getSprite():getProperties():Set(IsoFlagType.waterPiped, "true")

	return SlurpBurp
end

FA.updateSodaFountain = function(SodaFountain)
	SodaFountain:getSprite():getProperties():Set(IsoFlagType.waterPiped, "true")
	return SodaFountain
end

FA.updateDeepFryers = function(DeepFryers, fill)
	if DeepFryers:getModData()['Loaded'] ~= true and fill == true then
		DeepFryers:getModData()['Loaded'] = true

		if fill == true and DeepFryers:getModData()['VatOil'] ~= "VegetableOil" and DeepFryers:getModData()['VatOil'] ~= "CookingOil" then
			local FADeepFryerOil = SandboxVars.FunctionalAppliances.FADeepFryerOil
			local chanceOfOil = 0
			local RollRand = 0
	
			if FADeepFryerOil == 6 then
				chanceOfOil = 0
			elseif FADeepFryerOil == 1 then
				chanceOfOil = 5
			elseif FADeepFryerOil == 2 then
				chanceOfOil = 20
			elseif FADeepFryerOil == 3 then
				chanceOfOil = 40
			elseif FADeepFryerOil == 4 then
				chanceOfOil = 60
			elseif FADeepFryerOil == 5 then
				chanceOfOil = 80
			end
	
			RollRand = ZombRand(1,100)
			if RollRand < chanceOfOil then
				DeepFryers:getModData()['VatOil'] = "VegetableOil" 
			else
				DeepFryers:getModData()['VatOil'] = "Empty" 
			end
		end
	elseif DeepFryers:getModData()['VatOil'] ~= "VegetableOil" and DeepFryers:getModData()['VatOil'] ~= "CookingOil" then
		DeepFryers:getModData()['Loaded'] = true
		DeepFryers:getModData()['VatOil'] = "Empty" 
	end

	DeepFryers:getSquare():transmitModdata()
	DeepFryers:transmitModData()

	return DeepFryers
end

FA.updateHeatedCounter = function(HeatedCounter, fill)
	local square = HeatedCounter:getSquare()

	if HeatedCounter:getModData()['Loaded'] ~= true and fill == true then
		HeatedCounter:getModData()['Loaded'] = true
		if square:isOutside() == false then
			if square:getRoom() ~= nil then
				local roomName = square:getRoom():getName()
				if roomName == "icecreamkitchen" then
					HeatedCounter:getContainer():setCustomTemperature(0.25)
					HeatedCounter:getModData()['CustomTemp'] = "Cold" -- set to activate cold mode asap for ice cream shops
				else
					HeatedCounter:getContainer():setCustomTemperature(1.5)
					HeatedCounter:getModData()['CustomTemp'] = "Warm" -- else it's a warming coounter
				end
			end
		end
	end

	if HeatedCounter:getModData()['CustomTemp'] == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		HeatedCounter:getContainer():setCustomTemperature(1.5) 	-- just below cooking
		HeatedCounter:getModData()['CustomTemp'] = "Warm" 
	elseif HeatedCounter:getModData()['CustomTemp'] == "Hot" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		HeatedCounter:getContainer():setCustomTemperature(1.61) 	-- just enough to start cooking
		HeatedCounter:getModData()['CustomTemp'] = "Hot" 
	elseif HeatedCounter:getModData()['CustomTemp'] == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		HeatedCounter:getContainer():setCustomTemperature(0.25) 	-- cold
		HeatedCounter:getModData()['CustomTemp'] = "Cold" 
	else
		HeatedCounter:getContainer():setCustomTemperature(1) -- room temp
		HeatedCounter:getModData()['CustomTemp'] = "Off"
	end

	HeatedCounter:getSquare():transmitModdata()
	HeatedCounter:transmitModData()
	HeatedCounter:getContainer():requestSync()

	return HeatedCounter
end

FA.updateDisplayCounter = function(DisplayCounter, fill)
	local square = DisplayCounter:getSquare()

	if DisplayCounter:getModData()['Loaded'] ~= true and fill == true then
		DisplayCounter:getModData()['Loaded'] = true
		if square:isOutside() == false then
			if square:getRoom() ~= nil then
				local roomName = square:getRoom():getName()
				if roomName == "icecreamkitchen" or roomName == "candystore" or roomName == "cafe" or roomName == "cafekitchen" or roomName == "bakery" or roomName == "gigamart" or roomName == "grocery" then
					DisplayCounter:getContainer():setCustomTemperature(0.25)
					DisplayCounter:getModData()['CustomTemp'] = "Cold" -- set to activate cold mode asap for ice cream shops
				else
					DisplayCounter:getContainer():setCustomTemperature(1.5)
					DisplayCounter:getModData()['CustomTemp'] = "Warm" -- else it's a warming coounter
				end
			end
		end
	end

	if DisplayCounter:getModData()['CustomTemp'] == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		DisplayCounter:getContainer():setCustomTemperature(1.5) 	-- just below cooking
		DisplayCounter:getModData()['CustomTemp'] = "Warm" 
	elseif DisplayCounter:getModData()['CustomTemp'] == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		DisplayCounter:getContainer():setCustomTemperature(0.25) 	-- cold
		DisplayCounter:getModData()['CustomTemp'] = "Cold" 
	else
		DisplayCounter:getContainer():setCustomTemperature(1) -- room temp
		DisplayCounter:getModData()['CustomTemp'] = "Off"
	end

	DisplayCounter:getSquare():transmitModdata()
	DisplayCounter:transmitModData()
	DisplayCounter:getContainer():requestSync()

	return DisplayCounter
end

FA.updateVendingMachine = function(VendingMachine, fill)
	local square = VendingMachine:getSquare()

	if VendingMachine:getModData()['Loaded'] ~= true and fill == true then
		VendingMachine:getModData()['Loaded'] = true
		if VendingMachine:getSprite():getProperties():Val("GroupName") == "Small Soda" then
			VendingMachine:getContainer():setCustomTemperature(0.25)
			VendingMachine:getModData()['CustomTemp'] = "Cold" -- set to activate cold mode by default
		end
	end

	if VendingMachine:getModData()['CustomTemp'] == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)) then
		VendingMachine:getContainer():setCustomTemperature(1.5) 	-- just below cooking
		VendingMachine:getModData()['CustomTemp'] = "Warm" 
	elseif VendingMachine:getModData()['CustomTemp'] == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)) then
		VendingMachine:getContainer():setCustomTemperature(0.25) 	-- cold
		VendingMachine:getModData()['CustomTemp'] = "Cold" 
	else
		VendingMachine:getContainer():setCustomTemperature(1) -- room temp
		VendingMachine:getModData()['CustomTemp'] = "Off"
	end

	VendingMachine:getSquare():transmitModdata()
	VendingMachine:transmitModData()
	VendingMachine:getContainer():requestSync()

	return VendingMachine
end

FA.onLoadGridsquare = function(square)
	local SodaFountain = nil
	local SlurpBurp = nil
	local PopcornMachine = nil
	local PayPhones = nil
	local PaperTowelDispensersObject = nil
	local NapkinDispensersObject = nil
	local BulletinBoard = nil
	local HotDogMachine = nil
	local DeepFryers = nil
	local HeatedCounter = nil
	local DisplayCounter = nil
	local VendingMachine = nil

	local objects = square:getObjects()
	local fill = true

        for i=1, objects:size()-1 do
        	local thisObject = objects:get(i)
		local texture = thisObject:getTextureName() or nil
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
			elseif customName == "Noteboard" and groupName == "Cork" then	
				BulletinBoard = thisObject
                	elseif groupName == "Fossoil Candy" then
				HotDogMachine = thisObject
			elseif customName == "Industrial 2000" and groupName == "Fryers Club" then
				DeepFryers = thisObject	
			elseif customName == "Counter" and (groupName == "Corner A" or groupName == "Corner B" or groupName == "Middle") then	
				HeatedCounter = thisObject
			elseif texture == "location_restaurant_generic_01_16" or texture == "location_restaurant_generic_01_17" or texture == "location_restaurant_generic_01_18" or texture == "location_restaurant_generic_01_19" or texture == "location_restaurant_generic_01_20" or texture == "location_restaurant_generic_01_21" or texture == "location_restaurant_generic_01_22" or texture == "location_restaurant_generic_01_23" then
				HeatedCounter = thisObject
			elseif (customName == "Counter" or customName == "Stand" or customName == "Display") and (groupName == "Rounded Glass Display" or groupName == "Glass Display" or groupName == "Seahorse Coffee Glass") then	
				DisplayCounter = thisObject
			elseif customName == "Machine" and (groupName == "Large" or groupName == "Small Soda") then	
				VendingMachine = thisObject
                	end
            	end
        end

	if SlurpBurp then
		FA.replaceSlurpBurp(SlurpBurp, fill)
	end
	if SodaFountain then
		FA.updateSodaFountain(SodaFountain)
	end
	if DeepFryers then
		FA.updateDeepFryers(DeepFryers, fill)
	end
	if PopcornMachine then
		FA.replacePopcornMachine(PopcornMachine, fill)
	end
	if PayPhones then
		FA.updatePayPhones(PayPhones)
	end
	if PaperTowelDispensersObject then
		FA.replacePaperTowelDispensers(PaperTowelDispensersObject, fill)
	end
	if NapkinDispensersObject then
		FA.replaceNapkinDispensers(NapkinDispensersObject, fill)
	end
	if BulletinBoard then
		local destroyThis = FA.replaceBulletinBoard(BulletinBoard, fill)
		if destroyThis then
			sledgeDestroy(destroyThis)
			destroyThis:getSquare():transmitRemoveItemFromSquareOnServer(destroyThis)
			destroyThis:getSquare():transmitRemoveItemFromSquare(destroyThis)  
		end
	end
	if HotDogMachine then
		FA.replaceHotDogMachine(HotDogMachine, fill)
	end
	if HeatedCounter then
		FA.updateHeatedCounter(HeatedCounter, fill)
	end
	if DisplayCounter then
		FA.updateDisplayCounter(DisplayCounter, fill)
	end
	if VendingMachine then
		FA.updateVendingMachine(VendingMachine, fill)
	end
end

Events.LoadGridsquare.Add(FA.onLoadGridsquare)