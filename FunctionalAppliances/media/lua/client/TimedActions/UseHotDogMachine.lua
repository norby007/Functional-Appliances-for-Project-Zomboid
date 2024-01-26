require "TimedActions/ISBaseTimedAction"

UseHotDogMachine = ISBaseTimedAction:derive("UseHotDogMachine")

function UseHotDogMachine:isValid()
	return true
end

local function addXP(machine, foodType)
	local player = getPlayer()
	local xp = player:getXp()
	local perkBoost = xp:getPerkBoost(Perks.Cooking)
	local multiplier = xp:getMultiplier(Perks.Cooking)
	local baseXP = 1

	local inv = player:getInventory()
	local HotdogBun = inv:FindAndReturn("SapphCooking.HotdogBun")
	local BreadSlices = inv:FindAndReturn("Base.BreadSlices")
	local Sausage = inv:FindAndReturn("Base.Sausage")
	local VSausage = inv:FindAndReturn("SapphCooking.ViennaSausage")
	local FSausage = inv:FindAndReturn("SapphCooking.FrankfurterSausage")
	local ESausage = inv:FindAndReturn("SapphCooking.SausageEvolved")

	if foodType == "Hotdog" then
		if Sausage then
			inv:Remove("Sausage")
		elseif VSausage then
			inv:Remove("ViennaSausage")
		elseif FSausage then
			inv:Remove("FrankfurterSausage")
		elseif ESausage then
			inv:Remove("SausageEvolved")
		end
		if HotdogBun then
			inv:Remove("HotdogBun")
		elseif BreadSlices then
			inv:Remove("BreadSlices")
		end
		inv:AddItem("FunctionalAppliances.FAHotdog")
	end

	local playerItems = inv:getItems()
	for i=0, playerItems:size()-1 do
        	local item = playerItems:get(i)
		local itemType = nil

		if item and item:getType() then
			itemType = item:getType()
		end

		if (itemType == "Sausage" or itemType == "SausageEvolved") and not item:isCooked() then
			Sausage = item
		elseif itemType == "ViennaSausage" and not item:isCooked() then
			VSausage = item
		elseif itemType == "FrankfurterSausage" and not item:isCooked() then
			FSausage = item
		end
	end	

	if foodType == "Sausage" then
		inv:Remove(Sausage)
		local addItem1 = machine:getContainer():AddItem("Base.Sausage")
		if isClient() then
			machine:getItemContainer():addItemOnServer(addItem1)
		end
		addItem1:setCooked(true)
	elseif foodType == "ViennaSausage" then
		inv:Remove(VSausage)
		local addItem1 = machine:getContainer():AddItem("SapphCooking.ViennaSausage")
		if isClient() then
			machine:getItemContainer():addItemOnServer(addItem1)
		end
		addItem1:setCooked(true)
	elseif foodType == "FrankfurterSausage"	then
		inv:Remove(FSausage)
		local addItem1 = machine:getContainer():AddItem("SapphCooking.FrankfurterSausage")
		if isClient() then
			machine:getItemContainer():addItemOnServer(addItem1)
		end
		addItem1:setCooked(true)
	end	

	machine:getContainer():requestSync()

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

function UseHotDogMachine:waitToStart()
	self.character:faceThisObject(self.machine)
	return self.character:shouldBeTurning()
end

function UseHotDogMachine:update()

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

function UseHotDogMachine:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Mid")
	self:setOverrideHandModels(nil, nil)

	if self.lightSource == nil then
		self.lightSource = IsoLightSource.new(self.machine:getX(), self.machine:getY(), self.machine:getZ(), 0.1, 0, 0, 1)
		self.machine:getCell():addLamppost(self.lightSource)
	end
end

function UseHotDogMachine:stop()

	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound)
	end

	local soundRadius = 15
	local volume = 6
	
    	if self.lightSource ~= nil then
        	self.machine:getCell():removeLamppost(self.lightSource)	
        	self.lightSource = nil
    	end

	ISBaseTimedAction.stop(self)
end

function UseHotDogMachine:perform()

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

    	if self.lightSource ~= nil then
        	self.machine:getCell():removeLamppost(self.lightSource)	
        	self.lightSource = nil
    	end
	
	addXP(self.machine, self.foodType)

	ISBaseTimedAction.perform(self)
end

function UseHotDogMachine:new(character, machine, sound, food)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.machine = machine
	o.soundFile = sound
	o.foodType = food
	o.stopOnWalk = true
	o.stopOnRun = true
	o.gameSound = 0
	o.maxTime = 240
	o.lightSource = nil
	return o
end