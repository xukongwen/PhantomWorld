extends TextureButton


func _on_TextureButton_pressed():
	$click.play()
	$b_click_ani.set_frame(0)
	$b_click_ani.play()
	


func _on_TextureButton_mouse_entered():
	$hover.play()
	
