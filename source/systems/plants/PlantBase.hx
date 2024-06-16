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

class Plant_OnigiriRed extends PlantBase {
	public function new() {
		super();
		loadGraphic("assets/images/plants/onigiri_bush01.png");
	}
}

class Plant_OnigiriPurple extends PlantBase {
	public function new() {
		super();
		loadGraphic("assets/images/plants/onigiri_bush02.png");
	}
}

class Plant_OnigiriDeepPurple extends PlantBase {
	public function new() {
		super();
		loadGraphic("assets/images/plants/onigiri_bush03.png");
	}
}

class Plant_ForestFlowerOrange extends PlantBase {
	public function new() {
		super();
		loadGraphic("assets/images/plants/forest_flower_orange.png");
	}
}

class Plant_ForestFlowerPink extends PlantBase {
	public function new() {
		super();
		loadGraphic("assets/images/plants/forest_flower_pink.png");
	}
}

class Plant_ForestFlowerPurple extends PlantBase {
	public function new() {
		super();
		loadGraphic("assets/images/plants/forest_flower_purple.png");
	}
}

class Plant_ForestTree01 extends PlantBase {
	public function new() {
		super();
		loadGraphic("assets/images/plants/forest_tree_01.png");
	}
}
