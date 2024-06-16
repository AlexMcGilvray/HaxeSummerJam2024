package systems.plants;

import systems.plants.PlantBase;
import systems.crafting.CraftingMaterial;

interface ICraftable {
	public function getBuildRequirements():Map<String, Int>;
	public function generatePlant():PlantBase;
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

	public function generatePlant():PlantBase {
		return new PlantBase();
	}

	public function getName() {
		return "Base Plant";
	}
}

class Craftable_Rose implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();
		var mat1 = new CMPlantEssenceX();

		requirements.set(mat1.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant():PlantBase {
		return new Plant_Rose();
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
		var mat2 = new CMPlantEssenceX();

		requirements.set(mat1.getMaterialName(), 1);
		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant():PlantBase {
		return new Plant_Tulip();
	}

	public function getName() {
		return "Tulip";
	}
}

class Craftable_OnigiriRed implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat2 = new CMPlantEssenceX();

		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant():PlantBase {
		return new Plant_OnigiriRed();
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

		requirements.set(mat1.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant():PlantBase {
		return new Plant_OnigiriPurple();
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
		var mat2 = new CMPlantEssenceX();

		requirements.set(mat1.getMaterialName(), 1);
		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant():PlantBase {
		return new Plant_OnigiriDeepPurple();
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
		var mat2 = new CMPlantEssenceX();

		requirements.set(mat1.getMaterialName(), 2);
		requirements.set(mat2.getMaterialName(), 1);

		return requirements;
	}

	public function generatePlant():PlantBase {
		return new Plant_ForestFlowerOrange();
	}

	public function getName() {
		return "Orange Forest Flower";
	}
}

class Craftable_ForestFlowerPink implements ICraftable {
	public function new() {}

	public function getBuildRequirements():Map<String, Int> {
		var requirements = new Map<String, Int>();

		var mat1 = new CMPlantEssence();
		var mat2 = new CMPlantEssenceX();

		requirements.set(mat1.getMaterialName(), 2);
		requirements.set(mat2.getMaterialName(), 2);

		return requirements;
	}

	public function generatePlant():PlantBase {
		return new Plant_ForestFlowerPink();
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
		var mat2 = new CMPlantEssenceX();

		requirements.set(mat1.getMaterialName(), 2);
		requirements.set(mat2.getMaterialName(), 3);

		return requirements;
	}

	public function generatePlant():PlantBase {
		return new Plant_ForestFlowerPurple();
	}

	public function getName() {
		return "Purple Forest Flower";
	}
}
