@tool 
extends EditorPlugin

func _enter_tree():
	add_custom_type("RadialProgressBar","Control",preload("RadialProgressBar.gd"),preload("icon.png"));
	
func _exit_tree():
	remove_custom_type("RadialProgressBar");

func _ready():
	pass # Replace with function body.


