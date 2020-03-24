extends GraphNode



func _on_Node_resized():
	get_node("VBoxContainer/TextEdit").rect_min_size.y = self.get_rect().size.y - 45


func _on_Node_close_request():
	var graph = get_parent()
	var node_name = self.name
	var connection_list = graph.get_connection_list()
	#手动去掉连线，否则有时它自己不会去掉
	for i in connection_list:
		if i["to"] == node_name or i["from"] == node_name:
			graph.disconnect_node(i["from"], i["from_port"], i["to"], i["to_port"])
	graph.remove_child(self)
	self.queue_free()


func _on_Node_resize_request(new_minsize):
	self.rect_size = new_minsize
