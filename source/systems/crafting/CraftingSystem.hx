package systems.crafting;

import systems.plants.PlantBase;

class CraftingSystem {
	private var world:World;

	public function new(world:World) {
		this.world = world;
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
