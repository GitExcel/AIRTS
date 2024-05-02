extends StaticBody2D
var soldierArray = []
var canShoot = true
var dmg = 20
var health = 50
var toerase: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if health <= 0 :
		queue_free()
		var alloutattack = get_tree().get_first_node_in_group("AllOutAttack") 
		if alloutattack != null:
			alloutattack.enemies.erase(self)
			alloutattack.resetRange()
		for i in toerase.size():
			toerase[i].enemies.erase(self)
		
	for i in soldierArray.size():
		if soldierArray[i] != null && canShoot == true:
			canShoot = false
			$Timer2.start()
			shoot(soldierArray[i])
			break
			
		
	
	
func _on_range_body_entered(body):
	
	if body.is_in_group("soldiers"):
		soldierArray.append(body)
		
		
		
	#if body == enemyToAttack:
		#enemyIsInRange = true


func _on_range_body_exited(body):
	if body.is_in_group("soldiers"):
		soldierArray.erase(body)

func shoot(soldier):
	if soldier.health == dmg:
		soldierArray.erase(soldier)
	
	
	$Line2D.add_point(to_local(global_position))
	$Line2D.add_point(to_local(soldier.global_position))
	soldier.health -=dmg 
	$Timer.start()
		


func _on_timer_timeout():
	$Line2D.clear_points()


func _on_timer_2_timeout():
	canShoot = true
