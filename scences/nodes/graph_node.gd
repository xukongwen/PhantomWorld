extends GraphNode

func _on_Node_resize_request(new_minsize):
	rect_size = new_minsize


func _on_Node_close_request():
	queue_free()
	
	
	
