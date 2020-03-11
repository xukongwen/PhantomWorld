extends GraphNode

func _on_Node_resize_request(new_minsize):
	self.rect_size = new_minsize


func _on_Node_close_request():
	self.queue_free()
	

func _on_Node_resized():
	get_node("VBoxContainer/TextEdit").rect_min_size.y = self.get_rect().size.y - 45
