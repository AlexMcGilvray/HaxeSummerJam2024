package systems;

import systems.plants.Craftable.ICraftable;
import flixel.ui.FlxButton;
import systems.crafting.CraftingSystem;
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.util.FlxColor;
import flixel.text.FlxBitmapText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class MaterialTextPair {
	public var description:FlxBitmapText;
	public var value:FlxBitmapText;

	public function new(description:FlxBitmapText, value:FlxBitmapText) {
		this.description = description;
		this.value = value;
	}
}

class CraftingUI extends FlxTypedGroup<FlxSprite> {
	private var playerInventory:PlayerInventory;
	private var inputMangager:InputManager;

	private var background:FlxSprite;

	private var craftingSystem:CraftingSystem;
	private var craftingButtons:Map<ICraftable, FlxButton>;
	var buttonCountMultiplier = 1;

	public function new(playerInventory:PlayerInventory, inputMangager:InputManager, craftingSystem:CraftingSystem) {
		super();

		this.playerInventory = playerInventory;
		this.inputMangager = inputMangager;
		this.craftingSystem = craftingSystem;

		craftingButtons = new Map<ICraftable, FlxButton>();

		var yStart = 10;
		var bgWidth = 300;
		var bgMargin = 10;
		var yStartWPadding = yStart + 10;
		var xStartWPadding = FlxG.width - bgWidth - bgMargin;

		background = new FlxSprite(xStartWPadding, yStart);
		background.makeGraphic(250, 200, FlxColor.GRAY);
		background.scrollFactor.x = 0;
		background.scrollFactor.y = 0;

		add(background);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		var yStart = 10;
		var bgWidth = 300;
		var bgMargin = 10;
		var yStartWPadding = yStart + 10;
		var xStartWPadding = FlxG.width - bgWidth - bgMargin;
		// garbage implementation for now
		for (key in craftingButtons.keys()) {
			if (craftingButtons[key].justPressed) {
				craftingSystem.spawnPlantIntoWorld(key, playerInventory);
			}
		}

		function generateButtons() {
			var buttonStride = 20;
			for (item in craftingSystem.getAllCraftableTypes(playerInventory)) {
				if (!craftingButtons.exists(item)) {
					var button = new FlxButton(xStartWPadding, yStartWPadding + buttonCountMultiplier * buttonStride);
					craftingButtons.set(item, button);
					add(button);
					buttonCountMultiplier++;
				}
			}
		}
		generateButtons();
	}
}

class PlayerInventoryUI extends FlxTypedGroup<FlxBasic> {
	private var items:Map<String, MaterialTextPair>;
	private var inventoryNote:FlxBitmapText;
	private var background:FlxSprite;

	private var craftingUI:CraftingUI;

	private var playerInventory:PlayerInventory;
	private var inputMangager:InputManager;

	var itemYOffset = 12;

	public function new(playerInventory:PlayerInventory, inputMangager:InputManager, craftingSystem:CraftingSystem) {
		super();

		this.playerInventory = playerInventory;
		this.inputMangager = inputMangager;

		craftingUI = new CraftingUI(playerInventory, inputMangager, craftingSystem);
		craftingUI.visible = false;

		items = new Map<String, MaterialTextPair>();

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
		add(craftingUI);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		// enable/disable the crafting materials list ui
		if (inputMangager.digitalButton2PressedThisFrame) {
			visible = !visible;
			craftingUI.visible = visible;
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
				var numWorldPickups = worldPickups[key].count;
				items[key].description.text = key;
				items[key].value.text = "" + numWorldPickups;
			} else {
				var descriptionText = new FlxBitmapText(16, 24 + getMapSize() * itemYOffset, key);
				var valueText = new FlxBitmapText(140, 24 + getMapSize() * itemYOffset, "1");
				var pair = new MaterialTextPair(descriptionText, valueText);

				items.set(key, pair);

				descriptionText.scale.x = 1.5;
				descriptionText.scale.y = 1.5;
				descriptionText.scrollFactor.x = 0;
				descriptionText.scrollFactor.y = 0;

				valueText.scale.x = 1.5;
				valueText.scale.y = 1.5;
				valueText.scrollFactor.x = 0;
				valueText.scrollFactor.y = 0;

				add(descriptionText);
				add(valueText);
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
