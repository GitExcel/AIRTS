extends HSlider
@onready var attackManager = get_tree().get_first_node_in_group("attackManager")
@onready var text = $RichTextLabel

var assignNumber = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	assignNumber = value
	attackManager.sliderValue = assignNumber
	text.text = str(assignNumber)
