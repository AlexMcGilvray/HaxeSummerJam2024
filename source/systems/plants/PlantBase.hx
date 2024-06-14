package systems.plants;

import flixel.util.FlxColor;
import systems.crafting.CraftingMaterial.ICraftingMaterialDefinition;
import flixel.FlxSprite;

interface ICraftable {
	public function getBuildRequirements():Map<String, Array<ICraftingMaterialDefinition>>;
	public function generatePlant():PlantBase;
}

class Craftable_PlantBase implements ICraftable {
	public function getBuildRequirements():Map<String, Array<ICraftingMaterialDefinition>> {
		throw new haxe.exceptions.NotImplementedException();
	}

	public function generatePlant():PlantBase
		return new PlantBase();
}

// The world representation of the object
class PlantBase extends FlxSprite {
	public function new() {
		super();
		makeGraphic(64, 64, FlxColor.BROWN);
	}
}
