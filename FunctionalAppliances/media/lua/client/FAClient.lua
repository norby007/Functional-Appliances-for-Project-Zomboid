FAClient = FAClient or {}

FAClient.Use = function(args)
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
end

FAClient.OnServerCommand = function(module, command, args)
    	if not (module == "FunctionalAppliances" and FAClient[command]) then
		return
	end
	--print("FAClient: getting a " .. command .. " from the server")
        FAClient[command](args)
end

Events.OnServerCommand.Add(FAClient.OnServerCommand)