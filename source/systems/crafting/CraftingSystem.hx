package systems.crafting;

import systems.plants.Craftable;
import systems.plants.PlantBase;

class CraftingSystem {
	private var craftableTypes:Array<ICraftable>;

	private var world:World;
	private var objectPlacingSystem:ObjectPlacingSystem;
	private var worldPickupSystem:WorldPickupSystem;

	public function new(world:World, objectPlacingSystem:ObjectPlacingSystem, worldPickupSystem:WorldPickupSystem) {
		this.world = world;
		this.objectPlacingSystem = objectPlacingSystem;
		this.worldPickupSystem = worldPickupSystem;

		registerAllCraftableTypes();
	}

	private function registerAllCraftableTypes() {
		craftableTypes = new Array<ICraftable>();
		craftableTypes.push(new Craftable_PlantBase());
		craftableTypes.push(new Craftable_Rose());
		craftableTypes.push(new Craftable_Tulip());
		craftableTypes.push(new Craftable_OnigiriRed());
		craftableTypes.push(new Craftable_OnigiriPurple());
		craftableTypes.push(new Craftable_OnigiriDeepPurple());
		craftableTypes.push(new Craftable_ForestFlowerOrange());
		craftableTypes.push(new Craftable_ForestFlowerPink());
		craftableTypes.push(new Craftable_ForestFlowerPurple());
		craftableTypes.push(new Craftable_ForestTree01());
		craftableTypes.push(new Craftable_ForestTree02());
		craftableTypes.push(new Craftable_ForestTree03());
		craftableTypes.push(new Craftable_ForestMushroomPurple());
		craftableTypes.push(new Craftable_ForestMushroomBrown());
		craftableTypes.push(new Craftable_ForestMushroomRed());
	}

	public function getAllCraftableTypes(inventory:PlayerInventory):Array<ICraftable> {
		var retCraftable = new Array<ICraftable>();
		for (craftable in craftableTypes) {
			var reqs = craftable.getBuildRequirements();
			if (inventory.hasMaterialRequirements(reqs)) {
				retCraftable.push(craftable);
			}
		}
		return craftableTypes;
	}

	public function spawnPlantIntoWorld(craftDefinition:ICraftable, inventory:PlayerInventory):PlantBase {
		var requirements = craftDefinition.getBuildRequirements();
		if (inventory.hasMaterialRequirements(requirements)) {
			var plantWorldObject = craftDefinition.generatePlant(worldPickupSystem);
			objectPlacingSystem.attachHeldObject(plantWorldObject);
			world.addPlantToWorld(plantWorldObject);
			return plantWorldObject;
		}
		return null;
	}
}
