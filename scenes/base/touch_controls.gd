extends CanvasLayer
## Controles tactiles para Android / pantallas tactiles.
## Contiene el joystick virtual (movimiento) y un boton de "Interactuar".
##
## El joystick acciona las acciones ui_left/ui_right/ui_up/ui_down que ya lee
## el jugador (cosdigo/character_body_2d.gd via Input.get_vector), por lo que no
## hace falta modificar el script del jugador.
##
## El boton "Interactuar" presiona la accion "interactuar" (tecla E en escritorio)
## que usan las estaciones para abrir su minijuego.

## Mostrar los controles solo en pantallas tactiles (Android/movil).
## Si es false, se muestran siempre (util para probar en escritorio con el raton).
@export var solo_en_tactil: bool = true

const ACCION_INTERACTUAR: String = "interactuar"

@onready var _boton_interactuar: Button = $BotonInteractuar

func _ready() -> void:
	# Capa alta para dibujarse por encima del HUD (layer 40) y la UI (layer 50).
	layer = 100

	if solo_en_tactil and not DisplayServer.is_touchscreen_available():
		visible = false

	# Asegurar que la accion exista (game_state.gd tambien la registra).
	if not InputMap.has_action(ACCION_INTERACTUAR):
		InputMap.add_action(ACCION_INTERACTUAR)

	if _boton_interactuar != null:
		_boton_interactuar.button_down.connect(_on_interactuar_down)
		_boton_interactuar.button_up.connect(_on_interactuar_up)

func _on_interactuar_down() -> void:
	Input.action_press(ACCION_INTERACTUAR)

func _on_interactuar_up() -> void:
	Input.action_release(ACCION_INTERACTUAR)
