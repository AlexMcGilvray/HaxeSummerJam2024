package systems.crafting;

import systems.plants.Craftable.ICraftable;
import systems.plants.PlantBase;

class CraftingSystem {
	private var world:World;
	private var craftableTypes:Array<ICraftable>;

	public function new(world:World) {
		this.world = world;
	}

	private function registerAllCraftableTypes() {
		craftableTypes = new Array<ICraftable>();
	}

	public function spawnPlantIntoWorld(craftDefinition:ICraftable, inventory:PlayerInventory):PlantBase {
		var requirements = craftDefinition.getBuildRequirements();
		if (inventory.hasMaterialRequirements(requirements)) {
			inventory.subtractMaterials(requirements);
			var plantWorldObject = craftDefinition.generatePlant();
			world.addPlantToWorld(plantWorldObject);
			return plantWorldObject;
		}
		return null; // todo fix this
	}
}
