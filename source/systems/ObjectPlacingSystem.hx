package systems;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxSprite;

class ObjectPlacingSystem extends FlxBasic {
	public var heldObject(default, null):FlxObject;

	private var inputManager:InputManager;

	public function new(inputManager:InputManager) {
		super();
		this.inputManager = inputManager;
	}

	public function attachHeldObject(obj:FlxObject) {
		if (heldObject == null) {
			heldObject = obj;
		} else {
			trace("Tried to attach an object when we already have an object attached!");
		}
	}

	function releaseHeldObject() {
		if (heldObject != null) {
			heldObject = null;
		}
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (inputManager.cursorButton1PressedThisFrame) {
			if (heldObject != null) {
				releaseHeldObject();
			}
		}

		if (heldObject != null) {
			heldObject.x = FlxG.mouse.x - heldObject.width / 2;
			heldObject.y = FlxG.mouse.y - heldObject.height;
		}
	}
}
