extends RigidBody2D

@onready var lifespan: Timer = $Lifespan
@onready var tip: Area2D = $Tip

var base_damage = 10.0
#force passed from bow
var force = 0.0
var can_penetrate = false

func _ready() -> void:
	lifespan.start()

func _physics_process(delta: float) -> void:
	rotation = linear_velocity.angle()
	
	
func _on_tip_body_entered(body: Node2D) -> void:
	hit(body)

func _on_lifespan_timeout() -> void:
	queue_free()
	
func calc_damage() -> float:
	return base_damage + force
	
func hit(body: Node2D) -> void:
	if body.has_method('apply_damage'):
		body.apply_damage(calc_damage())
		
	if "can_penetrate" in body:
		if force > body.penetrate_treshold:
			can_penetrate = true
#			add some visual indicators for penetration
			
#	if arrow can NOT penetrate, it sticks to target
	if !can_penetrate:
		set_deferred("freeze", true)
		tip.set_deferred("monitoring", false)
