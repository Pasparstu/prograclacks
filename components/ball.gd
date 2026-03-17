extends RigidBody2D
class_name Ball

@export_group("Customizar")
@export var ball_name : String
@export_range(0.5,2) var size : float = 1.0
@export var color : Color = Color(0.5,0.5,0.5)
@export_range(0.01,1) var attack_cooldown : float = 0.25
@export_group("Nodos")
@export var elements : Node2D
@export var sprite : Sprite2D
@export var collision_shape : CollisionShape2D
@export var attack_timer : Timer
@export var clack_sound : AudioStreamPlayer2D
@export var label : Label

var string : String = ""
var life : int = 200

func _ready() -> void:
	sprite.scale = Vector2(1,1) * size
	elements.scale = Vector2(1,1) * size
	collision_shape.scale = Vector2(1,1) * size
	sprite.modulate = color
	attack_timer.wait_time = attack_cooldown
	label.text = str(life)
	label.label_settings.font_size = int(48 * size)

func _physics_process(delta: float):
	sprite.scale = Vector2(1,1) * size
	elements.scale = Vector2(1,1) * size
	collision_shape.scale = Vector2(1,1) * size
	sprite.modulate = color
	attack_timer.wait_time = attack_cooldown
	label.text = str(life)
	label.label_settings.font_size = int(48 * size)
	if life <= 0: queue_free()
	ball_physics_process(delta)
	if get_contact_count() > 0 and not clack_sound.playing:
		clack_sound.play()

func ball_physics_process(_delta : float):
	pass

func attack(ball : Ball, damage : int):
	if attack_timer.is_stopped():
		ball.life -= damage
		attack_timer.start()
		await get_tree().physics_frame
		if ball:
			ball.label.modulate = Color.RED
			create_tween().tween_property(ball.label,"modulate",Color.WHITE,0.5)
		#$"..".dramatic_pause()
