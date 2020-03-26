extends KinematicBody2D

export(int, 100) var initial_hunger = 70
export(int, 1024) var initial_food = 0
export(int, 1024) var initial_money = 0

export(int, 1024) var food_price = 5
export(int, 1024) var wage = 2
export(int, 100) var max_hunger = 80

onready var blackboard = $BehaviorBlackboard
onready var behavior_tree = $BehaviorTree

func _ready():
	
	blackboard.set("Hunger", initial_hunger)
	blackboard.set("Food", initial_food)
	blackboard.set("Money", initial_money)
	
	blackboard.set("FoodPrice", food_price)
	blackboard.set("Wage", wage)
	blackboard.set("MaxHunger", max_hunger)
	
