@tool
extends Control


@export var max_value: float = 100.0
@export var radius: float = 120.0
@export var progress: float = 0.0
@export var thickness: float = 20.0
@export var bg_color := Color(0.5, 0.5, 0.5, 1.0)
@export var bar_color := Color(0.2, 0.9, 0.2, 1.0)


func set_max(value: float) -> void:
	max_value = value
	_draw()


func set_progress(v: float) -> void:
	progress = v
	queue_redraw()


func set_radius_and_thickness(r: float, th: float) -> void:
	radius = r
	thickness = th
	queue_redraw()


func set_colors(bg: Color, bar: Color) -> void:
	bg_color = bg
	bar_color = bar
	queue_redraw()


func _draw() -> void:
	draw_circle_arc(Vector2.ZERO, radius, 0.0, TAU, bg_color)
	var angle: float = progress * TAU / max_value
	draw_circle_arc(Vector2.ZERO, radius, 0.0, angle, bar_color)
	draw_circle_arc(Vector2.ZERO, radius - thickness, 0.0, TAU, bg_color)

	
func _process(delta: float) -> void:
	queue_redraw()


func animate(duration: float, reverse: bool = false, initial_value: float = 0.0)\
		-> void:
	var tween: Tween = create_tween()
	var from: int = max_value if reverse else initial_value
	var to: int = initial_value if reverse else max_value
	tween.tween_method(set_progress, from, to, duration)\
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
	for i: int in range(nb_points + 1):
		var angle_point: float = a + float(i) * b
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
