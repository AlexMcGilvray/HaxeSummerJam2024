package systems;

import flixel.util.FlxColor;
import flixel.text.FlxBitmapText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayerInventoryUI extends FlxTypedGroup<FlxSprite> {
	private var items:Map<String, FlxBitmapText>;
	private var playerInventory:PlayerInventory;
	private var inventoryNote:FlxBitmapText;
	private var background:FlxSprite;
	private var inputMangager:InputManager;

	var itemYOffset = 12;

	public function new(playerInventory:PlayerInventory, inputMangager:InputManager) {
		super();

		this.playerInventory = playerInventory;
		this.inputMangager = inputMangager;

		items = new Map<String, FlxBitmapText>();

		background = new FlxSprite(10, 10);
		background.scrollFactor.x = 0;
		background.scrollFactor.y = 0;
		background.visible = false;

		inventoryNote = new FlxBitmapText(0, 0, "Press the F key or the B button to toggle this menu.");
		inventoryNote.scrollFactor.x = 0;
		inventoryNote.scrollFactor.y = 0;
		inventoryNote.visible = false;

		add(background);
		add(inventoryNote);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		// enable/disable the crafting materials list ui
		if (inputMangager.digitalButton2PressedThisFrame) {
			visible = !visible;
		}

		function getMapSize():Int {
			var count = 0;
			for (i in items.keys()) {
				count++;
			}
			return count;
		}

		// don't bother drawing if we don't have any materials
		var worldPickups = playerInventory.getWorldPickups();
		if (!worldPickups.keys().hasNext()) {
			return;
		}

		// very inefficient way to redraw the inventory list but hey.. this is a game jam :p
		for (key in worldPickups.keys()) {
			if (items.exists(key)) {
				var s = worldPickups[key].length;
				items[key].text = key + " " + s;
			} else {
				var newText = new FlxBitmapText(16, 24 + getMapSize() * itemYOffset, key + " 1");
				items.set(key, newText);
				add(newText);
				newText.scrollFactor.x = 0;
				newText.scrollFactor.y = 0;
			}
		}

		// add message on how to close menu to bottom
		inventoryNote.x = 16;
		inventoryNote.y = 24 + (getMapSize() + 1) * itemYOffset;
		inventoryNote.visible = true;

		// size background to match content, also very wasteful/inefficient
		var mapSize = getMapSize();
		if (getMapSize() > 0) {
			background.visible = true;
			var backgroundSizeTarget = mapSize * itemYOffset + itemYOffset * 3; // 2 for margin, 1 for the tutorial string
			if (backgroundSizeTarget != background.height) {
				background.makeGraphic(250, backgroundSizeTarget, FlxColor.GRAY);
			}
		} else {
			background.visible = false;
		}
	}
}
