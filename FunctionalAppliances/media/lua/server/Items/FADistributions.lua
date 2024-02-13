require 'Items/SuburbsDistributions'
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"

local FAKegSpawnChance = SandboxVars.FunctionalAppliances.BeerKegsChance; 
local FASyrupsSpawnChance = SandboxVars.FunctionalAppliances.SyrupsChance; 
local FATheatreSpawnChance = SandboxVars.FunctionalAppliances.FATheatreChance; 
local FAFreshTheatreSpawnChance = SandboxVars.FunctionalAppliances.FAFreshTheatreChance; 
local FAZombieItemsSpawn = SandboxVars.FunctionalAppliances.FAZombieItemsSpawn; 
local FASapphsCookingTheatreSpawnChance = SandboxVars.FunctionalAppliances.FASapphsCookingTheatreChance; 
local FASapphsCookingFreshTheatreSpawnChance = SandboxVars.FunctionalAppliances.FASapphsCookingFreshTheatreChance; 
local FACCSTheatreSpawnChance = SandboxVars.FunctionalAppliances.FACCSTheatreChance; 


if (FAKegSpawnChance == 6) then
	FAKegSpawnChance = 0;
end

if (FASyrupsSpawnChance == 6) then
	FASyrupsSpawnChance = 0;
end

if (FATheatreSpawnChance == 6) then
	FATheatreSpawnChance = 0;
end

if (FAFreshTheatreSpawnChance == 6) then
	FAFreshTheatreSpawnChance = 0;
end

if (FASapphsCookingTheatreSpawnChance == 6) then
	FASapphsCookingTheatreSpawnChance = 0;
end

if (FASapphsCookingFreshTheatreSpawnChance == 6) then
	FASapphsCookingFreshTheatreSpawnChance = 0;
end

if (FACCSTheatreSpawnChance == 6) then
	FACCSTheatreSpawnChance = 0;
end

table.insert(VehicleDistributions["GloveBox"].items, "FunctionalAppliances.FAFountainCup");
table.insert(VehicleDistributions["GloveBox"].items, 0.01);

if FAZombieItemsSpawn then
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, "FunctionalAppliances.FAFountainCup");
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, "FunctionalAppliances.FABucketofButteredPopcorn");
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, "FunctionalAppliances.FABucketofPopcorn");
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, "FunctionalAppliances.FAFountainCupOrangeSoda");
	table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.01);

	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "FunctionalAppliances.FAFountainCup");
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "FunctionalAppliances.FABucketofButteredPopcorn");
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "FunctionalAppliances.FABucketofPopcorn");
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "FunctionalAppliances.FAFountainCupOrangeSoda");
	table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.01);
end

table.insert(ProceduralDistributions["list"]["TheatreDrinks"].items, "FunctionalAppliances.FAFountainCupOrangeSoda");
table.insert(ProceduralDistributions["list"]["TheatreDrinks"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatreDrinks"].items, "FunctionalAppliances.FAFountainCupColaSoda");
table.insert(ProceduralDistributions["list"]["TheatreDrinks"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatreDrinks"].items, "FunctionalAppliances.FAFountainCupLemonlimeSoda");
table.insert(ProceduralDistributions["list"]["TheatreDrinks"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatreDrinks"].items, "FunctionalAppliances.FAFountainCupRootBeerSoda");
table.insert(ProceduralDistributions["list"]["TheatreDrinks"].items, 10);

table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "Base.Sausage");
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 20);
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "Base.Sausage");
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "Base.BreadSlices");
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "Base.Bread");
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "Base.Butter");
table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 10);

table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "FunctionalAppliances.FAFountainCup");
table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "FunctionalAppliances.FABucketofPopcorn");
table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "FunctionalAppliances.FABucketofButteredPopcorn");
table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);

table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, "FunctionalAppliances.FABucketofPopcorn");
table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, "FunctionalAppliances.FABucketofButteredPopcorn");
table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, 10);
table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, "Base.Butter");
table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, 20);
table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, "FunctionalAppliances.FAEmptyBucketPopcorn");
table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, 10);

