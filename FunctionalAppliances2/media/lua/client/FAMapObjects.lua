FA = FA or {}

FA.SiloGeneratorList = {}

FA.payPhones = {
	"street_decoration_01_38",
	"street_decoration_01_39"
}

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

MapObjects.OnLoadWithSprite(FA.payPhones, FA.updatePayPhones, 5)

FA.deepFryers = {
	"appliances_cooking_01_52",
	"appliances_cooking_01_53",
	"appliances_cooking_01_54",
	"appliances_cooking_01_55"
}

FA.loadDeepFryers = function(DeepFryers)
	DeepFryers:getModData()['Loaded'] = true
	if DeepFryers:getModData()['VatOil'] ~= "VegetableOil" and DeepFryers:getModData()['VatOil'] ~= "CookingOil" then
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

	DeepFryers = FA.updateDeepFryers(DeepFryers)
	return DeepFryers
end

FA.updateDeepFryers = function(DeepFryers)
	if DeepFryers:getModData()['VatOil'] ~= "VegetableOil" and DeepFryers:getModData()['VatOil'] ~= "CookingOil" then
		DeepFryers:getModData()['Loaded'] = true
		DeepFryers:getModData()['VatOil'] = "Empty" 
	end

	DeepFryers:getSquare():transmitModdata()
	DeepFryers:transmitModData()

	return DeepFryers
end

FA.newDeepFryers = function(DeepFryers)
	if DeepFryers:getModData()['Loaded'] ~= true then
		FA.loadDeepFryers(DeepFryers)
	else
		FA.updateDeepFryers(DeepFryers)
	end
end

MapObjects.OnLoadWithSprite(FA.deepFryers, FA.newDeepFryers, 5)

FA.sodaMachines = {
	"location_shop_accessories_01_18",
	"location_shop_accessories_01_19",
	"location_shop_accessories_01_30",
	"location_shop_accessories_01_31"
}

FA.vendingMachines = {
	"location_shop_accessories_01_16",
	"location_shop_accessories_01_17",
	"location_shop_accessories_01_28",
	"location_shop_accessories_01_29"
}

FA.buffetCounters = {
	"location_restaurant_generic_01_16",
	"location_restaurant_generic_01_17",
	"location_restaurant_generic_01_18",
	"location_restaurant_generic_01_19",
	"location_restaurant_generic_01_20",
	"location_restaurant_generic_01_21",
	"location_restaurant_generic_01_22",
	"location_restaurant_generic_01_23"
}

FA.metalDisplayCounters = {
	"location_restaurant_generic_01_24",
	"location_restaurant_generic_01_25",
	"location_restaurant_generic_01_26",
	"location_restaurant_generic_01_27",
	"location_restaurant_generic_01_28",
	"location_restaurant_generic_01_29",
	"location_restaurant_generic_01_32",
	"location_restaurant_generic_01_33",
	"location_restaurant_generic_01_34",
	"location_restaurant_generic_01_35",
	"location_restaurant_generic_01_36",
	"location_restaurant_generic_01_37"
}

FA.roundedDisplayCounters = {
	"location_shop_generic_01_32",
	"location_shop_generic_01_33",
	"location_shop_generic_01_34",
	"location_shop_generic_01_35",
	"location_restaurant_pie_01_48",
	"location_restaurant_pie_01_49",
	"location_restaurant_pie_01_50",
	"location_restaurant_pie_01_51",
	"location_restaurant_seahorse_01_56",
	"location_restaurant_seahorse_01_57",
	"location_restaurant_seahorse_01_58",
	"location_restaurant_seahorse_01_59",
	"location_restaurant_pizzawhirled_01_64",
	"location_restaurant_pizzawhirled_01_65",
	"location_restaurant_pizzawhirled_01_66",
	"location_restaurant_pizzawhirled_01_67"
}

FA.loadMachineTemp = function(Machine)
	local square = Machine:getSquare()

	Machine:getModData()['Loaded'] = true
	if square:isOutside() == false then
		if square:getRoom() ~= nil then
			local roomName = square:getRoom():getName()
			if roomName == "icecreamkitchen" or roomName == "candystore" or roomName == "cafe" or roomName == "cafekitchen" or roomName == "bakery" or roomName == "gigamart" or roomName == "grocery" then
				Machine:getContainer():setCustomTemperature(0.25)
				Machine:getModData()['CustomTemp'] = "Cold" -- set to activate cold mode asap for ice cream shops
			else
				Machine:getContainer():setCustomTemperature(1.5)
				Machine:getModData()['CustomTemp'] = "Warm" -- else it's a warming coounter
			end
		end
	end

	if Machine:getSprite():getProperties():Val("CustomName") == "Machine" then
		if Machine:getSprite():getProperties():Val("GroupName") == "Small Soda" then
			Machine:getContainer():setCustomTemperature(0.25)
			Machine:getModData()['CustomTemp'] = "Cold" -- set to activate cold mode by default
		elseif Machine:getSprite():getProperties():Val("GroupName") == "Large" then
			Machine:getContainer():setCustomTemperature(1) -- room temp
			Machine:getModData()['CustomTemp'] = "Off"
		end
	end

	Machine = FA.updateMachineTemp(Machine)
	return Machine
