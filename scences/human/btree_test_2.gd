extends KinematicBody2D

enum{
	IDEL,
	MOVE,
	NEW_D,
	SPEAK,
	EAT,
	THINK
}

export(int, 100) var initial_hunger = 70
export(int, 1024) var initial_food = 0
export(int, 1024) var initial_money = 0

export(int, 1024) var food_price = 5
export(int, 1024) var wage = 2
export(int, 100) var max_hunger = 80

onready var blackboard = $BehaviorBlackboard
onready var behavior_tree = $BehaviorTree

var speed = 100
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var state

var current_day: int = 0

var thinkings = ["今天要吃什么？","腰疼了","想看新闻"]
var speaking = ["我要去跑步了","带上口罩","想停下来"]
var eatting = ["热干面","素鸡","香椿炒鸡蛋"]

func _ready():
	
	randomize()
	
	Global.player = self
	Global.state_text = $Panel/state_text
	Global.state = state
	
	blackboard.set("Hunger", initial_hunger)
	blackboard.set("Food", initial_food)
	blackboard.set("Money", initial_money)
	
	blackboard.set("FoodPrice", food_price)
	blackboard.set("Wage", wage)
	blackboard.set("MaxHunger", max_hunger)
	
func change_task(task):
	state = task
	
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


func move(delta):
	
	position += direction*speed*delta
	
	
func speak():
	$speak/speak_text.text = "徐空文说道：" + choose(speaking)
	
	
func ego():
	$speak/speak_text.text = "徐空文想：" + choose(thinkings)

	
func eatting():
	$speak/speak_text.text = "徐空文吃：" + choose(eatting)


func choose(array):
	array.shuffle()
	return array.front()

func _on_Timer_timeout():
	$Timer.wait_time = 2
	blackboard.set("Hunger", blackboard.get("Hunger") + 10)
	
	current_day += 1
	
#	print("\n--- ", current_day, ". 日 ---")
#	print("饥饿: " , blackboard.get("Hunger"))
#	print("食物: ", blackboard.get("Food"))
#	print("钱: " , blackboard.get("Money"))
#	print("\n")
	
	behavior_tree.tick(self, blackboard)
	
func update_state_panel(state):
	$Panel/state_text.text = state
