FACoffeeMachine = FACoffeeMachine or {}

FACoffeeMachine.doBuildMenu = function(player, menu, square, CoffeeMachine)
	local soundFileBrewing = "coffee_brewing_sound"
	local soundFileFrothing = "frothing_milk_sound"
	local soundFileEspresso = "espresso_machine_sound"
	local soundFileGrinding = "grinding_coffee_sound"
	local soundFileBoiling = "BoilingFood"

	local teacup = nil
	local mugCyan = nil
	local mugRed = nil
	local mugWhite = nil
	local mugSpiffo = nil
	local thermos = nil
	local lowball = nil
	local coffeeBeans = nil
	local coffeeBag = nil
	local groundCoffee = nil
	local instantCoffee = nil
	local teaBag = nil
	local milk = nil
	local espresso = nil
	local waterItem = nil

	local playerItems = getSpecificPlayer(player):getInventory():getItems()

	for i=0, playerItems:size()-1 do
        	local item = playerItems:get(i)
		local itemType = nil

		if item and item:getType() then
			itemType = item:getType()
		end

		if itemType == "Teacup" or itemType == "WaterTeacup" then
			teacup = item
		end
		if itemType == "Mugl" or itemType == "WaterMug" then
			mugCyan = item
		end
		if itemType == "MugRed" or itemType == "WaterMugRed" then
			mugRed = item
		end
		if itemType == "MugWhite" or itemType == "WaterMugWhite" then
			mugWhite = item
		end
		if itemType == "MugSpiffo" or itemType == "WaterMugSpiffo" then
			mugSpiffo = item
		end
		if itemType == "EmptyThermos" or itemType == "FullWaterThermos" then
			thermos = item
		end
		if itemType == "LowballGlass" or itemType == "LowballGlassWater" then
			lowball = item
		end
		if itemType == "FAHotDrinkEspressoTeacup" or itemType == "FAHotDrinkEspressoMugl" or itemType == "FAHotDrinkEspressoRed" or itemType == "FAHotDrinkEspressoWhite" or itemType == "FAHotDrinkEspressoSpiffo" then
			espresso = item
		end
		if item:isWaterSource() then
			waterItem = item
		end
	end

	local groupName = CoffeeMachine:getSprite():getProperties():Val("GroupName")

	if groupName == "Espresso" then
		local contextMenu1 = menu:addOption(FA.translation.grind)
		local subContext1 = ISContextMenu:getNew(menu)
		menu:addSubMenu(contextMenu1, subContext1)

		subContext1:addOption(FA.translation.coffeebeans,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "grind", soundFileGrinding, nil, nil)

		subContext1:addOption(FA.translation.bagofcoffeebeans,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "grindbag", soundFileGrinding, nil, nil)
	end

	local contextMenu2 = menu:addOption(FA.translation.maketeain)
	local subContext2 = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu2, subContext2)

	if teacup then
		subContext2:addOption(FA.translation.teacup,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "tea", soundFileBoiling, teacup, waterItem)
	end
	if mugCyan then
		subContext2:addOption(FA.translation.cyanmug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "tea", soundFileBoiling, mugCyan, waterItem)
	end
	if mugRed then
		subContext2:addOption(FA.translation.redmug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "tea", soundFileBoiling, mugRed, waterItem)
	end
	if mugWhite then
		subContext2:addOption(FA.translation.whitemug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "tea", soundFileBoiling, mugWhite, waterItem)
	end
	if mugSpiffo then
		subContext2:addOption(FA.translation.spiffomug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "tea", soundFileBoiling, mugSpiffo, waterItem)
	end
	if not teacup and not mugCyan and not mugRed and not mugWhite and not mugSpiffo then
		subContext2:addOption(FA.translation.needscupormug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "tea", soundFileBoiling, mugSpiffo, waterItem)
	end

	local contextMenu3 = menu:addOption(FA.translation.makeinstantcoffeein)
	local subContext3 = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu3, subContext3)

	if mugCyan then
		subContext3:addOption(FA.translation.cyanmug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "instantcoffee", soundFileBoiling, mugCyan, waterItem)
	end
	if mugRed then
		subContext3:addOption(FA.translation.redmug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "instantcoffee", soundFileBoiling, mugRed, waterItem)
	end
	if mugWhite then
		subContext3:addOption(FA.translation.whitemug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "instantcoffee", soundFileBoiling, mugWhite, waterItem)
	end
	if mugSpiffo then
		subContext3:addOption(FA.translation.spiffomug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "instantcoffee", soundFileBoiling, mugSpiffo, waterItem)
	end
	if thermos then
		subContext3:addOption(FA.translation.thermos,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "instantcoffee", soundFileBoiling, thermos, waterItem)
	end
	if lowball then
		subContext3:addOption(FA.translation.lowballglass,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "instantcoffee", soundFileBoiling, lowball, waterItem)
	end
	if not mugCyan and not mugRed and not mugWhite and not mugSpiffo and not thermos and not lowball then
		subContext3:addOption(FA.translation.needscupormug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "instantcoffee", soundFileBoiling, lowball, waterItem)
	end

	local contextMenu4 = menu:addOption(FA.translation.brewcoffeein)
	local subContext4 = ISContextMenu:getNew(menu)
	menu:addSubMenu(contextMenu4, subContext4)

	if mugCyan then
		subContext4:addOption(FA.translation.cyanmug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "coffee", soundFileBrewing, mugCyan, waterItem)
	end
	if mugRed then
		subContext4:addOption(FA.translation.redmug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "coffee", soundFileBrewing, mugRed, waterItem)
	end
	if mugWhite then
		subContext4:addOption(FA.translation.whitemug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "coffee", soundFileBrewing, mugWhite, waterItem)
	end
	if mugSpiffo then
		subContext4:addOption(FA.translation.spiffomug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "coffee", soundFileBrewing, mugSpiffo, waterItem)
	end
	if thermos then
		subContext4:addOption(FA.translation.thermos,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "coffee", soundFileBrewing, thermos, waterItem)
	end
	if lowball then
		subContext4:addOption(FA.translation.lowballglass,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "coffee", soundFileBrewing, lowball, waterItem)
	end
	if not mugCyan and not mugRed and not mugWhite and not mugSpiffo and not thermos and not lowball then
		subContext4:addOption(FA.translation.needscupormug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "coffee", soundFileBrewing, lowball, waterItem)
	end

	if groupName == "Espresso" then
		local contextMenu5 = menu:addOption(FA.translation.brewespressoin)
		local subContext5 = ISContextMenu:getNew(menu)
		menu:addSubMenu(contextMenu5, subContext5)
		if teacup then
			subContext5:addOption(FA.translation.teacup,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "espresso", soundFileEspresso, teacup, waterItem)
		end
		if mugCyan then
			subContext5:addOption(FA.translation.cyanmug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "espresso", soundFileEspresso, mugCyan, waterItem)
		end
		if mugRed then
			subContext5:addOption(FA.translation.redmug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "espresso", soundFileEspresso, mugRed, waterItem)
		end
		if mugWhite then
			subContext5:addOption(FA.translation.whitemug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "espresso", soundFileEspresso, mugWhite, waterItem)
		end
		if mugSpiffo then
			subContext5:addOption(FA.translation.spiffomug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "espresso", soundFileEspresso, mugSpiffo, waterItem)
		end
		if not teacup and not mugCyan and not mugRed and not mugWhite and not mugSpiffo then
			subContext5:addOption(FA.translation.needscupormug,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "espresso", soundFileEspresso, mugSpiffo, waterItem)
		end

		menu:addOption(FA.translation.makelatte,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "latte", soundFileFrothing, espresso, waterItem)

		menu:addOption(FA.translation.makecappuccino,
				  nil,
				  FACoffeeMachine.onUseCoffeeMachine,
				  getSpecificPlayer(player),
				  CoffeeMachine,
				  "cappuccino", soundFileFrothing, espresso, waterItem)
	end
