package systems;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxBasic;

class ObjectPlacingSystem extends FlxBasic {
	public var heldObject(default, null):FlxObject;

	public var isHoldingObject(get, never):Bool;

	function get_isHoldingObject()
		return heldObject != null;

	private var inputManager:InputManager;
	private var world:World;

	public function new(inputManager:InputManager, world:World) {
		super();
		this.inputManager = inputManager;
		this.world = world;
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
			world.sortPlants();
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
