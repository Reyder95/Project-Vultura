extends Node

class_name Planet

var planet_name						# Name of planet
var resources = Array()				# Array of all the resources on the planet
var planet_type						# The type of planet as an enum
var orbits = Array()					# The celestial body or bodies that are orbiting this planet
var position
var is_moon

func _init(planet_name, planet_type, angle, radius, is_moon):
	self.planet_name = planet_name
	self.planet_type = planet_type
	self.is_moon = is_moon
	
	generate_resources()
	

	
func generate_resources():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var temp_item
	var temp_amount
	var resource_exists = false
	
	var num_resources = rng.randi_range(0, 5)
	
	for resource in num_resources:
		var random_num = rng.randf_range(0, 100)
		
		for resource_item in Functions.planet_objects[planet_type].rng_table.keys():
			if random_num >= Functions.planet_objects[planet_type].rng_table[resource_item].minimum && random_num <= Functions.planet_objects[planet_type].rng_table[resource_item].maximum:
				temp_item = resource_item
				break
				
		temp_amount = rng.randi_range(5000, 10000)
		
		for resource_item in Functions.planet_objects[planet_type].resources:
			if resource_item.id == temp_item:
				temp_amount = floor(temp_amount * resource_item.multiplier)
				
		var temp_resource = PlanetResource.new(temp_item, temp_amount)
		
		if resources.size() == 0:
			resources.push_back(temp_resource)
		else:
			for new_resource in resources:
				if new_resource.type == temp_item:
					new_resource.quantity += temp_amount
					resource_exists = true
					break
					
			if not resource_exists:
				resources.push_back(temp_resource)
	
	if Functions.planet_objects[planet_type].necessary_resources != null:
		for nec_resource in Functions.planet_objects[planet_type].necessary_resources:
			temp_item = nec_resource.id
			temp_amount = floor(rng.randi_range(5000, 10000) * nec_resource.multiplier)
			var temp_resource = PlanetResource.new(temp_item, temp_amount)
			resources.push_back(temp_resource)
		
		
