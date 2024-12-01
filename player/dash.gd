extends Node
@onready var player: CharacterBody2D = $".."
@onready var dash_timer: Timer = $DashTimer
@onready var dash_sound: AudioStreamPlayer = $DashSound
@onready var cooldown: Timer = $Cooldown
@onready var state: Node = $"../StateMachine"
@onready var dash_texture: TextureRect = $"../FXManager/DashTexture"
#switch dash texture to animated sprite later

var canDash = false
var dashCooldown = false


func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
		canDash = true
		dash_timer.start()
		
func _physics_process(delta: float) -> void:
	if canDash && !dashCooldown:
		if Input.is_action_just_pressed("move_left"):
			perform_dash(-1)
			
		if Input.is_action_just_pressed("move_right"):
			perform_dash(1)
	

func _on_dash_timer_timeout() -> void:
	canDash = false
	state.is_dashing = false
	dash_texture.visible = false

func _on_cooldown_timeout() -> void:
	dashCooldown = false
	

func perform_dash(direction: int) -> void:
	var dashSpeed = 1500
	player.velocity.x = dashSpeed * direction
	dash_sound.play()
	dash_texture.visible = true
	
	if direction == -1:
		dash_texture.flip_h = true
	else:
		dash_texture.flip_h = false
#	communicating with player trough state node
	state.is_dashing = true
	dashCooldown = true
	cooldown.start()
