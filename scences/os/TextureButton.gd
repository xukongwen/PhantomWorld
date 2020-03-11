extends TextureButton


func _ready():
	connect("mouse_enter", self, "_mouse_enter")

func _mouse_enter():
	$hover.play()


func _on_TextureButton_pressed():
	$click.play()
	$b_click_ani.set_frame(0)
	$b_click_ani.play()
	
