extends Control

var scene_path_load

# 取得每个按键对应要转场的信息
func _ready():
	# 这个是让键盘操作预先停留在新游戏按钮上
	$Main/VBoxContainer/buttons/NewGameButton.grab_focus()
	for button in $Main/VBoxContainer/buttons.get_children():
		button.connect("pressed", self, "_on_pressed", [button.scene_to_load])

# 按键下去之后先播放动画，要等动画播放完之后再切场景
func _on_pressed(scene_to_load):
	scene_path_load = scene_to_load
	$ColorRect.show()
	$ColorRect.fade_in()


# 退出游戏  dd
func _on_Button_pressed():
	get_tree().quit()

# 用esc退出
func _input(event):
	if event is InputEventKey:
		if (event as InputEventKey).scancode == KEY_ESCAPE:
			get_tree().quit()
		

		
# 动画播放完之后切场景
func _on_ColorRect_fade_finished():
	get_tree().change_scene(scene_path_load) 


func _on_go_test_button_pressed():
	get_tree().change_scene("res://scences/Sc_test_menu.tscn")
	
