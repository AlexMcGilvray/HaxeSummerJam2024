package systems;

import flixel.text.FlxText.FlxTextAlign;
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
	private var background:FlxSprite;

	private var playerInventory:PlayerInventory;
	private var inputMangager:InputManager;
	private var craftingSystem:CraftingSystem;
	private var objectPlacingSystem:ObjectPlacingSystem;

	private var craftingButtons:Map<ICraftable, FlxButton>;
	private var labels:Array<FlxBitmapText>;
	var buttonCountMultiplier = 1;

	public function new(playerInventory:PlayerInventory, inputMangager:InputManager, craftingSystem:CraftingSystem, objectPlacingSystem:ObjectPlacingSystem) {
		super();

		this.playerInventory = playerInventory;
		this.inputMangager = inputMangager;
		this.craftingSystem = craftingSystem;
		this.objectPlacingSystem = objectPlacingSystem;

		craftingButtons = new Map<ICraftable, FlxButton>();
		labels = new Array<FlxBitmapText>();

		var yStart = 10;
		var bgWidth = 250;
		var bgMargin = 10;
		var yStartWPadding = yStart + 10;
		var xStartWPadding = FlxG.width - bgWidth - bgMargin;

		background = new FlxSprite(xStartWPadding, yStart);
		background.makeGraphic(bgWidth + bgMargin, 400, FlxColor.GRAY);
		background.scrollFactor.x = 0;
		background.scrollFactor.y = 0;

		add(background);
	}

	function clearAllCraftingButtons() // todo implement me
	{
		for (button in craftingButtons) {
			button.kill();
		}
		craftingButtons.clear();
		for (label in labels) {
			label.kill();
		}
		labels.resize(0);
		buttonCountMultiplier = 1;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		var yStart = 10;
		var bgWidth = 250;
		var bgMargin = 10;
		var yStartWPadding = yStart + 10;
		var xStartWPadding = FlxG.width - bgWidth - bgMargin;
		// garbage implementation for now
		if (!objectPlacingSystem.isHoldingObject && visible) {
			for (key in craftingButtons.keys()) {
				if (craftingButtons[key].justPressed) {
					if (craftingSystem.spawnPlantIntoWorld(key, playerInventory) != null) {
						var requirements = key.getBuildRequirements();
						playerInventory.subtractMaterials(requirements);
						clearAllCraftingButtons();
						break; // important because clearAllCraftingButtons modifies craftingButtons during iteration
					}
				}
			}
		}

		function generateButtons() {
			var buttonStride = 20;
			for (item in craftingSystem.getAllCraftableTypes(playerInventory)) {
				if (!craftingButtons.exists(item) && playerInventory.hasMaterialRequirements(item.getBuildRequirements())) {
					var button = new FlxButton(xStartWPadding, yStartWPadding + buttonCountMultiplier * buttonStride);
					// button.text = item.getName();
					button.text = "Craft";
					// button.label.fieldWidth *= 2;
					// button.label.alignment = FlxTextAlign.LEFT;
					// button.scale.x = 2;
					// button.width *= 2;
					// button.height *= 2;
					add(button);
					craftingButtons.set(item, button);

					var label = new FlxBitmapText(xStartWPadding + button.width, yStartWPadding + buttonCountMultiplier * buttonStride);
					label.text = item.getName();
					label.scrollFactor.x = label.scrollFactor.y = 0;
					label.scale.x = label.scale.y = 1.5;
					label.y += 6;
					add(label);
					labels.push(label);

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
	private var objectPlacingSystem:ObjectPlacingSystem;

	var itemYOffset = 12;

	public function new(playerInventory:PlayerInventory, inputMangager:InputManager, craftingSystem:CraftingSystem, objectPlacingSystem:ObjectPlacingSystem) {
		super();

		this.playerInventory = playerInventory;
		this.inputMangager = inputMangager;
		this.objectPlacingSystem = objectPlacingSystem;

		craftingUI = new CraftingUI(playerInventory, inputMangager, craftingSystem, objectPlacingSystem);
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

	public function toggleUI() {
		visible = !visible;
		craftingUI.visible = visible;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		// enable/disable the crafting materials list ui
		if (inputMangager.digitalButton2PressedThisFrame) {
			toggleUI();
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
