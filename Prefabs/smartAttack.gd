extends Area2D
@onready var attackManager = get_tree().get_first_node_in_group("attackManager")
@onready var gatherPoint = get_tree().get_first_node_in_group("GatherPoint")
var gatherPointPos
var endpos
@onready var nav2d = $NavigationAgent2D
@onready var collisionShape = $CollisionShape2D

var smartAttackNumber
var enemies : Array
var moving = false
var moved = false
var grabbedNearby = false
var numberofsoldiersneeded = 0
var numberselected = 0
var gathering = false
var solideratpoint = 0
var attacking = false
var totalguys = 0
var movingtoend = false
var solidersatend = 0
var multiply 



# Called when the node enters the scene tree for the first time.
func _ready():
	onStart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving == true:
		position = nav2d.get_next_path_position()
	if moved:
		position = gatherPointPos
		grabUnits2()
	if grabbedNearby && !gathering:
		print("gathering")
		grabbedNearby = false
		
		gather()
	
	if attacking == true:
		attack()


func grabUnits2():
	if !grabbedNearby:
			var avalibleSoliders = 0  #IF THE NUMBER OF AVALIBLE SOLDIERS IS LESS THAN THE AMOUNT NEEDE DTHEN DIE
			for i in attackManager.soldiers.size():
				if attackManager.soldiers[i].occupied == false:
					avalibleSoliders += 1
			print(avalibleSoliders)
			if avalibleSoliders < numberofsoldiersneeded:
				print(numberofsoldiersneeded)
				print("not enough soldiers")
				reset()
			else:
				while numberselected < numberofsoldiersneeded:
					find_closest_node_to_point(attackManager.soldiers, gatherPointPos )
				if numberselected == numberofsoldiersneeded:
					grabbedNearby = true
					print("grabbed em all")
					moved = false
	
		


func onStart():
	multiply = attackManager.sliderValue
	attackManager.smartAttacks.append(self)
	attackManager.numberOfAttacks +=1
	smartAttackNumber = attackManager.numberOfAttacks
	position = gatherPoint.position
	gatherPointPos = gatherPoint.position
	nav2d.target_position = get_global_mouse_position()
	moving = true

func Bigfree():
	for i in enemies.size():
		enemies[i].toerase.erase(self)
	queue_free()
	
func gather():
	if numberofsoldiersneeded == 0:
		reset()
	gathering = true
	for i in attackManager.soldiers.size():
		if attackManager.soldiers[i].occupiedNumber == smartAttackNumber:
			attackManager.soldiers[i].gather()

func attack():
	position = endpos
	if !enemies.is_empty():
		
		
		for i in attackManager.soldiers.size():
			if attackManager.soldiers[i].occupiedNumber == smartAttackNumber:
				attackManager.soldiers[i].enemyToAttack = enemies[0]
				attackManager.soldiers[i].moved = true
				attackManager.soldiers[i].makePathWithPos(enemies[0].position)
				
	else:
		movingtoend = true
		collisionShape.scale = Vector2(1, 1)
		for i in attackManager.soldiers.size():
			if attackManager.soldiers[i].occupiedNumber == smartAttackNumber:
				attackManager.soldiers[i].makePathWithPos(endpos)
		if solidersatend == numberselected:
			print("they are at end")
			attacking = false
			reset()
	
func reset():
	for i in attackManager.soldiers.size():
		if attackManager.soldiers[i].occupiedNumber == smartAttackNumber:
			attackManager.soldiers[i].occupiedNumber = 0
			attackManager.soldiers[i].occupied = false
	attackManager.smartAttacks.erase(self)
	for i in enemies.size():
		enemies[i].toerase.erase(self)
	queue_free()
			
	
func find_closest_node_to_point(array, point): #made by a user on reddit https://www.reddit.com/r/godot/comments/q013i0/get_object_closest_to_position/
	var closest_node = null
	var closest_node_distance = 0.0
	for i in array:
		if !i.occupied:
			var current_node_distance = point.distance_to(i.global_position)
			if closest_node == null or current_node_distance < closest_node_distance:
				closest_node = i
				closest_node_distance = current_node_distance
	if closest_node != null:
		closest_node.occupied = true
		closest_node.occupiedNumber = smartAttackNumber
	numberselected += 1
	return closest_node


func _on_body_entered(body):
	if body.is_in_group("enemy") && moving:
		enemies.append(body)
		numberofsoldiersneeded += multiply
		body.toerase.append(self)
	if body.is_in_group("soldiers") && gathering == true:
		print("enter")
		if body.occupiedNumber == smartAttackNumber:
			print("enter suqared")
			solideratpoint += 1
			if solideratpoint == numberselected:
				solideratpoint = 0
				print("attacking")
				collisionShape.scale = Vector2(0.01, 0.01)
				gathering = false
				attacking = true
	if body.is_in_group("soldiers") && movingtoend == true:
		print("enter2")
		if body.occupiedNumber == smartAttackNumber:
			solidersatend += 1
			


func _on_body_exited(body):
	pass


func _on_navigation_agent_2d_navigation_finished():
	print("have moved")
	endpos = position
	moving = false
	position = gatherPointPos
	moved = true
