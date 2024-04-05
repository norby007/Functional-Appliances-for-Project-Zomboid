FA.preDistributionMerge = function()
    	ProceduralDistributions.list.BulletinBoards = {
        	rolls = 5,
        	items = {
            		"SheetPaper2", 40,
            		"SheetPaper2", 20,
            		"SheetPaper2", 10,
            		"LouisvilleMap1", 1,
            		"LouisvilleMap2", 1,
            		"LouisvilleMap3", 1,
            		"LouisvilleMap4", 1,
            		"LouisvilleMap5", 1,
            		"LouisvilleMap6", 1,
           		"LouisvilleMap7", 1,
            		"LouisvilleMap8", 1,
            		"LouisvilleMap9", 1,
            		"MuldraughMap", 1,
            		"WestpointMap", 1,
            		"MarchRidgeMap", 1,
            		"RosewoodMap", 1,
            		"RiversideMap", 1,
			"Magazine", 2,
			"Newspaper", 2,
			"HottieZ", 0.1,
        	}
    	}

    	ProceduralDistributions.list.Napkins = {
        	rolls = 3,
        	items = {
            		"FunctionalAppliances.FAPaperNapkins", 40,
            		"FunctionalAppliances.FAPaperNapkins", 20,
            		"FunctionalAppliances.FAPaperNapkins", 10,
        	}
    	}

	if getActivatedMods():contains("sapphcooking") then
    		ProceduralDistributions.list.HotdogMachines = {
        		rolls = 3,
       		 	items = {
        	    		"Sausage", 40,
        	    		"SapphCooking.HotdogBun", 20,
        	    		"FunctionalAppliances.FAHotdog", 10,
       		 	}
    		}
	else
    		ProceduralDistributions.list.HotdogMachines = {
        		rolls = 3,
       		 	items = {
        	    		"Sausage", 40,
        	    		"Sausage", 20,
        	    		"FunctionalAppliances.FAHotdog", 10,
       		 	}
    		}
	end

    	ProceduralDistributions.list.PopcornMachines = {
        	rolls = 3,
        	items = {
            		"FunctionalAppliances.FATheaterPopcorn", 40,
            		"FunctionalAppliances.FAButteredPopcorn", 20,
            		"FunctionalAppliances.FAButteredPopcorn", 10,
        	}
    	}

    	ProceduralDistributions.list.SlurpNBurps = {
        	rolls = 3,
        	items = {
            		"FunctionalAppliances.FAFountainCup", 40,
            		"FunctionalAppliances.FAFountainCup", 20,
            		"FunctionalAppliances.FAFountainCup", 10,
        	}
    	}
end

Events.OnPreDistributionMerge.Add(FA.preDistributionMerge)