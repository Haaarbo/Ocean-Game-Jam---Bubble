extends CharacterBody2D

const SPEED = 300.0
var runSpeed = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var focus_sprite = $Collision/focusSprite
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	pass
	
func _input(event):
	if event.is_action_released("focus"):
		focus_sprite.visible = false
		runSpeed = 1
	if event.is_action_pressed("focus"):
		focus_sprite.visible = true
		runSpeed = 0.5

func _physics_process(_delta):
	var direction_x = Input.get_axis("Left","Right")
	var direction_y = Input.get_axis("Up", "Down")
	if velocity.x > 0:
		animated_sprite_2d.play("Esquerda")
		
	elif velocity.x < 0:
		animated_sprite_2d.play("Direita")
	else:
		animated_sprite_2d.play("Default")
	if direction_x || direction_y:
		velocity.x = direction_x * SPEED * runSpeed
		velocity.y = direction_y * SPEED * runSpeed
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
