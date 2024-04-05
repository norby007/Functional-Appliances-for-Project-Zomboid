require "TimedActions/ISBaseTimedAction"

UseCoffeeMachine = ISBaseTimedAction:derive("UseCoffeeMachine")

function UseCoffeeMachine:isValid()
	return true
end

local function theEnd(player, machine, coffeeChoice, drinkContainer, waterItem)
	local player = getPlayer()
	local xp = player:getXp()
	local perkBoost = xp:getPerkBoost(Perks.Cooking)
	local multiplier = xp:getMultiplier(Perks.Cooking)
	local baseXP = 1

	local drinkContainerType = nil 
	if drinkContainer then
		drinkContainerType = drinkContainer:getType()
	end

	local inv = player:getInventory()
	local addItem1 = nil

	if coffeeChoice == "tea" then
		if drinkContainerType == "Teacup" or drinkContainerType == "WaterTeacup" then
			addItem1 = inv:AddItem("Base.HotDrinkTea")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "Mugl" or drinkContainerType == "WaterMug" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkTeaMugl")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugRed" or drinkContainerType == "WaterMugRed" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkTeaRed")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugWhite" or drinkContainerType == "WaterMugWhite" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkTeaWhite")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugSpiffo" or drinkContainerType == "WaterMugSpiffo" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkTeaSpiffo")
			addItem1:setCooked(true)
		end
		if waterItem ~= nil then
			waterItem:Use()
		end
		inv:Remove("Teabag2")
		inv:Remove(drinkContainer)
	elseif coffeeChoice == "instantcoffee" then
		if drinkContainerType == "Mugl" or drinkContainerType == "WaterMug" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCoffeeMugl")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugRed" or drinkContainerType == "WaterMugRed" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCoffeeRed")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugWhite" or drinkContainerType == "WaterMugWhite" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCoffeeWhite")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugSpiffo" or drinkContainerType == "WaterMugSpiffo" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCoffeeSpiffo")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "EmptyThermos" or drinkContainerType == "FullWaterThermos" then
			addItem1 = inv:AddItem("SapphCooking.ThermosCoffee")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "LowballGlass" or drinkContainerType == "LowballGlassWater" then
			addItem1 = inv:AddItem("SapphCooking.LowBallGlassCoffee")
			addItem1:setCooked(true)
		end
		if waterItem ~= nil then
			waterItem:Use()
		end
		local instantCoffee = inv:FindAndReturn("Base.Coffee2")
		local coffeePacket = inv:FindAndReturn("SapphCooking.CoffeePacket")
		if instantCoffee then 
			inv:Remove("Coffee2")
		elseif coffeePacket then
			inv:Remove("CoffeePacket")
		end
		inv:Remove(drinkContainer)
	elseif coffeeChoice == "coffee" then
		if drinkContainerType == "Mugl" or drinkContainerType == "WaterMug" then
			addItem1 = inv:AddItem("SapphCooking.MugBrewCoffee")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugRed" or drinkContainerType == "WaterMugRed" then
			addItem1 = inv:AddItem("SapphCooking.MugBrewCoffee3")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugWhite" or drinkContainerType == "WaterMugWhite" then
			addItem1 = inv:AddItem("SapphCooking.MugBrewCoffee2")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "MugSpiffo" or drinkContainerType == "WaterMugSpiffo" then
			addItem1 = inv:AddItem("SapphCooking.MugBrewCoffee4")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "EmptyThermos" or drinkContainerType == "FullWaterThermos" then
			addItem1 = inv:AddItem("SapphCooking.ThermosCoffee")
			addItem1:setCooked(true)
		end
		if drinkContainerType == "LowballGlass" or drinkContainerType == "LowballGlassWater" then
			addItem1 = inv:AddItem("SapphCooking.LowBallGlassCoffeeBrew")
			addItem1:setCooked(true)
		end
		if waterItem ~= nil then
			waterItem:Use()
		end
		local groundCoffee = inv:FindAndReturn("SapphCooking.GrindedCoffee")
		if groundCoffee then
			inv:Remove("GrindedCoffee")
		end
		inv:Remove(drinkContainer)
	elseif coffeeChoice == "espresso" then
		if drinkContainerType == "Teacup" or drinkContainerType == "WaterTeacup" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkEspressoTeacup")
		end
		if drinkContainerType == "Mugl" or drinkContainerType == "WaterMug" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkEspressoMugl")
		end
		if drinkContainerType == "MugRed" or drinkContainerType == "WaterMugRed" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkEspressoRed")
		end
		if drinkContainerType == "MugWhite" or drinkContainerType == "WaterMugWhite" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkEspressoWhite")
		end
		if drinkContainerType == "MugSpiffo" or drinkContainerType == "WaterMugSpiffo" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkEspressoSpiffo")
		end
		if waterItem ~= nil then
			waterItem:Use()
		end
		local groundCoffee = inv:FindAndReturn("SapphCooking.GrindedCoffee")
		if groundCoffee then
			inv:Remove("GrindedCoffee")
		end
		inv:Remove(drinkContainer)
	elseif coffeeChoice == "latte" then
		if drinkContainerType == "FAHotDrinkEspressoTeacup" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkLatteTeacup")
		end
		if drinkContainerType == "FAHotDrinkEspressoMugl" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkLatteMugl")
		end
		if drinkContainerType == "FAHotDrinkEspressoRed" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkLatteRed")
		end
		if drinkContainerType == "FAHotDrinkEspressoWhite" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkLatteWhite")
		end
		if drinkContainerType == "FAHotDrinkEspressoSpiffo" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkLatteSpiffo")
		end
		if waterItem ~= nil then
			waterItem:Use()
		end
		--local milk = inv:FindAndReturn("Base.Milk")
		--milk:Use()
		inv:Remove(drinkContainer)
	elseif coffeeChoice == "cappuccino" then
		if drinkContainerType == "FAHotDrinkEspressoTeacup" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCappuccinoTeacup")
		end
		if drinkContainerType == "FAHotDrinkEspressoMugl" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCappuccinoMugl")
		end
		if drinkContainerType == "FAHotDrinkEspressoRed" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCappuccinoRed")
		end
		if drinkContainerType == "FAHotDrinkEspressoWhite" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCappuccinoWhite")
		end
		if drinkContainerType == "FAHotDrinkEspressoSpiffo" then
			addItem1 = inv:AddItem("FunctionalAppliances.FAHotDrinkCappuccinoSpiffo")
		end
		if waterItem ~= nil then
			waterItem:Use()
		end
		--local milk = inv:FindAndReturn("Base.Milk")
		--milk:Use()
		inv:Remove(drinkContainer)
	elseif coffeeChoice == "grind" then
		inv:Remove("CoffeeBeans")
		inv:AddItem("SapphCooking.GrindedCoffee")
	elseif coffeeChoice == "grindbag" then
		inv:Remove("CoffeeBeansBag")
		inv:AddItem("SapphCooking.GrindedCoffee")
		inv:AddItem("SapphCooking.GrindedCoffee")
		inv:AddItem("SapphCooking.GrindedCoffee")
		inv:AddItem("SapphCooking.GrindedCoffee")
		inv:AddItem("SapphCooking.GrindedCoffee")
	end
	
	if perkBoost == 1 then
		baseXP = baseXP * 1.75
	elseif perkBoost == 2 then
		baseXP = baseXP * 2
	elseif perkBoost == 3 then
		baseXP = baseXP * 2.25
	end

	if multiplier ~= 0 then
		baseXP = baseXP * multiplier
	end
	
	xp:AddXP(Perks.Cooking, baseXP)
