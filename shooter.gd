extends Node2D

var Bullet = preload("res://bullet.tscn")
@onready var marker: Marker2D = $Marker2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees,0,360)

	if Input.is_action_just_pressed("Shoot"):
		var bullet_instance = Bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		
		print(bullet_instance.type)
		bullet_instance.global_position = marker.global_position
		bullet_instance.rotation = rotation
		
