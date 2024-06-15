package systems.plants;

import flixel.util.FlxColor;
import flixel.FlxSprite;

// The world representation of the object
class PlantBase extends FlxSprite {
	public function new() {
		super();
		makeGraphic(64, 64, FlxColor.BROWN);
	}
}

class Plant_Rose extends PlantBase {
	public function new() {
		super();
		makeGraphic(64, 64, FlxColor.RED);
	}
}

class Plant_Tulip extends PlantBase {
	public function new() {
		super();
		makeGraphic(64, 64, FlxColor.PURPLE);
	}
}
