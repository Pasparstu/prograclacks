extends Node2D

@export var clash_sound : AudioStreamPlayer
@export var ball_1 : PackedScene
@export var ball_2 : PackedScene
@export var ball_1_info : Label
@export var ball_2_info : Label
@export var ball_1_name : Label
@export var ball_2_name : Label

var ball_1_instance : Ball
var ball_2_instance : Ball

func _ready() -> void:
	ball_1_instance = ball_1.instantiate()
	add_child(ball_1_instance)
	ball_1_instance.color = Color.PURPLE
	ball_1_instance.position = Vector2(-128,0)
	ball_2_instance = ball_2.instantiate()
	add_child(ball_2_instance)
	ball_2_instance.color = Color.CYAN
	ball_2_instance.position = Vector2(128,0)
	ball_2_instance.elements.rotation_degrees = 180
	ball_1_instance.elements.rotation += randi_range(-PI,PI)
	ball_2_instance.elements.rotation += randi_range(-PI,PI)

func _process(_delta: float) -> void:
	if ball_1_instance and ball_2_instance:
		ball_1_info.text = ball_1_instance.string
		ball_2_info.text = ball_2_instance.string
		ball_1_name.text = ball_1_instance.ball_name
		ball_2_name.text = ball_2_instance.ball_name

func dramatic_pause():
	get_tree().paused = true
	clash_sound.play()
	await clash_sound.finished
	get_tree().paused = false
