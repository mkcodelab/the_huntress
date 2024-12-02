extends Node2D
class_name Bow

@onready var cooldown: Timer = $Cooldown
@onready var arrow_spawn_point: Marker2D = $ArrowSpawnPoint
@onready var bow_sound: AudioStreamPlayer = $BowSound

var can_shoot = true
var is_bow_drawn = false

var min_arrow_force = 100.0
var arrow_force = 0.0
var max_arrow_force = 300.0
var draw_speed = 100.0

var arrow = preload("res://player/weapons/arrow.tscn")

#change mouse pointer to reticle if bow is selected as weapon
#calculate vector from mouse position

func _ready() -> void:
	arrow_force = min_arrow_force

func _process(delta: float) -> void:
	
	if is_bow_drawn:
		if arrow_force < max_arrow_force:
			arrow_force += delta * draw_speed
			#print(arrow_force)
#optional signal for showing ui change 
#			arrow_force_value_change.emit(arrow_force) 
		#else:
			#arrow_force = min_arrow_force

func calcAngleBetweenPlayer(player: CharacterBody2D) -> float:
	return (player.global_position - get_global_mouse_position()).angle()

#sets angle in radians
func calcBowAngle(player: CharacterBody2D) -> void:
	rotation = calcAngleBetweenPlayer(player) - deg_to_rad(180)

func get_impulse_vector(angle, force) -> Vector2:
	var x = force * cos(angle) * 10
	var y = force * sin(angle) * 10
	return Vector2(x, y)
	
func draw():
	if can_shoot:
		if is_bow_drawn:
			return
		else:
			is_bow_drawn = true
#		fake_arrow.show()
#just add fake arrow image on bow

func release(player: CharacterBody2D) -> void:
#	fake_arrow.hide()
	if can_shoot:
		var arrow_instance = arrow.instantiate()
		get_tree().root.add_child(arrow_instance)
		arrow_instance.global_transform = arrow_spawn_point.global_transform
		arrow_instance.set_as_top_level(true)

		var vec = get_impulse_vector(calcAngleBetweenPlayer(player), arrow_force)
		arrow_instance.force = arrow_force
		arrow_instance.apply_central_impulse(-vec)
		
		is_bow_drawn = false
		can_shoot = false
		
		cooldown.start()
		
		bow_sound.pitch_scale = arrow_force / 100
		
#		reset arrow force
		arrow_force = min_arrow_force
		bow_sound.play()
	
	
func _on_cooldown_timeout() -> void:
	can_shoot = true
