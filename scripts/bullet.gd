extends Node2D

@export var bubble_type: String
const speed: int = 200
var _type: int = 1

var type = _type: 
	get: 
		return _type
	set(val):
		_type = val

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta

