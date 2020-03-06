extends Control


# 这个是神奇的游戏暂停大法
func _input(event):
	if event.is_action_pressed("pause"):
		var vis_state = not get_tree().paused
		get_tree().paused = vis_state
		visible = vis_state