table.insert(ProceduralDistributions["list"]["BarCounterMisc"].items, "FunctionalAppliances.FATheaterPopcorn");
table.insert(ProceduralDistributions["list"]["BarCounterMisc"].items, 10);
table.insert(ProceduralDistributions["list"]["BarCounterMisc"].items, "FunctionalAppliances.FAFriedPotatoSkins");
table.insert(ProceduralDistributions["list"]["BarCounterMisc"].items, 10);
table.insert(ProceduralDistributions["list"]["BarCounterMisc"].items, "FunctionalAppliances.FAFriedBloomingOnion");
table.insert(ProceduralDistributions["list"]["BarCounterMisc"].items, 10);

table.insert(ProceduralDistributions["list"]["FridgeTrailerPark"].items, "FunctionalAppliances.FAFountainCup");
table.insert(ProceduralDistributions["list"]["FridgeTrailerPark"].items, 5);

table.insert(ProceduralDistributions["list"]["BurgerKitchenFridge"].items, "FunctionalAppliances.FAFountainCupLemonLimeSoda");
table.insert(ProceduralDistributions["list"]["BurgerKitchenFridge"].items, 10);
table.insert(ProceduralDistributions["list"]["BurgerKitchenFridge"].items, "FunctionalAppliances.FAFountainCupOrangeSoda");
table.insert(ProceduralDistributions["list"]["BurgerKitchenFridge"].items, 10);
table.insert(ProceduralDistributions["list"]["BurgerKitchenFridge"].items, "FunctionalAppliances.FAFountainCupColaSoda");
table.insert(ProceduralDistributions["list"]["BurgerKitchenFridge"].items, 10);
table.insert(ProceduralDistributions["list"]["BurgerKitchenFridge"].items, "FunctionalAppliances.FAFountainCupRootBeerSoda");
table.insert(ProceduralDistributions["list"]["BurgerKitchenFridge"].items, 10);

table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, "FunctionalAppliances.FAFountainCup");
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, 10);
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, "FunctionalAppliances.FAFountainCupOrangeSoda");
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, 10);
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, "FunctionalAppliances.FAFountainCupColaSoda");
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, 10);
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, "FunctionalAppliances.FAFountainCupLemonLimeSoda");
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, 10);
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, "FunctionalAppliances.FAFountainCupRootBeerSoda");
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, 10);
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, "FunctionalAppliances.FAFriedChickenTenders");
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, 10);
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, "FunctionalAppliances.FAFriedCheeseSticks");
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, 10);
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, "FunctionalAppliances.FAFriedBloomingOnion");
table.insert(ProceduralDistributions["list"]["CafeteriaSandwiches"].items, 10);

table.insert(ProceduralDistributions["list"]["StoreCounterCleaning"].items, "Base.TinOpener");
table.insert(ProceduralDistributions["list"]["StoreCounterCleaning"].items, 10);

table.insert(ProceduralDistributions["list"]["GasStorageCombo"].items, "FunctionalAppliances.FAFountainCup");
table.insert(ProceduralDistributions["list"]["GasStorageCombo"].items, 10);
table.insert(ProceduralDistributions["list"]["GasStorageCombo"].items, "FunctionalAppliances.FAEmptySodaSyrupBox");
table.insert(ProceduralDistributions["list"]["GasStorageCombo"].items, 1);
table.insert(ProceduralDistributions["list"]["GasStorageCombo"].items, "FunctionalAppliances.EmptyFACO2Tank");
table.insert(ProceduralDistributions["list"]["GasStorageCombo"].items, 1);

table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, "FunctionalAppliances.FAFountainCup");
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, 10);
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, "FunctionalAppliances.FAEmptySodaSyrupBox");
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, 1);
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, "FunctionalAppliances.EmptyFACO2Tank");
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, 1);
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, "FunctionalAppliances.FAFriedChickenTenders");
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, 5);
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, "FunctionalAppliances.FAFriedChickenFillet");
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, 5);
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, "FunctionalAppliances.FAFriedBloomingOnion");
table.insert(ProceduralDistributions["list"]["JaysKitchenBags"].items, 5);

table.insert(ProceduralDistributions["list"]["StoreShelfSnacks"].items, "FunctionalAppliances.FAPopBottleLemonLime");
table.insert(ProceduralDistributions["list"]["StoreShelfSnacks"].items, 10);
table.insert(ProceduralDistributions["list"]["StoreShelfSnacks"].items, "FunctionalAppliances.FAPopBottleCola");
table.insert(ProceduralDistributions["list"]["StoreShelfSnacks"].items, 10);
table.insert(ProceduralDistributions["list"]["StoreShelfSnacks"].items, "FunctionalAppliances.FAPopBottleRootBeer");
table.insert(ProceduralDistributions["list"]["StoreShelfSnacks"].items, 10);

