extends CanvasLayer

var phase
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
var foodMax = 10
var turn = 0
var goal = 50

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
	$GoalLabel.text = String(turn)+"/"+String(goal)+" sol"
	pass
	
func addElec(quantite):
	if electricityAmount < electricityMax:
		electricityAmount = electricityAmount + quantite
	
func addOxygen(quantite):
	if oxygenAmount < oxygenMax:
		oxygenAmount = oxygenAmount + quantite
	
func addFertilizer(quantite):
	if fertilizerAmount < fertilizerMax:
		fertilizerAmount = fertilizerAmount + quantite
	
func addWater(quantite):
	if waterAmount < waterMax:
		waterAmount = waterAmount + quantite
	
func addFood(quantite):
	if foodAmount < foodMax:
		foodAmount = foodAmount + quantite
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_KP_1:
			addElec(1)
		if event.scancode == KEY_KP_2:
			addOxygen(1)
		if event.scancode == KEY_KP_3:
			addFertilizer(1)
		if event.scancode == KEY_KP_4:
			addWater(1)
		if event.scancode == KEY_KP_5:
			addFood(1)

func passTurn():
	turn += 1
	$Button.pressed = false
	$Button.disabled = false

func phase():
	return phase

func _on_Button_toggled(button_pressed):
	phase = button_pressed
	$Button.disabled = true
	pass # Replace with function body.
