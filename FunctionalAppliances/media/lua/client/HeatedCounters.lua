FAHeatedCounter = FAHeatedCounter or {}

FAHeatedCounter.doBuildMenu = function(player, menu, square, HeatedCounter)
	local contextMenu = menu:addOption("Change Setting")
	local subContext = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu, subContext)

	if HeatedCounter:getModData()['CustomTemp'] == "Off" then
		subContext:addOption(FA.translation.currentlyoffsettowarm,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Warm")
		subContext:addOption(FA.translation.currentlyoffsettohot,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Hot")
		subContext:addOption(FA.translation.currentlyoffsettocold,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Cold")
	elseif HeatedCounter:getModData()['CustomTemp'] == "Warm" then
		subContext:addOption(FA.translation.currentlywarmsettooff,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Off")
		subContext:addOption(FA.translation.currentlywarmsettohot,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Hot")
		subContext:addOption(FA.translation.currentlywarmsettocold,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Cold")
	elseif HeatedCounter:getModData()['CustomTemp'] == "Hot" then
		subContext:addOption(FA.translation.currentlyhotsettooff,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Off")
		subContext:addOption(FA.translation.currentlyhotsettowarm,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Warm")
		subContext:addOption(FA.translation.currentlyhotsettocold,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Cold")
	elseif HeatedCounter:getModData()['CustomTemp'] == "Cold" then
		subContext:addOption(FA.translation.currentlycoldsettooff,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Off")
		subContext:addOption(FA.translation.currentlycoldsettowarm,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Warm")
		subContext:addOption(FA.translation.currentlycoldsettohot,
				  nil,	
				  FAHeatedCounter.onUseHeatedCounter,
				  getSpecificPlayer(player),
				  HeatedCounter,
				  "Hot")
	end
end

FAHeatedCounter.onUseHeatedCounter = function(junk, player, HeatedCounter, tempSetting)
	if not FA.walkToRear(player, HeatedCounter) then
		return
	end

	local square = HeatedCounter:getSquare()
	square:playSound("LightSwitch")

	if tempSetting == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		HeatedCounter:getContainer():setCustomTemperature(1.5) 	-- just below cooking
		HeatedCounter:getModData()['CustomTemp'] = "Warm" 
	elseif tempSetting == "Hot" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		HeatedCounter:getContainer():setCustomTemperature(1.61) 	-- just enough to start cooking
		HeatedCounter:getModData()['CustomTemp'] = "Hot" 
	elseif tempSetting == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		HeatedCounter:getContainer():setCustomTemperature(0.25) 	-- cold
		HeatedCounter:getModData()['CustomTemp'] = "Cold" 
	elseif tempSetting == "Off" then
		HeatedCounter:getContainer():setCustomTemperature(1) -- room temp
		HeatedCounter:getModData()['CustomTemp'] = "Off"
	else
		HeatedCounter:getContainer():setCustomTemperature(1) -- room temp
		HeatedCounter:getModData()['CustomTemp'] = "Off"
		player:Say(FA.translation.sayneedagenerator)
	end		

	HeatedCounter:getModData()['Loaded'] = true
	square:transmitModdata()
	HeatedCounter:transmitModData()	
	HeatedCounter:getContainer():requestSync()
end