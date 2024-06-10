package;

import systems.CameraManager;
import systems.GameHUD;
import flixel.FlxState;

class PlayState extends FlxState {
	var gameHUD:GameHUD;
	var cameraManager:CameraManager;

	override public function create():Void {
		super.create();
		cameraManager = new CameraManager();
		gameHUD = new GameHUD();

		cameraManager.registerWithUICamera(gameHUD);

		add(gameHUD);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
}