table.insert(ProceduralDistributions["list"]["GigamartBottles"].items, "FunctionalAppliances.FAPopBottleLemonLime");
table.insert(ProceduralDistributions["list"]["GigamartBottles"].items, 10);
table.insert(ProceduralDistributions["list"]["GigamartBottles"].items, "FunctionalAppliances.FAPopBottleCola");
table.insert(ProceduralDistributions["list"]["GigamartBottles"].items, 10);
table.insert(ProceduralDistributions["list"]["GigamartBottles"].items, "FunctionalAppliances.FAPopBottleRootBeer");
table.insert(ProceduralDistributions["list"]["GigamartBottles"].items, 10);

table.insert(ProceduralDistributions["list"]["FridgeBottles"].items, "FunctionalAppliances.FAPopBottleLemonLime");
table.insert(ProceduralDistributions["list"]["FridgeBottles"].items, 10);
table.insert(ProceduralDistributions["list"]["FridgeBottles"].items, "FunctionalAppliances.FAPopBottleCola");
table.insert(ProceduralDistributions["list"]["FridgeBottles"].items, 10);
table.insert(ProceduralDistributions["list"]["FridgeBottles"].items, "FunctionalAppliances.FAPopBottleRootBeer");
table.insert(ProceduralDistributions["list"]["FridgeBottles"].items, 10);

table.insert(ProceduralDistributions["list"]["BarCounterGlasses"].items, "FunctionalAppliances.FABeerMug");
table.insert(ProceduralDistributions["list"]["BarCounterGlasses"].items, 20);
table.insert(ProceduralDistributions["list"]["BarCounterGlasses"].items, "FunctionalAppliances.FAPlasticCup");
table.insert(ProceduralDistributions["list"]["BarCounterGlasses"].items, 10);
table.insert(ProceduralDistributions["list"]["BarCounterGlasses"].items, "FunctionalAppliances.FAEmptyKeg");
table.insert(ProceduralDistributions["list"]["BarCounterGlasses"].items, 1);

table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, "FunctionalAppliances.FABubBeerBottle");
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, 10);
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, "FunctionalAppliances.FABubLiteBeerBottle");
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, 10);
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, "FunctionalAppliances.FASwillerBeerBottle");
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, 10);
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, "FunctionalAppliances.FASwillerLiteBeerBottle");
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, 10);
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, "FunctionalAppliances.FAEmptyKeg");
table.insert(ProceduralDistributions["list"]["BarShelfLiquor"].items, 1);

table.insert(ProceduralDistributions["list"]["BarCounterLiquor"].items, "FunctionalAppliances.FABubBeerBottle");
table.insert(ProceduralDistributions["list"]["BarCounterLiquor"].items, 10);
table.insert(ProceduralDistributions["list"]["BarCounterLiquor"].items, "FunctionalAppliances.FABubLiteBeerBottle");
table.insert(ProceduralDistributions["list"]["BarCounterLiquor"].items, 10);
table.insert(ProceduralDistributions["list"]["BarCounterLiquor"].items, "FunctionalAppliances.FASwillerBeerBottle");
table.insert(ProceduralDistributions["list"]["BarCounterLiquor"].items, 10);
table.insert(ProceduralDistributions["list"]["BarCounterLiquor"].items, "FunctionalAppliances.FASwillerLiteBeerBottle");
table.insert(ProceduralDistributions["list"]["BarCounterLiquor"].items, 10);

table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, "FunctionalAppliances.FABubBeerBottle");
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, 10);
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, "FunctionalAppliances.FABubLiteBeerBottle");
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, 10);
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, "FunctionalAppliances.FASwillerBeerBottle");
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, 10);
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, "FunctionalAppliances.FASwillerLiteBeerBottle");
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, 10);
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, "Base.Yeast");
table.insert(ProceduralDistributions["list"]["FridgeBeer"].items, 10);

function isFriendlyModEnabled(modname)
    local actmods = getActivatedMods();
    for i=0, actmods:size()-1, 1 do
        if actmods:get(i) == modname then
            return true;
        end
    end
    return false;
end

