package systems.crafting;

import systems.crafting.CraftingMaterial;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;

class CraftingMaterialWorldPickup extends FlxTypedGroup<FlxSprite> {
	private var craftingMaterialDefinition:ICraftingMaterialDefinition;
	private var worldPickupSprite:FlxSprite;

	public function new(materialDefinition:ICraftingMaterialDefinition, x:Float = 0, y:Float = 0) {
		super();
		craftingMaterialDefinition = materialDefinition;
		worldPickupSprite = craftingMaterialDefinition.getMaterialWorldDropGraphic();
		worldPickupSprite.x = x;
		worldPickupSprite.y = y;
		add(worldPickupSprite);
	}
}
