package systems;

import flixel.text.FlxBitmapText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayerInventoryUI extends FlxTypedGroup<FlxSprite> {
	private var items:Map<String, FlxBitmapText>;
	private var playerInventory:PlayerInventory;

	var itemYOffset = 12;

	public function new(playerInventory:PlayerInventory) {
		super();
		this.playerInventory = playerInventory;
		items = new Map<String, FlxBitmapText>();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		var stuff = playerInventory.getWorldPickups();

		function getMapSize() {
			var count = 0;
			for (i in items.keys()) {
				count++;
			}
			return count;
		}

		for (key in stuff.keys()) {
			if (items.exists(key)) {
				var s = stuff[key].length;
				items[key].text = key + " " + s;
			} else {
				var newText = new FlxBitmapText(10, 10 + getMapSize() * itemYOffset, key + " 1");
				items.set(key, newText);
				add(newText);
				newText.scrollFactor.x = 0;
				newText.scrollFactor.y = 0;
			}
		}
	}
}
