package systems;

import flixel.FlxG;
import util.SimpleAnimatedVFXController;
import openfl.utils.IAssetCache;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;

class GrassTuftEmitter extends SimpleAnimatedVFXController {
	public function configureSprite(sprite:FlxSprite) {
		sprite.loadGraphic("assets/images/grass_02_cut_vfx.png", true, 64, 64);
		sprite.animation.add("main", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
		sprite.animation.play("main");
	}
}

class GrassTuft extends FlxSprite {
	public function new() {
		super();
		loadGraphic("assets/images/grass_01.png", true, 16, 16);
		animation.add("idle", [0, 1, 2, 3, 3, 3, 2, 1, 0, 0], 12);
		animation.play("idle");
	}
}

class GrassSystem extends FlxTypedGroup<GrassTuft> {
	// private var grassTile:Array<FlxTile>;
	private var grassTufts:Array<GrassTuft>; // todo if all this system holds is grass tufts we don't need this second collection
	var grassTuftEmitter:GrassTuftEmitter;

	public function new() {
		super();
		grassTufts = new Array<GrassTuft>();
		grassTuftEmitter = new GrassTuftEmitter();
	}

	public function cutGrass(cutSprite:FlxSprite) {
		function doOverlap(objectA:FlxSprite, objectB:FlxSprite) {
			objectA.kill();
		}

		FlxG.overlap(this, cutSprite, doOverlap);
	}

	public function populateWorld(tileMap:FlxTilemap) {
		// for (i in 0...tileMap.widthInTiles * tileMap.heightInTiles) {
		// 	if ( tileMap.getTileByIndex(i) == 0)
		//         {grassTile.push(tileMap.gettil))}
		// }

		function isTileValid(x:Int, y:Int):Bool {
			if (tileMap.getTile(x, y) == 0) {
				return true;
			}
			return false;
		}

		function spawnGrassTuft(x:Int, y:Int) {
			var grassTuft = new GrassTuft();
			grassTuft.x = x * grassTuft.width;
			grassTuft.y = y * grassTuft.height;
			// set the animation so we get a kind of offset rolling wind effect on the grass
			grassTuft.animation.curAnim.curFrame = Std.int((x + Math.random() * 3) % grassTuft.animation.curAnim.numFrames);
			grassTufts.push(grassTuft);
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

		var numGrassToSpawn = 100;
		var randomSpawnPoint = new FlxPoint();

		while (numGrassToSpawn > 0) {
			randomSpawnPoint.x = Math.random() * tileMap.widthInTiles;
			randomSpawnPoint.y = Math.random() * tileMap.heightInTiles;

			if (!isTileValid(Std.int(randomSpawnPoint.x), Std.int(randomSpawnPoint.y))) {
				continue;
			}

			var width = Std.int(Math.random() * 15);
			var height = Std.int(Math.random() * 15);
			spawnTilesInGrid(Std.int(randomSpawnPoint.x), Std.int(randomSpawnPoint.y), width, height);

			randomSpawnPoint.x = randomSpawnPoint.x * tileMap.tileWidth;
			randomSpawnPoint.y = randomSpawnPoint.y * tileMap.tileHeight;
			// var grassTuft = new GrassTuft();
			// grassTuft.x = randomSpawnPoint.x;
			// grassTuft.y = randomSpawnPoint.y;
			// add(grassTuft);
			numGrassToSpawn--; // if successfully spawned
		}
	}
}
