package;

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
	var gameHUD:GameHUD;
	var cameraManager:CameraManager;
	var world:World;
	var inputManager:InputManager;
	var player:Player;
	var grassSystem:GrassSystem;
	var worldPickupSystem:WorldPickupSystem;
	var inventory:PlayerInventory;
	var playerInventoryUI:PlayerInventoryUI;
	var craftingSystem:CraftingSystem;

	override public function create():Void {
		super.create();
		// cameraManager = new CameraManager();
		gameHUD = new GameHUD();
		world = new World();
		inputManager = new InputManager();
		craftingSystem = new CraftingSystem(world);
		var grassTuftEmitter = new GrassTuftEmitter();
		worldPickupSystem = new WorldPickupSystem();
		inventory = new PlayerInventory();
		playerInventoryUI = new PlayerInventoryUI(inventory, inputManager, craftingSystem);
		grassSystem = new GrassSystem(grassTuftEmitter, worldPickupSystem);
		player = new Player(inputManager, grassSystem);

		// cameraManager.registerWithUICamera(gameHUD);

		// non-visual components/systems
		add(inputManager);
		// visible draw-order/dependent systems
		add(world);
		add(player);
		add(grassSystem);
		add(grassTuftEmitter);
		add(worldPickupSystem);
		add(gameHUD);
		add(playerInventoryUI);

		grassSystem.populateWorld(world.getTileMap());

		world.getTileMap().follow();
		// FlxG.cameras.follow(player);
		FlxG.camera.follow(player);
		// FlxG.camera.zoom = .25;
		// FlxG.worldBounds.set(0, 0, world.getWidth() * 16, world.getHeight() * 16);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		FlxG.overlap(player, worldPickupSystem, playerToWorldPickupOverlap);
	}

	private function playerToWorldPickupOverlap(a:Player, b:CraftingMaterialWorldPickup):Void {
		if (b.canBeCollected) {
			inventory.addPickup(b.materialDefinition);
			b.kill();
		}
	}
}