end

function UseCoffeeMachine:waitToStart()
	self.character:faceThisObject(self.machine)
	return self.character:shouldBeTurning()
end

function UseCoffeeMachine:update()

	local isPlaying = self.gameSound
		and self.gameSound ~= 0
		and self.character:getEmitter():isPlaying(self.gameSound)

	if not isPlaying then
		local soundRadius = 13
		local volume = 6

		self.gameSound = self.character:getEmitter():playSound(self.soundFile)
		
		addSound(self.character,
				 self.character:getX(),
				 self.character:getY(),
				 self.character:getZ(),
				 soundRadius,
				 volume)
	end
	
	self.character:faceThisObject(self.machine)
end

function UseCoffeeMachine:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Mid")
	self:setOverrideHandModels(nil, nil)
end

function UseCoffeeMachine:stop()

	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound)
	end

	local soundRadius = 15
	local volume = 6

	ISBaseTimedAction.stop(self)
end

function UseCoffeeMachine:perform()

	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound)
	end

	local soundRadius = 13
	local volume = 6
		
	addSound(self.character,
			 self.character:getX(),
			 self.character:getY(),
			 self.character:getZ(),
			 soundRadius,
			 volume)

	theEnd(self.character, self.machine, self.coffeeChoice, self.drinkContainer, self.waterItem)

	ISBaseTimedAction.perform(self)
end

function UseCoffeeMachine:new(character, machine, sound, coffee, container, water)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.machine = machine
	o.soundFile = sound
	o.coffeeChoice = coffee
	o.drinkContainer = container
	o.waterItem = water
	o.stopOnWalk = true
	o.stopOnRun = true
	o.gameSound = 0
	o.maxTime = 520
	return o
end