end

FACoffeeMachine.onUseCoffeeMachine = function(junk, player, CoffeeMachine, MyChoice, soundFile, container, waterItem)
	if not FA.walkToFront(player, CoffeeMachine) then
		return
	end

	local square = CoffeeMachine:getSquare()

	if not ((SandboxVars.AllowExteriorGenerator and square:haveElectricity()) or (SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier and square:isOutside() == false)) then
		player:Say(FA.translation.sayneedagenerator)
		return
	end

	if not CoffeeMachine:Activated() then
		player:Say(FA.translation.sayneedstobeturnedon)
		return
	end

	if not (SandboxVars.WaterShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.WaterShutModifier and square:isOutside() == false) then
		if MyChoice ~= "grind" and MyChoice ~= "grindbag" then
			if waterItem == nil then
				player:Say(FA.translation.sayneedmorewater)
				return
			end
		end
	else
		waterItem = nil
	end

	local inv = player:getInventory()
	local milk = inv:FindAndReturn("Base.Milk")
	local coffeeBeans = inv:FindAndReturn("SapphCooking.CoffeeBeans")
	--local roastedCoffeeGrains = inv:FindAndReturn("filcher.CoffeeGrainsCooked")
	local bagOfCoffeeBeans = inv:FindAndReturn("SapphCooking.CoffeeBeansBag")
	local teaBag = inv:FindAndReturn("Base.Teabag2")
	local instantCoffee = inv:FindAndReturn("Base.Coffee2")
	local instantCoffeePacket = inv:FindAndReturn("SapphCooking.CoffeePacket")
	local groundCoffee = inv:FindAndReturn("SapphCooking.GrindedCoffee")

	if MyChoice == "grind" and not coffeeBeans then 
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.coffeebeans)
		return
	end
	if MyChoice == "grindbag" and not bagOfCoffeeBeans then 
		player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.bagofcoffeebeans)
		return
	end

	if MyChoice == "tea" then
		if container == nil and not teaBag then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.teacup .. " or " .. FA.translation.mug .. " and " .. FA.translation.teabag)
			return
		elseif container == nil then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.teacup .. " or " .. FA.translation.mug)
			return
		elseif not teaBag then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.teabag)
			return
		end
	end

	if MyChoice == "instantcoffee" then
		if container == nil and not instantCoffee and not instantCoffeePacket then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.mug .. " or " .. FA.translation.lowballglass .. " or " .. FA.translation.thermos .. " and " .. FA.translation.instantcoffee .. " or " .. FA.translation.packetofinstantcoffee)
			return
		elseif container == nil then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.mug .. " or " .. FA.translation.lowballglass .. " or " .. FA.translation.thermos)
			return
		elseif not instantCoffee and not instantCoffeePacket then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.instantcoffee .. " or " .. FA.translation.packetofinstantcoffee)
			return
		end	
	end

	if MyChoice == "coffee" then
		if container == nil and not groundCoffee then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.mug .. " or " .. FA.translation.lowballglass .. " or " .. FA.translation.thermos .. " and " .. FA.translation.groundcoffeebeans)
			return
		elseif container == nil then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.mug .. " or " .. FA.translation.lowballglass .. " or " .. FA.translation.thermos)
			return
		elseif not groundCoffee then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.groundcoffeebeans)
			return
		end
	end

	if MyChoice == "espresso" then
		if container == nil and not groundCoffee then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.teacup .. " or " .. FA.translation.mug .. " and " .. FA.translation.groundcoffeebeans)
			return
		elseif container == nil then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.teacup .. " or " .. FA.translation.mug)
			return
		elseif not groundCoffee then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.groundcoffeebeans)
			return
		end
	end

	if MyChoice == "latte" or MyChoice == "cappuccino" then 
		if container == nil and not milk then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.mugorcupofespresso .. " and " .. FA.translation.milk)
			return
		elseif container == nil then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.mugorcupofespresso)
			return
		elseif not milk then
			player:Say(FA.translation.sayneedmissingingredients .. " " .. FA.translation.milk)
			return
		end
	end

	ISTimedActionQueue.add(UseCoffeeMachine:new(player, machine, soundFile, MyChoice, container, waterItem, squareToTurn))
end