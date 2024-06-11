package systems;

import flixel.math.FlxPoint;
import flixel.FlxBasic;
import flixel.FlxG;

class InputManager extends FlxBasic {
	public var direction:FlxPoint;

	private var inputHandled:Bool;

	override function update(elapsed:Float) {
		super.update(elapsed);
		inputHandled = false;
		keyboardUpdate(elapsed);
		gamepadUpdate(elapsed);
	}

	private function gamepadUpdate(elapsed:Float) {
		if (inputHandled) {
			return;
		}
		if (FlxG.gamepads.lastActive == null) {
			return;
		}
		var firstGamepadAnalog = FlxG.gamepads.lastActive.analog.value;
		var leftStickX = firstGamepadAnalog.LEFT_STICK_X;
		var leftStickY = firstGamepadAnalog.LEFT_STICK_Y;
		if (Math.abs(leftStickX) > 0.0 || Math.abs(leftStickY) > 0.0) {
			direction.x = leftStickX;
			direction.y = leftStickY;
			inputHandled = true;
		} else {
			direction.x = 0;
			direction.y = 0;
		}
	}

	private function keyboardUpdate(elapsed:Float) {
		if (inputHandled) {
			return;
		}

		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		var direction:FlxPoint = new FlxPoint();

		if (down) {
			direction.y = 1;
		} else if (up) {
			direction.y = -1;
		}

		if (right) {
			direction.x = 1;
		} else if (left) {
			direction.x = -1;
		}
	}
}
