extends CharacterBody2D


const SPEED = 430.0

func movement():
	var direction := Input.get_vector("Left", "Right","Up","Down")
	velocity = direction*SPEED
	
	if Input.is_action_pressed("Shift"):
		velocity = (direction*SPEED)/2

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	movement()
	move_and_slide()