if isFriendlyModEnabled("sapphcooking") then
	table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "SapphCooking.ViennaSausage");
	table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 20);
	table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "SapphCooking.FrankfurterSausage");
	table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 20);
	table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "SapphCooking.HotdogBun");
	table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, "SapphCooking.BagofHotdogBuns");
	table.insert(ProceduralDistributions["list"]["TheatreKitchenFreezer"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, "SapphCooking.CannedSausages");
	table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, "SapphCooking.CanofKernelCorn");
	table.insert(ProceduralDistributions["list"]["TheatrePopcorn"].items, 10);
end

if isFriendlyModEnabled("CCS") then
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.Snackers");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.Leeroy");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.ChitChat");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.Tittles");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.4muskepeers");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.Almondjaws");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.ZersheyBar");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.Mounds");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.PayDay");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.Kwix");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.BagofRollys");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCS.SweetTreats");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
end

if isFriendlyModEnabled("CCSFixed") then
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.Snackers");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.Leeroy");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.ChitChat");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.Tittles");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.4muskepeers");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.Almondjaws");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.ZersheyBar");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.Mounds");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.PayDay");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.Kwix");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.BagofRollys");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, "CCSFixed.SweetTreats");
	table.insert(ProceduralDistributions["list"]["TheatreSnacks"].items, 10);
end

local FABaseCandyList = {
	"Base.Chocolate",
	"Base.CandyPackage",
	"Base.HardCandies",
	"Base.LicoriceRed",
	"Base.LicoriceBlack",
	"Base.GummyBears",
	"Base.Modjeska",
	"Base.Jujubes",
	"Base.ChocolateCoveredCoffeeBeans",
	"Base.GummyWorms",
}

local FAPopcornList = {
	"FunctionalAppliances.FABucketofButteredPopcorn",
	"FunctionalAppliances.FABucketofPopcorn",
	"Base.Butter",
	"Base.Popcorn",
	"FunctionalAppliances.FAEmptyBucketPopcorn",
	"FunctionalAppliances.FAFountainCup",
}

local FAFreshList = {
	"Base.Butter",
	"FunctionalAppliances.FAFountainCupOrangeSoda",
	"FunctionalAppliances.FAFountainCupColaSoda",
	"FunctionalAppliances.FAFountainCupLemonLimeSoda",
	"FunctionalAppliances.FAFountainCupRootBeerSoda",
	"FunctionalAppliances.FAHotdog",
	"Base.Sausage",
	"Base.BreadSlices",
}

local FABarTapsKegsList = {
	"FunctionalAppliances.FABubKeg",
	"FunctionalAppliances.FABubLiteKeg",
	"FunctionalAppliances.FASwillerKeg",
	"FunctionalAppliances.FASwillerLiteKeg",
}

local FASodaFountainSyrupsList = {
	"FunctionalAppliances.FAOrangeSodaSyrupBox",
	"FunctionalAppliances.FALemonLimeSodaSyrupBox",
	"FunctionalAppliances.FARootBeerSodaSyrupBox",
	"FunctionalAppliances.FAColaSodaSyrupBox",
}

local FASapphsList = {
	"SapphCooking.CanofKernelCorn",
	"SapphCooking.CannedSausages",
}

local FASapphsFreshList = {
	"SapphCooking.BagofHotdogBuns",
	"SapphCooking.HotdogBun",
	"SapphCooking.FrankfurterSausage",
	"SapphCooking.ViennaSausage",
}

local FACCSCandyList = {
	"CCS.Snackers",
	"CCS.Leeroy",
	"CCS.ChitChat",
	"CCS.Tittles",
	"CCS.4muskepeers",
	"CCS.Leeroy",
	"CCS.Almondjaws",
	"CCS.ZersheyBar",
	"CCS.Mounds",
	"CCS.PayDay",
	"CCS.Kwix",
	"CCS.BagofRollys",
	"CCS.SweetTreats",
}

local FACCSFixedCandyList = {
	"CCSFixed.Snackers",
	"CCSFixed.Leeroy",
	"CCSFixed.ChitChat",
	"CCSFixed.Tittles",
	"CCSFixed.4muskepeers",
	"CCSFixed.Leeroy",
	"CCSFixed.Almondjaws",
	"CCSFixed.ZersheyBar",
	"CCSFixed.Mounds",
	"CCSFixed.PayDay",
	"CCSFixed.Kwix",
	"CCSFixed.BagofRollys",
	"CCSFixed.SweetTreats",
}