end

FA.updateMachineTemp = function(Machine)
	local square = Machine:getSquare()

	Machine:getModData()['Loaded'] = true
	if Machine:getModData()['CustomTemp'] == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)) then
		Machine:getContainer():setCustomTemperature(1.5) 	-- just below cooking
		Machine:getModData()['CustomTemp'] = "Warm" 
	elseif Machine:getModData()['CustomTemp'] == "Hot" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)) then
		Machine:getContainer():setCustomTemperature(1.61) 	-- just enough to start cooking
		Machine:getModData()['CustomTemp'] = "Hot" 
	elseif Machine:getModData()['CustomTemp'] == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)) then
		Machine:getContainer():setCustomTemperature(0.25) 	-- cold
		Machine:getModData()['CustomTemp'] = "Cold" 
	else
		Machine:getContainer():setCustomTemperature(1) -- room temp
		Machine:getModData()['CustomTemp'] = "Off"
	end

	Machine:getSquare():transmitModdata()
	Machine:transmitModData()
	Machine:getContainer():requestSync()

	return Machine
end

FA.newMachineTemp = function(Machine)
	if Machine:getModData()['Loaded'] ~= true then
		FA.loadMachineTemp(Machine)
	else
		FA.updateMachineTemp(Machine)
	end
end

MapObjects.OnLoadWithSprite(FA.vendingMachines, FA.newMachineTemp, 5)
MapObjects.OnLoadWithSprite(FA.sodaMachines, FA.newMachineTemp, 5)
MapObjects.OnLoadWithSprite(FA.buffetCounters, FA.newMachineTemp, 5)
MapObjects.OnLoadWithSprite(FA.metalDisplayCounters, FA.newMachineTemp, 5)
MapObjects.OnLoadWithSprite(FA.roundedDisplayCounters, FA.newMachineTemp, 5)

