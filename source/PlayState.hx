package;

import systems.World;
import systems.CameraManager;
import systems.GameHUD;
import flixel.FlxState;

class PlayState extends FlxState {
	var gameHUD:GameHUD;
	var cameraManager:CameraManager;
	var world:World;

	override public function create():Void {
		super.create();
		cameraManager = new CameraManager();
		gameHUD = new GameHUD();
		world = new World();

		cameraManager.registerWithUICamera(gameHUD);

		add(world);
		add(gameHUD);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
