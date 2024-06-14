package systems.plants;

import systems.plants.PlantBase.Plant_Tulip;
import systems.plants.PlantBase.Plant_Rose;
import flixel.util.FlxColor;
import systems.crafting.CraftingMaterial.ICraftingMaterialDefinition;
import flixel.FlxSprite;

interface ICraftable {
	public function getBuildRequirements():Map<String, Int>;
	public function generatePlant():PlantBase;
}

class Craftable_PlantBase implements ICraftable {
	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Array<ICraftingMaterialDefinition>>();

		// requirements.set()
		throw new haxe.exceptions.NotImplementedException();
	}

	public function generatePlant():PlantBase
		return new PlantBase();
}

class Craftable_Rose implements ICraftable {
	public function getBuildRequirements():Map<String, Int> {
		throw new haxe.exceptions.NotImplementedException();
	}

	public function generatePlant():PlantBase
		return new Plant_Rose();
}

class Craftable_Tulip implements ICraftable {
	public function getBuildRequirements():Map<String, Int> {
		throw new haxe.exceptions.NotImplementedException();
	}

	public function generatePlant():PlantBase
		return new Plant_Tulip();
}
