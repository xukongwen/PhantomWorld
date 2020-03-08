extends Node2D


var time = 0
var time_mult = 60
var paused = false
var time_scale = 1

var prev_time = 0
var deg = 0

signal time_passed(date_time)

func _ready():
	
	# 这里是把signal和接收的func链接起来
	connect("time_passed",self,"_on_time_passed")


class DateTime:
	
	var second
	var minute
	var hour
	var day
#	var week
#	var month
#	var year

	
	
	func _init(time):
		var int_time = int(floor(time))
		
		second = int_time % 60
		minute = (int_time / 60) % 60
		hour = (int_time / (60 * 60)) % 24
		day = (int_time / (60 * 60 * 24))
		
	func equals(second, minute, hour, day):
		return self.second == second and self.minute == minute and self.hour == hour and self.day == day
	

func _process(delta):
	
	# 设定游戏事件和真实时间的差距
	time += delta*time_mult
	
	var date_times = []
	var int_time = floor(time) + 1
	var prev_int_time = floor(prev_time) + 1
	while prev_int_time < int_time:
		date_times.append(prev_int_time)
		prev_int_time += 1
	
	# 这个DateTime.new(time)就是获取秒，分，小时，日的时间信息结构
	emit_signal("time_passed", DateTime.new(time))
	
	prev_time = time
	
	$time_lable.text = str("日:  ", DateTime.new(time).day,"  ", "时:  ", DateTime.new(time).hour,"点")
	
	

func _on_time_passed(date_times):
	
	if date_times.equals(0,0,12,0):
		$event.text = "现在是正午"
		
	
	deg = (0.1/60) * time_scale*time_mult
	#$deg.text = str("每一秒增加：", deg*60," 度")
	$deg.visible = false
		
	
	$human_01/yinyang.rotation_degrees += (0.1/60)*time_scale/24*60
	

func _on_Button_pressed():
	get_tree().quit()
	


func _on_time1_pressed():
	# 时间变速
	time_scale = 1
	Engine.set_time_scale(1)
	

func _on_time5_pressed():
	time_scale = 60
	Engine.set_time_scale(time_scale)


func _on_light_pressed():
	var light_stat = not $human_01/yinyang/yang/Light2D.enabled
	$human_01/yinyang/yang/Light2D.enabled = light_stat
	$ColorRect.visible = light_stat
	pass # Replace with function body.
