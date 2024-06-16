package systems.crafting;

import flixel.util.FlxColor;
import flixel.FlxSprite;

interface ICraftingMaterialDefinition {
	public function getMaterialName():String;
	public function setupMaterialWorldDropGraphic(sprite:FlxSprite):Void;
	public function getMaterialUIGraphic():FlxSprite;
}

class CMPlantEssence implements ICraftingMaterialDefinition {
	public function new() {}

	public function getMaterialName():String {
		return "Plant Essence";
	}

	public function setupMaterialWorldDropGraphic(sprite:FlxSprite):Void {
		sprite.makeGraphic(16, 16, FlxColor.PINK);
		sprite.loadGraphic("assets/images/materials/material_plant_essence.png", true, 16, 16);
		sprite.animation.add("idle", [0, 1, 2, 3, 4], 16);
		sprite.animation.play("idle");
	}

	public function getMaterialUIGraphic():FlxSprite {
		var sprite = new FlxSprite();
		sprite.loadGraphic("assets/images/materials/material_plant_essence.png", true, 16, 16);
		sprite.animation.add("idle", [0, 1, 2, 3, 4], 16);
		sprite.animation.play("idle");
		return sprite;
	}
}

class CMPurpleSurprise implements ICraftingMaterialDefinition {
	public function new() {}

	public function getMaterialName():String {
		return "Purple surprise";
	}

	public function setupMaterialWorldDropGraphic(sprite:FlxSprite):Void {
		sprite.loadGraphic("assets/images/materials/material_purple_surprise.png", true, 16, 16);
		sprite.animation.add("idle", [0, 1, 2, 3, 4], 16);
		sprite.animation.play("idle");
	}

	public function getMaterialUIGraphic():FlxSprite {
		var sprite = new FlxSprite();
		sprite.loadGraphic("assets/images/materials/material_purple_surprise.png", true, 16, 16);
		sprite.animation.add("idle", [0, 1, 2, 3, 4], 16);
		sprite.animation.play("idle");
		return sprite;
	}
}
