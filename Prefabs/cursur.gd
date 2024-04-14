extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Move"):
		$CollisionShape2D.global_position = get_global_mouse_position()
		$CollisionShape2D.disabled = false
		$Timer.start()
		
	
		


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		Singleton.attacked_enemy = body
		
		


func _on_timer_timeout():
	$CollisionShape2D.disabled = true
	