FA.updateSiloGenerator = function(SiloGenerator)
	local EnableSiloGenerators = SandboxVars.FunctionalAppliances.FAEnableSiloGenerators
	local objectName = SiloGenerator:getObjectName() or nil

	if not EnableSiloGenerators or objectName == "IsoGenerator" then
		return
	end

	local square = SiloGenerator:getSquare()
	local NewSiloGenerator = nil
	if SiloGenerator:getModData()['Loaded'] ~= true then
		SiloGenerator:getModData()['Loaded'] = true	
		SiloGenerator:getModData()['PoweredOn'] = false

		local GeneratorMagazineSpawnChance = SandboxVars.FunctionalAppliances.FAGeneratorMagazineSpawnChance
		local AutoPowerOnChance = SandboxVars.FunctionalAppliances.FAAutoPowerOnChance
		local FuelTankFilledAmount = SandboxVars.FunctionalAppliances.FAFuelTankFilledAmount
		local ConditionAmount = SandboxVars.FunctionalAppliances.FAConditionAmount

		local randNumb = ZombRand(0,100)
		if GeneratorMagazineSpawnChance == 5 and randNumb <= 60 then
			SiloGenerator:getModData()['GeneratorMagazine'] = true
		elseif GeneratorMagazineSpawnChance == 4 and randNumb <= 30 then
			SiloGenerator:getModData()['GeneratorMagazine'] = true
		elseif GeneratorMagazineSpawnChance == 3 and randNumb <= 20 then
			SiloGenerator:getModData()['GeneratorMagazine'] = true
		elseif GeneratorMagazineSpawnChance == 2 and randNumb <= 10 then
			SiloGenerator:getModData()['GeneratorMagazine'] = true
		elseif GeneratorMagazineSpawnChance == 1 and randNumb <= 5 then
			SiloGenerator:getModData()['GeneratorMagazine'] = true
		else
			SiloGenerator:getModData()['GeneratorMagazine'] = false
		end

		randNumb = ZombRand(0,100)
		if AutoPowerOnChance == 5 then
			SiloGenerator:getModData()['AutoPowerOn'] = true
		elseif AutoPowerOnChance == 4 and randNumb <= 60 then
			SiloGenerator:getModData()['AutoPowerOn'] = true
		elseif AutoPowerOnChance == 3 and randNumb <= 30 then
			SiloGenerator:getModData()['AutoPowerOn'] = true
		elseif AutoPowerOnChance == 2 and randNumb <= 10 then
			SiloGenerator:getModData()['AutoPowerOn'] = true
		elseif AutoPowerOnChance == 1 and randNumb <= 5 then
			SiloGenerator:getModData()['AutoPowerOn'] = true
		else
			SiloGenerator:getModData()['AutoPowerOn'] = false
		end

		if FuelTankFilledAmount == 5 then
			SiloGenerator:setPipedFuelAmount(ZombRand(0,500))
		elseif FuelTankFilledAmount == 4 then
			SiloGenerator:setPipedFuelAmount(500)
		elseif FuelTankFilledAmount == 3 then
			SiloGenerator:setPipedFuelAmount(ZombRand(300,500))
		elseif FuelTankFilledAmount == 2 then
			SiloGenerator:setPipedFuelAmount(ZombRand(50,300))
		elseif FuelTankFilledAmount == 1 then
			SiloGenerator:setPipedFuelAmount(ZombRand(0,50))
		else
			SiloGenerator:setPipedFuelAmount(0)
		end

		if ConditionAmount == 5 then
			SiloGenerator:getModData()['Condition'] = ZombRand(0,100)
		elseif ConditionAmount == 4 then
			SiloGenerator:getModData()['Condition'] = 100
		elseif ConditionAmount == 3 then
			SiloGenerator:getModData()['Condition'] = ZombRand(70,100)
		elseif ConditionAmount == 2 then
			SiloGenerator:getModData()['Condition'] = ZombRand(30,70)
		elseif ConditionAmount == 1 then
			SiloGenerator:getModData()['Condition'] = ZombRand(0,30)
		else
			SiloGenerator:getModData()['Condition'] = 0
		end

		local spr = SiloGenerator:getSprite():getName()

       		NewSiloGenerator = IsoGenerator.new(nil, square:getCell(), square)  
		NewSiloGenerator:setSprite(spr)  
		NewSiloGenerator:transmitCompleteItemToServer()
       		NewSiloGenerator:setCondition(100)
       		NewSiloGenerator:setFuel(100)
       		NewSiloGenerator:setConnected(true)
		NewSiloGenerator:setActivated(false)
		NewSiloGenerator:setSurroundingElectricity()  

		square:transmitModdata()
		SiloGenerator:transmitModData()	
		NewSiloGenerator:transmitModData()	
	end

	if NewSiloGenerator == nil then
		for i=1,square:getObjects():size() do
			local thisObject = square:getObjects():get(i-1)
			local objectName = thisObject:getObjectName()
			local spriteName = thisObject:getSpriteName()

			if spriteName == "industry_02_67" and objectName == "IsoGenerator" then
				NewSiloGenerator = thisObject
				break
			end
		end
	end

	if NewSiloGenerator == nil then
		local spr = SiloGenerator:getSprite():getName()

       		NewSiloGenerator = IsoGenerator.new(nil, square:getCell(), square)  
		NewSiloGenerator:setSprite(spr)  
		NewSiloGenerator:transmitCompleteItemToServer()
       		NewSiloGenerator:setCondition(100)
       		NewSiloGenerator:setFuel(100)
       		NewSiloGenerator:setConnected(true)
		NewSiloGenerator:setActivated(false)
		NewSiloGenerator:setSurroundingElectricity()  

		square:transmitModdata()
		SiloGenerator:transmitModData()	
		NewSiloGenerator:transmitModData()
	end

	if not square:haveElectricity() and not (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier) then
		if SiloGenerator:getModData()['AutoPowerOn'] == true and SiloGenerator:getModData()['Condition'] > 0 and SiloGenerator:getPipedFuelAmount() > 0 then
			SiloGenerator:getModData()['PoweredOn'] = true
		end
	end

	if SiloGenerator:getModData()['PoweredOn'] == true and SiloGenerator:getModData()['Condition'] > 0 and SiloGenerator:getPipedFuelAmount() > 0 then
        	NewSiloGenerator:setActivated(true)
		NewSiloGenerator:setSurroundingElectricity() 
	else
		SiloGenerator:getModData()['PoweredOn'] = false
		NewSiloGenerator:setActivated(false)
		NewSiloGenerator:setSurroundingElectricity() 
	end   

	if square:getBuilding() then
		--print("grid square toxic off")
		square:getBuilding():setToxic(false)
	end

	local foundSiloGenerator = false
	if #FA.SiloGeneratorList > 0 then
		for index,x in ipairs(FA.SiloGeneratorList) do
			if x.x == SiloGenerator:getX() and x.y == SiloGenerator:getY() and x.z == SiloGenerator:getZ() then
				x.poweredon = SiloGenerator:getModData()['PoweredOn']
				foundSiloGenerator = true
				break
			end
		end
	end

	if not foundSiloGenerator then
		local t = t or {}
		t.x = SiloGenerator:getX()
		t.y = SiloGenerator:getY()
		t.z = SiloGenerator:getZ()
		t.poweredon = SiloGenerator:getModData()['PoweredOn']
		table.insert(FA.SiloGeneratorList, 1, t)
	end

	square:transmitModdata()
	SiloGenerator:transmitModData()	
	NewSiloGenerator:transmitModData()

	return SiloGenerator
end

MapObjects.OnLoadWithSprite("industry_02_67", FA.updateSiloGenerator, 5)