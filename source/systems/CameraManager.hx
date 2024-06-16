package systems;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;

class CameraManager extends FlxBasic {
	private var uiCamera(default, null):FlxCamera;
	private var mainCamera(default, null):FlxCamera;

	private var currentZoomLevel = 1.0;
	private var targetZoomLevel = 1.0;
	private var zoomSpeed = 10.0;

	public function new() {
		super();
		initCameras();
	}

	public function initCameras() {
		mainCamera = FlxG.camera;
		uiCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		uiCamera.bgColor = 0x00000000;
		FlxG.cameras.add(uiCamera, false);
	}

	public function registerWithUICamera(item:FlxBasic) {
		item.camera = uiCamera;
	}

	public function setZoomLevel(zoom:Float, zoomSpeed:Float = 0.5) {
		targetZoomLevel = zoom;
		this.zoomSpeed = zoomSpeed;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (Math.abs(currentZoomLevel - targetZoomLevel) > 0.001) {
			if (targetZoomLevel > currentZoomLevel) {
				currentZoomLevel += zoomSpeed * elapsed;
			} else {
				currentZoomLevel -= zoomSpeed * elapsed;
			}
			mainCamera.zoom = currentZoomLevel;
		}
	}
}
