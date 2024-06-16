package systems;

import systems.crafting.CraftingWorldPickup.CraftingMaterialWorldPickup;
import flixel.group.FlxGroup.FlxTypedGroup;

class WorldPickupSystem extends FlxTypedGroup<CraftingMaterialWorldPickup> {
	public function addWorldPickup(pickup:CraftingMaterialWorldPickup) {
		add(pickup);
	}

	public function attractTowardsPlayer(player:Player, elapsed:Float) {
		var threshold = 70;
		var speed = 250;
		function attract(item:CraftingMaterialWorldPickup):Void {
			if (item.getPosition().dist(player.getPosition()) < threshold) {
				var directionToPlayer = (player.getPosition() - item.getPosition()).normalize();
				item.x += directionToPlayer.x * speed * elapsed;
				item.y += directionToPlayer.y * speed * elapsed;
			}
		}
		forEachAlive(attract);
	}
}
