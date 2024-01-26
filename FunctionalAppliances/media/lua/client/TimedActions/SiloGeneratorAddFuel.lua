require "TimedActions/ISBaseTimedAction"

SiloGeneratorAddFuel = ISBaseTimedAction:derive("SiloGeneratorAddFuel");

function SiloGeneratorAddFuel:isValid()
	--return self.generator:getObjectIndex() ~= -1 and
	--	self.character:isPrimaryHandItem(self.petrol) or self.character:isSecondaryHandItem(self.petrol)
	return true
end

function SiloGeneratorAddFuel:waitToStart()
	self.character:faceThisObject(self.generator)
	return self.character:shouldBeTurning()
end

function SiloGeneratorAddFuel:update()
	self.character:faceThisObject(self.generator)

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function SiloGeneratorAddFuel:start()
	self:setActionAnim("refuelgascan")
	-- Don't call setOverrideHandModels() with self.petrol, the right-hand mask
	-- will bork the animation.
	self:setOverrideHandModels(self.petrol:getStaticModel(), nil)
	self.sound = self.character:playSound("GeneratorAddFuel")
end

function SiloGeneratorAddFuel:stop()
	self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function SiloGeneratorAddFuel:perform()
	self.character:stopOrTriggerSound(self.sound)

    local endFuel = 0;
    while self.petrol and self.petrol:getUsedDelta() > 0 and self.generator:getPipedFuelAmount() + endFuel < 500 do
        self.petrol:Use();
        endFuel = endFuel + 1 --0;
    end

    self.generator:setPipedFuelAmount(self.generator:getPipedFuelAmount() + endFuel)
    
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function SiloGeneratorAddFuel:new(character, generator, petrolCan, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
    	o.petrol = petrolCan;
	o.generator = generator;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time;
	if o.character:isTimedActionInstant() then o.maxTime = 1; end
	return o;
end
