extends Tabs


var spn = load("res://scences/nodes/graph_node.tscn")
var ini_positon = Vector2(40,40)
var node_index = 0

var all_save_data = []
var save_data = []
var new_nodes = []
var nodes = []
var connections = []

onready var p_edit = $VBoxContainer/GraphEdit



func _on_b_addnode_pressed():
	var node = spn.instance()
	node.offset += ini_positon + (node_index*Vector2(20,20))
	p_edit.add_child(node)
	node_index += 1
	
