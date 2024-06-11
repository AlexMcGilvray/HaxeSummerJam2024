package;

import systems.GrassSystem;
import flixel.FlxG;
import systems.InputManager;
import systems.World;
import systems.CameraManager;
import systems.GameHUD;
import flixel.FlxState;

class PlayState extends FlxState {
	var gameHUD:GameHUD;
	var cameraManager:CameraManager;
	var world:World;
	var inputManager:InputManager;
	var player:Player;
	var grassSystem:GrassSystem;

	override public function create():Void {
		super.create();
		// cameraManager = new CameraManager();
		gameHUD = new GameHUD();
		world = new World();
		inputManager = new InputManager();
		var grassTuftEmitter = new GrassTuftEmitter();
		grassSystem = new GrassSystem(grassTuftEmitter);
		player = new Player(inputManager, grassSystem);

		// cameraManager.registerWithUICamera(gameHUD);

		// non-visual components/systems
		add(inputManager);
		// visible draw-order/dependent systems
		add(world);
		add(player);
		add(grassSystem);
		add(grassTuftEmitter);
		add(gameHUD);

		grassSystem.populateWorld(world.getTileMap());

		world.getTileMap().follow();
		// FlxG.cameras.follow(player);
		FlxG.camera.follow(player);
		// FlxG.camera.zoom = .25;
		// FlxG.worldBounds.set(0, 0, world.getWidth() * 16, world.getHeight() * 16);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
