extends Node

var time = {
	"year": null,
	"month": null,
	"day": null
}

var credits = null

var resources = {
	"1": null,
	"2": null,
	"3": null,
	"4": null,
	"5": null,
	"6": null,
	"7": null,
	"8": null,
	"9": null,
	"10": null,
	"11": null,
	"12": null
} 

func _initialize_game():
	time.year = 2100
	time.month = 1
	time.day = 1
	
	credits = 25000
	
	for resource in resources.keys():
		resources[resource] = 0
