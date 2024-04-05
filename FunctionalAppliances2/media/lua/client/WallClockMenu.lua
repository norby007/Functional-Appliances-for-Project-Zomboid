FAWallClock = FAWallClock or {}

FAWallClock.doBuildMenu = function(player, menu, square, WallClock)
	local FA24HRWallClocks = SandboxVars.FunctionalAppliances.FA24HRWallClocks

	if not (WallClock:getModData()['LastTimeHour'] and WallClock:getModData()['LastTimeMinutes']) then
		WallClock:getModData()['LastTimeHour'] = ZombRand(1,12)
		WallClock:getModData()['LastTimeMinutes'] = ZombRand(1,59)
		WallClock:getModData()['ClockBattery'] = ZombRand(1,100)
	end

	local TimeofDayHour = getGameTime():getHour()
	local TimeofDayMinutes = getGameTime():getMinutes()

	if not FA24HRWallClocks then
		if TimeofDayHour > 12 then
			TimeofDayHour = TimeofDayHour - 12
		end
		if TimeofDayHour == 0 then
			TimeofDayHour = 12
		end
	end

	if ((SandboxVars.AllowExteriorGenerator and WallClock:getSquare():haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and WallClock:getSquare():isOutside() == false)) then
		WallClock:getModData()['LastTimeHour'] = TimeofDayHour
		WallClock:getModData()['LastTimeMinutes'] = TimeofDayMinutes
		if WallClock:getModData()['ClockBattery'] < 100 then
			WallClock:getModData()['ClockBattery'] = WallClock:getModData()['ClockBattery'] + 1
		end
	elseif WallClock:getModData()['ClockBattery'] > 0 then
		WallClock:getModData()['LastTimeHour'] = TimeofDayHour
		WallClock:getModData()['LastTimeMinutes'] = TimeofDayMinutes
		WallClock:getModData()['ClockBattery'] = WallClock:getModData()['ClockBattery'] - 0.25
	else
		TimeofDayHour = WallClock:getModData()['LastTimeHour']
		TimeofDayMinutes = WallClock:getModData()['LastTimeMinutes']
	end

	WallClock:getSquare():transmitModdata()
	WallClock:transmitModData()

	--print("Battery Level: " .. WallClock:getModData()['ClockBattery'])

	if TimeofDayMinutes < 10 then
		menu:addOption(FA.translation.thecurrenttimeis .. ": " .. TimeofDayHour .. ":0" .. TimeofDayMinutes,
				  nil,	
				  FAWallClock.onUseWallClock,
				  getSpecificPlayer(player),
				  WallClock, nil)
	else
		menu:addOption(FA.translation.thecurrenttimeis .. ": " .. TimeofDayHour .. ":" .. TimeofDayMinutes,
				  nil,	
				  FAWallClock.onUseWallClock,
				  getSpecificPlayer(player),
				  WallClock, nil)
	end

	if WallClock:getModData()['ClockBattery'] < 1 then
		menu:addOption(FA.translation.replacedeadbattery,
				  nil,	
				  FAWallClock.onUseWallClock,
				  getSpecificPlayer(player),
				  WallClock, "Battery")
	end
end

FAWallClock.onUseWallClock = function(junk, player, WallClock, MyChoice)
	if not FA.walkToFront(player, WallClock) then
		return
	end

	local square = WallClock:getSquare()
	local inv = player:getInventory()
	local hasBattery = inv:FindAndReturn("Base.Battery")

	if MyChoice == "Battery" and WallClock:getModData()['ClockBattery'] < 1 and hasBattery then
		square:playSound("LightSwitch")
		inv:Remove("Battery")
		WallClock:getModData()['ClockBattery'] = 100
		WallClock:getSquare():transmitModdata()
		WallClock:transmitModData()
	elseif MyChoice == "Battery" and WallClock:getModData()['ClockBattery'] < 1 then
		player:Say(FA.translation.sayneedabattery)
	end
end