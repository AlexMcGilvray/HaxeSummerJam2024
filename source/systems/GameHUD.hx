package systems;

import flixel.text.FlxBitmapText;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class GameHUD extends FlxTypedGroup<FlxSprite> {
	var testText:FlxBitmapText;

	public function new() {
		super();
		testText = new FlxBitmapText(10, 10, "Testing out a new project");
		// add(testText);

		forEach(function(sprite) {
			sprite.scrollFactor.set(0, 0);
		});
	}

	override function update(elapsed:Float) {}
}
