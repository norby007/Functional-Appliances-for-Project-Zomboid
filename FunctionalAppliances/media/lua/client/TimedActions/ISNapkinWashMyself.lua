require "TimedActions/ISBaseTimedAction"

ISNapkinWashMyself = ISBaseTimedAction:derive("ISNapkinWashMyself");

function ISNapkinWashMyself:isValid()
	return self.character:getInventory():contains(self.item) and ISWashYourself.GetRequiredWater(self.character) > 0 and self.item:getUsedDelta() > 0;
end

function ISNapkinWashMyself:update()
    	self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISNapkinWashMyself:start()
	self:setActionAnim("WashFace")
	self:setOverrideHandModels(nil, nil)
	self.sound = self.character:playSound("WashYourself")
	self.character:reportEvent("EventWashClothing")
end

function ISNapkinWashMyself:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISNapkinWashMyself:stop()
	self:stopSound()
    	ISBaseTimedAction.stop(self);
end

function ISNapkinWashMyself:perform()
	self:stopSound()
	local visual = self.character:getHumanVisual()
	for i=1,BloodBodyPartType.MAX:index() do
		local part = BloodBodyPartType.FromIndex(i-1)
		if self:washPart(visual, part) then
			if self.item and self.item:getUsedDelta() > 0 then
				self.item:Use()
			else
				break
			end
		end
	end
	self.character:resetModelNextFrame();
	sendVisual(self.character);
	triggerEvent("OnClothingUpdated", self.character)

	ISBaseTimedAction.perform(self);
end

function ISNapkinWashMyself:washPart(visual, part)
	if visual:getBlood(part) + visual:getDirt(part) <= 0 then
		return false
	end
	visual:setBlood(part, 0)
	visual:setDirt(part, 0)
	return true
end

function ISNapkinWashMyself:new(character, item, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time;
	if o.character:isTimedActionInstant() then 
		o.maxTime = 1; 
	end
	o.timer = time / 20;
	o.tick = 0;
    	o.caloriesModifier = 4;
	return o;
end