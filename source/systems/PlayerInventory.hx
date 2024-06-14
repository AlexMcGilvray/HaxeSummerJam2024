package systems;

import systems.crafting.CraftingMaterial.ICraftingMaterialDefinition;

class PlayerInventoryWorldPickupValuePair {
	public function new(def:ICraftingMaterialDefinition, val:Int = 1) {
		definition = def;
		count = val;
	}

	public var definition:ICraftingMaterialDefinition;
	public var count:Int = 0;
}

class PlayerInventory {
	private var worldPickups:Map<String, PlayerInventoryWorldPickupValuePair>;

	public function new() {
		worldPickups = new Map<String, PlayerInventoryWorldPickupValuePair>();
	}

	// checks to see if we have adequate materials to satisfy the query.
	public function hasMaterialRequirements(requirements:Map<String, Int>):Bool {
		for (key in requirements.keys()) {
			if (worldPickups.exists(key)) {
				var numRequired = requirements[key];
				var numOwned = worldPickups[key].count;
				if (numRequired > numOwned) {
					return false;
				}
			} else {
				return false;
			}
		}
		return true;
	}

	// public function subtractMaterials2(requirements:Map<String, PlayerInventoryWorldPickupValuePair>) {
	// 	if (!hasMaterialRequirements(requirements)) {
	// 		// todo error throw or something (read haxe docs on idiomatic error handling)
	// 		trace("doesn't have adequate resources to subtract from inventory. Code isn't doing adequate checks.");
	// 		return;
	// 	}
	// 	for (key in requirements.keys()) {
	// 		// shouldn't need to do a check since this should get caught in the hasMaterialRequirements call
	// 		worldPickups[key].count = worldPickups[key].count - requirements[key].count;
	// 	}
	// }

	public function subtractMaterials(requirements:Map<String, Int>) {
		if (!hasMaterialRequirements(requirements)) {
			// todo error throw or something (read haxe docs on idiomatic error handling)
			trace("doesn't have adequate resources to subtract from inventory. Code isn't doing adequate checks.");
			return;
		}
		for (key in requirements.keys()) {
			// shouldn't need to do a check since this should get caught in the hasMaterialRequirements call
			worldPickups[key].count = worldPickups[key].count - requirements[key];
		}
	}

	public function getWorldPickups():Map<String, PlayerInventoryWorldPickupValuePair> {
		return worldPickups;
	}

	public function addPickup(pickup:ICraftingMaterialDefinition) {
		if (worldPickups.exists(pickup.getMaterialName())) {
			worldPickups[pickup.getMaterialName()].count += 1;
			return;
		}
		worldPickups.set(pickup.getMaterialName(), new PlayerInventoryWorldPickupValuePair(pickup, 1));
	}
}
