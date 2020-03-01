extends GraphNode


#func _ready():
#	set_slot(0,true,0,Color(1,1,1,1),true,0,Color(1,1,1,1))


# node可以关闭
func _on_Node_close_request():
	queue_free()

# node可以调整大小
func _on_Node_resize_request(new_minsize):
	rect_size = new_minsize
