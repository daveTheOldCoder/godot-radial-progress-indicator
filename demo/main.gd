extends Node2D

@onready var button: Button = $Button
@onready var slider: Slider = $HSlider
@onready var radial_progress1: RadialProgress = $RadialProgress1
@onready var radial_progress2: RadialProgress = $RadialProgress2


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	slider.value_changed.connect(_on_slider_value_changed)


# Demonstrates RadialProgress animate() method.
func _on_button_pressed() -> void:
	button.disabled = true
	await radial_progress1.animate(2.0) # clockwise
	await get_tree().create_timer(0.5).timeout
	await radial_progress1.animate(2.0, false) # counterclockwise
	button.disabled = false


# Demonstrates explicit setting of RadialProgress progress property.
func _on_slider_value_changed(v: float) -> void:
	radial_progress2.progress =\
			(v - slider.min_value) / (slider.max_value - slider.min_value)\
			* radial_progress2.max_value
