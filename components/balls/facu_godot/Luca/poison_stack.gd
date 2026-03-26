extends Node

var damage = 1

func _process(delta: float) -> void:
	get_parent().life -= damage * delta


func _on_timer_timeout() -> void:
	queue_free()
