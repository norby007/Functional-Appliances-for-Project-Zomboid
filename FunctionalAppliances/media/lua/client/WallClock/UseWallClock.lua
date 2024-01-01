UseWallClockMenu = {};
UseWallClockMenu.doBuildMenu = function(player, context, worldobjects)

	local WallClockObject = nil

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()

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
			
				if customName == "Clock" and groupName == "Wall" then				
					WallClockObject = thisObject
					if not (WallClockObject:getModData()['LastTimeHour'] and WallClockObject:getModData()['LastTimeMinutes']) then
						WallClockObject:getModData()['LastTimeHour'] = ZombRand(1,12)
						WallClockObject:getModData()['LastTimeMinutes'] = ZombRand(1,59)
						WallClockObject:getModData()['ClockBattery'] = ZombRand(1,100)
					end
					break
				end
			end 
		end 
	end

	if not WallClockObject then 
		return 
	end

	local TimeofDayHour = getGameTime():getHour()
	local TimeofDayMinutes = getGameTime():getMinutes()

	if TimeofDayHour > 12 then
		TimeofDayHour = TimeofDayHour - 12
	end

	if ((SandboxVars.AllowExteriorGenerator and WallClockObject:getSquare():haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and WallClockObject:getSquare():isOutside() == false)) then
		WallClockObject:getModData()['LastTimeHour'] = TimeofDayHour
		WallClockObject:getModData()['LastTimeMinutes'] = TimeofDayMinutes
		if WallClockObject:getModData()['ClockBattery'] < 100 then
			WallClockObject:getModData()['ClockBattery'] = WallClockObject:getModData()['ClockBattery'] + ZombRand(0,1)
		end
	elseif WallClockObject:getModData()['ClockBattery'] > 0 then
		WallClockObject:getModData()['LastTimeHour'] = TimeofDayHour
		WallClockObject:getModData()['LastTimeMinutes'] = TimeofDayMinutes
		WallClockObject:getModData()['ClockBattery'] = WallClockObject:getModData()['ClockBattery'] - ZombRand(0,1)
	else
		TimeofDayHour = WallClockObject:getModData()['LastTimeHour']
		TimeofDayMinutes = WallClockObject:getModData()['LastTimeMinutes']
	end

	WallClockObject:getSquare():transmitModdata()
	WallClockObject:transmitModData()

	if TimeofDayMinutes < 10 then
		context:addOption("The current time is: " .. TimeofDayHour .. ":0" .. TimeofDayMinutes,
				  worldobjects,
				  UseWallClockMenu.onUseWallClock,
				  getSpecificPlayer(player),
				  WallClockObject, nil)
	else
		context:addOption("The current time is: " .. TimeofDayHour .. ":" .. TimeofDayMinutes,
				  worldobjects,
				  UseWallClockMenu.onUseWallClock,
				  getSpecificPlayer(player),
				  WallClockObject, nil)
	end

	if WallClockObject:getModData()['ClockBattery'] < 1 then
		context:addOption("Replace Dead Battery",
				  worldobjects,
				  UseWallClockMenu.onUseWallClock,
				  getSpecificPlayer(player),
				  WallClockObject, "Battery")
	end
end

UseWallClockMenu.getFrontSquare = function(square, facing)
	local value = nil
	
	if facing == "S" then
		value = square:getS()
	elseif facing == "E" then
		value = square:getE()
	elseif facing == "W" then
		value = square:getW()
	elseif facing == "N" then
		value = square:getN()
	end
	
	return value
end

UseWallClockMenu.getFacing = function(properties, square)

	local facing = nil

	if properties:Is("Facing") then
		facing = properties:Val("Facing")
	end

	if square:getE() and facing == "E" then
		facing = "E"
	elseif square:getS() and facing == "S" then
		facing = "S" 
	elseif square:getW() and facing == "W" then
		facing = "W"
	elseif square:getN() and facing == "N" then
		facing = "N"
	else 
		facing = nil
	end

	return facing
end

UseWallClockMenu.walkToFront = function(thisPlayer, WallClockObject)
	local spriteName = WallClockObject:getSprite():getName()
	if not spriteName then
		return false
	end

	local properties = WallClockObject:getSprite():getProperties()
	local facing = UseWallClockMenu.getFacing(properties, WallClockObject:getSquare())
	if facing == nil then
		thisPlayer:Say("I am unable to access this machine, the path is blocked.")
		return false
	end
	
	local frontSquare = UseWallClockMenu.getFrontSquare(WallClockObject:getSquare(), facing)
	local turn = UseWallClockMenu.getFrontSquare(frontSquare, facing)
	
	if not frontSquare then
		return false
	end

	local wallClockSquare = WallClockObject:getSquare()

	if AdjacentFreeTileFinder.privTrySquare(wallClockSquare, frontSquare) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(thisPlayer, frontSquare))
		if turn then
			thisPlayer:faceLocation(wallClockSquare:getX(), wallClockSquare:getY())
		end
		return true
	end

	return false
end

UseWallClockMenu.onUseWallClock = function(worldobjects, player, machine, battery)
	if not UseWallClockMenu.walkToFront(player, machine) then
		return
	end

	local square = machine:getSquare()
	local inv = player:getInventory()
	local hasBattery = inv:FindAndReturn("Base.Battery")

	if battery == "Battery" and machine:getModData()['ClockBattery'] < 1 and hasBattery then
		square:playSound("LightSwitch")
		inv:Remove("Battery")
		machine:getModData()['ClockBattery'] = 100
		machine:getSquare():transmitModdata()
		machine:transmitModData()
	elseif battery == "Battery" and machine:getModData()['ClockBattery'] < 1 then
		player:Say("I'll need a battery first.")
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(UseWallClockMenu.doBuildMenu);
