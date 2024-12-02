extends Node2D
#here we should actually include all attacking logic i guess
@onready var bow: Bow = $Bow
@onready var player: CharacterBody2D = $".."

enum WEAPONS {
	SPEAR,
	BOW,
	BOMB
}

var weapon_selected: WEAPONS
# Called when the node enters the scene tree for the first time.

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("weapon_01"):
		weapon_selected = WEAPONS.SPEAR
		Input.set_custom_mouse_cursor(preload("res://assets/cursor/spearpoint.png"))
		bow.visible = false
	if Input.is_action_just_pressed("weapon_02"):
		weapon_selected = WEAPONS.BOW
		Input.set_custom_mouse_cursor(preload("res://assets/cursor/crosshair_01.png"))
		bow.visible = true
	if Input.is_action_just_pressed("weapon_03"):
		weapon_selected = WEAPONS.BOMB
		bow.visible = false
		
	
	
	
			
func _process(delta: float) -> void:
	
	#if Input.is_action_pressed("LMB"):
	
	if weapon_selected == WEAPONS.BOW:
		bow.calcBowAngle(player)
		
	
	if Input.is_action_pressed("LMB"):
		if weapon_selected == WEAPONS.BOW:
			bow.draw()
			#bow.spawn_arrow()
			
	if Input.is_action_just_released("LMB"):
		if weapon_selected == WEAPONS.BOW:
			bow.release(player)
	
