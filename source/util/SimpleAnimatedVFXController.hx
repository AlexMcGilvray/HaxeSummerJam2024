package util;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

abstract class SimpleAnimatedVFXController extends FlxTypedGroup<FlxSprite> {
	public function new() {
		super();
	}

	public abstract function configureSprite(sprite:FlxSprite):Void;

	public function addEmitter(newVFX:FlxSprite, x:Float, y:Float) {
		var newVFX = recycle(FlxSprite);
		newVFX.x = x;
		newVFX.y = y;
		configureSprite(newVFX);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		for (vfx in this) {
			if (vfx.animation.finished) {
				vfx.kill();
			}
		}
	}
}
