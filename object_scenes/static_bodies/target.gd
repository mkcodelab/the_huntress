extends StaticBody2D

@onready var gong: AudioStreamPlayer2D = $gong

var can_penetrate = true
var penetrate_treshold = 200.0

func apply_damage(damage: float):
	#print('target hit!: ', damage)
	$Label.text = "%.2f" % damage
	gong.pitch_scale = randf_range(0.9, 1.5)
	gong.play()
