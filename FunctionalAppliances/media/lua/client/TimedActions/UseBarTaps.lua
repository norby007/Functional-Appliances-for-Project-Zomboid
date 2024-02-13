require "TimedActions/ISBaseTimedAction"

UseBarTaps = ISBaseTimedAction:derive("UseBarTaps")

function UseBarTaps:isValid()
	return true
end

local function exchangeBottle(flavor, kegType)
	local inv = getPlayer():getInventory()

	local vanillaPlasticCup = inv:FindAndReturn("Base.PlasticCup")
	local FAPlasticCup = inv:FindAndReturn("FunctionalAppliances.FAPlasticCup")
	local FABeerMug = inv:FindAndReturn("FunctionalAppliances.FABeerMug")
	local emptyBeerBottle = inv:FindAndReturn("Base.BeerEmpty")

	if flavor == "Beer" then
		if FABeerMug then
			inv:Remove("FABeerMug")
			if kegType == nil then
				inv:AddItem("FunctionalAppliances.FABeerMugBeer")
			elseif kegType == "FABubKeg" then
				inv:AddItem("FunctionalAppliances.FABeerMugBubBeer")
			elseif kegType == "FABubLiteKeg" then
				inv:AddItem("FunctionalAppliances.FABeerMugBubLiteBeer")
			elseif kegType == "FASwillerKeg" then
				inv:AddItem("FunctionalAppliances.FABeerMugSwillerBeer")
			elseif kegType == "FASwillerLiteKeg" then
				inv:AddItem("FunctionalAppliances.FABeerMugSwillerLiteBeer")
			elseif kegType == "FAHomeBrewKeg" then
				inv:AddItem("FunctionalAppliances.FABeerMugHomeBrewBeer")
			elseif kegType == "KegAmericanLager" then
				inv:AddItem("FunctionalAppliances.FABeerMugAmericanLager")
			elseif kegType == "KegAPA1" then
				inv:AddItem("FunctionalAppliances.FABeerMugAPA1")
			elseif kegType == "KegAPA2" then
				inv:AddItem("FunctionalAppliances.FABeerMugAPA2")
			elseif kegType == "KegIPA1" then
				inv:AddItem("FunctionalAppliances.FABeerMugIPA1")
			elseif kegType == "KegIPA2" then
				inv:AddItem("FunctionalAppliances.FABeerMugIPA2")
			elseif kegType == "KegLightLager" then
				inv:AddItem("FunctionalAppliances.FABeerMugLightLager")
			elseif kegType == "KegPilsner" then
				inv:AddItem("FunctionalAppliances.FABeerMugPilsner")
			elseif kegType == "KegPorter" then
				inv:AddItem("FunctionalAppliances.FABeerMugPorter")
			elseif kegType == "KegStout" then
				inv:AddItem("FunctionalAppliances.FABeerMugStout")
			elseif kegType == "KegSkunked" then
				inv:AddItem("FunctionalAppliances.FABeerMugSkunked")
			else
				inv:AddItem("FunctionalAppliances.FABeerMugBeer")
			end
		elseif FAPlasticCup then
			inv:Remove("FAPlasticCup")
			if kegType == nil then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBeer")
			elseif kegType == "FABubKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBubBeer")
			elseif kegType == "FABubLiteKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBubLiteBeer")
			elseif kegType == "FASwillerKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSwillerBeer")
			elseif kegType == "FASwillerLiteKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSwillerLiteBeer")
			elseif kegType == "FAHomeBrewKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupHomeBrewBeer")
			elseif kegType == "KegAmericanLager" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAmericanLager")
			elseif kegType == "KegAPA1" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAPA1")
			elseif kegType == "KegAPA2" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAPA2")
			elseif kegType == "KegIPA1" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupIPA1")
			elseif kegType == "KegIPA2" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupIPA2")
			elseif kegType == "KegLightLager" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupLightLager")
			elseif kegType == "KegPilsner" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupPilsner")
			elseif kegType == "KegPorter" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupPorter")
			elseif kegType == "KegStout" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupStout")
			elseif kegType == "KegSkunked" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSkunked")
			else
				inv:AddItem("FunctionalAppliances.FAPlasticCupBeer")
			end
		elseif vanillaPlasticCup then
			inv:Remove("PlasticCup")
			if kegType == nil then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBeer")
			elseif kegType == "FABubKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBubBeer")
			elseif kegType == "FABubLiteKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupBubLiteBeer")
			elseif kegType == "FASwillerKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSwillerBeer")
			elseif kegType == "FASwillerLiteKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSwillerLiteBeer")
			elseif kegType == "FAHomeBrewKeg" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupHomeBrewBeer")
			elseif kegType == "KegAmericanLager" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAmericanLager")
			elseif kegType == "KegAPA1" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAPA1")
			elseif kegType == "KegAPA2" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupAPA2")
			elseif kegType == "KegIPA1" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupIPA1")
			elseif kegType == "KegIPA2" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupIPA2")
			elseif kegType == "KegLightLager" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupLightLager")
			elseif kegType == "KegPilsner" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupPilsner")
			elseif kegType == "KegPorter" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupPorter")
			elseif kegType == "KegStout" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupStout")
			elseif kegType == "KegSkunked" then
				inv:AddItem("FunctionalAppliances.FAPlasticCupSkunked")
			else
				inv:AddItem("FunctionalAppliances.FAPlasticCupBeer")
			end
		end
	elseif flavor == "RefillBeerBottle" then
		inv:Remove("BeerEmpty")
		if kegType == nil then
			inv:AddItem("Base.BeerBottle")
		elseif kegType == "FABubKeg" then
			inv:AddItem("FunctionalAppliances.FABubBeerBottle")
		elseif kegType == "FABubLiteKeg" then
			inv:AddItem("FunctionalAppliances.FABubLiteBeerBottle")
		elseif kegType == "FASwillerKeg" then
			inv:AddItem("FunctionalAppliances.FASwillerBeerBottle")
		elseif kegType == "FASwillerLiteKeg" then
			inv:AddItem("FunctionalAppliances.FASwillerLiteBeerBottle")
		elseif kegType == "FAHomeBrewKeg" then
			inv:AddItem("FunctionalAppliances.FAHomeBrewBeerBottle")
		elseif kegType == "KegAmericanLager" then
			inv:AddItem("MoreBrews.BeerBottleAmericanLager")
		elseif kegType == "KegAPA1" then
			inv:AddItem("MoreBrews.BeerBottleAPA1")
		elseif kegType == "KegAPA2" then
			inv:AddItem("MoreBrews.BeerBottleAPA2")
		elseif kegType == "KegIPA1" then
			inv:AddItem("MoreBrews.BeerBottleIPA1")
		elseif kegType == "KegIPA2" then
			inv:AddItem("MoreBrews.BeerBottleIPA2")
		elseif kegType == "KegLightLager" then
			inv:AddItem("MoreBrews.BeerBottleLightLager")
		elseif kegType == "KegPilsner" then
			inv:AddItem("MoreBrews.BeerBottlePilsner")
		elseif kegType == "KegPorter" then
			inv:AddItem("MoreBrews.BeerBottlePorter")
		elseif kegType == "KegStout" then
			inv:AddItem("MoreBrews.BeerBottleStout")
		elseif kegType == "KegSkunked" then
			inv:AddItem("MoreBrews.BeerBottleSkunked")
		else
			inv:AddItem("Base.BeerBottle")
		end
	end
