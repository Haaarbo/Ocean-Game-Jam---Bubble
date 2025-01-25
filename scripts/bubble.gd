extends Area2D

# Velocidade do projétil
@export var speed = 200.0
# Referencia ao jogador para verificar o tipo de projétil
@export var bubble_type: String
# Variavel que guardara a pontuacao do jogador
@export var score: int = 0

# SO PRA SIMULAR A GRAVIDADE POR ENQUANTO DEPOIS TIRAR
var velocity = Vector2(0, 0)  # Velocidade da bolha
func _ready():
	add_to_group("bubble_group") # Diz que toda bubble pertence ao seu devido grupo. Usado para verificar colisao e posteriormente destruicao
	# Detecta quando a bolha colide com outro corpo
	connect("area_entered", Callable(self, "_on_area_entered"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func _on_area_entered(area):
	# Verifica se a colisão é com outra bolha do mesmo tipo
	if area.is_in_group("bubble_group") and area.bubble_type == self.bubble_type:
		# Obtém as bolhas conectadas e verifica se há uma combinação válida
		var connected_bubbles = get_connected_bubbles()
		if connected_bubbles.size() >= 2:
			# Destroi as bolhas
			destroy_bubbles(connected_bubbles)
			# Se houver, destroi bolhas isoladas
			destroy_isolated_bubbles()

#Funcao para destruir as bolhas nas devidas condicoes
func destroy_bubbles(bubbles): # bubbles aqui se refere a todas as bolhas conectadas, que devem ser destruidas
	# Checa todas as bolhas existente as que estao listadas para serem removidas e as destroi
	for bubble in bubbles: # P/ cada bolha das que devem ser destruidas...
		bubble.queue_free()
		update_score(bubble.score) 

# Funcao p/ verificar quem sao as isoladas e depois chama para serem destruidas
func destroy_isolated_bubbles():
	# Pega TODAS as bolhas
	var all_bubbles = get_tree().get_nodes_in_group("bubble_group")
	# Cria uma lista de bolhas isoladas, inicialmente nenhuma
	var isolated_bubbles = []
	for bubble in all_bubbles: # P/ cada bolha de TODAS...
		if bubble.get_connected_bubbles().size() == 0: # Se nao tem NENHUMA BOLHA em volta...
			isolated_bubbles.append(bubble) # Adiciona a uma lista de bolhas isoladas
	# Manda pro beleleu
	destroy_bubbles(isolated_bubbles)
	
#Funcao pra selecionar todas as bolhas que precisam ser destruidas
func get_connected_bubbles():
	var checked = [] # Bolhas JA checadas
	var to_check = [self]  # Bolhas a serem checadaas
	var connected = [] # Bolhas conectadas = que vao ser destruidas
	
	while to_check .size() > 0: #Ou seja, se tem bolhas que precisam ser checadas...
		##  Cria uma variavel de  
		var current = to_check.pop_front()
		
		if current in checked: # Se a bolha atual ja foi checada, entao passa pra proxima
			continue
		# Adiciona a bolha atual para as checadas
		checked.append(current)
		connected.append(current)
		
		# Adiciona bolhas conectadas do mesmo tipo
		for vizinho in current.get_vizinhos():
			# Se o vizinho tiver o mesmo tipo da bolha atual E s
			if vizinho.bubble_type == self.bubble_type and vizinho not in checked:
				to_check.append(vizinho)
	# Retorna a lista de bolhas conectadas
	return connected
# Funcao p/ atualizar o score do jogador
func update_score(points):
	score += points
	pass

func get_vizinhos():
	var vizinhos = []
	for other in get_tree().get_nodes_in_group("bubble_group"):
		if self != other and global_position.distance_to(other.global_position) < 32: #ex de 32 pixels de distancia, configurar dps
			vizinhos.append(other)
	return vizinhos
