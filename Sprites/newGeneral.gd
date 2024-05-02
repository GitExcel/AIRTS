extends CharacterBody2D


var mousePos = Vector2(0,0)
@export var speed = 0
var moved = false
var normalSprite = ("res://Sprites/general3.png")
var selectedSprite = ("res://Sprites/generalselected.png")
@onready var nav2d = $NavigationAgent2D
var mouseIn = false
var selected = false
var unitmanager
var selecting = false
var test
var enemyInRange = 0
var enemyIsInRange = false
var enemyToAttack
var enemyArray: Array
var bullet = preload("res://Prefabs/bullet.tscn")
var readyToShoot = true
var health = 100
@export var gameover: CanvasLayer
var gathering = false


func _ready():
	unitmanager = get_tree().get_first_node_in_group("unitController")
	
	
	
	





func _process(_delta: float) -> void:
	
	if health == 0:
		gameover.visible = true
		queue_free()
	if Input.is_action_just_pressed("Move") && selected:
		
		$Timer.start()
		
		makePath()
		moved = true
	if Input.is_action_just_released("Select"):
		selecting = false
	if moved && enemyToAttack == null:
		
		
		var dir = to_local(nav2d.get_next_path_position()).normalized()
		velocity = dir * speed
		$Sprite2D.rotation = dir.angle()
		$CollisionShape2D.rotation = dir.angle()
		move_and_slide()
		
	elif moved && enemyToAttack != null:
		isEnemyInRange()
		
		
		
		
		
		
		if enemyIsInRange && readyToShoot :
			readyToShoot = false
			$Sprite2D.rotation = ((enemyToAttack.global_position - global_position).normalized()).angle()
			$Line2D.add_point(to_local(global_position))
			$Line2D.add_point(to_local(enemyToAttack.global_position))
			$lineTimer.start()
			
			#var instance = bullet.instantiate()  BULLET LOGIC MAYBE SAVE FOR LATER
			#get_tree().root.add_child(instance)
			#instance.position = self.position
			#instance.startPos = position
			#instance.target = enemyToAttack.position
			$BulletTimer.wait_time = randf_range(0.5, 0.7)
			
			$BulletTimer.start()
		elif enemyIsInRange:
			pass
		else:
			
			
			
			var dir = to_local(nav2d.get_next_path_position()).normalized()
			velocity = dir * speed
			$Sprite2D.rotation = dir.angle()
			$CollisionShape2D.rotation = dir.angle()
			move_and_slide()
			
		
		
		
	if selected:
		$Sprite2D.texture =load(selectedSprite)
	
	else:
		$Sprite2D.texture = load(normalSprite)
	
		
	
func makePath() -> void:
	mousePos = get_global_mouse_position()
	nav2d.target_position = mousePos + Vector2(randf_range(-100.0, 100), randf_range(-100, 100) )
	
func makePathWithPos(pos) -> void:
	nav2d.target_position = pos + Vector2(randf_range(-100.0, 100), randf_range(-100, 100) )
	



		


func _on_navigation_agent_2d_target_reached():
	moved = false
	


#func _on_mouse_entered():
	#mouseIn = true
	#print("enter")
#
#
#func _on_mouse_exited():
	#mouseIn = false
	#print("exit")


func gather():
	gathering = true
	moved = true
	
	print("gathering")
	nav2d.target_position = get_tree().get_first_node_in_group("GatherPoint").position
	selected = false




func _on_range_body_entered(body):
	
	if body.is_in_group("enemy"):
		enemyArray.append(body)
		
		
		enemyInRange +=1
		
	#if body == enemyToAttack:
		#enemyIsInRange = true


func _on_range_body_exited(body):
	if body.is_in_group("enemy"):
		enemyArray.erase(body)
		enemyInRange -=1
		if body == enemyToAttack:
			enemyIsInRange = false
			
func isEnemyInRange():
	for i in enemyArray.size():
		
		if enemyArray[i] == enemyToAttack:
			
			
			enemyIsInRange = true
			break
		else:
			enemyIsInRange = false
			
	
	


func _on_timer_timeout():
	enemyToAttack = Singleton.attacked_enemy
	print(Singleton.attacked_enemy)
	print(enemyToAttack)
	


func _on_bullet_timer_timeout():
	readyToShoot = true


func _on_line_timer_timeout():
	$Line2D.clear_points()
	
