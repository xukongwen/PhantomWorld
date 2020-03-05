extends GraphNode

func _on_Node_resize_request(new_minsize):
	rect_size = new_minsize


func _on_Node_close_request():
#	print(self.get_instance_id())
#	print(get_parent().get_connection_list())
#
	#get_parent().disconnect_node(self.get_instance_id(), 0, Node, 0)
	queue_free()
	
	
	
