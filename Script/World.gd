extends Node

class_name World_dao, "res://Image/dao/world.png" #可以给一个icon！竟然！
	
var dao = 0
var yin = -1
var yang = 1
	
var yin_yang_now = 0
	
var temp = 0
var seazon = null

	
var second
var minute
var hour
var day


#################################################################################
##################################Functions######################################
#################################################################################
	
	
#世界的时间功能
func _init(time):
	var int_time = int(floor(time))
		
	second = int_time % 60
	minute = (int_time / 60) % 60
	hour = (int_time / (60 * 60)) % 24
	day = (int_time / (60 * 60 * 24))
		
#世界时间的事件激活功能
func equals(second, minute, hour, day):
	return self.second == second and self.minute == minute and self.hour == hour and self.day == day
	
















