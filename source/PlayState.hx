package;

import flixel.ui.FlxButton;
import systems.ObjectPlacingSystem;
import systems.PlayerInventory;
import systems.PlayerInventoryUI;
import systems.crafting.CraftingWorldPickup.CraftingMaterialWorldPickup;
import systems.WorldPickupSystem;
import systems.GrassSystem;
import flixel.FlxG;
import systems.InputManager;
import systems.World;
import systems.CameraManager;
import systems.GameHUD;
import flixel.FlxState;
import systems.crafting.CraftingSystem;

class PlayState extends FlxState {
	// var gameHUD:GameHUD;
	var cameraManager:CameraManager;
	var world:World;
	var inputManager:InputManager;
	var player:Player;
	var grassSystem:GrassSystem;
	var worldPickupSystem:WorldPickupSystem;
	var inventory:PlayerInventory;
	var playerInventoryUI:PlayerInventoryUI;
	var craftingSystem:CraftingSystem;
	var objectPlacingSystem:ObjectPlacingSystem;

	var craftingButton:FlxButton;

	override public function create():Void {
		super.create();
		// cameraManager = new CameraManager();
		world = new World();
		inputManager = new InputManager();
		objectPlacingSystem = new ObjectPlacingSystem(inputManager, world);
		craftingSystem = new CraftingSystem(world, objectPlacingSystem);
		var grassTuftEmitter = new GrassTuftEmitter();
		worldPickupSystem = new WorldPickupSystem();
		inventory = new PlayerInventory();
		playerInventoryUI = new PlayerInventoryUI(inventory, inputManager, craftingSystem, objectPlacingSystem);
		// gameHUD = new GameHUD(playerInventoryUI);
		grassSystem = new GrassSystem(grassTuftEmitter, worldPickupSystem);
		player = new Player(inputManager, grassSystem);

		// cameraManager.registerWithUICamera(gameHUD);

		// non-visual components/systems
		add(inputManager);
		add(objectPlacingSystem);
		// visible draw-order/dependent systems
		add(world);
		add(player);
		add(grassSystem);
		add(grassTuftEmitter);
		add(worldPickupSystem);
		// add(gameHUD);
		add(playerInventoryUI);

		craftingButton = new FlxButton(0, 0, "Crafting");
		craftingButton.x = 4;
		add(craftingButton);

		grassSystem.populateWorld(world.getTileMap());

		world.getTileMap().follow();
		// FlxG.cameras.follow(player);
		FlxG.camera.follow(player);
		// FlxG.camera.zoom = .25;
		// FlxG.worldBounds.set(0, 0, world.getWidth() * 16, world.getHeight() * 16);

		FlxG.camera.flash();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		FlxG.overlap(player, worldPickupSystem, playerToWorldPickupOverlap);
		if (craftingButton.justPressed) {
			playerInventoryUI.toggleUI();
		}
		worldPickupSystem.attractTowardsPlayer(player, elapsed);
	}

	private function playerToWorldPickupOverlap(a:Player, b:CraftingMaterialWorldPickup):Void {
		if (b.canBeCollected) {
			inventory.addPickup(b.materialDefinition);
			b.kill();
		}
	}
}