local FATheatrespawns = {
	theatrestorage = {shelves=60,crate=60,counter=60,fridge=60},
    	theatre = {counter=60,fridge=60,crate=60,freezer=60},
   	theatrekitchen = {counter=60,crate=60,fridge=60,metal_shelves=60}
}


local FABarTapsspawns = {
	bar = {counter=80}
}

local FASyrupsspawns = {
	zippeestore = {counter=80},
	theatrestorage = {counter=80},
    	theatre = {counter=80},
  	theatrekitchen = {counter=80},
	spiffo_dining = {counter=80},
    	spiffoskitchen = {counter=80},
	gasstore = {counter=80},
	restaurant = {counter=80}
}

FA = FA or {}

FA.ApplySpawnChance = function(value)
	if ZombRand(100)+1 >= (100 - value) then
		return true
	else
		return false
	end
end

FA.PickOne = function(index)
	return ZombRand(index)+1
end

FA.depleteSpawnedKeg = function(keg)
		local filledAmount = SandboxVars.FunctionalAppliances.BeerKegsFilledAmount
		local randomNumb = 0

		if filledAmount == 6 then
			randomNumb = ZombRand(2,48)
		elseif filledAmount == 5 then
			randomNumb = 48
		elseif filledAmount == 4 then
			randomNumb = ZombRand(30,47)
		elseif filledAmount == 3 then
			randomNumb = ZombRand(20,32)
		elseif filledAmount == 2 then
			randomNumb = ZombRand(10,22)
		elseif filledAmount == 1 then
			randomNumb = ZombRand(2,12)
		end

		local kegDelta = keg:getUseDelta()
		local newWeightAmount = 2 + (randomNumb * 0.375)

		keg:setDelta(randomNumb * kegDelta)
		keg:setActualWeight(newWeightAmount)
		keg:setCustomWeight(true)
end	

FA.depleteSpawnedTank = function(tank)
	local filledAmount = SandboxVars.FunctionalAppliances.SyrupsFilledAmount
	local randomNumb = 0

	if filledAmount == 6 then
		randomNumb = ZombRand(2,100)
	elseif filledAmount == 5 then
		randomNumb = 100
	elseif filledAmount == 4 then
		randomNumb = ZombRand(73,98)
	elseif filledAmount == 3 then
		randomNumb = ZombRand(48,77)
	elseif filledAmount == 2 then
		randomNumb = ZombRand(23,52)
	elseif filledAmount == 1 then
		randomNumb = ZombRand(2,27)
	end

	local tankDelta = tank:getUseDelta()
	local newWeightAmount = 5 + (randomNumb * 0.05)

	tank:setDelta(randomNumb * tankDelta)
	tank:setActualWeight(newWeightAmount)
	tank:setCustomWeight(true)
end

FA.depleteSpawnedSyrup = function(syrup)
	local filledAmount = SandboxVars.FunctionalAppliances.SyrupsFilledAmount
	local randomNumb = 0

	if filledAmount == 6 then
		randomNumb = ZombRand(2,48)
	elseif filledAmount == 5 then
		randomNumb = 48
	elseif filledAmount == 4 then
		randomNumb = ZombRand(30,47)
	elseif filledAmount == 3 then
		randomNumb = ZombRand(20,32)
	elseif filledAmount == 2 then
		randomNumb = ZombRand(10,22)
	elseif filledAmount == 1 then
		randomNumb = ZombRand(2,12)
	end

	local syrupDelta = syrup:getUseDelta()
	local newWeightAmount = 1 + (randomNumb * 0.1875)

	syrup:setDelta(randomNumb * syrupDelta)
	syrup:setActualWeight(newWeightAmount)
	syrup:setCustomWeight(true)
end

