extends CharacterBody2D


const SPEED = 430.0 

var time_limit = 15.0 # Tempo constante para que o multiplier reset, TEM QUE DIMINUIR CONFORME O TEMPO
var multiplier: int = 1 # Multiplicador de graze
var grazebar: float = 100 # Barra de graze/esquiva
var time_left: float = 0.0 # Tempo restante para o multiplier
var timer_active: bool = false # Variavel booleana para verificar se ja esta contando o tempo para o multiplier zerar

@onready var score_label = $scrControl/lblScore
@onready var multiplier_label = $scrControl/lblMultiplier
@onready var multiplier_bar = $scrControl/lblScore
@onready var life_bar = $scrControl/lblScore


var life: int = 6 # Vida do jogador
var score: int = 0
# Referência para a ProgressBar de tempo no UI (certifique-se de que ela está no seu scene tree)


func movement(delta: float):
	var direction := Input.get_vector("Left", "Right","Up","Down")
	velocity = direction*SPEED
	
	# Aumento de pontuação aplicada
	score += multiplier * 10
	
	# Texto do multiplicador
	multiplier_label.text = "Multiplicador: " + str(multiplier)
	multiplier_bar.value = time_left / 15.0 # Atualiza a barra de multiplicador com o tempo
	
	# Atualiza a barra de vida
	life_bar.value = life


func _physics_process(delta: float) -> void:
	movement(delta) # Realiza o movimento
	move_and_slide()	
	# Se o multiplicador for maior que 1, atualize o tempo restante
	if timer_active:
		time_left -= delta
		#time_bar.value = time_left / TIME_LIMIT  # Atualiza a barra de tempo
		
		# Se o tempo acabar ou o jogador tomar dano, reseta o multiplicador
		# MEXER AQUI
		if time_left <= 0.0 or life <= 0:
			reset_multiplier()


# Função para aumentar o multiplicador
func increase_multiplier() -> void:
	if multiplier < 2:  # Garantir que o multiplicador não ultrapasse 2
		multiplier += 1
		time_left = time_limit # Reseta o tempo
		timer_active = true # Ativa o temporizador

# Função para resetar o multiplicador
func reset_multiplier() -> void:
	multiplier = 1.0  # Reseta o multiplicador
	time_left = 0.0  # Reseta o tempo
	timer_active = false  # Desativa o temporizador
