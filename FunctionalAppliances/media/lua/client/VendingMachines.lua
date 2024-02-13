FAVendingMachine = FAVendingMachine or {}

FAVendingMachine.doBuildMenu = function(player, menu, square, VendingMachine)
	local contextMenu = menu:addOption("Change Setting")
	local subContext = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu, subContext)

	if VendingMachine:getModData()['CustomTemp'] == "Off" then
		subContext:addOption(FA.translation.currentlyoffsettowarm,
				  nil,	
				  FAVendingMachine.onUseVendingMachine,
				  getSpecificPlayer(player),
				  VendingMachine,
				  "Warm")
		subContext:addOption(FA.translation.currentlyoffsettocold,
				  nil,	
				  FAVendingMachine.onUseVendingMachine,
				  getSpecificPlayer(player),
				  VendingMachine,
				  "Cold")
	elseif VendingMachine:getModData()['CustomTemp'] == "Warm" then
		subContext:addOption(FA.translation.currentlywarmsettooff,
				  nil,	
				  FAVendingMachine.onUseVendingMachine,
				  getSpecificPlayer(player),
				  VendingMachine,
				  "Off")
		subContext:addOption(FA.translation.currentlywarmsettocold,
				  nil,	
				  FAVendingMachine.onUseVendingMachine,
				  getSpecificPlayer(player),
				  VendingMachine,
				  "Cold")
	elseif VendingMachine:getModData()['CustomTemp'] == "Cold" then
		subContext:addOption(FA.translation.currentlycoldsettooff,
				  nil,	
				  FAVendingMachine.onUseVendingMachine,
				  getSpecificPlayer(player),
				  VendingMachine,
				  "Off")
		subContext:addOption(FA.translation.currentlycoldsettowarm,
				  nil,	
				  FAVendingMachine.onUseVendingMachine,
				  getSpecificPlayer(player),
				  VendingMachine,
				  "Warm")
	end
end

FAVendingMachine.onUseVendingMachine = function(junk, player, VendingMachine, tempSetting)
	if not FA.walkToFront(player, VendingMachine) then
		return
	end

	local square = VendingMachine:getSquare()
	square:playSound("LightSwitch")

	if tempSetting == "Warm" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)) then
		VendingMachine:getContainer():setCustomTemperature(1.5) 	-- just below cooking
		VendingMachine:getModData()['CustomTemp'] = "Warm" 
	elseif tempSetting == "Cold" and ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier)) then
		VendingMachine:getContainer():setCustomTemperature(0.25) 	-- cold
		VendingMachine:getModData()['CustomTemp'] = "Cold" 
	elseif tempSetting == "Off" then
		VendingMachine:getContainer():setCustomTemperature(1) -- room temp
		VendingMachine:getModData()['CustomTemp'] = "Off"
	else
		VendingMachine:getContainer():setCustomTemperature(1) -- room temp
		VendingMachine:getModData()['CustomTemp'] = "Off"
		player:Say(FA.translation.sayneedagenerator)
	end		

	VendingMachine:getModData()['Loaded'] = true
	square:transmitModdata()
	VendingMachine:transmitModData()	
	VendingMachine:getContainer():requestSync()
end