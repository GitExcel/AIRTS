extends ColorRect
@onready var resourcestore = get_tree().get_first_node_in_group("resourceStore")
@onready var gasText = $gasText
@onready var mineralText = $mineralText

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("WorkerUi"):
		self.visible = !self.visible
	
	gasText.text = "Gas Workers: " + str(resourcestore.gasWorkers.size())
	mineralText.text = "Mineral Workers: " + str(resourcestore.mineralWorkers.size())


func _on_button_pressed():
	resourcestore.addGas()


func _on_button_2_pressed():
	resourcestore.addMineral()
