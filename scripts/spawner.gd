extends Node2D

@export var bubble_scene: PackedScene #p/ bubble.tscn
@export var spawn_time = 1.0
@export var num_bubbles = 7 # Quantidade inicial
@export var max_degrees = 10 # Limite de niveis de linhas de bolhas

@export var distanciaWaves = 100  # Distância entre as waves

# Lista para armazenar as waves de bolhas geradas
var waves = []

# Variavel para controle de altura de descida
var current_wave_y = 0  # Wave atual, settada pra ser a primeira posicao

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Tempo inicial em que as bolhas vao spawnar 
	$Timer.wait_time = spawn_time
	$Timer.start()
	$Timer.one_shot = false  # Faz com que o Timer continue repetindo
	$Timer.timeout.connect(_spawn_bubbles) # Ao encerrar, chama a funcao de spawn

# Funcao para spawnar as bolhas
func _spawn_bubbles() -> void:
	if current_wave_y >= max_degrees:
		return  # Não spawnar mais bolhas se atingir o limite
	
	# Cria uma nova wave de bolhas
	var new_wave = []

	# Apos o padrao de 7 bolhas, a quantidade sera 8, depois 7, depois 8, etc...
	num_bubbles = 8 if num_bubbles == 7 else 7
	
	# Se ainda nao atingiu o limite maximo do nivel da wave
	if current_wave_y < max_degrees:
		current_wave_y += 1
		
	for i in range(num_bubbles): # Acontecera o set de bolhas em fileira
		# Instancia/cria mais uma bolha
		var bubble = bubble_scene.instantiate()
		# Posiciona ela ao lado
		bubble.position = Vector2((i + 0.5) * get_viewport_rect().size.x * 0.5 / num_bubbles, 0) #a nova instancia SEMPRE começa do topo, por isso 0
		
		# Adiciona a bolha à nova onda
		new_wave.append(bubble)
		add_child(bubble)
	
	# Depois de add todas as bolhas, a wave criada e inseridda na lista de waves existentes
	# Na posicao 0, pois esta estrutura tem o comportamento de PILHA
	waves.insert(0, new_wave)
	
	# Como houve uma nova wave, as outras devem ser reposicionadas para baixo
	for i in range(1, len(waves)): # loop p/ a quantidade de waves que tem
		for bubble in waves[i]: # Dentro da wave[i], para cada bolha...
			bubble.position.y += distanciaWaves  # Desce cada uma das bolhas da onda anterior pela distancia que definimos
		
	# Se atingiu o limite de ondas, não cria mais ondas
	# A principio, sao 10 ondas, definidas em max_degrees
	if len(waves) > max_degrees:
		# Remove a última onda para manter o número de ondas dentro do limite
		var old_wave = waves.pop_back()
		for bubble in old_wave:
			bubble.queue_free()  # Remove as bolhas da última onda
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
