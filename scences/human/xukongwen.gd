extends KinematicBody2D

enum{
	IDEL,
	MOVE,
	NEW_D,
	SPEAK,
	EAT,
	THINK
}

var speed = 100
var state = MOVE
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

var thinkings = ["今天要吃什么？","腰疼了","想看新闻"]
var speaking = ["我要去跑步了","带上口罩","想停下来"]
var eatting = ["热干面","素鸡","香椿炒鸡蛋"]

func _ready():
	randomize()
	

func _process(delta):
	match state:
		IDEL:
			update_state_panel("发呆")
			
			
		MOVE:
			update_state_panel("移动")
			move(delta)
			
		NEW_D:
			direction = choose([Vector2.RIGHT,Vector2.UP,Vector2.DOWN,Vector2.LEFT])
			update_state_panel("Moving to " + str(direction))
			state = choose([IDEL, MOVE])
			
		SPEAK:
			update_state_panel("说话")
			speak()
			
		EAT:
			update_state_panel("吃饭")
			eatting()
			
		THINK:
			update_state_panel("自言自语")
			ego()

# 这个func是个神器
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	position += direction*speed*delta
	
func speak():
	$Think_panle/Thinking.text = "徐空文说道：" + choose(speaking)
	
func ego():
	$Think_panle/Thinking.text = "徐空文想：" + choose(thinkings)
	
func eatting():
	$Think_panle/Thinking.text = "徐空文吃：" + choose(eatting)
	
	
func update_state_panel(state):
	$State_panle/State.text = state

func _on_Timer_timeout():
	$Timer.wait_time = choose([0.5,1,1.5])
	state = choose([IDEL,MOVE,NEW_D,EAT,SPEAK,THINK])
