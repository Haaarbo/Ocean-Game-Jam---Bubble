extends Node2D


const speed: int = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = transform.x * speed * delta
