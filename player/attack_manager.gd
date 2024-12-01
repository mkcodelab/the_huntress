extends Node

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
#@onready var attack_1: Timer = $Attack1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("LMB"):
		pass
		#attack_1.start()
