extends StaticBody2D


var entered = false;
var selected = false;
var soldier = preload("res://Prefabs/soldier.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true && Input.is_action_just_pressed("Select"):
		selected = true
	if !entered && Input.is_action_just_pressed("Select"): 
		selected = false
		
	if selected && Input.is_action_just_pressed("Move"):
		print("moved")
		$Marker2D.global_position = get_global_mouse_position()
	
	if selected:
		$Marker2D/Sprite2D.visible = true
		selectedlogic()
	if !selected:
		$Marker2D/Sprite2D.visible = false
		notSelectedLogic()
		
func selectedlogic():
	$Button.disabled = false
	$Button.visible = true
	
	
func notSelectedLogic():
	$Button.disabled = true
	$Button.visible = false
	


func _on_mouse_entered():
	entered = true


func _on_mouse_exited():
	entered = false







func _on_button_mouse_entered():
	entered = true
	print("entered")
	


func _on_button_mouse_exited():
	entered = false
	print("exit")


func _on_button_pressed():
	var instance = soldier.instantiate()
	get_tree().root.add_child(instance)
	instance.position = self.position
	instance.moved = true
	instance.nav2d.target_position = $Marker2D.global_position
	
