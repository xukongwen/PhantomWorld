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
	
	make_allmap()
#
	
########自动生成地图部分#################

func make_allmap():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < grass_cap:
				$nav/All.set_cell(x,y,0)
			if a < road_caps.x and a > road_caps.y:
				$nav/All.set_cell(x,y,1)
			if a < enviroment_caps.x and a > enviroment_caps.y or a < enviroment_caps.z:
				# 这里是在2-3之间放置环境物品
				var chance = randi() % 100
				if chance < 2:
					#在2-3之间选择
					var num = [2,3]
					var new_n = num[randi() % num.size()]
					$nav/All.set_cell(x,y,new_n)
		
	# 下面是加载自动tile的东西	
	#$nav/All.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))	

			
	


