extends Node2D
var smartDefNumber = 0
var target
@onready var attackManager = get_tree().get_first_node_in_group("attackManager")
@onready var infoBox = get_tree().get_first_node_in_group("InfoBox")
var multiply
var numberOfUnitsNeeded
var unitsGot = 0
var unitsNeeded = true
var attacking = false
var doOnce = true
var readyToAgrab = false





# Called when the node enters the scene tree for the first time.
func _ready():
	
	numberOfUnitsNeeded = attackManager.sliderValue
	attackManager.numberOfAttacks +=1
	smartDefNumber = attackManager.numberOfAttacks


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	numberOfUnitsNeeded = attackManager.sliderValue
	if unitsNeeded:
		if doOnce:
			checkUnits()
		if readyToAgrab:
			grabUnits()
	if attacking:
		attack()

func checkUnits():
	doOnce = false
	var avalibleSoliders = 0
	for i in attackManager.soldiers.size():
		if attackManager.soldiers[i].occupied == false:
			avalibleSoliders += 1
	
	if avalibleSoliders < numberOfUnitsNeeded && avalibleSoliders > 0:
		infoBox.makeText("[center]  NOT ENOUGH SOLDIERS TO DEFEND, WILL SEND THOSE THAT CAN")
		numberOfUnitsNeeded = avalibleSoliders
		readyToAgrab = true
		doOnce = false
	elif avalibleSoliders == 0:
		infoBox.makeText("[center]  NO SOLDIERS AVALIBLE TO DEFEND")
		for i in attackManager.soldiers.size():
			if attackManager.soldiers[i].occupiedNumber == smartDefNumber:
				attackManager.soldiers[i].occupiedNumber = 0
				attackManager.soldiers[i].occupied = false
		doOnce = true
	else:
		readyToAgrab = true
		doOnce = false
	
func grabUnits():
	if unitsGot < numberOfUnitsNeeded:
		if target != null:
			find_closest_node_to_point(attackManager.soldiers, target.position)
			
	else:
		unitsNeeded = false
		attacking = true

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
		closest_node.occupiedNumber = smartDefNumber
	unitsGot += 1
	return closest_node
	
func attack():
	var soldiersAlive = 0
	for i in attackManager.soldiers.size():
		if attackManager.soldiers[i].occupiedNumber == smartDefNumber:
			soldiersAlive +=1
			
		
	if target != null && soldiersAlive > 0:
		for i in attackManager.soldiers.size():
			if attackManager.soldiers[i].occupiedNumber == smartDefNumber:
				attackManager.soldiers[i].enemyToAttack = target
				attackManager.soldiers[i].moved = true
				attackManager.soldiers[i].makePathWithPos(target.position)
	elif soldiersAlive == 0:
		attacking = false
		infoBox.makeText("[center]  DEFENCE FAILED, SENDING ANOTHER UNIT")
		doOnce = true
		unitsGot = 0
		readyToAgrab = false
		unitsNeeded = true
	else:
		attacking = false
		for i in attackManager.soldiers.size():
			if attackManager.soldiers[i].occupiedNumber == smartDefNumber:
				attackManager.soldiers[i].occupiedNumber = 0
				attackManager.soldiers[i].occupied = false
				infoBox.makeText("[center]  SUCCESSFULLY DEFENDED")
				queue_free()
