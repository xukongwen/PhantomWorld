extends KinematicBody2D
onready var text = get_node("Panel/stat_text")

func _ready():
	pass


func task_speak(task):
	text.text = "说话中"
	print(text.text)
	yield(get_tree().create_timer(5.0), "timeout")
	task.succeed()
	
	
	
func task_eat(task):
	text.text = "吃饭中"
	print(text.text)
	yield(get_tree().create_timer(5.0), "timeout")
	task.succeed()
	

