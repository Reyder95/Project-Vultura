extends Node

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

enum ResourceType {
	# Gases
	HYDROGEN,		# Fuel
	
	# Metals
	IRON,			# Building infrastructure.
	COPPER,			# Electrical circuits.
	TIN,			# Building infrastructure.
	URANIUM,		# Nuclear items
	
	# Luxury Goods
	ANIMAL_FUR,		# Clothing.
	TRITIUM,		# Used for the holographic lights on various consumer goods
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
