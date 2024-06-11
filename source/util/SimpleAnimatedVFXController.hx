package util;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

abstract class SimpleAnimatedVFXController extends FlxTypedGroup<FlxSprite> {
	public function new() {
		super();
	}

	public abstract function configureSprite(sprite:FlxSprite):Void;

	public function addEmitter(x:Float, y:Float) {
		var newVFX = new FlxSprite(); // todo recycle(FlxSprite);
		configureSprite(newVFX);
		newVFX.x = x - newVFX.width / 2;
		newVFX.y = y - newVFX.height / 2;
		add(newVFX);
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
