@tool
extends Control
class_name RadialProgress

@export var max_value: float = 100.0
@export var radius: float = 120.0
@export var progress: float = 0.0
@export var thickness: float = 20.0
@export var bg_color := Color(0.5, 0.5, 0.5, 1.0)
@export var bar_color := Color(0.2, 0.9, 0.2, 1.0)
@export var ring: bool = false
@export var nb_points: int = 32

func _draw() -> void:
	var angle: float = (progress / max_value) * TAU
	if ring:
		draw_ring_arc(Vector2.ZERO, radius, radius-thickness, 0.0, TAU, bg_color)
		draw_ring_arc(Vector2.ZERO, radius, radius-thickness, 0.0, angle, bar_color)
	else:
		draw_circle_arc(Vector2.ZERO, radius, 0.0, TAU, bg_color)
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
	var points_arc := PackedVector2Array()
	points_arc.push_back(center)
	var colors := PackedColorArray([color])
	var a: float = angle_from - (PI / 2.0)
	var b: float = (angle_to - angle_from) / float(nb_points)
	for i in range(nb_points + 1):
		var angle_point: float = a + float(i) * b
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)


func draw_ring_arc(center: Vector2, radius1: float, radius2: float,\
		angle_from: float, angle_to: float, color: Color) -> void:
	var points_arc := PackedVector2Array()
	var colors := PackedColorArray([color])
	var a: float = angle_from - (PI / 2.0)
	var b: float = (angle_to - angle_from) / float(nb_points)
	for i in range(nb_points + 1):
		var angle_point: float = a + float(i) * b
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius1)
	for i in range(nb_points, -1, -1):
		var angle_point: float = a + float(i) * b
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius2)
	draw_polygon(points_arc, colors)
