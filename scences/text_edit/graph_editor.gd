extends GraphEdit

var spn = load("res://scences/nodes/graph_node.tscn")
onready var p_edit = self
onready var save_pop = get_node("save_as_file")
onready var load_pop = get_node("open_file")
onready var pop_menu = get_node("graph_menu")
var graph_nodes = []
var mouseInGraphEdit = false

var app_name = "Phantom Text Editor"
const UNTITLE = 'untitled'
var current_name = UNTITLE

func _input(event):
	if mouseInGraphEdit and \
	event is InputEventMouseButton \
	and event.button_index == BUTTON_RIGHT \
	and event.pressed:
		pop_menu.popup()
		pop_menu.rect_position = event.position


func _ready():
	update_title()
	self.get_zoom_hbox().visible = false
	
	pop_menu.connect("id_pressed",self,"_on_item_pressed")
	
func update_title():
	OS.set_window_title(app_name + "-" + current_name)
	
func _on_item_pressed(id):
	if pop_menu.get_item_text(id) == "添加Node":
		add_node()
		
	if pop_menu.get_item_text(id) == "新建Graph":
		current_name = UNTITLE
		update_title()
		clear_all_nodes()
		
	elif pop_menu.get_item_text(id) == "打开":
		load_pop.popup()
		
	elif pop_menu.get_item_text(id) == "储存":
		save_file()
		
	elif pop_menu.get_item_text(id) == "另存":
		save_pop.popup()
		
	elif pop_menu.get_item_text(id) == "网格":
		var snap = not p_edit.use_snap
		p_edit.use_snap = snap	
		
func add_node():
	var node = spn.instance()
	#新的node根据鼠标的所在来添加
	node.set_offset(get_viewport().get_mouse_position() + p_edit.scroll_offset)
	# 这里一定要加true，一定要给一个独特的名字，否则后面一定悲剧
	add_child(node, true)

func get_all_graphnode():
	var nodes = self.get_children()
	for node in nodes:
		if node is GraphNode:
			graph_nodes.append(node)
			
func clear_all_nodes():
	graph_nodes = []
	for i in p_edit.get_children():
		if i is GraphNode:
			i.queue_free()
	clear_connections()
	
func save_file():
	var path = current_name
	if path == UNTITLE:
		save_pop.popup()
	else:
		var file = File.new()
		file.open(path, file.WRITE)
		file.store_line(to_json(save()))
		file.close()
		update_title()

func save():
	get_all_graphnode()
	var save_data = []
	var connections = get_connection_list()
	
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
	update_title()
	return save_data
	
func save_as(path):
	var file = File.new()
	file.open(path, file.WRITE)
	file.store_line(to_json(save()))
	file.close()
	current_name = path
	update_title()
	
func open(path):
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
	current_name = path
	update_title()
	

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)

func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	disconnect_node(from, from_slot, to, to_slot)


func _on_GraphEdit_mouse_entered():
	mouseInGraphEdit = true

func _on_GraphEdit_mouse_exited():
	mouseInGraphEdit = false


func _on_open_file_file_selected(path):
	open(path)

func _on_save_as_file_file_selected(path):
	save_as(path)
