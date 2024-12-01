extends Node
@onready var state: Node = $"../StateMachine"

const SPEED = 500.0
const SPRINT_SPEED = 800.0

var CURRENT_JUMP_VELOCITY = 400.0
const JUMP_POWER_BUILDUP = 500.0

const MIN_JUMP_VELOCITY = 400.0
const MAX_JUMP_VELOCITY = 1000.0

var CURRENT_SPEED = 300.0

const ACCELERATION = 20
const DECELERATION = 100

#steering midair speed
const IN_AIR_ACCELERATION = 5

var current_hp = 100.0
var max_hp = 100.0

var current_stamina = 100.0
var max_stamina = 100.0

func reset_jump_velocity() -> void:
	CURRENT_JUMP_VELOCITY = MIN_JUMP_VELOCITY

func toggle_sprint() -> void:
	if state.is_sprinting:
		CURRENT_SPEED = SPRINT_SPEED
	else:
		CURRENT_SPEED = SPEED
		
func _process(delta: float) -> void:
	toggle_sprint()
