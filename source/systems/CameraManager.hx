package systems;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;

class CameraManager {
	private var uiCamera(default, null):FlxCamera;
	private var mainCamera(default, null):FlxCamera;

	public function new() {
		initCameras();
	}

	public function initCameras() {
		uiCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		uiCamera.bgColor = 0x00000000;
		FlxG.cameras.add(uiCamera, false);
	}

	public function registerWithUICamera(item:FlxBasic) {
		item.camera = uiCamera;
	}
}
