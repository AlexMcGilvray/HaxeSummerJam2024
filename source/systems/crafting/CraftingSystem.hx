package systems.crafting;

import systems.plants.Craftable;
import systems.plants.PlantBase;

class CraftingSystem {
	private var world:World;
	private var craftableTypes:Array<ICraftable>;

	public function new(world:World) {
		this.world = world;
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
			if (inventory.hasMaterialRequirements(craftable.getBuildRequirements())) {
				retCraftable.push(craftable);
			}
		}
		return craftableTypes;
	}

	public function spawnPlantIntoWorld(craftDefinition:ICraftable, inventory:PlayerInventory):PlantBase {
		var requirements = craftDefinition.getBuildRequirements();
		if (inventory.hasMaterialRequirements(requirements)) {
			inventory.subtractMaterials(requirements);
			var plantWorldObject = craftDefinition.generatePlant();
			plantWorldObject.x = 100; // temp
			plantWorldObject.y = 100; // temp
			world.addPlantToWorld(plantWorldObject);
			return plantWorldObject;
		}
		return null; // todo fix this bad return value
	}
}
