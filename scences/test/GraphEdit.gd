extends GraphEdit

var spn = load("res://scences/nodes/graph_node.tscn")

var graph_nodes = []

onready var p_edit = self
onready var save_pop = get_node("../HBoxContainer/b_save/save_g")
onready var load_pop = get_node("../HBoxContainer/b_load/load_g")

#===添加graphnode
func _on_b_addnode_pressed():
	var node = spn.instance()
	#新的node根据鼠标的所在来添加
	node.set_offset(get_viewport().get_mouse_position() + p_edit.scroll_offset)
	# 这里一定要加true，一定要给一个独特的名字，否则后面一定悲剧
	add_child(node, true)
	print(node.name)
#===拿到所有graphnode	
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

#===清除所有graphnode
func clear_all_nodes():
	graph_nodes = []
	for i in p_edit.get_children():
		if i is GraphNode:
			i.queue_free()
	clear_connections()
	
func _on_b_new_pressed():
	clear_all_nodes()
	
func _on_save_g_file_selected(path):
	get_all_graphnode()
	var save_data = []
	var connections = get_connection_list()
	var file = File.new()
	#===制作并记录在场node数据
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
				
		save_data.append(n_data)
	#===写入存档	
	file.open(path, file.WRITE)
	file.store_line(to_json(save_data))
	file.close()

func _on_load_g_file_selected(path):
	var load_data = []
	clear_all_nodes()
	#===读取存档
	var file = File.new()
	file.open(path, file.READ)
	var data = JSON.parse(file.get_as_text())
	# 这里后面必须加个.result否则只是一个json的怪格式
	load_data = data.result
	file.close()

	#===根据存档创建node
	for i in load_data:
		var node = spn.instance()
		#恢复位置，内容，大小
		node.get_child(0).get_child(0).text = i["node_text"]
		node.offset = Vector2(i["node_pos_x"],i["node_pos_y"])
		node.rect_min_size = Vector2(i["node_width"], i["node_height"])
		#给当下的instance改名，于是下面连线可以对应,这里应该注意，上面产生的instance的命名是随机的，所以必须改成之前记录的
		node.set_name(i["node_name"])
		add_child(node)
		
	#===连接node
	for i in range(0, load_data.size()):
		var connect_to = load_data[i]["connect_to"]
		var connect_from = load_data[i]["node_name"]
		for x in range(connect_to.size()):
			connect_node(connect_from,0,connect_to[x],0)
			
	
