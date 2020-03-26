extends "res://addons/godot-behavior-tree-plugin/action.gd"


enum{
	IDEL,
	MOVE,
	NEW_D,
	SPEAK,
	EAT,
	THINK
}

func tick(tick: Tick) -> int:
	
	tick.blackboard.set("Money", tick.blackboard.get("Money") + tick.blackboard.get("Wage"))
	
	Global.player.change_task(SPEAK)
	
	print("工作中:")
	print("\t钱: " , tick.blackboard.get("Money"), " (+", tick.blackboard.get("Wage"), ")" )

	return OK
