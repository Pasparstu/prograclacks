extends Ball

@export var Poison_node: Node2D
@export var daga: Area2D


const Initial_Speed: int = 650
var speed: int = Initial_Speed
var direction: Vector2
var damage : float = 1
var bodies_inside = []
var damage_per_tick : float = 5

func _ready():
	direction = get_random_direction()

func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
	Poison_node.rotation += 15 * delta

func get_random_direction() -> Vector2:
	var new_direction = Vector2()
	new_direction.x = [1,-1].pick_random()
	new_direction.y = randf_range(-1,1)
	return new_direction.normalized()
	
func ball_physics_process(delta : float):
	string = "Damage: " + String.num(damage,2)
	Poison_node.rotation += 15 * delta
	

	for body in daga.get_overlapping_bodies():
		if body is Ball and body != self:
			attack(body,floor(damage))
			damage *= 1.25

func on_poison_timer_timeout() -> void:
	damage = true
	await get_tree().create_timer(0.5).timeout
	$Stabsound.play()
	damage_per_tick *= 1.25
	await get_tree().create_timer(0.1).timeout
	damage = false
