FA = FA or {}

FA.addMenuFromInventory = function(playerIndex, menu, stack)
    	local item = nil
    	local items = nil
    	if stack and stack[1] and stack[1].items then
        	items = stack[1].items
        	item = items[1]
    	elseif stack and stack[1] then
        	item = stack[1]
    	end

    	if not item then 
		return 
	end

	if not item:isInPlayerInventory() then
		return
	end

	local playerIsWet = false
	local playerIsDirty = false
	local player = getSpecificPlayer(playerIndex)

	if item:getType() == "FAPaperNapkins" and player:getBodyDamage():getWetness() > 0 then
		playerIsWet = true
	end
	if item:getType() == "FAPaperNapkinsWet" and ISWashYourself.GetRequiredWater(player) > 0 then
		playerIsDirty = true
	end

	if playerIsWet then
		menu:addOptionOnTop(FA.translation.dryself, items, FA.onNapkinDryMyself, playerIndex)
	end
	if playerIsDirty then
		menu:addOptionOnTop(FA.translation.washself, items, FA.onNapkinWashMyself, playerIndex)
	end
end

Events.OnFillInventoryObjectContextMenu.Add(FA.addMenuFromInventory)

FA.onNapkinDryMyself = function(napkins, player)
    	napkins = ISInventoryPane.getActualItems(napkins)
    	for i,napkin in ipairs(napkins) do
        	FA.napkinDryMyself(napkin, player)
        	break
   	end
end

FA.napkinDryMyself = function(napkin, player)
	local playerObj = getSpecificPlayer(player)
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, napkin)
	local useLeft = math.ceil(napkin:getUsedDelta() * 10)
	ISTimedActionQueue.add(ISNapkinDryMyself:new(playerObj, napkin, (useLeft * 20) + 80))
end

FA.onNapkinWashMyself = function(napkins, player)
    	napkins = ISInventoryPane.getActualItems(napkins)
    	for i,napkin in ipairs(napkins) do
        	FA.napkinWashMyself(napkin, player)
        	break
   	end
end

FA.napkinWashMyself = function(napkin, player)
	local playerObj = getSpecificPlayer(player)
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, napkin)
	local useLeft = math.ceil(napkin:getUsedDelta() * 10)
	ISTimedActionQueue.add(ISNapkinWashMyself:new(playerObj, napkin, (useLeft * 20) + 60))
end