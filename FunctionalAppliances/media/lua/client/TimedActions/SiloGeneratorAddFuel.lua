require "TimedActions/ISBaseTimedAction"

SiloGeneratorAddFuel = ISBaseTimedAction:derive("SiloGeneratorAddFuel");

function SiloGeneratorAddFuel:isValid()
	return self.fuelTank:getPipedFuelAmount() < 500
end

function SiloGeneratorAddFuel:waitToStart()
	self.character:faceThisObject(self.fuelTank)
	return self.character:shouldBeTurning()
end

function SiloGeneratorAddFuel:update()
	self.character:faceThisObject(self.fuelTank)
    	self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function SiloGeneratorAddFuel:start()
	self:setActionAnim("refuelgascan")
	self:setOverrideHandModels(self.petrolCan:getStaticModel(), nil)
	self.sound = self.character:playSound("fuelTankAddFuel")
end

function SiloGeneratorAddFuel:stop()
	self.character:stopOrTriggerSound(self.sound)
    	ISBaseTimedAction.stop(self);
end

function SiloGeneratorAddFuel:perform()
	self.character:stopOrTriggerSound(self.sound)
  	local endFuel = 0
	local maxEmpty = self.petrolCan:getUsedDelta()/self.petrolCan:getUseDelta()
	if (self.fuelTank:getPipedFuelAmount() + maxEmpty) <= 500 then
		endFuel = maxEmpty
	else 
		endFuel = 500 - self.fuelTank:getPipedFuelAmount()
	end

	if self.fuelTank:getPipedFuelAmount() < 1 then
    		self.fuelTank:setPipedFuelAmount(endFuel)
	else
    		self.fuelTank:setPipedFuelAmount(self.fuelTank:getPipedFuelAmount() + endFuel)
	end

	if self.fuelTank:getPipedFuelAmount() > 500 then
		self.fuelTank:setPipedFuelAmount(500)
	end

    	while endFuel > 0 do
        	self.petrolCan:Use()
        	endFuel = endFuel - 1
    	end

	self.fuelTank:transmitModData()   
	ISBaseTimedAction.perform(self);
end

function SiloGeneratorAddFuel:new(character, fuelTank, petrolCan, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
    	o.petrolCan = petrolCan;
	o.fuelTank = fuelTank;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time;
	if o.character:isTimedActionInstant() then 
		o.maxTime = 1; 
	end
	return o;
end
