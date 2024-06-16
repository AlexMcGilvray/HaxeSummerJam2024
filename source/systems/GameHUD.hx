package systems;

import flixel.group.FlxContainer.FlxTypedContainer;
import flixel.ui.FlxButton;
import flixel.text.FlxBitmapText;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class GameHUD extends FlxTypedContainer<FlxSprite> {
	var craftingButton:FlxButton;
	var zoom1X:FlxButton;
	var zoom2X:FlxButton;
	var zoom4X:FlxButton;

	private var playerInventoryUI:PlayerInventoryUI;
	private var cameraManager:CameraManager;

	public function new(playerInventoryUI:PlayerInventoryUI, cameraManager:CameraManager) {
		super();

		this.playerInventoryUI = playerInventoryUI;
		this.cameraManager = cameraManager;

		craftingButton = new FlxButton(0, 0);
		craftingButton.text = "Crafting";

		zoom1X = new FlxButton(0, 0);
		zoom1X.text = "1X";

		zoom2X = new FlxButton(0, 0);
		zoom2X.text = "2X";

		zoom4X = new FlxButton(0, 0);
		zoom4X.text = "4X";

		zoom1X.x = FlxG.width - zoom1X.width * 3;
		zoom2X.x = FlxG.width - zoom1X.width * 2;
		zoom4X.x = FlxG.width - zoom1X.width;

		add(craftingButton);
		add(zoom1X);
		add(zoom2X);
		add(zoom4X);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (craftingButton.justPressed) {
			playerInventoryUI.toggleUI();
		}
		if (zoom1X.justPressed) {
			cameraManager.setZoomLevel(1);
		}
		if (zoom2X.justPressed) {
			cameraManager.setZoomLevel(2);
		}
		if (zoom4X.justPressed) {
			cameraManager.setZoomLevel(4);
		}
	}
}
