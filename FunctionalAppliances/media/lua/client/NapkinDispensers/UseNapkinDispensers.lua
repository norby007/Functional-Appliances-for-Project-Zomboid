UseNapkinDispensersMenu = {};
UseNapkinDispensersMenu.doBuildMenu = function(player, context, worldobjects)

	local NapkinDispensersObject = nil

	for _,object in ipairs(worldobjects) do
		local square = object:getSquare()

		if not square then
			return
		end
	
		for i=1,square:getObjects():size() do
			local thisObject = square:getObjects():get(i-1)
			
			if thisObject:getSprite() then
				local properties = thisObject:getSprite():getProperties()
				local spr = thisObject:getSprite():getName()  

				if properties == nil then
					return
				end

				local customName = nil
				local groupName = nil

				if properties:Is("CustomName") then
					customName = properties:Val("CustomName")
				end


				if properties:Is("GroupName") then
					groupName = properties:Val("GroupName")
				end
			
				if (groupName == "Shop" and customName == "Dispenser") then				
					NapkinDispensersObject = thisObject
					if not NapkinDispensersObject:getContainer() then
						local index = NapkinDispensersObject:getObjectIndex()
               					sledgeDestroy(NapkinDispensersObject)
						NapkinDispensersObject:getSquare():transmitRemoveItemFromSquareOnServer(NapkinDispensersObject)
						NapkinDispensersObject:getSquare():transmitRemoveItemFromSquare(NapkinDispensersObject)            

                				NapkinDispensersObject = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
                				NapkinDispensersObject:setIsContainer(true)
                				NapkinDispensersObject:getContainer():setType("napkinDispenser")
                				NapkinDispensersObject:getContainer():setCapacity(5)

                				square:AddTileObject(NapkinDispensersObject, index)
						square:transmitAddObjectToSquare(NapkinDispensersObject, NapkinDispensersObject:getObjectIndex())
						square:transmitModdata()
						NapkinDispensersObject:transmitModData()	
              					NapkinDispensersObject:transmitCompleteItemToServer()
                				NapkinDispensersObject:transmitUpdatedSpriteToServer()
					end
					break
				end
			end 
		end 
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(UseNapkinDispensersMenu.doBuildMenu);
