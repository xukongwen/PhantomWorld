extends GraphEdit


var spn = load("res://scences/nodes/graph_node.tscn")
var ini_positon = Vector2(40,40)
var node_index = 0
const path = "user://node_save_test_1.json"

var all_save_data = []
var save_data = []
var graph_nodes = []
var nodes = []
var connections = []

onready var p_edit = self

func _on_b_addnode_pressed():
	var node = spn.instance()
	node.offset += ini_positon + (node_index*Vector2(20,20))
	p_edit.add_child(node)
	node_index += 1
	
func get_all_graphnode():
	var nodes = self.get_children()
	for node in nodes:
		if node is GraphNode:
			graph_nodes.append(node)
	
	var node_list = p_edit.get_connection_list()
	connections = node_list


func _on_b_save_pressed():
	get_all_graphnode()
	print("所有graph_node:", graph_nodes)
	all_save_data = []
	save_data = []
	var file = File.new()
	
	for i in graph_nodes:
		#print(node.get_node("TextEdit"))
		var n = i.get_node("TextEdit")
		var p = i.rect_position
		var s = i.rect_size
		
		var n_data = {
			"node_text": i.text, 
			"node_pos_x": p.x,
			"node_pos_y": p.y,
			"node_width": s.x,
			"node_height": s.y
		}
		save_data.append(n_data)
		
	all_save_data = [save_data, connections]
	file.open(path, file.WRITE)
	file.store_line(to_json(all_save_data))
	file.close()
	
	
	

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	p_edit.connect_node(from, from_slot, to, to_slot)
	

func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	p_edit.disconnect_node(from, from_slot, to, to_slot)


func _on_b_load_pressed():
	get_all_graphnode()
	clear_all_nodes()
	
	var file = File.new()
	file.open(path, file.READ)
	var data = JSON.parse(file.get_as_text())
	# 这里后面必须加个.result否则只是一个json的怪格式
	all_save_data = data.result
	file.close()
	load_nodes()
	
func load_nodes():
	graph_nodes = []
	# 读node信息部分
	for i in all_save_data[0]:
		var node = spn.instance()
		node.get_node("TextEdit").text = i["node_text"]
		# 奇怪，用offset就行，rect_positon就不行
		node.offset = Vector2(i["node_pos_x"],i["node_pos_y"])
		# 大小也奇怪，必须用rect_min_size而rect_size就不行
		node.rect_min_size = Vector2(i["node_width"], i["node_height"])
		p_edit.add_child(node)
	
	# 读connection信息部分
	for i in all_save_data[1]:
		print("链接：", i)
		p_edit.connect_node(i["from"], i["from_port"], i["to"], i["to_port"])
		p_edit.connect_node(i["from"], i["from_port"], i["to"], i["to_port"])

func clear_all_nodes():
	p_edit.clear_connections()
	for i in p_edit.get_children():
		if i is GraphNode:
			i.free()
