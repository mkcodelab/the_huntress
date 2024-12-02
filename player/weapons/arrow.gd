extends RigidBody2D

@onready var lifespan: Timer = $Lifespan
@onready var tip: Area2D = $Tip

var base_damage = 10.0

func _ready() -> void:
	lifespan.start()

func _physics_process(delta: float) -> void:
	rotation = linear_velocity.angle()
	
	
func _on_tip_body_entered(body: Node2D) -> void:
	hit(body)

func _on_lifespan_timeout() -> void:
	queue_free()
	
func hit(body: Node2D) -> void:
	print('arrow hit')
	set_deferred("freeze", true)
	if body.has_method('apply_damage'):
		body.apply_damage(base_damage)
	#tip.monitoring = false
	tip.set_deferred("monitoring", false)
