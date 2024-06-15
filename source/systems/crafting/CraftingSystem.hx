package systems.crafting;

import systems.plants.Craftable;
import systems.plants.PlantBase;

class CraftingSystem {
	private var world:World;
	private var craftableTypes:Array<ICraftable>;
	private var objectPlacingSystem:ObjectPlacingSystem;

	public function new(world:World, objectPlacingSystem:ObjectPlacingSystem) {
		this.world = world;
		this.objectPlacingSystem = objectPlacingSystem;
		registerAllCraftableTypes();
	}

	private function registerAllCraftableTypes() {
		craftableTypes = new Array<ICraftable>();
		craftableTypes.push(new Craftable_PlantBase());
		craftableTypes.push(new Craftable_Rose());
		craftableTypes.push(new Craftable_Tulip());
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
			var plantWorldObject = craftDefinition.generatePlant();
			objectPlacingSystem.attachHeldObject(plantWorldObject);
			world.addPlantToWorld(plantWorldObject);
			return plantWorldObject;
		}
		return null; // todo fix this bad return value
	}
}
