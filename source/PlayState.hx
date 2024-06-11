package;

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

	override public function create():Void {
		super.create();
		cameraManager = new CameraManager();
		gameHUD = new GameHUD();
		world = new World();
		inputManager = new InputManager();
		player = new Player(inputManager);

		cameraManager.registerWithUICamera(gameHUD);

		// non-visual components/systems
		add(inputManager);
		// visible draw-order/dependent systems
		add(world);
		add(player);
		add(gameHUD);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
