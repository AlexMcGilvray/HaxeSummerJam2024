package systems;

import flixel.util.FlxSort;
import flixel.FlxBasic;
import systems.plants.PlantBase;
import openfl.utils.Assets;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;

class World extends FlxTypedGroup<FlxBasic> {
	var worldTileMap:FlxTilemap;

	var plants:FlxTypedGroup<PlantBase>;

	public function getTileMap():FlxTilemap {
		return worldTileMap;
	}

	public function getWidth() {
		return worldTileMap.width;
	}

	public function getHeight() {
		return worldTileMap.height;
	}

	public function addPlantToWorld(plant:PlantBase) {
		plants.add(plant);
	}

	public function sortPlants() {
		plants.sort(FlxSort.byY, FlxSort.ASCENDING);
	}

	public function new() {
		super();
		worldTileMap = new FlxTilemap();

		var levelJsonText = Assets.getText("assets/world.json");
		var levelJson:Dynamic = haxe.Json.parse(levelJsonText);
		var mapData:Array<Int> = levelJson.layers[0].data;
		// Tilemap seems to be off by one for my purposes, more on why here :
		// https://discourse.mapeditor.org/t/array-files-are-one-number-off-from-tile-set/1884
		for (i in 0...mapData.length - 1) {
			mapData[i] = mapData[i] - 1;
		}
		// load map from our csv data
		worldTileMap.loadMapFromArray(mapData, levelJson.width, levelJson.height, "assets/images/tilemap_world.png", 16, 16, OFF, 0, 0, 65);
		add(worldTileMap);

		plants = new FlxTypedGroup<PlantBase>();
		add(plants);
	}
}
