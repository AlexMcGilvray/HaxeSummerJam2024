package systems;

import flixel.math.FlxPoint;
import flixel.FlxBasic;
import flixel.FlxG;

class InputManager extends FlxBasic {
	public var direction:FlxPoint;
	public var digitalButton1PressedThisFrame:Bool;
	public var digitalButton2PressedThisFrame:Bool;
	public var cursorButton1PressedThisFrame:Bool;

	private var movementInputHandled:Bool;

	public function new() {
		super();
		direction = new FlxPoint();
	}

	public function moveInputRecievedThisFrame() {
		return !((Math.abs(direction.x) < 0.001) && (Math.abs(direction.y) < 0.001));
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		movementInputHandled = false;
		cursorButton1PressedThisFrame = FlxG.mouse.justPressed; // right now this is not abstracted beyond the mouse
		keyboardUpdate(elapsed);
		gamepadUpdate(elapsed);
		if (!movementInputHandled) {
			direction.x = 0;
			direction.y = 0;
		}
	}

	private function gamepadUpdate(elapsed:Float) {
		if (FlxG.gamepads.lastActive == null) {
			return;
		}

		var gamepad = FlxG.gamepads.lastActive;
		digitalButton1PressedThisFrame = gamepad.justPressed.A;
		digitalButton2PressedThisFrame = gamepad.justPressed.B;

		if (movementInputHandled) {
			return;
		}
		var firstGamepadAnalog = gamepad.analog.value;
		var leftStickX = firstGamepadAnalog.LEFT_STICK_X;
		var leftStickY = firstGamepadAnalog.LEFT_STICK_Y;
		if (Math.abs(leftStickX) > 0.0 || Math.abs(leftStickY) > 0.0) {
			direction.x = leftStickX;
			direction.y = leftStickY;
			movementInputHandled = true;
		}
	}

	private function keyboardUpdate(elapsed:Float) {
		digitalButton1PressedThisFrame = FlxG.keys.justPressed.SPACE;
		digitalButton2PressedThisFrame = FlxG.keys.justPressed.F;

		if (movementInputHandled) {
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

		if (down) {
			direction.y = 1;
		} else if (up) {
			direction.y = -1;
		} else {
			direction.y = 0;
		}

		if (right) {
			direction.x = 1;
		} else if (left) {
			direction.x = -1;
		} else {
			direction.x = 0;
		}

		movementInputHandled = up || down || left || right;
	}
}
