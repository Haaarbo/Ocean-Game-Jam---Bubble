extends CharacterBody2D


const SPEED = 430.0
var collision = get_slide_collision(0)

var life: int = 6
var grazebar: int = 100

func movement():
	var direction := Input.get_vector("Left", "Right","Up","Down")
	velocity = direction*SPEED
	
	if grazebar>0:
		velocity = (direction*SPEED)/2
		grazebar -= 0.005

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	movement()
	move_and_slide()
	if move_and_slide():
		print(collision.get_collider())
	
#func _process(delta: float) -> void:
