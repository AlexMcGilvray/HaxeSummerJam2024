import systems.InputManager;
import flixel.FlxSprite;

class Player extends FlxSprite {
	private static inline var ANIM_IDLE = "idle";
	private static inline var ANIM_WALK_DOWN = "walk_down";
	private static inline var ANIM_WALK_UP = "walk_up";
	private static inline var ANIM_WALK_LEFT = "walk_left";
	private static inline var ANIM_WALK_RIGHT = "walk_right";

	public var playerSpeed(default, null):Float = 125;

	private var inputManager:InputManager;

	public function new(inputManager:InputManager) {
		super(300, 200);

		this.inputManager = inputManager;

		loadGraphic(AssetPaths.player_walking_spritesheet__png, true, 32, 32);

		animation.add(ANIM_IDLE, [0], 12);
		animation.add(ANIM_WALK_DOWN, [0, 1, 2], 12);
		animation.add(ANIM_WALK_UP, [4, 5, 6], 12);
		animation.add(ANIM_WALK_LEFT, [8, 9, 10], 12);
		animation.add(ANIM_WALK_RIGHT, [8, 9, 10], 12, true, true);
		animation.play(ANIM_IDLE);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (inputManager.moveInputRecievedThisFrame()) {
			// determine most appropriate animation to play
			if (Math.abs(inputManager.direction.x) >= Math.abs(inputManager.direction.y)) {
				x = x + inputManager.direction.x * playerSpeed * elapsed; // move player
				if (inputManager.direction.x > 0) {
					animation.play(ANIM_WALK_RIGHT);
				} else {
					animation.play(ANIM_WALK_LEFT);
				}
			} else {
				y = y + inputManager.direction.y * playerSpeed * elapsed; // move player
				if (inputManager.direction.y > 0) {
					animation.play(ANIM_WALK_DOWN);
				} else {
					animation.play(ANIM_WALK_UP);
				}
			}
		} else {
			animation.play(ANIM_IDLE);
		}
	}
}
