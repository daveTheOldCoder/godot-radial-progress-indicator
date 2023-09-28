@tool
extends Control
class_name RadialProgress

@export var max_value: float = 100.0:
	set(v):
		max_value = v
		_draw()

@export var radius: float = 120.0:
	set(v):
		radius = v
		queue_redraw()

@export var progress: float = 0.0:
	set(v):
		progress = v
		queue_redraw()

@export var thickness: float = 20.0:
	set(v):
		thickness = v
		queue_redraw()

@export var bg_color := Color(0.5, 0.5, 0.5, 1.0):
	set(v):
		bg_color = v
		queue_redraw()

@export var bar_color := Color(0.2, 0.9, 0.2, 1.0):
	set(v):
		bar_color = v
		queue_redraw()


func _draw() -> void:
	draw_circle_arc(Vector2.ZERO, radius, 0.0, TAU, bg_color)
	var angle: float = (progress / max_value) * TAU 
	draw_circle_arc(Vector2.ZERO, radius, 0.0, angle, bar_color)
	draw_circle_arc(Vector2.ZERO, radius - thickness, 0.0, TAU, bg_color)

	
func _process(_delta: float) -> void:
	queue_redraw()


func animate(duration: float, clockwise: bool = true, initial_value: float = 0.0)\
		-> void:
	var from: float = initial_value if clockwise else max_value
	var to: float = max_value if clockwise else initial_value
	var tween: Tween = create_tween()
	tween.tween_property(self, "progress", to, duration).from(from)\
			.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	await tween.finished


func draw_circle_arc(center: Vector2, radius: float, angle_from: float,\
		angle_to: float, color: Color) -> void:
	var nb_points: int = 32
	var points_arc := PackedVector2Array()
	points_arc.push_back(center)
	var colors := PackedColorArray([color])
	var a: float = angle_from - (PI / 2.0)
	var b: float = (angle_to - angle_from) / float(nb_points)
	for i in range(nb_points + 1):
		var angle_point: float = a + float(i) * b
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
