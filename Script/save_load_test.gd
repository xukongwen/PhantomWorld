extends Node
# 这个文件在项目设置里要放在autoload里enable

var item_data = {}

const PATH = "user://my_save.json"

var new_data = {"gancao": 10}

# 一个可读的json示例，未来实验一下伤寒论
var default_data = {
	"player" : {
		"name" : "Jamie",
		"level" : 3,
		"health" : 10
		},
	"options" : {
		"music_volume" : 0.5,
		"cheat_mode" : false
		},
	"levels_completed" : [1, 2, 3]
}


# 这次至少终于读出来了！
func _ready():
	#先做一个文件
	var itemdatafile = File.new()
	#这个文件打开目标data文件
	itemdatafile.open("res://data/test_2.json", File.READ)
	#读取里面json格式，读到一个文件
	var item_data_json = JSON.parse(itemdatafile.get_as_text())
	#读完了关闭
	itemdatafile.close()
	item_data = item_data_json.result
	
	print(item_data)
	
	on_save()
	on_load()
	
# 这个是存成json，存成功了
func on_save():
	print("saving")
	var save_file = File.new()
	save_file.open(PATH, File.WRITE)
	#这里就是写成json
	save_file.store_line(to_json(new_data))
	save_file.close()
	
# 读就是反过来，但是先要确定有没有这个存档，没有读话先存一个默认的
func on_load():
	print("loading")
	var file = File.new()
	if not file.file_exists(PATH):
		reset_data()
		return
	file.open(PATH, file.READ)
	var text = JSON.parse(file.get_as_text())
	item_data = text.result
	print(item_data)
	
	
func reset_data():
	item_data = default_data.duplicate(true)
	
