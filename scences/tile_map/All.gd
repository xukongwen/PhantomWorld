extends TileMap

onready var tile_name = preload("res://scences/tile_map/tile_name.tscn")
onready var tt = tile_name.instance()
func _ready():
	add_child(tt)

func _unhandled_input(event: InputEvent) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var tile_pos = world_to_map(mouse_pos)
	var tile_cell_at_mouse_pos = get_cellv(tile_pos)

	var t_name = tile_set.tile_get_name(get_cellv(tile_pos))
	tt.get_node("Panel/Label").text = t_name
	tt.rect_position = mouse_pos
	print(mouse_pos)

	if event is InputEventMouseMotion and tile_cell_at_mouse_pos == INVALID_CELL : 
		tt.get_node("Panel/Label").text = "空的"
		


	
	
		
	
		
	


