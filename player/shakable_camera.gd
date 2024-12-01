extends Camera2D

@export var decay := 1.0 #How quickly shaking will stop [0,1].
@export var max_offset := Vector2(10,10) #Maximum displacement in pixels.
@export var max_roll = 0.0 #Maximum rotation in radians (use sparingly).


var trauma := 0.0 #Current shake strength
var trauma_pwr := 2 #Trauma exponent. Use [2,3]

func _ready() -> void:
	randomize()

func add_trauma(amount : float) ->void:
	trauma = min(trauma + amount, 1.0)
	
func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

		
func shake(): 
	var amount = pow(trauma, trauma_pwr)
	
	rotation = max_roll * amount * randf_range(-1,1)
	offset.x = max_offset.x * amount * randf_range(-1,1)
	offset.y = max_offset.y * amount * randf_range(-1,1)
	
