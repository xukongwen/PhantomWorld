extends Control

var app_name = "Phantom Text Editor"
const UNTITLE = 'untitled'
var current_name = UNTITLE

onready var menu = get_node("VBoxContainer/TabContainer/TextEdit/VBoxContainer/HBoxContainer/MenuButton")
onready var menu_about = get_node("VBoxContainer/TabContainer/TextEdit/VBoxContainer/HBoxContainer/About")
onready var text_edit = get_node("VBoxContainer/TabContainer/TextEdit/VBoxContainer/CenterContainer/TextEdit")
onready var open_file = get_node("VBoxContainer/TabContainer/TextEdit/VBoxContainer/HBoxContainer/MenuButton/open_file")
onready var save_file = get_node("VBoxContainer/TabContainer/TextEdit/VBoxContainer/HBoxContainer/MenuButton/save_file")
onready var about_win = get_node("VBoxContainer/TabContainer/TextEdit/VBoxContainer/HBoxContainer/About/about_win")
onready var p_edit = $VBoxContainer/TabContainer/GraphEdit/VBoxContainer/GraphEdit


func _ready():
	update_title()
	# 下面这个太牛了，可以隐藏那些特别难看的图标
	p_edit.get_zoom_hbox().visible = false
	
	
	# 这里是menu添加下拉菜单选项
	menu.get_popup().add_item("New File")
	menu.get_popup().add_item("Open File")
	menu.get_popup().add_item("Save File")
	menu.get_popup().add_item("Save as File")
	
	
	
	# 按下那个下拉选项
	menu.get_popup().connect("id_pressed",self,"_on_item_pressed")
	menu_about.get_popup().connect("id_pressed",self,"_on_item_about")
	
	

	
# 更新title
func update_title():
	OS.set_window_title(app_name + "-" + current_name)
	
# 新文件
func new_file():
	current_name = UNTITLE
	
	update_title()
	text_edit.text = ''
	
# 判断点选的是哪个，就运行哪个命令
func _on_item_pressed(id):
	var item_name = menu.get_popup().get_item_text(id)
	if item_name == "Open File":
		open_file.popup()
		
	elif item_name == "New File":
		new_file()
		
	elif item_name == "Save File":
		save_file()
		
	elif item_name == "Save as File":
		save_file.popup()
	
# 关于	
func _on_item_about(id):
	var item_name = menu_about.get_popup().get_item_text(id)
	if item_name == "About":
		about_win.popup()

	
# 打开文件
func _on_open_file_file_selected(path):
	var f = File.new()
	f.open(path,1)
	text_edit.text = f.get_as_text()
	f.close()
	current_name = path
	update_title()

# 储存文件（另存为）
func _on_save_file_file_selected(path):
	var f = File.new()
	f.open(path,2)
	f.store_string(text_edit.text)
	f.close()
	current_name = path
	update_title()
	
# 储存修改
func save_file():
	var path = current_name
	if path == UNTITLE:
		save_file.popup()
		
	else:
		var f = File.new()
		f.open(path,2)
		f.store_string(text_edit.text)
		f.close()
		update_title()


func _on_Button_pressed():
	get_tree().change_scene("res://scences/Sc_test_menu.tscn")


func _on_b_snap_pressed():
	var snap = not p_edit.use_snap
	p_edit.use_snap = snap
	
func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	p_edit.disconnect_node(from, from_slot, to, to_slot)
