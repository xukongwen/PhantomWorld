extends Node2D


var this_world : World_dao

var time = 0
var time_mult = 60
var paused = false
var time_scale = 1
var prev_time = 0.0

var deg = 0
var tempture = 0

signal time_passed(date_time)

func _ready():
	
	# 这里是把signal和接收的func链接起来
	connect("time_passed",self,"_on_time_passed")



func _process(delta):
	
	# 设定游戏事件和真实时间的差距
	time += delta*time_mult
	
	var date_times = []
	var int_time = floor(time)
	var prev_int_time = floor(prev_time)
	while prev_int_time < int_time:
		var new = World_dao.new(prev_int_time)
		date_times.append(new)
		prev_int_time += 1

	# 这个DateTime.new(time)就是获取秒，分，小时，日的时间信息结构
	emit_signal("time_passed", date_times)
	
	prev_time = time
	
	$time_lable.text = str("日:  ", World_dao.new(time).day,"  ", "时:  ", World_dao.new(time).hour,"点")
		
	# 这里是把太阳，月亮的位置（角度）和游戏时间匹配
	$human_01/yinyang.rotation_degrees += (0.1/60)*time_scale/24*60
	
	
	

func _on_time_passed(date_times):
	for dt in date_times:
		temp(dt.hour)
		
		if dt.hour == 12:
			$event.text = "现在是正午"
		elif dt.hour == 0:
			$event.text = "现在是午夜"
		
#		if dt.equals(0,0,12,0):
#			$event.text = "现在是正午"
	
		
func temp(time):
	$deg.visible = true
	
	if time <= 12 and time >0:
		tempture += 1
		
	if time > 11 and time <= 23:
		tempture -= 1
	
	$deg.text = str(tempture)

func _on_Button_pressed():
	get_tree().change_scene("res://scences/Sc_test_menu.tscn")

func _on_time1_pressed():
	# 时间变速
	time_scale = 1
	Engine.set_time_scale(1)
	

func _on_time5_pressed():
	time_scale = 60
	Engine.set_time_scale(time_scale)


# 开关光
func _on_light_pressed():
	var light_stat = not $human_01/yinyang/yang/Light2D.enabled
	$human_01/yinyang/yang/Light2D.enabled = light_stat
	$ColorRect.visible = light_stat
