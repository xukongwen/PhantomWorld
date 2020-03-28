extends Node2D

var noise
var map_size = Vector2(180, 160)
var grass_cap = 0.5
var road_caps = Vector2(0.3, 0.05)
var enviroment_caps = Vector3(0.4, 0.3, 0.04)


var selected_units = [] # objects

var units = []

onready var button = preload("res://scences/buttons/unite_button_1.tscn")
var buttons = [] # strings 

func select_unit(unit):
	if not selected_units.has(unit):
		selected_units.append(unit)
	create_buttons()

func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)
	create_buttons()

func deselect_all():
	while selected_units.size() > 0:
		selected_units[0].set_selected(false)

func create_buttons():
	delete_buttons()
	for unit in selected_units:
		if not buttons.has(unit.name):
			var but = button.instance()
			but.connect_me(self, unit.name)
			but.rect_position = Vector2(buttons.size() * 64 + 32 , -120)
			$'UI/Base'.add_child(but)
			buttons.append(unit.name)

func delete_buttons():
	for but in buttons:
		if $'UI/Base'.has_node(but):
			var b = $'UI/Base'.get_node(but)
			b.queue_free()
			$'UI/Base'.remove_child(b)
	buttons.clear()

func was_pressed(obj):
	for unit in selected_units:
		if unit.name == obj.name:
			unit.set_selected(false)
			break


func get_units_in_area(area):
	var u = []
	for unit in units:
		if unit.position.x > area[0].x and unit.position.x < area[1].x:
			if unit.position.y > area[0].y and unit.position.y < area[1].y:
				u.append(unit)
	return u

func area_selected(obj):
	var start = obj.start
	var end = obj.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var ut = get_units_in_area(area)
	if not Input.is_key_pressed(KEY_SHIFT):
		deselect_all()
	for u in ut:
		u.selected = not u.selected

func start_move_selection(obj):
	for un in selected_units:
		un.move_unit(obj.move_to_point)


func _ready():
	randomize()
	
	units = get_tree().get_nodes_in_group("units")
	
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 1.0
	noise.period = 12
	noise.persistence = 0.7
	make_grass_map()
	make_road_map()
	make_enviroment_map()
	make_background()
	
func make_grass_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < grass_cap:
				$nav/Grass.set_cell(x,y,0)
				
	$nav/Grass.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))
	
func make_road_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < road_caps.x and a > road_caps.y:
				$nav/Roads.set_cell(x,y,0)
	$nav/Roads.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))
	
func make_enviroment_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < enviroment_caps.x and a > enviroment_caps.y or a < enviroment_caps.z:
				var chance = randi() % 100
				if chance < 2:
				
					var num = randi() % 4
					$nav/Enviroment.set_cell(x,y, num)
				
				

func make_background():
	for x in map_size.x:
		for y in map_size.y:
			if $nav/Grass.get_cell(x,y) == -1:
				if $nav/Grass.get_cell(x,y-1) == 0:
					$nav/Background.set_cell(x,y,0)
				
	$nav/Background.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))
				


