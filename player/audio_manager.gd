extends Node
@onready var footsteps: AudioStreamPlayer = $Footsteps
@onready var landing: AudioStreamPlayer = $Landing
@onready var jump: AudioStreamPlayer = $Jump
@onready var step_timer: Timer = $StepTimer
@onready var weapon: AudioStreamPlayer = $Weapon

var run_time = 0.3
var sprint_time = 0.2

@onready var variables: Node = $"../Variables"
@onready var state: Node = $"../StateMachine"

var can_play_footsteps = true

var jump_sounds = [preload("res://assets/audio/jump.wav"), preload("res://assets/audio/jump2.wav")]
var weapon_sounds = [preload("res://assets/audio/swish_2.wav"), preload("res://assets/audio/swish_4.wav")]

func _process(delta: float) -> void:
	if can_play_footsteps && state.is_running && !state.is_in_air:
		play_footsteps()
		
	if Input.is_action_just_released("jump"):
		play_jump_sound()
	
	if Input.is_action_just_pressed("LMB"):
		play_weapon_sound()


func play_footstep():
	footsteps.pitch_scale = randf_range(0.8, 1.2)
	footsteps.play()

func play_landing():
	landing.pitch_scale = randf_range(0.8, 1.2)
	landing.play()

func _on_state_machine_has_landed_signal() -> void:
	play_landing()

func play_footsteps():
#	altering step speed when run/sprint
	if state.is_sprinting:
		step_timer.wait_time = sprint_time
	else:
		step_timer.wait_time = run_time
	step_timer.start()
	can_play_footsteps = false
	play_footstep()

func _on_step_timer_timeout() -> void:
	can_play_footsteps = true

func play_jump_sound() -> void:
#	play sound when it's power jump.
	if variables.CURRENT_JUMP_VELOCITY > 700.0:
		jump_sounds.shuffle()
		jump.pitch_scale = randf_range(0.95, 1.05)
		jump.stream = jump_sounds[0]
		jump.play()
	
func play_weapon_sound() -> void:
	if state.is_attacking:
		weapon_sounds.shuffle()
		weapon.pitch_scale = randf_range(0.9, 1.1)
		weapon.stream = weapon_sounds[0]
		weapon.play()
