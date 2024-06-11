package systems;

import systems.crafting.CraftingWorldPickup.CraftingMaterialWorldPickup;
import flixel.group.FlxGroup.FlxTypedGroup;

class WorldPickupSystem extends FlxTypedGroup<CraftingMaterialWorldPickup> {
	public function addWorldPickup(pickup:CraftingMaterialWorldPickup) {
		add(pickup);
	}
}
