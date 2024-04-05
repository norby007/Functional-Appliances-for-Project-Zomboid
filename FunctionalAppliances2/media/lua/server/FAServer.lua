FAServer = FAServer or {}

FAServer.SendServerCommandToClients = function(command, args)
	if not isClient() and not isServer() then
		triggerEvent("OnServerCommand", "FunctionalAppliances", command, args) -- Singleplayer
	else
		sendServerCommand("FunctionalAppliances", command, args) -- Multiplayer
	end
end

FAServer.Use = function(args)
	local square = getSquare(args.x, args.y, args.z)
	local completed = false
	if square ~= nil then
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

					if itemType == args.type then
						local number = args.number
						while number > 0 do
							item:Use()
							number = number - 1
						end
						if args.weight ~= nil then
							item:setActualWeight(args.weight)
							item:setCustomWeight(true)
						end
						completed = true
						break
					end
				end
				if completed then 
					break
				end
			end
		end
	end
	FAServer.SendServerCommandToClients("Use", args)
end

FAServer.OnClientCommand = function(module, command, player, args)
    	if not (module == "FunctionalAppliances" and FAServer[command]) then
		return
	end
	print("Functional Appliances Server: Getting a " .. command .. " from a client.")
	FAServer[command](args)
end

Events.OnClientCommand.Add(FAServer.OnClientCommand)