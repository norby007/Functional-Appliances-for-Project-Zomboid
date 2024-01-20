FASiloGenerator = FASiloGenerator or {}

FASiloGenerator.doBuildMenu = function(player, menu, square, SiloGenerator)
	local index = SiloGenerator:getObjectIndex()
	local spr = SiloGenerator:getSprite():getName()

	sledgeDestroy(SiloGenerator)
	SiloGenerator:getSquare():transmitRemoveItemFromSquareOnServer(SiloGenerator)
	SiloGenerator:getSquare():transmitRemoveItemFromSquare(SiloGenerator)            

        SiloGenerator = IsoGenerator.new(nil, square:getCell(), square)  
	SiloGenerator:setSprite(spr)
		
	square:AddSpecialObject(SiloGenerator, index)
	square:transmitAddObjectToSquare(SiloGenerator, SiloGenerator:getObjectIndex())
	square:transmitModdata()
	SiloGenerator:transmitModData()	
       	SiloGenerator:transmitCompleteItemToServer()
        SiloGenerator:transmitUpdatedSpriteToServer()

	SiloGenerator:setCondition(100)
	SiloGenerator:setConnected(true)
	SiloGenerator:setFuel(500)
	SiloGenerator:setCanPassThrough(false)     
	SiloGenerator:setBlockAllTheSquare(true)
	SiloGenerator:setIsDismantable(false) 

	if isClient() then 
		SiloGenerator:transmitCompleteItemToServer() 
	end      

	local contextMenu = menu:addOption(FA.translation.check)
	local subContext = ISContextMenu:getNew(menu)

	menu:addSubMenu(contextMenu, subContext)

	if SiloGenerator then
		subContext:addOption(FA.translation.fuel,
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  "amount")
	end
	if SiloGenerator then
		subContext:addOption(FA.translation.condition,
				  nil,	
				  FASiloGenerator.onUseSiloGenerator,
				  getSpecificPlayer(player),
				  SiloGenerator,
				  "condition")
	end
end

FASiloGenerator.onUseSiloGenerator = function(junk, player, SiloGenerator, MyChoice)
	if not FA.walkToFront(player, SiloGenerator) then
		return
	end

	if MyChoice == "amount" then
		print(FA.translation.sayfuelamount .. ": " .. SiloGenerator:getFuel())
	elseif MyChoice == "condition" then
		print(FA.translation.condition .. ": " .. SiloGenerator:getCondition())
	end
end