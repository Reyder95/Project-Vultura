extends Node

# Enums for various types of things in the game
var planet_types = {}
var resource_types = {}
var star_types = {}

# Mapping enum to its respective data
var planet_objects = {}
var resource_objects = {}
var star_objects = {}

# Planet and Star RNG Tables
var planet_rng_table = {}
var star_rng_table = {}

# Load all game data upon game start
func _ready():
	
	# Parsed JSON data
	var planet_data = {}
	var resource_data = {}
	var star_data = {}
	
	# Initial JSON files loaded
	var planet_json = File.new()
	var resource_json = File.new()
	var star_json = File.new()
	
	# Load the planet JSON file into planet_data
	planet_json.open("res://data/planet_data.json", File.READ)
	planet_data = parse_json(planet_json.get_as_text())
	
	# Create dynamic enum, associating type with ID. Take that ID and associate it with an object
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
	
	# Load the resource JSON file into resource_data
	resource_json.open("res://data/resource_data.json", File.READ)
	resource_data = parse_json(resource_json.get_as_text())
	
	# Create dynamic enum, associating type with ID. Take that ID and associate it with an object
	for resource in resource_data:
		resource_types[parse_enum_identifier(resource.name)] = int(resource.id)
		
		var new_resource = {
			"name": resource.name,
			"description": resource.description,
			"filename": resource.filename,
			"alternative_filepath": resource.alternative_filepath
		}
		
		resource_objects[int(resource.id)] = new_resource
	
	# Load the star JSON file into star_data
	star_json.open("res://data/star_data.json", File.READ)
	star_data = parse_json(star_json.get_as_text())
	
	# Create dynamic enum, associating type with ID. Take that ID and associate it with an object
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
	
	# Taking all the JSON data loaded, build various RNG maps for each object's chance of spawning
	build_rng_maps()
	
# Each enum should be in all caps, and the spaces should instead be underscores. Example: Gas Giant -> GAS_GIANT
func parse_enum_identifier(string):
	var new_string = string.to_upper()
	new_string = new_string.replace(" ", "_")
	return new_string

# Build initial RNG maps
func build_rng_maps():
	
	# For each planet, build an rng map for the chance of resources spawning on the planets
	for planet in planet_objects.values():
		var rng_dict = {}
		var previous_max_percent = 0
		
		for resource in planet.resources:
			var current_max_percent = previous_max_percent + resource.chance
			var new_dict = {
				"minimum": previous_max_percent,
				"maximum": current_max_percent
			}
			
			rng_dict[int(resource.id)] = new_dict
			previous_max_percent = current_max_percent
		
		planet["rng_table"] = rng_dict
	
	var previous_max_percent = 0
	
	# Build an rng map for the chance of each planet spawning in a star system
	for planet in planet_objects.keys():
		var current_max_percent = previous_max_percent + planet_objects[planet].chance
		
		var new_dict = {
			"minimum": previous_max_percent,
			"maximum": current_max_percent
		}
		
		planet_rng_table[planet] = new_dict
		previous_max_percent = current_max_percent
		
	previous_max_percent = 0
		
	# Build an rng map for the chance of each star spawning in the galaxy
	for star in star_objects.keys():
		var current_max_percent = previous_max_percent + star_objects[star].chance
		
		var new_dict = {
			"minimum": previous_max_percent,
			"maximum": current_max_percent
		}
		
		star_rng_table[star] = new_dict
		previous_max_percent = current_max_percent

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
