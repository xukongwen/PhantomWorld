extends Node2D


var time = 0
var time_mult = 1
var paused = false
var time_scale = 1

var prev_time = 0

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
	
	$time_lable.text = str("second:",DateTime.new(time).second, "min:", DateTime.new(time).minute)
	
		

func _on_time_passed(date_times):
	
	if date_times.equals(10,0,0,0):
		$event.text = "this is noon"
	
#	for dt in date_times:
#		print(date_times)
#		if dt.equals(10, 0, 0, 0):
#			$event.text = "this is noon"
#		print(dt)


func _on_Button_pressed():
	get_tree().quit()
	


func _on_time1_pressed():
	# 时间变速
	Engine.set_time_scale(1)
	


func _on_time5_pressed():
	Engine.set_time_scale(5)
