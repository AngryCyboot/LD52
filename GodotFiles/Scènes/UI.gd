extends CanvasLayer


# Declare member variables here. Examples:
var electricityAmount = 0
var oxygenAmount = 0
var fertilizerAmount = 0
var waterAmount = 0
var foodAmount = 0
var electricityMax = 240
var oxygenMax = 240
var fertilizerMax = 240
var waterMax = 240
var foodMax = 240
var goal = 1200

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ElectricityLabel.text = String(electricityAmount)+"/"+String(electricityMax)
	$OxygenLabel.text = String(oxygenAmount)+"/"+String(oxygenMax)
	$FertilizerLabel.text = String(fertilizerAmount)+"/"+String(fertilizerMax)
	$WaterLabel.text = String(waterAmount)+"/"+String(waterMax)
	$FoodLabel.text = String(foodAmount)+"/"+String(foodMax)
	$GoalLabel.text = String(goal)+" sol"
	pass
