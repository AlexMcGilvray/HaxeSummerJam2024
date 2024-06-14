package systems;

import systems.crafting.CraftingMaterial.ICraftingMaterialDefinition;

class PlayerInventory {
	private var worldPickups:Map<String, Array<ICraftingMaterialDefinition>>;

	public function new() {
		worldPickups = new Map<String, Array<ICraftingMaterialDefinition>>();
	}

	// checks to see if we have adequate materials to satisfy the query.
	public function hasMaterialRequirements(requirements:Map<String, Array<ICraftingMaterialDefinition>>):Bool {
		for (key in requirements.keys()) {
			if (worldPickups.exists(key)) {
				var numRequired = requirements[key].length;
				var numOwned = worldPickups[key].length;
				if (numRequired > numOwned) {
					return false;
				}
			} else {
				return false;
			}
		}
		return true;
	}

	public function subtractMaterials(requirements:Map<String, Array<ICraftingMaterialDefinition>>) {
		if (!hasMaterialRequirements(requirements)) {
			// todo error throw or something (read haxe docs on idiomatic error handling)
			trace("doesn't have adequate resources to subtract from inventory. Code isn't doing adequate checks.");
			return;
		}
		for (key in requirements.keys()) {
			var requirementLength = requirements[key].length;
			// shouldn't need to do a check since this should get caught in the hasMaterialRequirements call
			worldPickups[key].resize(worldPickups[key].length - requirementLength);
		}
	}

	public function getWorldPickups():Map<String, Array<ICraftingMaterialDefinition>> {
		return worldPickups;
	}

	public function addPickup(pickup:ICraftingMaterialDefinition) {
		if (!worldPickups.exists(pickup.getMaterialName())) {
			worldPickups[pickup.getMaterialName()] = new Array<ICraftingMaterialDefinition>();
		}
		worldPickups[pickup.getMaterialName()].push(pickup);
	}
}
