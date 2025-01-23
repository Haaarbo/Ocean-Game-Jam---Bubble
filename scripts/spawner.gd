extends Node2D

@export var bubble_scene: PackedScene #p/ bubble.tscn
@export var spawn_time = 1.0
@export var num_bubbles = 7 # Quantidade inicial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = spawn_time
	$Timer.start()
	$Timer.one_shot = false  # Faz com que o Timer continue repetindo
	$Timer.timeout.connect(_spawn_bubbles)

# Funcao para spawnar as bolhas
func _spawn_bubbles() -> void:
	for i in range(num_bubbles):
		var bubble = bubble_scene.instantiate()
		bubble.position = Vector2((i + 0.5) * get_viewport_rect().size.x / num_bubbles, 0)
		add_child(bubble)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
