extends Node
@onready var player: CharacterBody2D = $".."
@onready var focus_time_shader: CanvasLayer = $FocusTimeShader

#signal focus_toggled

var focus_time = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("focus"):
		toggle_focus()

func toggle_focus() -> void:
	focus_time = !focus_time
	focus()
	
func focus():
	if focus_time:
		Engine.time_scale = 0.5
		focus_time_shader.visible = true
#		play focus sound 
		$FocusSound.pitch_scale = 0.2
		$FocusSound.play()
		
	else:
		Engine.time_scale = 1
		focus_time_shader.visible = false
#		play focus sound backwards
		$FocusSound.pitch_scale = 0.5
		$FocusSound.play()
