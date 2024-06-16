package systems;

import flixel.ui.FlxButton;
import flixel.text.FlxBitmapText;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class GameHUD extends FlxTypedGroup<FlxSprite> {
	var materialsButton:FlxButton;
	var craftingButton:FlxButton;

	private var playerInventoryUI:PlayerInventoryUI;

	public function new(playerInventoryUI:PlayerInventoryUI) {
		super();
		// this.playerInventoryUI = playerInventoryUI;

		materialsButton = new FlxButton(0, 0);
		materialsButton.text = "Materials";
		//	materialsButton.y = FlxG.height - materialsButton.height - 100;

		craftingButton = new FlxButton(0, 0, "Crafting");
		craftingButton.x = materialsButton.width + 4;
		//	craftingButton.y = FlxG.height - craftingButton.height - 100;

		add(materialsButton);
		add(craftingButton);

		// forEach(function(sprite) {
		// 	sprite.scrollFactor.set(0, 0);
		// });
	}

	override function update(elapsed:Float) {
		if (materialsButton.justPressed) {
			playerInventoryUI.toggleUI();
		}
	}
}
