package systems;

import flixel.util.FlxColor;
import flixel.text.FlxBitmapText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayerInventoryUI extends FlxTypedGroup<FlxSprite> {
	private var items:Map<String, FlxBitmapText>;
	private var playerInventory:PlayerInventory;
	private var background:FlxSprite;

	var itemYOffset = 12;

	public function new(playerInventory:PlayerInventory) {
		super();
		this.playerInventory = playerInventory;
		items = new Map<String, FlxBitmapText>();
		background = new FlxSprite(10, 10);
		background.scrollFactor.x = 0;
		background.scrollFactor.y = 0;
		add(background);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		var stuff = playerInventory.getWorldPickups();

		function getMapSize():Int {
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
				var newText = new FlxBitmapText(10, 24 + getMapSize() * itemYOffset, key + " 1");
				items.set(key, newText);
				add(newText);
				newText.scrollFactor.x = 0;
				newText.scrollFactor.y = 0;
			}
		}

		var mapSize = getMapSize();
		if (getMapSize() > 0) {
			background.visible = true;
			var backgroundSizeTarget = mapSize * itemYOffset + itemYOffset * 2;
			if (backgroundSizeTarget != background.height) {
				background.makeGraphic(300, backgroundSizeTarget, FlxColor.GRAY);
			}
		} else {
			background.visible = true;
		}
	}
}