local function FASpawn(roomName, containerType, containerFilled)
	if FATheatrespawns[roomName] == nil and FABarTapsspawns[roomName] == nil and FASyrupsspawns[roomName] == nil then
		return
	end

	local RollRand = 0
	
	if FATheatrespawns[roomName] ~= nil and FATheatrespawns[roomName][containerType] ~= nil then
		if FA.ApplySpawnChance(FATheatrespawns[roomName][containerType]) then
			if isFriendlyModEnabled("sapphcooking") then
				if containerType == "fridge" then
					RollRand = ZombRand(1,100)+(FASapphsCookingFreshTheatreSpawnChance*10)
					if RollRand >= 101 then
						containerFilled:AddItem(FASapphsFreshList[FA.PickOne(#FASapphsFreshList)])
						if RollRand >= 121 then
							containerFilled:AddItem(FASapphsFreshList[FA.PickOne(#FASapphsFreshList)])
							if RollRand >= 131 then
								containerFilled:AddItem(FASapphsFreshList[FA.PickOne(#FASapphsFreshList)])
							end
						end
					end
				else
					RollRand = ZombRand(1,100)+(FASapphsCookingFreshTheatreSpawnChance*10)
					if RollRand >= 101 then
						containerFilled:AddItem(FASapphsFreshList[FA.PickOne(#FASapphsFreshList)])
						if RollRand >= 121 then
							containerFilled:AddItem(FASapphsFreshList[FA.PickOne(#FASapphsFreshList)])
						end
					end
					RollRand = ZombRand(1,100)+(FASapphsCookingTheatreSpawnChance*10)
					if RollRand >= 101 then
						containerFilled:AddItem(FASapphsList[FA.PickOne(#FASapphsList)])
						if RollRand >= 121 then
							containerFilled:AddItem(FASapphsList[FA.PickOne(#FASapphsList)])
							if RollRand >= 131 then
								containerFilled:AddItem(FASapphsList[FA.PickOne(#FASapphsList)])
							end
						end
					end
				end
			end

			if isFriendlyModEnabled("CCSFixed") and containerType == "counter" then
				RollRand = ZombRand(1,100)+(FACCSTheatreSpawnChance*10)
				if RollRand >= 101 then
					containerFilled:AddItem(FACCSFixedCandyList[FA.PickOne(#FACCSFixedCandyList)])
					if RollRand >= 121 then
						containerFilled:AddItem(FACCSFixedCandyList[FA.PickOne(#FACCSFixedCandyList)])
						if RollRand >= 131 then
							containerFilled:AddItem(FACCSFixedCandyList[FA.PickOne(#FACCSFixedCandyList)])
						end
					end
				end
			elseif isFriendlyModEnabled("CCS") and containerType == "counter" then
				RollRand = ZombRand(1,100)+(FACCSTheatreSpawnChance*10)
				if RollRand >= 101 then
					containerFilled:AddItem(FACCSCandyList[FA.PickOne(#FACCSCandyList)])
					if RollRand >= 121 then
						containerFilled:AddItem(FACCSCandyList[FA.PickOne(#FACCSCandyList)])
						if RollRand >= 131 then
							containerFilled:AddItem(FACCSCandyList[FA.PickOne(#FACCSCandyList)])
						end
					end
				end
			end

			if containerType == "fridge" then
				RollRand = ZombRand(1,100)+(FAFreshTheatreSpawnChance*10)
				if RollRand >= 101 then
					containerFilled:AddItem(FAFreshList[FA.PickOne(#FAFreshList)])
					if RollRand >= 121 then
						containerFilled:AddItem(FAFreshList[FA.PickOne(#FAFreshList)])
						if RollRand >= 131 then
							containerFilled:AddItem(FAFreshList[FA.PickOne(#FAFreshList)])
						end
					end
				end
			else
				RollRand = ZombRand(1,100)+(FAFreshTheatreSpawnChance*10)
				if RollRand >= 101 then
					containerFilled:AddItem(FAFreshList[FA.PickOne(#FAFreshList)])
					if RollRand >= 121 then
						containerFilled:AddItem(FAFreshList[FA.PickOne(#FAFreshList)])
					end
				end
				RollRand = ZombRand(1,100)+(FATheatreSpawnChance*10)
				if RollRand >= 101 then
					containerFilled:AddItem(FAPopcornList[FA.PickOne(#FAPopcornList)])
					if RollRand >= 121 then
						containerFilled:AddItem(FAPopcornList[FA.PickOne(#FAPopcornList)])
						if RollRand >= 131 then
							containerFilled:AddItem(FAPopcornList[FA.PickOne(#FAPopcornList)])
						end
					end
				end
				RollRand = ZombRand(1,100)+(FATheatreSpawnChance*10)
				if RollRand >= 101 then
					containerFilled:AddItem(FABaseCandyList[FA.PickOne(#FABaseCandyList)])
					if RollRand >= 121 then
						containerFilled:AddItem(FABaseCandyList[FA.PickOne(#FABaseCandyList)])
						if RollRand >= 131 then
							containerFilled:AddItem(FABaseCandyList[FA.PickOne(#FABaseCandyList)])
						end
					end
				end
			end

		end
	end

	if FABarTapsspawns[roomName] ~= nil and FABarTapsspawns[roomName][containerType] ~= nil then
		if FA.ApplySpawnChance(FABarTapsspawns[roomName][containerType]) then
			local BarTapsObject = nil
			local square = containerFilled:getParent():getSquare()
			for i=1,square:getObjects():size() do
				local thisObject = square:getObjects():get(i-1)
				if thisObject:getSprite() then
					local properties = thisObject:getSprite():getProperties()
					local spr = thisObject:getSprite():getName()  
					local groupName = nil
					if properties ~= nil then
						if properties:Is("GroupName") then
							groupName = properties:Val("GroupName")
						end				
						if groupName == "Bar Tap" then				
							BarTapsObject = thisObject
							break
						end
					end
				end
			end
			if BarTapsObject ~= nil then
				RollRand = ZombRand(1,100)+(FAKegSpawnChance*20)
				if RollRand >= 101 then
					local keg1 = containerFilled:AddItem(FABarTapsKegsList[FA.PickOne(#FABarTapsKegsList)])
					FA.depleteSpawnedKeg(keg1)
					if RollRand >= 121 then
						local keg2 = containerFilled:AddItem(FABarTapsKegsList[FA.PickOne(#FABarTapsKegsList)])
						FA.depleteSpawnedKeg(keg2)
						if RollRand >= 131 then
							local keg3 = containerFilled:AddItem(FABarTapsKegsList[FA.PickOne(#FABarTapsKegsList)])
							FA.depleteSpawnedKeg(keg3)
							if RollRand >= 141 then
								local keg4 = containerFilled:AddItem(FABarTapsKegsList[FA.PickOne(#FABarTapsKegsList)])
								FA.depleteSpawnedKeg(keg4)
							end
						end
					end
				end
			end
		end
	end

	if FASyrupsspawns[roomName] ~= nil and FASyrupsspawns[roomName][containerType] ~= nil then
		if FA.ApplySpawnChance(FASyrupsspawns[roomName][containerType]) then
			local SodaFountainObject = nil
			local square = containerFilled:getParent():getSquare()
			for i=1,square:getObjects():size() do
				local thisObject = square:getObjects():get(i-1)
				if thisObject:getSprite() then
					local properties = thisObject:getSprite():getProperties()
					local spr = thisObject:getSprite():getName()  
					local groupName = nil
					if properties ~= nil then
						if properties:Is("GroupName") then
							groupName = properties:Val("GroupName")
						end				
						if groupName == "Tabletop Soda" then				
							SodaFountainObject = thisObject
							break
						end
					end
				end
			end
			if SodaFountainObject ~= nil then
				RollRand = ZombRand(1,100)+(FASyrupsSpawnChance*20)
				if RollRand >= 101 then
					local addItem1 = containerFilled:AddItem(FASodaFountainSyrupsList[FA.PickOne(#FASodaFountainSyrupsList)])
					FA.depleteSpawnedSyrup(addItem1)
					local addItem2 = containerFilled:AddItem("FunctionalAppliances.FACO2Tank")
					FA.depleteSpawnedTank(addItem2)
					if RollRand >= 121 then
						local addItem3 = containerFilled:AddItem(FASodaFountainSyrupsList[FA.PickOne(#FASodaFountainSyrupsList)])
						FA.depleteSpawnedSyrup(addItem3)
						if RollRand >= 131 then
							local addItem4 = containerFilled:AddItem(FASodaFountainSyrupsList[FA.PickOne(#FASodaFountainSyrupsList)])
							FA.depleteSpawnedSyrup(addItem4)
							if RollRand >= 141 then
								local addItem5 = containerFilled:AddItem(FASodaFountainSyrupsList[FA.PickOne(#FASodaFountainSyrupsList)])
								FA.depleteSpawnedSyrup(addItem5)
							end
						end
					end
				end
			end
		end
	end
end

Events.OnFillContainer.Add(FASpawn)