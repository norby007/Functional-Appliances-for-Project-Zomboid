UsePayPhonesMenu = {};
UsePayPhonesMenu.doBuildMenu = function(player, context, worldobjects)

	local PayPhones = nil
	local square = nil

	for _,object in ipairs(worldobjects) do
		square = object:getSquare()

		if not square then
			return
		end
	
		for i=1,square:getObjects():size() do
			local thisObject = square:getObjects():get(i-1)
			
			if thisObject:getSprite() then
				local properties = thisObject:getSprite():getProperties()
				local spr = thisObject:getSprite():getName()  

				if properties == nil then
					return
				end

				local customName = nil
				local groupName = nil

				if properties:Is("CustomName") then
					customName = properties:Val("CustomName")
				end

				if properties:Is("GroupName") then
					groupName = properties:Val("GroupName")
				end
			
				if groupName == "Pay" and customName == "Phones" then				
					PayPhones = thisObject
					break
				end
			end
		end
	end

	if not PayPhones then 
		return 
	end

	soundFile = "payphone_busy_sound"

	if PayPhones:getModData()['Ring'] == "TRUE" and SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier then
		local x = square:getX()
		local y = square:getY()
		local z = square:getZ()
		local randomNumb = ZombRand(1,100)

		if randomNumb < 30 then
			square:playSound("payphone_ringing_1x_sound")
		elseif randomNumb < 60 then
			square:playSound("payphone_ringing_2x_sound")
		elseif randomNumb < 80 then
			square:playSound("payphone_ringing_3x_sound")
		elseif randomNumb < 95 then
			square:playSound("payphone_ringing_4x_sound")
		else
			square:playSound("payphone_ringing_5x_sound")
		end

		PayPhones:getModData()['Ring'] = "FALSE"

		local FAPayPhonesAttractZombies = SandboxVars.FunctionalAppliances.FAPayPhonesAttractZombies; 

		local zombies = square:getCell():getZombieList()
		if zombies and FAPayPhonesAttractZombies then
  			for i = 0, zombies:size() - 1 do
				local zombie = zombies:get(i) 
				if zombie:getSquare() then
					local zx = zombie:getSquare():getX()
					local zy = zombie:getSquare():getY()
					local zz = zombie:getSquare():getZ()
					local difx = 0
					local dify = 0
					local difz = 0
					if zx >= x then 
						difx = zx - x
					else 
						difx = x - zx 
					end
					if zy >= y then 
						dify = zy - y
					else 
						dify = y - zy 
					end
					if zz >= z then 
						difz = zz - z
					else 
						difz = z - zz
					end
					if (square:isOutside() == TRUE and zombie:isOutside() == FALSE) or (square:isOutside() == FALSE and zombie:isOutside() == TRUE) then
						difx = difx*2
						dify = dify*2
						difz = difz*2
					end
					if difx < 20 and dify < 20 and difz < 5 then
						zombie:pathToLocationF(x, y, z)
					end
				end
   			end
 		end
	elseif PayPhones:getModData()['Ring'] == "FALSE" then
		context:addOption("Check Phone",
				  worldobjects,
				  UsePayPhonesMenu.onUsePayPhones,
				  getSpecificPlayer(player),
				  PayPhones,
				  soundFile)
	end

	PayPhones:transmitModData()
end

function MachineNoPower(player)
	player:Say("The line is dead.")
end

UsePayPhonesMenu.getFrontSquare = function(square, facing)
	local value = nil
	
	if facing == "S" then
		value = square:getS()
	elseif facing == "E" then
		value = square:getE()
	elseif facing == "W" then
		value = square:getW()
	elseif facing == "N" then
		value = square:getN()
	else
		value = square:getE()
	end
	
	return value
end

UsePayPhonesMenu.getFacing = function(properties)

	local facing = nil
	
	if properties:Is("Facing") then
		facing = properties:Val("Facing")
	else
		facing = "E"
	end
	return facing
end

UsePayPhonesMenu.walkToFront = function(thisPlayer, PayPhones)

	local controllerSquare = nil
	local spriteName = PayPhones:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = PayPhones:getSprite():getProperties()
	local facing = UsePayPhonesMenu.getFacing(properties)
	if facing == nil then
		return false
	end
	
	local frontSquare = UsePayPhonesMenu.getFrontSquare(PayPhones:getSquare(), facing)
	local turn = UsePayPhonesMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local PayPhonesSquare = PayPhones:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(PayPhonesSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		thisPlayer:faceLocation(PayPhonesSquare:getX(), PayPhonesSquare:getY())
		return true
	end

	return false
end

UsePayPhonesMenu.onUsePayPhones = function(worldobjects, player, machine, soundFile)
	if not UsePayPhonesMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()

	if SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier then
		square:playSound(soundFile)
		local FAPayPhonesAttractZombies = SandboxVars.FunctionalAppliances.FAPayPhonesAttractZombies; 

		local zombies = square:getCell():getZombieList()
		if zombies and FAPayPhonesAttractZombies then
			for i = 0, zombies:size() - 1 do
				local zombie = zombies:get(i) 
				if zombie:getSquare() then
					local zx = zombie:getSquare():getX()
					local zy = zombie:getSquare():getY()
					local zz = zombie:getSquare():getZ()
					local difx = 0
					local dify = 0
					local difz = 0
					if zx >= x then 
						difx = zx - x
					else 
						difx = x - zx 
					end
					if zy >= y then 
						dify = zy - y
					else 
						dify = y - zy 
					end
					if zz >= z then 
						difz = zz - z
					else 
						difz = z - zz
					end
					if (square:isOutside() == TRUE and zombie:isOutside() == FALSE) or (square:isOutside() == FALSE and zombie:isOutside() == TRUE) then
						difx = difx*2
						dify = dify*2
						difz = difz*2
					end
					if difx < 10 and dify < 10 and difz < 2 then
						zombie:pathToLocationF(x, y, z)
					end
				end
			end
		end
	else
		MachineNoPower(player)
	end
	machine:transmitModData()
end

Events.OnPreFillWorldObjectContextMenu.Add(UsePayPhonesMenu.doBuildMenu);