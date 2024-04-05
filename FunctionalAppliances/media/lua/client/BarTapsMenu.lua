FABarTaps = FABarTaps or {}

FABarTaps.doBuildMenu = function(player, menu, square, BarTaps)
	local foundKeg1 = nil
	local foundKeg2 = nil
	local foundKeg3 = nil
	local foundKeg4 = nil

	for index=1,square:getObjects():size() do
		local thisObject = square:getObjects():get(index-1)
		local containerItems = nil
		
		if thisObject:getContainer() then
			containerItems = thisObject:getItemContainer():getItems()
		end

		if containerItems ~= nil then
			for i=0, containerItems:size()-1 do
        			local item = containerItems:get(i)
				local itemType = nil

				if item and item:getType() then
					itemType = item:getType()
				end

				if (itemType == "FABubKeg" or itemType == "FABubLiteKeg" or itemType == "FASwillerKeg" or itemType == "FASwillerLiteKeg" or itemType == "FAHomeBrewKeg") or
					(itemType == "KegAmericanLager" or itemType == "KegAPA1" or itemType == "KegAPA2" or itemType == "KegIPA1" or itemType == "KegIPA2") or
					(itemType == "KegLightLager" or itemType == "KegPilsner" or itemType == "KegPorter" or itemType == "KegStout" or itemType == "KegSkunked") then
					if not foundKeg1 then
						foundKeg1 = item
					elseif not foundKeg2 then
						foundKeg2 = item
					elseif not foundKeg3 then
						foundKeg3 = item
					elseif not foundKeg4 then
						foundKeg4 = item
						break
					end
				end
			end
		end
		if foundKeg4 then
			break
		end
	end

	if not foundKeg1 then 
		return 
	end

	local soundFile = "sodafountain_sound"

	local contextMenu = menu:addOption(FA.translation.dispensefrom)
	local subContext = ISContextMenu:getNew(menu)

	menu:addSubMenu(contextMenu, subContext)

	if foundKeg1 then
		subContext:addOption(foundKeg1:getDisplayName(),
				  nil,	
				  FABarTaps.onUseBarTaps,			
				  getSpecificPlayer(player),
				  BarTaps,
				  soundFile, "Beer", foundKeg1)
	end
	if foundKeg2 then
		subContext:addOption(foundKeg2:getDisplayName(),
				  nil,	
				  FABarTaps.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTaps,
				  soundFile, "Beer", foundKeg2)
	end
	if foundKeg3 then
		subContext:addOption(foundKeg3:getDisplayName(),
				  nil,	
				  FABarTaps.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTaps,
				  soundFile, "Beer", foundKeg3)
	end
	if foundKeg4 then
		subContext:addOption(foundKeg4:getDisplayName(),
				  nil,	
				  FABarTaps.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTaps,
				  soundFile, "Beer", foundKeg4)
	end

	local contextMenu2 = menu:addOption(FA.translation.refillbeerbottlefrom)
	local subContext2 = ISContextMenu:getNew(menu);

	menu:addSubMenu(contextMenu2, subContext2)

	if foundKeg1 then
		subContext2:addOption(foundKeg1:getDisplayName(),
				  nil,	
				  FABarTaps.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTaps,
				  soundFile, "RefillBeerBottle", foundKeg1)
	end
	if foundKeg2 then
		subContext2:addOption(foundKeg2:getDisplayName(),
				  nil,	
				  FABarTaps.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTaps,
				  soundFile, "RefillBeerBottle", foundKeg2)
	end
	if foundKeg3 then
		subContext2:addOption(foundKeg3:getDisplayName(),
				  nil,	
				  FABarTaps.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTaps,
				  soundFile, "RefillBeerBottle", foundKeg3)
	end
	if foundKeg4 then
		subContext2:addOption(foundKeg4:getDisplayName(),
				  nil,	
				  FABarTaps.onUseBarTaps,
				  getSpecificPlayer(player),
				  BarTaps,
				  soundFile, "RefillBeerBottle", foundKeg4)
	end

	local contextMenu3 = menu:addOption(FA.translation.correctbartapfacing)
	local subContext3 = ISContextMenu:getNew(menu);

	menu:addSubMenu(contextMenu3, subContext3)

	subContext3:addOption(FA.translation.pourfromeast,
				  nil,	
				  FABarTaps.FixBarTapFacing,
				  getSpecificPlayer(player),
				  BarTaps, "E")
	subContext3:addOption(FA.translation.pourfromwest,
				  nil,	
				  FABarTaps.FixBarTapFacing,
				  getSpecificPlayer(player),
				  BarTaps, "W")
end

FABarTaps.FixBarTapFacing = function(junk, player, BarTaps, direction)
	local properties = BarTaps:getSprite():getProperties()

	if properties:Is("Facing") then
		properties:Set("Facing", direction)
	end

	BarTaps:transmitModData()	
end

FABarTaps.onUseBarTaps = function(junk, player, BarTaps, soundFile, flavorChoice, foundKeg)
	if not FA.walkToFront(player, BarTaps) then
		return
	end

	local square = BarTaps:getSquare()
	local inv = player:getInventory()
	local FABeerMug = inv:FindAndReturn("FunctionalAppliances.FABeerMug")
	local vanillaPlasticCup = inv:FindAndReturn("Base.PlasticCup")
	local FAPlasticCup = inv:FindAndReturn("FunctionalAppliances.FAPlasticCup")
	local emptyBeerBottle = inv:FindAndReturn("Base.BeerEmpty")
		
	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		player:Say(FA.translation.sayneedagenerator)
	elseif (flavorChoice == "Beer" or flavorChoice == "RefillBeerBottle") and not foundKeg then
		player:Say(FA.translation.saybartapnotconnected)
	elseif (flavorChoice == "Beer" or flavorChoice == "RefillBeerBottle") and (foundKeg:getType() == "FunctionalAppliances.FAEmptyKeg" or foundKeg:getType() == "MoreBrews.EmptyKeg") then
		player:Say(FA.translation.saybartapconnectedtoemptykeg)
	elseif flavorChoice == "Beer" and (vanillaPlasticCup or FAPlasticCup or FABeerMug) then
		ISTimedActionQueue.add(UseBarTaps:new(player, BarTaps, soundFile, flavorChoice, foundKeg, squareToTurn))
	elseif flavorChoice == "RefillBeerBottle" and emptyBeerBottle then
		ISTimedActionQueue.add(UseBarTaps:new(player, BarTaps, soundFile, flavorChoice, foundKeg, squareToTurn))
	elseif flavorChoice == "RefillBeerBottle" then
		player:Say(FA.translation.sayneedbeerbottle)
	elseif flavorChoice == "Beer" then
		player:Say(FA.translation.sayneedplasticcuporbeermug)
	end
end