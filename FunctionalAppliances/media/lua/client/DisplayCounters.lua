FADisplayCounter = FADisplayCounter or {}

FADisplayCounter.doBuildMenu = function(player, menu, square, DisplayCounter)
	local contextMenu = menu:addOption("Change Setting")
	local subContext = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu, subContext)

	if DisplayCounter:getModData()['CustomTemp'] == "Off" then
		subContext:addOption(FA.translation.currentlyoffsettowarm,
				  nil,	
				  FADisplayCounter.onUseDisplayCounter,
				  getSpecificPlayer(player),
				  DisplayCounter,
				  "Warm")
		subContext:addOption(FA.translation.currentlyoffsettocold,
				  nil,	
				  FADisplayCounter.onUseDisplayCounter,
				  getSpecificPlayer(player),
				  DisplayCounter,
				  "Cold")
	elseif DisplayCounter:getModData()['CustomTemp'] == "Warm" then
		subContext:addOption(FA.translation.currentlywarmsettooff,
				  nil,	
				  FADisplayCounter.onUseDisplayCounter,
				  getSpecificPlayer(player),
				  DisplayCounter,
				  "Off")
		subContext:addOption(FA.translation.currentlywarmsettocold,
				  nil,	
				  FADisplayCounter.onUseDisplayCounter,
				  getSpecificPlayer(player),
				  DisplayCounter,
				  "Cold")
	elseif DisplayCounter:getModData()['CustomTemp'] == "Cold" then
		subContext:addOption(FA.translation.currentlycoldsettooff,
				  nil,	
				  FADisplayCounter.onUseDisplayCounter,
				  getSpecificPlayer(player),
				  DisplayCounter,
				  "Off")
		subContext:addOption(FA.translation.currentlycoldsettowarm,
				  nil,	
				  FADisplayCounter.onUseDisplayCounter,
				  getSpecificPlayer(player),
				  DisplayCounter,
				  "Warm")
	end
end

FADisplayCounter.onUseDisplayCounter = function(junk, player, DisplayCounter, tempSetting)
	if not FA.walkToRear(player, DisplayCounter) then
		return
	end

	local square = DisplayCounter:getSquare()
	square:playSound("LightSwitch")

	if tempSetting == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		DisplayCounter:getContainer():setCustomTemperature(1.5) 	-- just below cooking
		DisplayCounter:getModData()['CustomTemp'] = "Warm" 
	elseif tempSetting == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		DisplayCounter:getContainer():setCustomTemperature(0.25) 	-- cold
		DisplayCounter:getModData()['CustomTemp'] = "Cold" 
	elseif tempSetting == "Off" then
		DisplayCounter:getContainer():setCustomTemperature(1) -- room temp
		DisplayCounter:getModData()['CustomTemp'] = "Off"
	else
		DisplayCounter:getContainer():setCustomTemperature(1) -- room temp
		DisplayCounter:getModData()['CustomTemp'] = "Off"
		player:Say(FA.translation.sayneedagenerator)
	end		

	DisplayCounter:getModData()['Loaded'] = true
	square:transmitModdata()
	DisplayCounter:transmitModData()	
	DisplayCounter:getContainer():requestSync()
end