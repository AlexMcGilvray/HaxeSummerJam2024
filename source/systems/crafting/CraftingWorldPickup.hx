package systems.crafting;

import flixel.tweens.FlxEase;
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
		var yOffset = 40 + Math.random() * 15;
		var time = 0.2 + 0.2 * Math.random();

		function onCompletePhase2(tween:FlxTween):Void {
			FlxTween.tween(this, {
				x: this.x + xOffset,
				y: this.y + yOffset
			}, time, {
				ease: FlxEase.cubeIn,
				onComplete: function(tween:FlxTween) canBeCollected = true
			});
		}

		FlxTween.tween(this, {
			x: this.x + xOffset,
			y: this.y - yOffset
		}, time, {
			ease: FlxEase.cubeOut,
			onComplete: onCompletePhase2
		});
	}
}
