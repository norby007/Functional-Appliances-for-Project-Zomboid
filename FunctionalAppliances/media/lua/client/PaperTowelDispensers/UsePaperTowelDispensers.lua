UsePaperTowelDispensersMenu = {};
UsePaperTowelDispensersMenu.doBuildMenu = function(player, context, worldobjects)

	local PaperTowelDispensersObject = nil

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
			
				if (groupName == "Air" and customName == "Blower") then				
					PaperTowelDispensersObject = thisObject
					if not PaperTowelDispensersObject:getContainer() then
						local index = PaperTowelDispensersObject:getObjectIndex()
               					sledgeDestroy(PaperTowelDispensersObject)
						PaperTowelDispensersObject:getSquare():transmitRemoveItemFromSquareOnServer(PaperTowelDispensersObject)
						PaperTowelDispensersObject:getSquare():transmitRemoveItemFromSquare(PaperTowelDispensersObject)            

                				PaperTowelDispensersObject = IsoThumpable.new(getCell(), square, spr, false, ISWoodenContainer:new(spr, nil))  
                				PaperTowelDispensersObject:setIsContainer(true)
                				PaperTowelDispensersObject:getContainer():setType("papertowelDispenser")
                				PaperTowelDispensersObject:getContainer():setCapacity(5)

                				square:AddTileObject(PaperTowelDispensersObject, index)
						square:transmitAddObjectToSquare(PaperTowelDispensersObject, PaperTowelDispensersObject:getObjectIndex())
						square:transmitModdata()
						PaperTowelDispensersObject:transmitModData()	
              					PaperTowelDispensersObject:transmitCompleteItemToServer()
                				PaperTowelDispensersObject:transmitUpdatedSpriteToServer()
					end
					break
				end
			end 
		end 
	end
end

Events.OnPreFillWorldObjectContextMenu.Add(UsePaperTowelDispensersMenu.doBuildMenu);
