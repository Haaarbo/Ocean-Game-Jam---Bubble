extends Area2D

# Velocidade do projétil
@export var speed = 200.0
# Referência ao jogador para verificar o tipo de projétil
@export var bubble_type: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Move o projetil para baixo
	position.y += speed * delta
	# Remove o projétil ao sair da tela
	if position.y > get_viewport_rect().size.y:
		queue_free()
	
func _on_area_entered(area):
	# Verifica se a colisão é com outro projétil do mesmo tipo
	if area.is_in_group("spawner") and area.bubble_type == self.bubble_type:
		#Destroi as bolhas
		destroy_connected_bubbles()

#Funcao para destruir as bolhas nas devidas condicoes
func destroy_connected_bubbles():
	# Busca todos os projéteis conectados e do mesmo tipo para destruir
	var to_destroy = get_connected_bubbles()
	# Checa todas as bolhas existente as que estao listadas para serem removidas e as destroi
	for bubble in to_destroy:
		bubble.queue_free()
		
#Funcao pra selecionar todas as bolhas que precisam ser destruidas
func get_connected_bubbles():
	var checked = [] #Bolhas checadas
	var to_check = [self]  # Bolhas a serem checadaas
	var connected = [] #Bolhas conectadas
	
	while to_check .size() > 0: #Ou seja, se tem bolhas que precisam ser checadas
		var currente = to_check.pop_front()
