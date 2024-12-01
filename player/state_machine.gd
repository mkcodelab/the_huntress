extends Node

@onready var player: CharacterBody2D = $".."
@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"

var is_in_air = false
var is_flying = false
var is_ducking = false
var is_sprinting = false
var has_landed = false
var is_attacking = false
var idle = false
var is_running = false
var is_dashing = false

signal has_landed_signal
#move somewhere else... (some animation manager)
var attackAnims = ["attack1", "attack2"]

func _process(delta: float) -> void:
	
	in_air_check()
	landing_check()
		
	if Input.is_action_just_pressed("sprint"):
		is_sprinting = true
	
	if Input.is_action_just_released("sprint"):
		is_sprinting = false
	
	if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"):
		is_running = true
	else:
		is_running = false
		
	if Input.is_action_just_pressed("LMB"):
		is_attacking = true
		attackAnims.shuffle()
		sprite.play(attackAnims[0])
		

func landing_check():
	#player landed
	if is_in_air and player.is_on_floor():
		is_in_air = false
		has_landed = true
		has_landed_signal.emit()

func in_air_check() -> void:
	if !player.is_on_floor():
		is_in_air = true
		has_landed = false


func _on_animated_sprite_2d_animation_finished() -> void:
#	animation looping has to be off on attack animation frames!!
	if sprite.animation == "attack2" || sprite.animation == "attack1":
		is_attacking = false
