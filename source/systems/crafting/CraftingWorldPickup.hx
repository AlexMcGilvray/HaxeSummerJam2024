package systems.crafting;

import flixel.tweens.FlxTween;
import systems.crafting.CraftingMaterial;
import flixel.FlxSprite;

class CraftingMaterialWorldPickup extends FlxSprite {
	public var canBeCollected:Bool = false;

	public function new(materialDefinition:ICraftingMaterialDefinition, x:Float = 0, y:Float = 0) {
		super();

		materialDefinition.setupMaterialWorldDropGraphic(this);

		this.x = x;
		this.y = y;

		var xOffset = (Math.random() * 2 - 1) * 10;
		var yOffset = 40;

		function onCompletePhase2(tween:FlxTween):Void {
			FlxTween.tween(this, {
				x: this.x + xOffset,
				y: this.y + yOffset
			}, 0.5, {
				onComplete: function(tween:FlxTween) canBeCollected = true
			});
		}

		FlxTween.tween(this, {
			x: this.x + xOffset,
			y: this.y - yOffset
		}, 0.5, {
			onComplete: onCompletePhase2
		});
	}
}
