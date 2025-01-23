extends Node2D

@export var bubble_scene: PackedScene #p/ bubble.tscn
@export var spawn_time = 1.0
@export var num_bubbles = 7 # Quantidade inicial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Tempo inicial em que as bolhas vao spawnar 
	$Timer.wait_time = spawn_time
	$Timer.start()
	$Timer.one_shot = false  # Faz com que o Timer continue repetindo
	$Timer.timeout.connect(_spawn_bubbles) # Ao encerrar, chama a funcao de spawn

# Funcao para spawnar as bolhas
func _spawn_bubbles() -> void:
	# Apos o padrao de 7 bolhas, a quantidade sera 8, depois 7, depois 8, etc...
	if num_bubbles == 7:
		num_bubbles = 8
	else:
		num_bubbles = 7
	for i in range(num_bubbles): # Acontecera a 
		var bubble = bubble_scene.instantiate()
		print(bubble.position)
		bubble.position = Vector2((i + 0.5) * get_viewport_rect().size.x * 0.5 / num_bubbles, 0)
		print(bubble.position)
		add_child(bubble)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
