package systems.plants;

import systems.plants.PlantBase;
import systems.crafting.CraftingMaterial;

interface ICraftable {
	public function getBuildRequirements():Map<String, Int>;
	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase;
	public function getName():String;
}

class Craftable_PlantBase implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();
		var mat1 = new CMPlantEssence();

		requirements.set(mat1.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new PlantBase(worldPickupSystem);
	}

	public function getName() {
		return "Base Plant";
	}
}

class Craftable_Rose implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();
		var mat1 = new CMPurpleSurprise();

		requirements.set(mat1.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_Rose(worldPickupSystem);
	}

	public function getName() {
		return "Rose";
	}
}

class Craftable_Tulip implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();
		var mat2 = new CMPurpleSurprise();

		requirements.set(mat1.getMaterialName(), 1);
		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_Tulip(worldPickupSystem);
	}

	public function getName() {
		return "Tulip";
	}
}

class Craftable_OnigiriRed implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat2 = new CMPurpleSurprise();

		requirements.set(mat2.getMaterialName(), 2);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_OnigiriRed(worldPickupSystem);
	}

	public function getName() {
		return "Red Onigiri Bush";
	}
}

class Craftable_OnigiriPurple implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();

		requirements.set(mat1.getMaterialName(), 2);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_OnigiriPurple(worldPickupSystem);
	}

	public function getName() {
		return "Purple Onigiri Bush";
	}
}

class Craftable_OnigiriDeepPurple implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();
		var mat2 = new CMPurpleSurprise();

		requirements.set(mat1.getMaterialName(), 2);
		requirements.set(mat2.getMaterialName(), 2);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_OnigiriDeepPurple(worldPickupSystem);
	}

	public function getName() {
		return "Deep Purple Onigiri Bush";
	}
}

class Craftable_ForestFlowerOrange implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();

		requirements.set(mat1.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestFlowerOrange(worldPickupSystem);
	}

	public function getName() {
		return "Orange Forest Flower";
	}
}

class Craftable_ForestFlowerPink implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat2 = new CMPurpleSurprise();

		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestFlowerPink(worldPickupSystem);
	}

	public function getName() {
		return "Pink Forest Flower";
	}
}

class Craftable_ForestFlowerPurple implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();
		var mat2 = new CMPurpleSurprise();

		requirements.set(mat1.getMaterialName(), 1);
		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestFlowerPurple(worldPickupSystem);
	}

	public function getName() {
		return "Purple Forest Flower";
	}
}

class Craftable_ForestTree01 implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();
		var mat2 = new CMPurpleSurprise();

		requirements.set(mat1.getMaterialName(), 3);
		requirements.set(mat2.getMaterialName(), 3);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestTree01(worldPickupSystem);
	}

	public function getName() {
		return "Forest Tree 01";
	}
}

class Craftable_ForestTree02 implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();
		var mat2 = new CMPurpleSurprise();

		requirements.set(mat1.getMaterialName(), 4);
		requirements.set(mat2.getMaterialName(), 3);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestTree02(worldPickupSystem);
	}

	public function getName() {
		return "Forest Tree 02";
	}
}

class Craftable_ForestTree03 implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();
		var mat2 = new CMPurpleSurprise();

		requirements.set(mat1.getMaterialName(), 3);
		requirements.set(mat2.getMaterialName(), 4);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestTree03(worldPickupSystem);
	}

	public function getName() {
		return "Forest Tree 03";
	}
}

class Craftable_ForestMushroomPurple implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat2 = new CMPurpleSurprise();

		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestMushroomPurple(worldPickupSystem);
	}

	public function getName() {
		return "Purple Forst Mushroom";
	}
}

class Craftable_ForestMushroomBrown implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();
		var mat1 = new CMPlantEssence();

		requirements.set(mat1.getMaterialName(), 2);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestMushroomBrown(worldPickupSystem);
	}

	public function getName() {
		return "Brown Forst Mushroom";
	}
}

class Craftable_ForestMushroomRed implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();
		var mat2 = new CMPurpleSurprise();

		requirements.set(mat1.getMaterialName(), 1);
		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant(worldPickupSystem:WorldPickupSystem):PlantBase {
		return new Plant_ForestMushroomRed(worldPickupSystem);
	}

	public function getName() {
		return "Red Forst Mushroom";
	}
}
