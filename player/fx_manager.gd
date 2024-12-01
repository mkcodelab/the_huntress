extends Node2D

@onready var state: Node = $"../StateMachine"
@onready var landing_dust: GPUParticles2D = $LandingDust

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_landed():
	landing_dust.emitting = true
