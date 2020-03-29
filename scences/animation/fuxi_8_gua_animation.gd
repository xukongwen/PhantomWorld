extends Control

onready var yang = preload("res://scences/animation/yang_box.tscn")
onready var yin = preload("res://scences/animation/yin_box.tscn")

var space_1 = 20
var start_x = 1000
var start_y = 700

var test1 = [1, -1]

func _ready():
	
	print(xian_tian(3))
	
	#draw_gua(test1)
	
	fuxi(9)
	

	
func draw_gua(gua, x):
	for i in range(gua.size()):
		if gua[i] == 1:
			var new_yang = yang.instance()
			new_yang.rect_position = Vector2((start_x + space_1*x), (start_y - (space_1*i)))
			add_child(new_yang)
			
		if gua[i] == -1:
			var new_yin = yin.instance()
			new_yin.rect_position = Vector2((start_x + space_1*x), (start_y - (space_1*i)))
			add_child(new_yin)
	
	


func fuxi(num):
	var newGua = []
	if num == 0:
		return [0]
	elif num == 1:
		#draw_gua([1,-1])
		return [[1],[-1]]
		
	else:
		var preGua = fuxi(num-1)
		for gua in preGua:
			newGua.append([1] + gua)
			newGua.append([-1] + gua)
			#draw_gua(newGua)
	
	for i in range(newGua.size()):
		draw_gua(newGua[i],i)
		
	return newGua
	

func xian_tian(num):
	var newGua = []
	if num == 0:
		return [0]
	elif num == 1:
		return [[1],[-1]]
		
	else:
		var preGua = xian_tian(num-1)
		for gua in preGua:
			newGua.append([1] + gua)
			newGua.append([-1] + gua)
			
	return newGua

		
