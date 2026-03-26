extends Ball

@export var Poison_node: Node2D
@export var daga: Area2D
@export var poison_stack_scene : PackedScene

const Initial_Speed: int = 650
var speed: int = Initial_Speed
var direction: Vector2
var damage : float = 1
var bodies_inside = []
var damage_per_tick : float = 5


func _ready():
	direction = get_random_direction()




func get_random_direction() -> Vector2:
	var new_direction = Vector2()
	new_direction.x = [1,-1].pick_random()
	new_direction.y = randf_range(-1,1)
	return new_direction.normalized()
	
func ball_physics_process(delta : float):
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
	Poison_node.rotation_degrees += 10 * delta
	string = "Damage: " + String.num(damage,2)
	Poison_node.rotation += 15 * delta
	

	for body in daga.get_overlapping_bodies():
		if body is Ball and body != self:
			var new_stack = poison_stack_scene.instantiate()
			body.add_child(new_stack)
			new_stack.damage = damage
			damage *= 1.01
	
