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

var startype_map_files = {
	StarType.MAIN_SEQUENCE : "main_sequence",
	StarType.WHITE_DWARF : "white_dwarf",
	StarType.SUPER_GIANT : "supergiant",
	StarType.RED_GIANT : "red_giant",
	StarType.BROWN_DWARF : "brown_dwarf",
	StarType.PULSAR : "pulsar",
	StarType.BLACK_HOLE : "black_hole"
}

var startype_map_text = {
	StarType.MAIN_SEQUENCE : "Main Sequence",
	StarType.WHITE_DWARF : "White Dwarf",
	StarType.SUPER_GIANT : "Super Giant",
	StarType.RED_GIANT : "Red Giant",
	StarType.BROWN_DWARF : "Brown Dwarf",
	StarType.PULSAR : "Pulsar",
	StarType.BLACK_HOLE : "Black Hole"
}
