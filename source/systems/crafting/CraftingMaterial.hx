package systems.crafting;

import flixel.util.FlxColor;
import flixel.FlxSprite;

interface ICraftingMaterialDefinition {
	public function getMaterialName():String;
	public function setupMaterialWorldDropGraphic(sprite:FlxSprite):Void;
	public function getMaterialUIGraphic():FlxSprite;
}

class CMPlantEssence implements ICraftingMaterialDefinition {
	public function new() {} // could make the argument these interfaces could be static?

	public function getMaterialName():String {
		return "Plant Essence";
	}

	public function setupMaterialWorldDropGraphic(sprite:FlxSprite):Void {
		sprite.makeGraphic(16, 16, FlxColor.PINK);
	}

	public function getMaterialUIGraphic():FlxSprite {
		var sprite = new FlxSprite();
		sprite.makeGraphic(16, 16, FlxColor.PINK);
		return sprite;
	}
}

class CMPlantEssenceX implements ICraftingMaterialDefinition {
	public function new() {} // could make the argument these interfaces could be static?

	public function getMaterialName():String {
		return "Purple surprise";
	}

	public function setupMaterialWorldDropGraphic(sprite:FlxSprite):Void {
		sprite.makeGraphic(16, 16, FlxColor.PURPLE);
	}

	public function getMaterialUIGraphic():FlxSprite {
		var sprite = new FlxSprite();
		sprite.makeGraphic(16, 16, FlxColor.PURPLE);
		return sprite;
	}
}
