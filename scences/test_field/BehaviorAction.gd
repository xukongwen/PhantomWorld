extends "res://addons/godot-behavior-tree-plugin/action.gd"


func tick(tick: Tick) -> int:
	
	tick.blackboard.set("Money", tick.blackboard.get("Money") + tick.blackboard.get("Wage"))
	
	print("工作中:")
	print("\t钱: " , tick.blackboard.get("Money"), " (+", tick.blackboard.get("Wage"), ")" )

	return OK
