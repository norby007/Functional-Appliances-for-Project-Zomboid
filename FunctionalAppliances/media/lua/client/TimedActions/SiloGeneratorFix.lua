require "TimedActions/ISBaseTimedAction"

SiloGeneratorFix = ISBaseTimedAction:derive("SiloGeneratorFix");

function SiloGeneratorFix:isValid()
	local scrapItemE = self.character:getInventory():getFirstTypeRecurse("ElectronicsScrap")
	local scrapItemM = self.character:getInventory():getFirstTypeRecurse("ScrapMetal")
	if (scrapItemE ~= nil or scrapItemM ~= nil) and self.generator:getModData()['Condition'] < 100 and self.generator:getModData()['PoweredOn'] == false then
		return true
	else
		return false
	end
end

function SiloGeneratorFix:waitToStart()
	self.character:faceThisObject(self.generator)
	return self.character:shouldBeTurning()
end

function SiloGeneratorFix:update()
	self.character:faceThisObject(self.generator)
    	self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function SiloGeneratorFix:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	self.sound = self.character:playSound("GeneratorRepair")
end

function SiloGeneratorFix:stop()
	self.character:stopOrTriggerSound(self.sound)
    	ISBaseTimedAction.stop(self);
end

function SiloGeneratorFix:perform()
	self.character:stopOrTriggerSound(self.sound)

	local scrapItemE = self.character:getInventory():getFirstTypeRecurse("ElectronicsScrap");
	local scrapItemM = self.character:getInventory():getFirstTypeRecurse("ScrapMetal");

	if not scrapItemE and not scrapItemM then 
		return; 
	end;

	if scrapItemE ~= nil then
		self.character:removeFromHands(scrapItemE);
		self.character:getInventory():Remove(scrapItemE);
		self.generator:getModData()['Condition'] = (self.generator:getModData()['Condition'] + 2 + (1*(self.character:getPerkLevel(Perks.Electricity))/4))
		self.character:getXp():AddXP(Perks.Electricity, 5);
	elseif scrapItemM ~= nil then
		self.character:removeFromHands(scrapItemM);
		self.character:getInventory():Remove(scrapItemM);
		self.generator:getModData()['Condition'] = (self.generator:getModData()['Condition'] + 2 + (1*(self.character:getPerkLevel(Perks.Mechanics))/4))
		self.character:getXp():AddXP(Perks.Mechanics, 5);
	end

	if self.generator:getModData()['Condition'] < 100 then
		scrapItemE = self.character:getInventory():getFirstTypeRecurse("ElectronicsScrap")
		scrapItemM = self.character:getInventory():getFirstTypeRecurse("ScrapMetal")
		if scrapItemE ~= nil then
			local previousAction = self
			if scrapItemE:getContainer() ~= self.character:getInventory() then
				local action = ISInventoryTransferAction:new(self.character, scrapItemE, scrapItemE:getContainer(), self.character:getInventory(), nil)
				ISTimedActionQueue.addAfter(self, action)
				previousAction = action
			end
			ISTimedActionQueue.addAfter(previousAction, SiloGeneratorFix:new(self.character, self.generator, 150));
		elseif scrapItemM ~= nil then
			local previousAction = self
			if scrapItemM:getContainer() ~= self.character:getInventory() then
				local action = ISInventoryTransferAction:new(self.character, scrapItemM, scrapItemM:getContainer(), self.character:getInventory(), nil)
				ISTimedActionQueue.addAfter(self, action)
				previousAction = action
			end
			ISTimedActionQueue.addAfter(previousAction, SiloGeneratorFix:new(self.character, self.generator, 150));
		end
	elseif self.generator:getModData()['Condition'] > 100 then
		self.generator:getModData()['Condition'] = 100
	end

	self.generator:transmitModData()
	ISBaseTimedAction.perform(self);
end

function SiloGeneratorFix:new(character, generator, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.generator = generator;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time - (o.character:getPerkLevel(Perks.Electricity) * 3);
	if o.character:isTimedActionInstant() then 
		o.maxTime = 1; 
	end
    	o.caloriesModifier = 4;
	return o;
end