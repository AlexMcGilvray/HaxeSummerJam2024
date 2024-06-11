package systems;

import systems.crafting.CraftingMaterial.ICraftingMaterialDefinition;

class PlayerInventory {
	private var worldPickups:Map<String, Array<ICraftingMaterialDefinition>>;

	public function new() {
		worldPickups = new Map<String, Array<ICraftingMaterialDefinition>>();
	}

	public function addPickup(pickup:ICraftingMaterialDefinition) {
		if (!worldPickups.exists(pickup.getMaterialName())) {
			worldPickups[pickup.getMaterialName()] = new Array<ICraftingMaterialDefinition>();
		}
		worldPickups[pickup.getMaterialName()].push(pickup);
	}
}
