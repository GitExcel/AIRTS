extends CharacterBody2D


var mousePos = Vector2(0,0)
@export var speed = 0
var moved = false
var normalSprite = ("res://Sprites/pixil-frame-0.png")
var selectedSprite = ("res://Sprites/selected2.png")
@onready var nav2d = $NavigationAgent2D
var mouseIn = false
var selected = false
var unitmanager
var selecting = false
var test



func _ready():
	unitmanager = get_tree().get_first_node_in_group("unitController")
	print(unitmanager)
	unitmanager.soldierArray.append(self)
	print(unitmanager.soldierArray)





func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Move") && selected:
		makePath()
		moved = true
	if Input.is_action_just_released("Select"):
		selecting = false
	if moved:
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
	nav2d.target_position = mousePos
	



		


func _on_navigation_agent_2d_target_reached():
	moved = false
	print("WORKING")


func _on_mouse_entered():
	mouseIn = true
	print("enter")


func _on_mouse_exited():
	mouseIn = false
	print("exit")
