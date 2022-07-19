extends Node

# Enums for various types of things in the game
var planet_types = {}
var resource_types = {}
var star_types = {}

# Mapping enum to its respective data
var planet_objects = {}
var resource_objects = {}
var star_objects = {}

# Load all game data upon game start
func _ready():
	
	var planet_data = {}
	var resource_data = {}
	var star_data = {}
	
	var planet_json = File.new()
	var resource_json = File.new()
	var star_json = File.new()
	
	planet_json.open("res://data/planet_data.json", File.READ)
	planet_data = parse_json(planet_json.get_as_text())
	
	for planet in planet_data:
		planet_types[parse_enum_identifier(planet.name)] = int(planet.id)
		
		var new_planet = {
			"name": planet.name,
			"chance": planet.chance,
			"radius": planet.radius,
			"radius_null": planet.radius_end,
			"filename": planet.filename,
			"alternative_filepath": planet.alternative_filepath,
			"description": planet.description,
			"necessary_resources": planet.necessary_resources,
			"resources": planet.resources
		}
		
		planet_objects[int(planet.id)] = new_planet
	
	resource_json.open("res://data/resource_data.json", File.READ)
	resource_data = parse_json(resource_json.get_as_text())
	
	for resource in resource_data:
		resource_types[parse_enum_identifier(resource.name)] = int(resource.id)
		
		var new_resource = {
			"name": resource.name,
			"description": resource.description,
			"filename": resource.filename,
			"alternative_filepath": resource.alternative_filepath
		}
		
		resource_objects[int(resource.id)] = new_resource
		
	for resource in planet_objects[planet_types.GAS_GIANT].resources:
		print(resource_objects[int(resource.id)].name)
	
	star_json.open("res://data/star_data.json", File.READ)
	star_data = parse_json(star_json.get_as_text())
	
	for star in star_data:
		star_types[parse_enum_identifier(star.name)] = int(star.id)
		
		var new_star = {
			"name": star.name,
			"filename": star.filename,
			"alternative_filepath": star.alternative_filepath,
			"chance": star.chance,
			"radius": star.radius,
			"radius_end": star.radius_end,
			"scale": star.scale
		}
		
		star_objects[int(star.id)] = new_star
	
	
	
func parse_enum_identifier(string):
	var new_string = string.to_upper()
	new_string = new_string.replace(" ", "_")
	return new_string


# - Enums and Maps

# -- Star Types

# Different star types
enum StarType {
	MAIN_SEQUENCE,
	WHITE_DWARF,
	SUPER_GIANT,
	RED_GIANT,
	BROWN_DWARF,
	PULSAR,
	BLACK_HOLE 
}

# Mapping a star type enum to a file name equivelant
var startype_map_files = {
	StarType.MAIN_SEQUENCE : "main_sequence",
	StarType.WHITE_DWARF : "white_dwarf",
	StarType.SUPER_GIANT : "supergiant",
	StarType.RED_GIANT : "red_giant",
	StarType.BROWN_DWARF : "brown_dwarf",
	StarType.PULSAR : "pulsar",
	StarType.BLACK_HOLE : "black_hole"
}

# Mapping a star type enum to text to display it properly
var startype_map_text = {
	StarType.MAIN_SEQUENCE : "Main Sequence",
	StarType.WHITE_DWARF : "White Dwarf",
	StarType.SUPER_GIANT : "Super Giant",
	StarType.RED_GIANT : "Red Giant",
	StarType.BROWN_DWARF : "Brown Dwarf",
	StarType.PULSAR : "Pulsar",
	StarType.BLACK_HOLE : "Black Hole"
}

# -- Resource Types

enum ResourceDivision {
	CONSUMER_GOOD = 1,
	GAS = 2,
	METAL = 3
}

# Different resources found on planets and other astral bodies
enum ResourceType {
	HYDROGEN = 1,		# Fuel
	IRON = 2,			# Building infrastructure.
	COPPER = 3,			# Electrical circuits.
	TIN = 4,			# Building infrastructure.
	URANIUM = 5,		# Nuclear items
	ANIMAL_FUR = 6,		# Clothing.
	TRITIUM = 7,		# Used for the holographic lights on various consumer goods
	AMMONIA = 8,		# Fertilizer. Necessary for farming and survival
	INFECTIOUS_METALS = 9,     # Ethereal - Used for building Ethereal-tier weapons and ships.
	BRINE_GAS = 10, 			# Ethereal - Used for building Ethereal-tier weapons and ships
	ECHTON_ORE = 11,		# Ethereal, ultra rare
	AQUATIC_RESIN = 12      # Only on island and ocean worlds
}

# Mapping a resource type enum to a file name equivelant
var resource_map_files = {
	ResourceType.HYDROGEN : "hydrogen",
	ResourceType.IRON : "iron",
	ResourceType.COPPER : "copper",
	ResourceType.TIN : "tin",
	ResourceType.URANIUM : "uranium",
	ResourceType.ANIMAL_FUR : "animal_fur",
	ResourceType.TRITIUM : "tritium"
}

# Mapping a resource type enum to text to display it properly
var resource_map_text = {
	ResourceType.HYDROGEN : "Hydrogen",
	ResourceType.IRON : "Iron",
	ResourceType.COPPER : "Copper",
	ResourceType.TIN : "Tin",
	ResourceType.URANIUM : "Uranium",
	ResourceType.ANIMAL_FUR : "Animal Fur",
	ResourceType.TRITIUM : "Tritium"
}

# -- Planet Types

# Different planet types
enum PlanetType {
	ARCTIC = 1,
	BARREN = 2,
	CONTINENTAL = 3,
	ETHEREAL = 4,
	GAS_GIANT = 5,
	ISLAND = 6,
	OCEAN = 7,
	VOLCANIC = 8
}

# Mapping a planet type to a file name
var planet_map_files = {
	PlanetType.ARCTIC : "arctic",
	PlanetType.BARREN : "barren",
	PlanetType.CONTINENTAL : "continental",
	PlanetType.ETHEREAL : "ethereal",
	PlanetType.GAS_GIANT : "gas_giant",
	PlanetType.ISLAND : "island",
	PlanetType.OCEAN : "ocean",
	PlanetType.VOLCANIC : "volcanic"
}

# Mapping a planet type to text to display it properly
var planet_map_text = {
	PlanetType.ARCTIC : "Arctic",
	PlanetType.BARREN : "Barren",
	PlanetType.CONTINENTAL : "Continental",
	PlanetType.ETHEREAL : "Ethereal",
	PlanetType.GAS_GIANT : "Gas Giant",
	PlanetType.ISLAND : "Island",
	PlanetType.OCEAN : "Ocean",
	PlanetType.VOLCANIC : "Volcanic"
}

# Mapping a planet type to random generation chance (rng)
var planet_chance = {
	PlanetType.ARCTIC : 0.125,
	PlanetType.BARREN : 0.125,
	PlanetType.CONTINENTAL : 0.125,
	PlanetType.ETHEREAL : 0.125,
	PlanetType.GAS_GIANT : 0.125,
	PlanetType.ISLAND : 0.125,
	PlanetType.OCEAN : 0.125,
	PlanetType.VOLCANIC : 0.125
}

# - Useful Arrays

# Temporary list of random names for star systems
var system_names = [
	"Ragnid",
	"Ketar",
	"Alpha Denuvos",
	"Siniptris",
	"Porcupine",
	"Raoltoa",
	"Jita"
]
