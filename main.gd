extends Node2D

@onready var button: Button = $RunDemo
@onready var radial_progress: Control = $RadialProgress

func _ready() -> void:
	button.pressed.connect(func(): radial_progress.animate(3.0))
