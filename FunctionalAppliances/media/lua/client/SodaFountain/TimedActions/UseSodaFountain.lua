require "TimedActions/ISBaseTimedAction"

UseSodaFountain = ISBaseTimedAction:derive("UseSodaFountain");

function UseSodaFountain:isValid()
	return true;
end

local function exchangeBottle(flavor, syrup)
	local inv = getPlayer():getInventory()

	local emptyPopBottle = inv:FindAndReturn("Base.PopBottleEmpty")
	local emptyWaterBottle = inv:FindAndReturn("Base.WaterBottleEmpty")
	local vanillaFountainCup = inv:FindAndReturn("Base.FountainCup")
	local FAFountainCup = inv:FindAndReturn("FunctionalAppliances.FAFountainCup")

	if flavor == "Soda" then
		if vanillaFountainCup then
			inv:Remove("FountainCup")
			if syrup == "Box of Orange Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupOrangeSoda")
			elseif syrup == "Box of KY Cola Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupColaSoda")
			elseif syrup == "Box of Lemon Lime Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupLemonLimeSoda")
			elseif syrup == "Box of Root Beer Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupRootBeerSoda")
			elseif syrup == "Box of Berry Flavored Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupBerrySoda")
			else
				inv:AddItem("FunctionalAppliances.FAFountainCupCarbonatedWater")
			end
		elseif FAFountainCup then
			inv:Remove("FAFountainCup")
			if syrup == "Box of Orange Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupOrangeSoda")
			elseif syrup == "Box of KY Cola Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupColaSoda")
			elseif syrup == "Box of Lemon Lime Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupLemonLimeSoda")
			elseif syrup == "Box of Root Beer Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupRootBeerSoda")
			elseif syrup == "Box of Berry Flavored Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAFountainCupBerrySoda")
			else
				inv:AddItem("FunctionalAppliances.FAFountainCupCarbonatedWater")
			end
		end
	elseif flavor == "RefillSodaBottle" then
		if emptyPopBottle then
			inv:Remove("PopBottleEmpty")
			if syrup == "Box of Orange Soda Syrup" then
				inv:AddItem("Base.PopBottle")
			elseif syrup == "Box of KY Cola Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAPopBottleCola")
			elseif syrup == "Box of Lemon Lime Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAPopBottleLemonLime")
			elseif syrup == "Box of Root Beer Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAPopBottleRootBeer")
			elseif syrup == "Box of Berry Flavored Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAPopBottleBerry")
			else
				if getActivatedMods():contains("sapphcooking") then
					inv:AddItem("SapphCooking.CarbonatedWater")
				else
					inv:AddItem("FunctionalAppliances.FAPopBottleCarbonatedWater")
				end
			end
		elseif emptyWaterBottle then
			inv:Remove("WaterBottleEmpty")
			if syrup == "Box of Orange Soda Syrup" then
				inv:AddItem("Base.PopBottle")
			elseif syrup == "Box of KY Cola Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAPopBottleCola")
			elseif syrup == "Box of Lemon Lime Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAPopBottleLemonLime")
			elseif syrup == "Box of Root Beer Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAPopBottleRootBeer")
			elseif syrup == "Box of Berry Flavored Soda Syrup" then
				inv:AddItem("FunctionalAppliances.FAPopBottleBerry")
			else
				if getActivatedMods():contains("sapphcooking") then
					inv:AddItem("SapphCooking.CarbonatedWater")
				else
					inv:AddItem("FunctionalAppliances.FAPopBottleCarbonatedWater")
				end
			end
		end
	end
end

function UseSodaFountain:waitToStart()
	self.character:faceThisObject(self.machine);
	return self.character:shouldBeTurning();
end

function UseSodaFountain:update()

	local isPlaying = self.gameSound
		and self.gameSound ~= 0
		and self.character:getEmitter():isPlaying(self.gameSound)

	if not isPlaying then
		local soundRadius = 13
		local volume = 6

		self.gameSound = self.character:getEmitter():playSound(self.soundFile);
		
		addSound(self.character,
				 self.character:getX(),
				 self.character:getY(),
				 self.character:getZ(),
				 soundRadius,
				 volume)
	end
	
	self.character:faceThisObject(self.machine);
end

function UseSodaFountain:start()
	self:setActionAnim("fill_container_tap");
	self.character:SetVariable("LootPosition", "Mid")
	self:setOverrideHandModels(nil, nil)
end

function UseSodaFountain:stop()

	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound);
	end

	local soundRadius = 15
	local volume = 6

	ISBaseTimedAction.stop(self);
end

function UseSodaFountain:perform()

	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound);
	end

	local soundRadius = 13
	local volume = 6
		
	addSound(self.character,
			 self.character:getX(),
			 self.character:getY(),
			 self.character:getZ(),
			 soundRadius,
			 volume)

	if self.flavor == "RefillSodaBottle" then
		if self.syrup:getDisplayName() ~= "Empty Box of Soda Syrup" then
			local newWeightAmount = 1 + (math.floor(self.syrup:getDelta()/self.syrup:getUseDelta()) - 1) * 0.1875

			self.syrup:setActualWeight(newWeightAmount)
			self.syrup:setCustomWeight(true)
			self.syrup:Use()
			self.syrup:Use()
		end		

		local newTankWeightAmount = 5 + (math.floor(self.tank:getDelta()/self.tank:getUseDelta()) - 2) * 0.05

		self.tank:setActualWeight(newTankWeightAmount)
		self.tank:setCustomWeight(true)
		self.tank:Use()
		self.tank:Use()
	elseif self.flavor == "Soda" then
		if self.syrup:getDisplayName() ~= "Empty Box of Soda Syrup" then
			local newWeightAmount = 1 + (math.floor(self.syrup:getDelta()/self.syrup:getUseDelta()) - 1) * 0.1875

			self.syrup:setActualWeight(newWeightAmount)
			self.syrup:setCustomWeight(true)
			self.syrup:Use()
		end

		local newTankWeightAmount = 5 + (math.floor(self.tank:getDelta()/self.tank:getUseDelta()) - 1) * 0.05

		self.tank:setActualWeight(newTankWeightAmount)
		self.tank:setCustomWeight(true)
		self.tank:Use()
	end

	if self.flavor == "RefillSodaBottle" and self.machine:getWaterAmount() > 3 then
		local newWaterAmount = self.machine:getWaterAmount() - 4
		if newWaterAmount < 0 then
			newWaterAmount = 0
		end
		self.machine:setWaterAmount(newWaterAmount)
	elseif self.flavor == "RefillSodaBottle" then
		self.jug:Use()
		self.jug:Use()
		self.jug:Use()
		self.jug:Use()
	elseif self.machine:getWaterAmount() > 1 then
		local newWaterAmount = self.machine:getWaterAmount() - 2
		if newWaterAmount < 0 then
			newWaterAmount = 0
		end
		self.machine:setWaterAmount(newWaterAmount)
	else
		self.jug:Use()
		self.jug:Use()
	end

	self.tank:getContainer():requestSync()

	exchangeBottle(self.flavor, self.syrup:getDisplayName())

	ISBaseTimedAction.perform(self);
end

function UseSodaFountain:new(character, machine, sound, flavor, syrup, tank, jug)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.machine = machine
	o.soundFile = sound
	o.flavor = flavor
	o.syrup = syrup
	o.tank = tank
	o.jug = jug
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.gameSound = 0
	o.maxTime = 170
	return o;
end