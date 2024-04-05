local FA_DistributionTable = {
    	all = {
        	bulletinBoard = {
            		procedural = true,
            		procList = {
                		{name="BulletinBoards", min=0, max=99, forceForTiles="location_business_office_generic_01_7;location_business_office_generic_01_15", weightChance=50},
            		}
        	},
        	largeBulletinBoard = {
            		procedural = true,
            		procList = {
                		{name="BulletinBoards", min=0, max=99, forceForTiles="location_business_office_generic_01_36;location_business_office_generic_01_37;location_business_office_generic_01_38;location_business_office_generic_01_39", weightChance=50},
            		}
        	},
        	napkinDispenser = {
            		procedural = true,
            		procList = {
                		{name="Napkins", min=0, max=99, forceForTiles="location_shop_accessories_01_10;location_shop_accessories_01_11", weightChance=50},
            		}
        	},
        	papertowelDispenser = {
            		procedural = true,
            		procList = {
                		{name="Napkins", min=0, max=99, forceForTiles="fixtures_bathroom_01_16;fixtures_bathroom_01_17", weightChance=50},
            		}
        	},
        	pegBoard = {
            		procedural = true,
            		procList = {
                		{name="ArmyHangarTools", min=0, max=99, forceForTiles="location_business_machinery_01_24;location_business_machinery_01_25;location_business_machinery_01_26;location_business_machinery_01_27", weightChance=50},
            		}
        	},
        	hotdogMachine = {
            		procedural = true,
            		procList = {
                		{name="HotdogMachines", min=0, max=99, forceForTiles="location_shop_fossoil_01_10;location_shop_fossoil_01_11", weightChance=50},
            		}
        	},
        	popcornMachine = {
            		procedural = true,
            		procList = {
                		{name="PopcornMachines", min=0, max=99, forceForTiles="location_entertainment_theatre_01_17", weightChance=50},
            		}
        	},
        	slurpNBurp = {
            		procedural = true,
            		procList = {
                		{name="SlurpNBurps", min=0, max=99, forceForTiles="location_shop_zippee_01_56;location_shop_zippee_01_57", weightChance=50},
            		}
        	},
    	},
}

table.insert(Distributions, 2, FA_DistributionTable)