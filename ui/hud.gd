extends CanvasLayer

@onready var hp: TextureProgressBar = $Control/bars/hp
@onready var stamina: TextureProgressBar = $Control/bars/stamina

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stat_max_value_change(stat: String, value: float) -> void:
	if stat == "hp":
		hp.max_value = value
	if stat == "stamina":
		stamina.max_value = value

func stat_change(stat: String, value: float) -> void:
	if stat == "hp":
		hp.value = value
	if stat == "stamina":
		stamina.value = value
		
