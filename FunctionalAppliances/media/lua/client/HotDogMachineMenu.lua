FAHotDogMachine = FAHotDogMachine or {}

FAHotDogMachine.doBuildMenu = function(player, menu, square, HotDogMachine)
	if ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		HotDogMachine:getContainer():setCustomTemperature(1.5)
	else
		HotDogMachine:getContainer():setCustomTemperature(1)
	end

	HotDogMachine:getContainer():requestSync()

	local spriteName = HotDogMachine:getSprite():getName()
	local soundFile = "HotDogMachine_sound"
	menu:addOption(FA.translation.makehotdog,
				  nil,
				  FAHotDogMachine.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachine,
				  soundFile, "Hotdog")

	local Sausage = nil
	local VSausage = nil
	local FSausage = nil
	local playerItems = getSpecificPlayer(player):getInventory():getItems()

	for i=0, playerItems:size()-1 do
        	local item = playerItems:get(i)
		local itemType = nil

		if item and item:getType() then
			itemType = item:getType()
		end

		if (itemType == "Sausage" or itemType == "SausageEvolved") and not item:isCooked() then
			Sausage = item
		elseif itemType == "ViennaSausage" and not item:isCooked() then
			VSausage = item
		elseif itemType == "FrankfurterSausage" and not item:isCooked() then
			FSausage = item
		end
	end


	local contextMenu2 = menu:addOption(FA.translation.cook)
	local subContext2 = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu2, subContext2)

	if Sausage then
		subContext2:addOption(FA.translation.sausage,
				  nil,	
				  FAHotDogMachine.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachine,
				  soundFile, "Sausage")
	elseif Sausage == nil then
		subContext2:addOption(FA.translation.sausage,
				  nil,	
				  FAHotDogMachine.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachine,
				  soundFile, "Not Found Sausage")
	end	
	if VSausage then
		subContext2:addOption(FA.translation.viennasausage,
				  nil,	
				  FAHotDogMachine.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachine,
				  soundFile, "ViennaSausage")
	elseif VSausage == nil then
		subContext2:addOption(FA.translation.viennasausage,
				  nil,	
				  FAHotDogMachine.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachine,
				  soundFile, "Not Found Vienna Sausage")
	end
	if FSausage then
		subContext2:addOption(FA.translation.frankfurter,
				  nil,	
				  FAHotDogMachine.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachine,
				  soundFile, "FrankfurterSausage")
	elseif FSausage == nil then
		subContext2:addOption(FA.translation.frankfurter,
				  nil,	
				  FAHotDogMachine.onUseHotDogMachine,
				  getSpecificPlayer(player),
				  HotDogMachine,
				  soundFile, "Not Found Frankfurter")
	end
end

FAHotDogMachine.onUseHotDogMachine = function(junk, player, HotDogMachine, soundFile, foodType)
	if not FA.walkToFront(player, HotDogMachine) then
		return
	end

	local square = HotDogMachine:getSquare()

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		player:Say(FA.translation.sayneedagenerator)
		return
	end

	if foodType == "Not Found Sausage" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.sausage)
		return
	elseif foodType == "Not Found Vienna Sausage" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.viennasausage)
		return
	elseif foodType == "Not Found Frankfurter" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.frankfurter)
		return
	end
	
	local inv = player:getInventory()
	local HotdogBun = inv:FindAndReturn("SapphCooking.HotdogBun")
	local BreadSlices = inv:FindAndReturn("Base.BreadSlices")
	local Sausage = inv:FindAndReturn("Base.Sausage")
	local VSausage = inv:FindAndReturn("SapphCooking.ViennaSausage")
	local FSausage = inv:FindAndReturn("SapphCooking.FrankfurterSausage")
	local ESausage = inv:FindAndReturn("SapphCooking.SausageEvolved")

	if foodType == "Hotdog" and (HotdogBun or BreadSlices) and (Sausage or VSausage or FSausage or ESausage) then
		ISTimedActionQueue.add(UseHotDogMachine:new(player, HotDogMachine, soundFile, foodType, squareToTurn))
	elseif foodType == "Hotdog" and not HotdogBun and not BreadSlices and not Sausage and not VSausage and not FSausage and not ESausage then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.hotdogbun .. " or " .. FA.translation.slicedbread .. " and " .. FA.translation.sausage .. " or " .. FA.translation.viennasausage .. " or " .. FA.translation.frankfurter)
	elseif foodType == "Hotdog" and not HotdogBun and not BreadSlices then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.hotdogbun .. " or " .. FA.translation.slicedbread)
	elseif foodType == "Hotdog" then
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.sausage .. " or " .. FA.translation.viennasausage .. " or " .. FA.translation.frankfurter)
	else
		ISTimedActionQueue.add(UseHotDogMachine:new(player, HotDogMachine, soundFile, foodType, squareToTurn))
	end
end