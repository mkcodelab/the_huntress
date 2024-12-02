extends Node
@onready var state: Node = $"../StateMachine"

signal hp_changed
signal stamina_changed

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

var stamina_regen = 10.0
var hp_regen = 10.0

func reset_jump_velocity() -> void:
	CURRENT_JUMP_VELOCITY = MIN_JUMP_VELOCITY

func toggle_sprint() -> void:
	if state.is_sprinting:
		CURRENT_SPEED = SPRINT_SPEED
	else:
		CURRENT_SPEED = SPEED
		
func _process(delta: float) -> void:
	toggle_sprint()
	
	
func deplete_stamina(value: float) -> void:
	if current_stamina - value < 0.0:
		current_stamina = 0.0
	else:
		current_stamina -= value
	stamina_changed.emit(current_stamina)
		
func apply_damage(value: float) -> void:
	if current_hp - value < 0.0:
		current_hp = 0.0
#		
#		dead/respawn logic here
	else:
		current_hp -= value
	hp_changed.emit(current_hp)
	
func heal(value: float) -> void:
	if value + current_hp > max_hp:
		current_hp = max_hp
	else:
		current_hp += value
	hp_changed.emit(current_hp)
	
func regen_stamina(value: float) -> void:
	if value + current_stamina > max_stamina:
		current_stamina = max_stamina
	else:
		current_stamina += value
	hp_changed.emit(current_stamina)
	
