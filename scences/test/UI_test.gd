extends Control

var app_name = "Phantom Text Editor"
const UNTITLE = 'untitled'
var current_name = UNTITLE

func _ready():
	
	update_title()
	
	# 这里是menu添加下拉菜单选项
	$MenuButton.get_popup().add_item("New File")
	$MenuButton.get_popup().add_item("Open File")
	$MenuButton.get_popup().add_item("Save File")
	$MenuButton.get_popup().add_item("Save as File")
	
	# 按下那个下拉选项
	$MenuButton.get_popup().connect("id_pressed",self,"_on_item_pressed")
	$About.get_popup().connect("id_pressed",self,"_on_item_about")
	
	read_json_1()
	
func read_json_1():
	
	var data_file = File.new()
	
	assert(data_file.file_exists("res://data/test.json"))
	
	data_file.open("res://data/test.json", data_file.READ)
	var text_json = data_file.get_as_text()
	var result_json = parse_json(text_json)
	# assert(result_json.size() > 0)

	if result_json.error == OK:
		var data = result_json.result
		print(data)
	else:
		print("Error: ", result_json.error)
		print("Error Line: ", result_json.error_line)
		print("Error String: ", result_json.error_string)
		

	
# 更新title
func update_title():
	OS.set_window_title(app_name + "-" + current_name)
	
# 新文件
func new_file():
	current_name = UNTITLE
	update_title()
	$"TabContainer/text edit/TextEdit".text = ''
	
# 判断点选的是哪个，就运行哪个命令
func _on_item_pressed(id):
	var item_name = $MenuButton.get_popup().get_item_text(id)
	if item_name == "Open File":
		$open_file.popup()
		
	elif item_name == "New File":
		new_file()
		
	elif item_name == "Save File":
		save_file()
		
	elif item_name == "Save as File":
		$save_file.popup()
	
# 关于	
func _on_item_about(id):
	var item_name = $About.get_popup().get_item_text(id)
	if item_name == "About":
		$about_win.popup()

	
# 打开文件
func _on_open_file_file_selected(path):
	var f = File.new()
	f.open(path,1)
	$"TabContainer/text edit/TextEdit".text = f.get_as_text()
	f.close()
	current_name = path
	update_title()

# 储存文件（另存为）
func _on_save_file_file_selected(path):
	var f = File.new()
	f.open(path,2)
	f.store_string($"TabContainer/text edit/TextEdit".text)
	f.close()
	current_name = path
	update_title()
	
# 储存修改
func save_file():
	var path = current_name
	if path == UNTITLE:
		$save_file.popup()
		
	else:
		var f = File.new()
		f.open(path,2)
		f.store_string($"TabContainer/text edit/TextEdit".text)
		f.close()
		update_title()
