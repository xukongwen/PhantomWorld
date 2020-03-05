extends Control

var spn = load("res://scences/nodes/graph_node.tscn")
var ini_positon = Vector2(40,40)
var node_index = 0

var all_save_data = []
var save_data = []
var new_nodes = []

var connections = []

onready var p_edit = $VBoxContainer/GraphEdit

func _on_save_button_pressed():
	
	#下面两个是全面清空数据，从当下node情况来储存
	get_new_node()
	all_save_data = []
	save_data = []

	var file = File.new()
	
	# 把node转换成一个一个json
	for i in new_nodes:
		# 这里就是拿child里的node的方法，其实就是你知道node名字就行了
		var n = i.get_node("TextEdit")
		var p = i.rect_position
		var s = i.rect_size
		var id = 0
		# 这里是制作一个dic，里面就是node需要被存储的各种信息
		var n_data = {
			"node_text": n.text, 
			"node_pos_x": p.x,
			"node_pos_y": p.y,
			"node_width": s.x,
			"node_height": s.y
		}
		#存到总data里
		save_data.append(n_data)
		#print("存的数据",n_data)
	# 把node信息与connection信息合成一个总arry，放在一个文件里
	all_save_data = [save_data, connections]
	
	file.open("user://node_save_test.json", file.WRITE)
	file.store_line(to_json(all_save_data))
	
	file.close()
	
func _on_load_button_pressed():
	get_new_node()
	clear_all_nodes()
	
	var file = File.new()
	file.open("user://node_save_test.json", file.READ)
	var data = JSON.parse(file.get_as_text())
	# 这里后面必须加个.result否则只是一个json的怪格式
	all_save_data = data.result
	file.close()
	load_nodes()
	
# 读取node信息并创建
func load_nodes():
	new_nodes = []
	
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

func check_node():
	var node_list = $GraphEdit.get_connection_list()
	print("slot链接信息:")
	print(node_list)

func _on_back_pressed():
	get_tree().change_scene("res://scences/Sc_test_menu.tscn")



func _on_Button_pressed():
	# fun里可以定义var，然后instance（）就是做了一个实例
	var node = spn.instance()
	node.offset += ini_positon + (node_index*Vector2(20,20))
	p_edit.add_child(node)
	node_index += 1
	
	

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	p_edit.connect_node(from, from_slot, to, to_slot)


func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	p_edit.disconnect_node(from, from_slot, to, to_slot)


# 下面这个就是拿到当下所有node的信息，存和读之前都要执行
func get_new_node():
	var all_node = p_edit.get_children()
	new_nodes = []
	for i in all_node:
		if i.has_node("TextEdit"):
			new_nodes.append(i)
		else:
			pass
	
	var node_list = p_edit.get_connection_list()
	connections = node_list
	

func _on_info_button_pressed():
	
	for i in connections:
		print("from:",i["from"])
	
			
	print("list:", connections)
	
