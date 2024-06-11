package systems;

import openfl.utils.IAssetCache;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;

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
	private var grassTufts:Array<GrassTuft>;

	public function new() {
		super();
		grassTufts = new Array<GrassTuft>();
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
			grassTuft.animation.curAnim.curFrame = x % grassTuft.animation.curAnim.numFrames;
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
