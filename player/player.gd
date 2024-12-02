extends CharacterBody2D

@onready var VARS = $Variables
@onready var state: Node = $StateMachine
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapons_manager: Node2D = $WeaponsManager

#save velocity before landing (for camera shake and fall damage calculations)
var last_fall_velocity = 0.0

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
#	if dashing, no gravity
	if !state.is_dashing:
		if not is_on_floor():
			velocity += get_gravity() * delta

	jump(delta)
	
	turn_player_sprite()
	
	var direction := Input.get_axis("move_left", "move_right")
	if !state.is_attacking:
		if !state.is_in_air:
			if direction:
#				changing animation speed when sprinting and walking
					if state.is_sprinting:
						sprite.speed_scale = 1.2
					else:
						sprite.speed_scale = 1
						
					sprite.play("walk")
					velocity.x += direction * VARS.ACCELERATION
					
			else:
				if !state.is_dashing:
					velocity.x = lerp(velocity.x, 0.0, 0.3)
					sprite.play("idle")
				else:
					sprite.play('jump')
		if state.is_in_air:
			sprite.play("jump")
		if state.is_in_air && velocity.y > 0:
			sprite.play("fall")
			last_fall_velocity = velocity.y
			
#		midair steering
		velocity.x += direction * VARS.IN_AIR_ACCELERATION
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	if !state.is_dashing:
#	this prevents the dashing!!!
		velocity.x = clamp(velocity.x, -VARS.CURRENT_SPEED, VARS.CURRENT_SPEED)

	move_and_slide()

func _on_state_machine_has_landed_signal() -> void:
	#$ShakableCamera.add_trauma(0.5)
	$ShakableCamera.add_trauma(calc_fall_impact())
	last_fall_velocity = 0.0	

#for camera shake and fall damage
func calc_fall_impact():
	return last_fall_velocity / 1000
	
func turn_player_sprite() -> void:
	if Input.is_action_just_pressed("move_left"):
		sprite.flip_h = true
	if Input.is_action_just_pressed("move_right"):
		sprite.flip_h = false
	# if bow is selected, flip sprite to the side of the mouse cursor:
	if weapons_manager.weapon_selected == weapons_manager.WEAPONS.BOW:
		var screen_middle = (get_viewport().size.x) / 2
		if get_viewport().get_mouse_position().x < screen_middle:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	
func jump(delta):
	#	Jump
	if Input.is_action_pressed("jump"):
		var jump_power = VARS.CURRENT_JUMP_VELOCITY
		var max_power = VARS.MAX_JUMP_VELOCITY
		if jump_power < max_power:
			VARS.CURRENT_JUMP_VELOCITY += VARS.JUMP_POWER_BUILDUP * delta
	
	if Input.is_action_just_released("jump"):
		if is_on_floor():
			velocity.y = -VARS.CURRENT_JUMP_VELOCITY
		if is_on_wall():
			velocity.y = -VARS.CURRENT_JUMP_VELOCITY
	
