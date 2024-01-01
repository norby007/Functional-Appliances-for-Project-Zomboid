UseDeepFryers = ISBaseTimedAction:derive("UseDeepFryers");

function UseDeepFryers:isValid()
	return true;
end

local function theEnd(player, machine, foodChoice)
	local player = getPlayer()
	local xp = player:getXp()
	local perkBoost = xp:getPerkBoost(Perks.Cooking)
	local multiplier = xp:getMultiplier(Perks.Cooking)
	local baseXP = 1

	local inv = player:getInventory()

	if foodChoice == "French Fries" then
		if inv:FindAndReturn("SapphCooking.CutPeeledPotato") then
			inv:Remove("CutPeeledPotato")
		else
			inv:Remove("FAPotatoWedges")
		end
		inv:AddItem("Base.Fries")
	elseif foodChoice == "Potato Skins" then
		if inv:FindAndReturn("SapphCooking.PotatoPeel") then
			inv:Remove("PotatoPeel")
		else
			inv:Remove("FAPotatoSkins")
		end
		inv:AddItem("FunctionalAppliances.FAFriedPotatoSkins")
	elseif foodChoice == "Onion Rings" then
		inv:Remove("FriedOnionRingsCraft")
		inv:AddItem("Base.FriedOnionRings")
	elseif foodChoice == "Blooming Onion" then
		inv:Remove("FABatteredBloomingOnion")
		inv:AddItem("FunctionalAppliances.FAFriedBloomingOnion")
	elseif foodChoice == "Tortillas" then
		inv:Remove("CutTortilla")
		inv:AddItem("SapphCooking.SapphTortillaChips")
	elseif foodChoice == "Shrimp" then
		inv:Remove("ShrimpFriedCraft")
		inv:AddItem("Base.ShrimpFried")
	elseif foodChoice == "Fish Fillet" then
		inv:Remove("FishFilletinBatter")
		inv:AddItem("SapphCooking.SapphFishFried")
	elseif foodChoice == "Corndog" then
		inv:Remove("SausageinBatter")
		inv:AddItem("SapphCooking.SapphCorndog")
	elseif foodChoice == "Fried Chicken" then			
		inv:Remove("FABatteredChicken")
		inv:AddItem("Base.ChickenFried")
	elseif foodChoice == "Chicken Fillet" then			
		inv:Remove("FABatteredChickenFillet")
		inv:AddItem("FunctionalAppliances.FAFriedChickenFillet")
	elseif foodChoice == "Chicken Tenders" then			
		inv:Remove("SlicedChickenBatter")
		inv:AddItem("FunctionalAppliances.FAFriedChickenTenders")
	elseif foodChoice == "Chicken Nuggets" then			
		inv:Remove("SmallBirdMeatinBatter")
		inv:AddItem("Base.ChickenNuggets")
	elseif foodChoice == "Doughboy" then			
		if inv:FindAndReturn("Base.BreadDough") then
			inv:Remove("BreadDough")
		elseif inv:FindAndReturn("Base.Dough") then
			inv:Remove("Dough")
		elseif inv:FindAndReturn("SapphCooking.SmallDough") then
			inv:Remove("SmallDough")
		else
			inv:Remove("PastryDough")
		end
		inv:AddItem("FunctionalAppliances.FAFriedDoughboy")
	elseif foodChoice == "Doughnut" then				
		if inv:FindAndReturn("SapphCooking.DoughnutShapedDough") then
			inv:Remove("DoughnutShapedDough")
		elseif inv:FindAndReturn("Base.Dough") then
			inv:Remove("Dough")
		elseif inv:FindAndReturn("SapphCooking.SmallDough") then
			inv:Remove("SmallDough")
		else
			inv:Remove("PastryDough")
		end
		inv:AddItem("Base.DoughnutPlain")
	elseif foodChoice == "Churros" then				
		if inv:FindAndReturn("SapphCooking.PastryDough") then
			inv:Remove("PastryDough")
		elseif inv:FindAndReturn("Base.Dough") then
			inv:Remove("Dough")
		else
			inv:Remove("SmallDough")
		end
		inv:AddItem("SapphCooking.ChurrosPlain")
	elseif foodChoice == "Cheese Sticks" then		
		inv:Remove("FABatteredCheese")
		inv:AddItem("FunctionalAppliances.FAFriedCheeseSticks")
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

function UseDeepFryers:waitToStart()
	self.character:faceThisObject(self.machine);
	return self.character:shouldBeTurning();
end

function UseDeepFryers:update()

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

function UseDeepFryers:start()
	self:setActionAnim("Loot");
	self.character:SetVariable("LootPosition", "Mid")
	self:setOverrideHandModels(nil, nil)
end

function UseDeepFryers:stop()

	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound);
	end

	local soundRadius = 15
	local volume = 6

	ISBaseTimedAction.stop(self);
end

function UseDeepFryers:perform()

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

	theEnd(self.character, self.machine, self.foodChoice)

	ISBaseTimedAction.perform(self);
end

function UseDeepFryers:new(character, machine, sound, food)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.machine = machine
	o.foodChoice = food
	o.soundFile = sound
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.gameSound = 0
	o.maxTime = 440
	return o;
end