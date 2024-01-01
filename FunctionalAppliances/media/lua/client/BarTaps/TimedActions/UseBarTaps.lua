require "TimedActions/ISBaseTimedAction"

UseBarTaps = ISBaseTimedAction:derive("UseBarTaps");

function UseBarTaps:isValid()
	return true;
end

local function exchangeBottle(flavor, keg)
	local inv = getPlayer():getInventory()

	local vanillaPlasticCup = inv:FindAndReturn("Base.PlasticCup")
	local FAPlasticCup = inv:FindAndReturn("FunctionalAppliances.FAPlasticCup")
	local FABeerMug = inv:FindAndReturn("FunctionalAppliances.FABeerMug")
	local emptyBeerBottle = inv:FindAndReturn("Base.BeerEmpty")

	if flavor == "Beer" then
		if FABeerMug then
			inv:Remove("FABeerMug")
			if keg == nil then
				inv:AddItem("FunctionalAppliances.FABeerMugBeer")
			elseif keg == "Keg of Bub Beer" then
				inv:AddItem("FunctionalAppliances.FABeerMugBubBeer")
			elseif keg == "Keg of Bub Lite Beer" then
				inv:AddItem("FunctionalAppliances.FABeerMugBubLiteBeer")
			elseif keg == "Keg of Swiller Beer" then
				inv:AddItem("FunctionalAppliances.FABeerMugSwillerBeer")
			elseif keg == "Keg of Swiller Lite Beer" then
				inv:AddItem("FunctionalAppliances.FABeerMugSwillerLiteBeer")
			elseif keg == "Keg of Home Brew Beer" then
				inv:AddItem("FunctionalAppliances.FABeerMugHomeBrewBeer")
			elseif keg == "Keg of Beer [American Lager]" then
				inv:AddItem("FunctionalAppliances.FABeerMugAmericanLager")
			elseif keg == "Keg of Beer [Dark American Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FABeerMugAPA1")
			elseif keg == "Keg of Beer [Light American Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FABeerMugAPA2")
			elseif keg == "Keg of Beer [Light India Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FABeerMugIPA1")
			elseif keg == "Keg of Beer [Dark India Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FABeerMugIPA2")
			elseif keg == "Keg of Beer [Light Lager]" then
				inv:AddItem("FunctionalAppliances.FABeerMugLightLager")
			elseif keg == "Keg of Beer [Pilsner]" then
				inv:AddItem("FunctionalAppliances.FABeerMugPilsner")
			elseif keg == "Keg of Beer [Porter]" then
				inv:AddItem("FunctionalAppliances.FABeerMugPorter")
			elseif keg == "Keg of Beer [Stout]" then
				inv:AddItem("FunctionalAppliances.FABeerMugStout")
			elseif keg == "Keg of Beer [Skunked]" then
				inv:AddItem("FunctionalAppliances.FABeerMugSkunked")
			else
				inv:AddItem("FunctionalAppliances.FABeerMugBeer")
			end
		elseif FAPlasticCup then
			inv:Remove("FAPlasticCup")
			if keg == nil then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBeer")
			elseif keg == "Keg of Bub Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBubBeer")
			elseif keg == "Keg of Bub Lite Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBubLiteBeer")
			elseif keg == "Keg of Swiller Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSwillerBeer")
			elseif keg == "Keg of Swiller Lite Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSwillerLiteBeer")
			elseif keg == "Keg of Home Brew Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupHomeBrewBeer")
			elseif keg == "Keg of Beer [American Lager]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAmericanLager")
			elseif keg == "Keg of Beer [Dark American Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAPA1")
			elseif keg == "Keg of Beer [Light American Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAPA2")
			elseif keg == "Keg of Beer [Light India Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupIPA1")
			elseif keg == "Keg of Beer [Dark India Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupIPA2")
			elseif keg == "Keg of Beer [Light Lager]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupLightLager")
			elseif keg == "Keg of Beer [Pilsner]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupPilsner")
			elseif keg == "Keg of Beer [Porter]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupPorter")
			elseif keg == "Keg of Beer [Stout]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupStout")
			elseif keg == "Keg of Beer [Skunked]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSkunked")
			else
				inv:AddItem("FunctionalAppliances.FAPlasticCupBeer")
			end
		elseif vanillaPlasticCup then
			inv:Remove("PlasticCup")
			if keg == nil then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBeer")
			elseif keg == "Keg of Bub Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBubBeer")
			elseif keg == "Keg of Bub Lite Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBubLiteBeer")
			elseif keg == "Keg of Swiller Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSwillerBeer")
			elseif keg == "Keg of Swiller Lite Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSwillerLiteBeer")
			elseif keg == "Keg of Home Brew Beer" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupHomeBrewBeer")
			elseif keg == "Keg of Beer [American Lager]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAmericanLager")
			elseif keg == "Keg of Beer [Dark American Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAPA1")
			elseif keg == "Keg of Beer [Light American Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAPA2")
			elseif keg == "Keg of Beer [Light India Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupIPA1")
			elseif keg == "Keg of Beer [Dark India Pale Ale]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupIPA2")
			elseif keg == "Keg of Beer [Light Lager]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupLightLager")
			elseif keg == "Keg of Beer [Pilsner]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupPilsner")
			elseif keg == "Keg of Beer [Porter]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupPorter")
			elseif keg == "Keg of Beer [Stout]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupStout")
			elseif keg == "Keg of Beer [Skunked]" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSkunked")
			else
				inv:AddItem("FunctionalAppliances.FAPlasticCupBeer")
			end
		end
	elseif flavor == "RefillBeerBottle" then
		inv:Remove("BeerEmpty")
		if keg == nil then
			inv:AddItem("Base.BeerBottle")
		elseif keg == "Keg of Bub Beer" then
			inv:AddItem("FunctionalAppliances.FABubBeerBottle")
		elseif keg == "Keg of Bub Lite Beer" then
			inv:AddItem("FunctionalAppliances.FABubLiteBeerBottle")
		elseif keg == "Keg of Swiller Beer" then
			inv:AddItem("FunctionalAppliances.FASwillerBeerBottle")
		elseif keg == "Keg of Swiller Lite Beer" then
			inv:AddItem("FunctionalAppliances.FASwillerLiteBeerBottle")
		elseif keg == "Keg of Home Brew Beer" then
			inv:AddItem("FunctionalAppliances.FAHomeBrewBeerBottle")
		elseif keg == "Keg of Beer [American Lager]" then
			inv:AddItem("MoreBrews.BeerBottleAmericanLager")
		elseif keg == "Keg of Beer [Dark American Pale Ale]" then
			inv:AddItem("MoreBrews.BeerBottleAPA1")
		elseif keg == "Keg of Beer [Light American Pale Ale]" then
			inv:AddItem("MoreBrews.BeerBottleAPA2")
		elseif keg == "Keg of Beer [Light India Pale Ale]" then
			inv:AddItem("MoreBrews.BeerBottleIPA1")
		elseif keg == "Keg of Beer [Dark India Pale Ale]" then
			inv:AddItem("MoreBrews.BeerBottleIPA2")
		elseif keg == "Keg of Beer [Light Lager]" then
			inv:AddItem("MoreBrews.BeerBottleLightLager")
		elseif keg == "Keg of Beer [Pilsner]" then
			inv:AddItem("MoreBrews.BeerBottlePilsner")
		elseif keg == "Keg of Beer [Porter]" then
			inv:AddItem("MoreBrews.BeerBottlePorter")
		elseif keg == "Keg of Beer [Stout]" then
			inv:AddItem("MoreBrews.BeerBottleStout")
		elseif keg == "Keg of Beer [Skunked]" then
			inv:AddItem("MoreBrews.BeerBottleSkunked")
		else
			inv:AddItem("Base.BeerBottle")
		end
	end
