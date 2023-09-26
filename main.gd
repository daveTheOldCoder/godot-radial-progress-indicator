extends Node2D

@onready var button: Button = $RunDemo
@onready var radial_progress: Control = $RadialProgress


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	button.disabled = true
	await radial_progress.animate(2.0)
	await get_tree().create_timer(1.0).timeout
	await radial_progress.animate(2.0, true)
	button.disabled = false
