package systems.plants;

import systems.crafting.CraftingWorldPickup.CraftingMaterialWorldPickup;
import systems.crafting.CraftingMaterial;
import flixel.util.FlxColor;
import flixel.FlxSprite;

// The world representation of the object
class PlantBase extends FlxSprite {
	private var worldPickupSystem:WorldPickupSystem;

	private var pickupEmitTime:Float;

	public function new(worldPickupSystem:WorldPickupSystem) {
		this.worldPickupSystem = worldPickupSystem;
		super();
		makeGraphic(64, 64, FlxColor.BROWN);
		// scale.x = scale.y = 2;
		pickupEmitTime = getEmitTime();
	}

	// override this to change the emit time
	function getEmitTime():Float {
		return 10;
	}

	function onEmit() {
		pickupEmitTime = getEmitTime();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		pickupEmitTime -= elapsed;
		if (pickupEmitTime <= 0) {
			onEmit();
		}
	}
}

class Plant_Rose extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_flower_rose.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPlantEssence();
		var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
		worldPickupSystem.addWorldPickup(pickup);
	}
}

class Plant_Tulip extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_flower_tulip.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPurpleSurprise();
		var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
		worldPickupSystem.addWorldPickup(pickup);
	}
}

class Plant_OnigiriRed extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/onigiri_bush01.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPlantEssence();
		var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
		worldPickupSystem.addWorldPickup(pickup);
	}
}

class Plant_OnigiriPurple extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/onigiri_bush02.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPurpleSurprise();
		var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
		worldPickupSystem.addWorldPickup(pickup);
	}
}

class Plant_OnigiriDeepPurple extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/onigiri_bush03.png");
	}

	override function getEmitTime():Float {
		return super.getEmitTime() + 2;
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPurpleSurprise();
		for (i in 0...2) {
			var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
			worldPickupSystem.addWorldPickup(pickup);
		}
	}
}

class Plant_ForestFlowerOrange extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_flower_orange.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPlantEssence();
		var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
		worldPickupSystem.addWorldPickup(pickup);
	}
}

class Plant_ForestFlowerPink extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_flower_pink.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPlantEssence();
		var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
		worldPickupSystem.addWorldPickup(pickup);
	}
}

class Plant_ForestFlowerPurple extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_flower_purple.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPurpleSurprise();
		var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
		worldPickupSystem.addWorldPickup(pickup);
	}
}

class Plant_ForestTree01 extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_tree_01.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPurpleSurprise();
		for (i in 0...4) {
			var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
			worldPickupSystem.addWorldPickup(pickup);
		}
	}
}

class Plant_ForestTree02 extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_tree_02.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPlantEssence();
		for (i in 0...5) {
			var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
			worldPickupSystem.addWorldPickup(pickup);
		}
	}
}

class Plant_ForestTree03 extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_tree_03.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPurpleSurprise();
		for (i in 0...6) {
			var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
			worldPickupSystem.addWorldPickup(pickup);
		}
	}
}

class Plant_ForestMushroomPurple extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_mushroom_purple.png");
	}

	override function onEmit() {
		super.onEmit();
		var matInterface = new CMPurpleSurprise();
		var pickup = new CraftingMaterialWorldPickup(matInterface, this.x + width / 2, this.y + height);
		worldPickupSystem.addWorldPickup(pickup);
	}
}

class Plant_ForestMushroomBrown extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_mushroom_brown.png");
	}
}

class Plant_ForestMushroomRed extends PlantBase {
	public function new(worldPickupSystem:WorldPickupSystem) {
		super(worldPickupSystem);
		loadGraphic("assets/images/plants/forest_mushroom_red.png");
	}
}
