extends Area2D

# Velocidade do projétil
@export var speed = 200.0
# Referência ao jogador para verificar o tipo de projétil
@export var bubble_type: String


#SO PRA SIMULAR A GRAVIDADE POR ENQUANTO DEPOIS TIRAR
var velocity = Vector2(0, 0)  # Velocidade da bolha
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))  # Conecta colisões com outras áreas
	# Detecta quando a bolha colide com outro corpo
	connect("area_entered", Callable(self, "_on_area_entered"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	# Remove o projétil ao sair da tela
	#if position.y > get_viewport_rect().size.y:
		#queue_free()
	
func _on_area_entered(area):
	# Verifica se a colisão é com outro projétil do mesmo tipo
	if area.is_in_group("spawner") and area.bubble_type == self.bubble_type:
		#Destroi as bolhas
		destroy_connected_bubbles()


# Quando a bolha colide com algo
func _on_body_entered(body):
	if body.is_in_group("ground"):  # O chão precisa estar no grupo "ground"
		velocity.y = 0  # Para a bolha ao colidir com o chão

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