end

function UseBarTaps:waitToStart()
	self.character:faceThisObject(self.machine)
	return self.character:shouldBeTurning()
end

function UseBarTaps:update()

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

function UseBarTaps:start()
	self:setActionAnim("fill_container_tap")
	self.character:SetVariable("LootPosition", "Mid")
	self:setOverrideHandModels(nil, nil)
end

function UseBarTaps:stop()

	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound)
	end

	local soundRadius = 15
	local volume = 6

	ISBaseTimedAction.stop(self)
end

function UseBarTaps:perform()

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

	if self.flavor == "RefillBeerBottle" then
		local newWeightAmount = 2 + (math.floor(self.keg:getDelta()/self.keg:getUseDelta()) - 2) * 0.375

		if isClient() then
			local args = {x = self.keg:getContainer():getParent():getSquare():getX(), y = self.keg:getContainer():getParent():getSquare():getY(), z = self.keg:getContainer():getParent():getSquare():getZ(), type = self.keg:getType(), weight = newWeightAmount, number = 2}
			sendClientCommand("FunctionalAppliances", "Use", args)
		else
			self.keg:setActualWeight(newWeightAmount)
			self.keg:setCustomWeight(true)
			self.keg:Use()
			self.keg:Use()
		end
	elseif self.flavor == "Beer" then
		local newWeightAmount = 2 + (math.floor(self.keg:getDelta()/self.keg:getUseDelta()) - 1) * 0.375

		if isClient() then
			local args = {x = self.keg:getContainer():getParent():getSquare():getX(), y = self.keg:getContainer():getParent():getSquare():getY(), z = self.keg:getContainer():getParent():getSquare():getZ(), type = self.keg:getType(), weight = newWeightAmount, number = 1}
			sendClientCommand("FunctionalAppliances", "Use", args)
		else
			self.keg:setActualWeight(newWeightAmount)
			self.keg:setCustomWeight(true)
			self.keg:Use()
		end
	end

	self.keg:getContainer():requestSync()

	exchangeBottle(self.flavor, self.keg:getType())

	ISBaseTimedAction.perform(self)
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
	o.stopOnWalk = true
	o.stopOnRun = true
	o.gameSound = 0
	o.maxTime = 170
	return o
end