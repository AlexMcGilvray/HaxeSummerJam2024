package systems;

import systems.crafting.CraftingMaterial.CMPlantEssenceX;
import systems.crafting.CraftingWorldPickup.CraftingMaterialWorldPickup;
import systems.crafting.CraftingMaterial.CMPlantEssence;
import flixel.FlxG;
import util.SimpleAnimatedVFXController;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;

class GrassTuftEmitter extends SimpleAnimatedVFXController {
	public function configureSprite(sprite:FlxSprite) {
		sprite.loadGraphic("assets/images/grass_02_cut_vfx.png", true, 64, 64);
		var randomFrameRate = Std.int(Math.random() * 6 + 8);
		sprite.animation.add("main", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], randomFrameRate, false);
		sprite.animation.play("main");
		var randomScale = Math.random() * 0.5 + 1;
		sprite.scale.x = randomScale;
		sprite.scale.y = randomScale;
	}
}

class GrassTuft extends FlxSprite {
	var worldPickupSystem:WorldPickupSystem;

	public function new(worldPickupSystem:WorldPickupSystem) {
		super();
		this.worldPickupSystem = worldPickupSystem;
		loadGraphic("assets/images/grass_01.png", true, 16, 16);
		animation.add("idle", [0, 1, 2, 3, 3, 3, 2, 1, 0, 0], 12);
		animation.play("idle");
	}

	override function kill() {
		super.kill();
		// roll dice to see if we spawn a material pickup
		if (Math.random() > 0.8) {
			if (Math.random() > 0.5) {
				var matInterface = new CMPlantEssenceX();
				var pickup = new CraftingMaterialWorldPickup(matInterface, this.x, this.y);
				worldPickupSystem.addWorldPickup(pickup);
			} else {
				var matInterface = new CMPlantEssence();
				var pickup = new CraftingMaterialWorldPickup(matInterface, this.x, this.y);
				worldPickupSystem.addWorldPickup(pickup);
			}
		}
	}
}

class GrassSystem extends FlxTypedGroup<GrassTuft> {
	var grassTuftEmitter:GrassTuftEmitter;
	var worldPickupSystem:WorldPickupSystem;

	public function new(grassTuftEmitter:GrassTuftEmitter, worldPickupSystem:WorldPickupSystem) {
		super();
		this.grassTuftEmitter = grassTuftEmitter;
		this.worldPickupSystem = worldPickupSystem;
	}

	public function cutGrass(cutSprite:FlxSprite) {
		function doOverlap(objectA:FlxSprite, objectB:FlxSprite) {
			grassTuftEmitter.addEmitter(objectA.x + objectA.width / 2, objectA.y + objectA.height / 2);
			objectA.kill();
		}

		FlxG.overlap(this, cutSprite, doOverlap);
	}

	public function populateWorld(tileMap:FlxTilemap) {
		function isTileValid(x:Int, y:Int):Bool {
			if (tileMap.getTile(x, y) == 0) {
				return true;
			}
			return false;
		}

		function spawnGrassTuft(x:Int, y:Int) {
			var grassTuft = new GrassTuft(worldPickupSystem);
			// will matter later when we regenerate grass but that means we need a parameterless ctro
			// var grassTuft = recycle(GrassTuft.new);
			grassTuft.x = x * grassTuft.width;
			grassTuft.y = y * grassTuft.height;
			// set the animation so we get a kind of offset rolling wind effect on the grass
			grassTuft.animation.curAnim.curFrame = Std.int((x + Math.random() * 3) % grassTuft.animation.curAnim.numFrames);
			add(grassTuft);
		}

		function spawnTilesInGrid(spawnX:Int, spawnY:Int, width:Int, height:Int) {
			for (y in 0...height - 1) {
				for (x in 0...width - 1) {
					if (isTileValid(spawnX + x, spawnY + y)) {
						spawnGrassTuft(spawnX + x, spawnY + y);
					}
				}
			}
		}

		// try to spawn N grass clusters
		//  todo currently no bailout if we get stuck
		var numGrassToSpawn = 100;
		var randomSpawnPoint = new FlxPoint();

		while (numGrassToSpawn > 0) {
			randomSpawnPoint.x = Math.random() * tileMap.widthInTiles;
			randomSpawnPoint.y = Math.random() * tileMap.heightInTiles;

			if (!isTileValid(Std.int(randomSpawnPoint.x), Std.int(randomSpawnPoint.y))) {
				continue;
			}

			var width = Std.int(Math.random() * 10);
			var height = Std.int(Math.random() * 10);
			spawnTilesInGrid(Std.int(randomSpawnPoint.x), Std.int(randomSpawnPoint.y), width, height);

			randomSpawnPoint.x = randomSpawnPoint.x * tileMap.tileWidth;
			randomSpawnPoint.y = randomSpawnPoint.y * tileMap.tileHeight;
			numGrassToSpawn--; // if successfully spawned
		}
	}
}
