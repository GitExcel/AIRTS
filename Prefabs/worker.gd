extends CharacterBody2D



@onready var nav = $NavigationAgent2D
var gotMat
@onready var resourcestore = get_tree().get_first_node_in_group("resourceStore")
@export var group = "MINERAL"
var target
var needTarget = true
var moveToResource = false
var speed = 100
var haveResource = false
var returnToBase = false
var typeHolding = "NONE"
var firsttime = true


func _ready():
	resourcestore.workers.append(self)

func _physics_process(delta):
	if needTarget:
		getTarget()
	if moveToResource:
		moveToResourse()
	if haveResource:
		returnToBaseTarget()
	if returnToBase:
		moveToBase()
	
func getTarget():
	
	
	
	
	firsttime = false
		
	
	if group == "GAS":
		if resourcestore.gasNodes.is_empty():
			print("no gas nodes")
		else:
			needTarget = false
			target = find_closest_node_to_point(resourcestore.gasNodes, position)
			nav.target_position = target.position
			moveToResource = true
		
	if group == "MINERAL":
		if resourcestore.mineralNodes.is_empty():
			print("no minteral nodes")
		else:
			needTarget = false
			target = find_closest_node_to_point(resourcestore.mineralNodes, position)
			nav.target_position = target.position
			moveToResource = true
		
	
		
	


func moveToResourse():
	if target == null:
		needTarget = true
		moveToResource = false
	var dir = to_local(nav.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	$Sprite2D.rotation = dir.angle()
	$CollisionShape2D.rotation = dir.angle()
	
func returnToBaseTarget():
	target = find_closest_node_to_point(resourcestore.buildings, position)
	nav.target_position = target.position
	haveResource = false
	returnToBase = true

func moveToBase():
	var dir = to_local(nav.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	$Sprite2D.rotation = dir.angle()
	$CollisionShape2D.rotation = dir.angle()
	
	
func find_closest_node_to_point(array, point):
	var closest_node = null
	var closest_node_distance = 0.0
	for i in array:
		var current_node_distance = point.distance_to(i.global_position)
		if closest_node == null or current_node_distance < closest_node_distance:
			closest_node = i
			closest_node_distance = current_node_distance
	return closest_node

func addResource():
	if typeHolding == "MINERALS":
		resourcestore.minerals += 20
		
	if typeHolding == "GAS":
		resourcestore.gas += 20
		
	

	
