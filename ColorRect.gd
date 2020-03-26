extends ColorRect

signal time_passed(date_time)

var speed = 10.0

var prev_time = 0.0
var time = 0.0

class DateTime:
	var second
	var minute
	var hour
	var day

	func _init(time):
		var int_time = int(floor(time))

		second = int_time % 60
		minute = (int_time / 60) % 60
		hour = (int_time / (60 * 60)) % 24
		day = (int_time / (60 * 60 * 24))

	func equals(second, minute, hour, day):
		return self.second == second and self.minute == minute and self.hour == hour and self.day == day


func _ready():
	connect("time_passed", self, "_on_time_passed")


func _process(delta):
	time += delta * speed
	

	var date_times = []
	var int_time = floor(time)
	var prev_int_time = floor(prev_time)
	while prev_int_time < int_time:
		var new = DateTime.new(prev_int_time)
		date_times.append(new)
		prev_int_time += 1
		
	

	emit_signal("time_passed", date_times)

	prev_time = time


func _on_time_passed(date_times):
	for dt in date_times:
		print(dt.second)
		if dt.equals(0, 5, 0, 0):
			color = Color("#FF0000")