end

function UseBarTaps:waitToStart()
	self.character:faceThisObject(self.machine);
	return self.character:shouldBeTurning();
end

function UseBarTaps:update()

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

function UseBarTaps:start()
	self:setActionAnim("fill_container_tap");
	self.character:SetVariable("LootPosition", "Mid")
	self:setOverrideHandModels(nil, nil)
end

function UseBarTaps:stop()

	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound);
	end

	local soundRadius = 15
	local volume = 6

	ISBaseTimedAction.stop(self);
end

function UseBarTaps:perform()

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

	if self.flavor == "RefillBeerBottle" then
		local newWeightAmount = 2 + (math.floor(self.keg:getDelta()/self.keg:getUseDelta()) - 2) * 0.375

		self.keg:setActualWeight(newWeightAmount)
		self.keg:setCustomWeight(true)
		self.keg:Use()
		self.keg:Use()
	elseif self.flavor == "Beer" then
		local newWeightAmount = 2 + (math.floor(self.keg:getDelta()/self.keg:getUseDelta()) - 1) * 0.375

		self.keg:setActualWeight(newWeightAmount)
		self.keg:setCustomWeight(true)
		self.keg:Use()
	end

	self.keg:getContainer():requestSync()

	exchangeBottle(self.flavor, self.keg:getDisplayName())

	ISBaseTimedAction.perform(self);
end

function UseBarTaps:new(character, machine, sound, flavor, keg)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.machine = machine
	o.soundFile = sound
	o.flavor = flavor
	o.keg = keg
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.gameSound = 0
	o.maxTime = 170
	return o;
end