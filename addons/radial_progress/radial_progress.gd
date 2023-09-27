@tool 
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("RadialProgress", "Control", preload("RadialProgress.gd"),\
			preload("icon.png"));
	
func _exit_tree() -> void:
	remove_custom_type("RadialProgress");
