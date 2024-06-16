package;

import flixel.FlxCamera;
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
	var objectPlacingSystem:ObjectPlacingSystem;

	var craftingButton:FlxButton;

	override public function create():Void {
		super.create();

		cameraManager = new CameraManager();
		world = new World();
		inputManager = new InputManager();
		worldPickupSystem = new WorldPickupSystem();
		inventory = new PlayerInventory();
		var grassTuftEmitter = new GrassTuftEmitter();
		objectPlacingSystem = new ObjectPlacingSystem(inputManager, world);
		craftingSystem = new CraftingSystem(world, objectPlacingSystem, worldPickupSystem);
		playerInventoryUI = new PlayerInventoryUI(inventory, inputManager, craftingSystem, objectPlacingSystem);
		gameHUD = new GameHUD(playerInventoryUI, cameraManager);
		grassSystem = new GrassSystem(grassTuftEmitter, worldPickupSystem);
		player = new Player(inputManager, grassSystem);

		cameraManager.registerWithUICamera(gameHUD);
		cameraManager.registerWithUICamera(playerInventoryUI);

		// non-visual components/systems
		add(inputManager);
		add(objectPlacingSystem);
		add(cameraManager);
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
		FlxG.camera.follow(player);

		FlxG.camera.flash();

		FlxG.sound.playMusic("assets/music/main_music.ogg");
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		FlxG.overlap(player, worldPickupSystem, playerToWorldPickupOverlap);
		worldPickupSystem.attractTowardsPlayer(player, elapsed);
	}

	private function playerToWorldPickupOverlap(a:Player, b:CraftingMaterialWorldPickup):Void {
		if (b.canBeCollected) {
			inventory.addPickup(b.materialDefinition);
			b.kill();
		}
	}
}
