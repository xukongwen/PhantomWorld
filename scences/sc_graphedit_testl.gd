extends Control

var spn = load("res://scences/nodes/graph_node.tscn")
var ini_positon = Vector2(40,40)
var node_index = 0


func _on_back_pressed():
	get_tree().change_scene("res://scences/Sc_test_menu.tscn")



func _on_Button_pressed():
	# fun里可以定义var，然后instance（）就是做了一个实例
	var node = spn.instance()
	node.offset += ini_positon + (node_index*Vector2(20,20))
	$GraphEdit.add_child(node)
	node_index += 1


func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	$GraphEdit.connect_node(from, from_slot, to, to_slot)


func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	$GraphEdit.disconnect_node(from, from_slot, to, to_slot)
