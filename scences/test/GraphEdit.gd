extends GraphEdit

var spn = load("res://scences/nodes/graph_node.tscn")

var graph_nodes = []
var nodes = []

onready var p_edit = self
onready var save_pop = get_node("../HBoxContainer/b_save/save_g")
onready var load_pop = get_node("../HBoxContainer/b_load/load_g")

func _on_b_addnode_pressed():
	var node = spn.instance()
	#新的node根据鼠标的所在来添加
	node.set_offset(get_viewport().get_mouse_position() + p_edit.scroll_offset)
	p_edit.add_child(node)
	
	
func get_all_graphnode():
	var nodes = self.get_children()
	for node in nodes:
		if node is GraphNode:
			graph_nodes.append(node)



func _on_b_save_pressed():
	save_pop.popup()
	

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)
	

func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	disconnect_node(from, from_slot, to, to_slot)


func _on_b_load_pressed():
	load_pop.popup()
	

func clear_all_nodes():
	graph_nodes = []
	nodes = []
	for i in p_edit.get_children():
		if i is GraphNode:
			i.queue_free()
	clear_connections()
	

func _on_b_new_pressed():
	clear_all_nodes()
	
	
func _on_save_g_file_selected(path):
	get_all_graphnode()
	var all_save_data = []
	var save_data = []
	var connections = get_connection_list()
	var file = File.new()
	
	print("connections:",connections)
	for i in self.get_children():
		if i is GraphNode:
			print(i.name)

	
	for i in graph_nodes:
		var n_data = {
			"node_name": "",
			"node_text": "" ,
			"node_pos_x": "",
			"node_pos_y": "",
			"node_width": "",
			"node_height": "",
			"connect_to": []
		}
		
		n_data["node_name"] = i.name
		n_data["node_text"] = i.get_child(0).get_child(0).text
		n_data["node_pos_x"] = i.rect_position.x
		n_data["node_pos_y"] = i.rect_position.y
		n_data["node_width"] = i.rect_size.x
		n_data["node_height"] = i.rect_size.y
		
		for j in connections:
			if j.from == i.name:
				n_data["connect_to"].append(j.to)
				print("to:", j.to)
				
		save_data.append(n_data)
		
	all_save_data = [save_data, connections]
	print("save_list:",all_save_data[0])
	
	file.open(path, file.WRITE)
	file.store_line(to_json(all_save_data))
	file.close()

func _on_load_g_file_selected(path):
	var load_data = []
	var nodes_now = []
	clear_all_nodes()
	
	var file = File.new()
	file.open(path, file.READ)
	var data = JSON.parse(file.get_as_text())
	# 这里后面必须加个.result否则只是一个json的怪格式
	load_data = data.result
	file.close()

	# 读node信息部分
	
	for i in range(0,load_data[0].size()):
		var node = spn.instance()
		p_edit.add_child(node)
		node.get_child(0).get_child(0).text = load_data[0][i]["node_text"]
		node.offset = Vector2(load_data[0][i]["node_pos_x"],load_data[0][i]["node_pos_y"])
		node.rect_min_size = Vector2(load_data[0][i]["node_width"], load_data[0][i]["node_height"])
		node.set_name(load_data[0][i]["node_name"])
		
	print("load_data:",load_data[0])
	print(self.get_children())
	for i in self.get_children():
		if i is GraphNode:
			print(i.name)
			
	
	for i in range(0, load_data[0].size()):
		var connect_to = load_data[0][i]["connect_to"]
		print(connect_to)
		for x in range(connect_to.size()):
			connect_node(load_data[0][i]["node_name"],0,connect_to[x],0)
		
	print("场上连接：", self.get_connection_list())
	
