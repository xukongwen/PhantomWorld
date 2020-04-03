extends Node2D

var noise
var xoff = 100
var yoff = 10000
var xoff1 = 0
var yoff1 = 5000
var width 
var height 

func _ready():
	noise = OpenSimplexNoise.new()
	width = get_viewport().size.x / 2
	height = get_viewport().size.y / 2
#	noise = OpenSimplexNoise.new()
	noise.seed = randi()
#	noise.octaves = 1.0
#	noise.period = 12
#	noise.persistence = 0.7
	pass
	
	
func _process(delta):
	fly()
	
	
	
# 1d perlin noise的一个例子，是从p5那里搬过来的哈哈，这里是open noise，更高级，是出得-1，1的值
# 蝴蝶飞，这里可以模拟一些动物的行动
func fly():
	
	var px = noise.get_noise_1d(xoff)*width + 1900
	var py = noise.get_noise_1d(yoff)*height + 500
	
	var px1 = noise.get_noise_1d(xoff1)*width + 1700
	var py1 = noise.get_noise_1d(yoff1)*height + 500
	
	
	xoff += 0.06
	yoff += 0.06
	
	xoff1 += 0.03
	yoff1 += 0.05
	
	$man.position = Vector2(px,py)
	$man2.position = Vector2(px1,py1)
	
	
