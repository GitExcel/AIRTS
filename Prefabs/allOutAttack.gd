extends Area2D


var canAOA = false
var mousePos = Vector2(0,0)
@onready var nav2d = $NavigationAgent2D
var moving = false
var soldiers : Array
var gathered = false
var numberofsoliders
var gathering = false
var solideratpoint = 0
var enemies : Array
var attacking = false
var enemiesempty = true
var enemytoattack = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clean_arrays()
	if Input.is_action_just_pressed("All Out Attack"):
		canAOA = !canAOA
		print("all out attack is ", canAOA)
		
	if Input.is_action_just_pressed("Move") && canAOA:
		canAOA = false
		soldiers = get_tree().get_nodes_in_group("soldiers")
		gather()
		mousePos = get_global_mouse_position()
		nav2d.target_position = mousePos
		
	if gathering:
		if solideratpoint == numberofsoliders:
			moving = true
		
	if moving == true:
		position = nav2d.get_next_path_position()
	if attacking:
		attack()
	


func gather ():
	gathering = true
	soldiers = get_tree().get_nodes_in_group("soldiers")
	numberofsoliders = soldiers.size()
	position = get_tree().get_first_node_in_group("GatherPoint").position
	print("gather begin")
	for i in soldiers.size():
		soldiers[i].gather()
		
func attack():
	
	
	if !enemies.is_empty():
		for i in soldiers.size():
			print(soldiers[i])
		
			
			
			soldiers[i].enemyToAttack = enemies[enemytoattack]
			soldiers[i].moved = true
			soldiers[i].makePathWithPos(enemies[enemytoattack].position)
	else:
		for i in soldiers.size():
			soldiers[i].makePathWithPos(position)
			soldiers[i].moved = true
			

func _on_navigation_agent_2d_link_reached(details):
	pass


func _on_navigation_agent_2d_navigation_finished():
	moving = false
	attacking = true
	print ("finished nav mesh")


func _on_body_entered(body):
	if body.is_in_group("soldiers"):
		print("soldier in")
		solideratpoint += 1
	if body.is_in_group("enemy") && moving:
		enemies.append(body)
		
	
func clean_arrays():
	for i in soldiers:
		if !is_instance_valid(i):
			soldiers.erase(i)
		

func _on_body_exited(body):
	if body.is_in_group("soldiers"):
		print("soldier out")
		solideratpoint -= 1
