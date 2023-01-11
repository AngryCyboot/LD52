extends CanvasLayer

var phase

var turn = 0
var end = 0
var survivors = 0

var food = [0,0,0,0]
var energy = [0,0,0,0]
var oxy = [0,0,0,0]
var water = [0,0,0,0]
var shit = [0,0,0,0]

signal restart 

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ElectricityLabel.text = String(energy[0])+"/"+String(energy[1])
	$ElectricityLabel.hint_tooltip = "+" + String(energy[2]) + " -" + String(energy[3])
	$OxygenLabel.text = String(oxy[0])+"/"+String(oxy[1])
	$OxygenLabel.hint_tooltip = "+" + String(oxy[2]) + " -" + String(oxy[3])
	$FertilizerLabel.text = String(shit[0])+"/"+String(shit[1]) + " +" + String(shit[4])
	$FertilizerLabel.hint_tooltip = "+" + String(shit[2]) + " -" + String(shit[3])
	$WaterLabel.text = String(water[0])+"/"+String(water[1]) + " +" + String(water[4])
	$WaterLabel.hint_tooltip = "+" + String(water[2]) + " -" + String(water[3])
	$FoodLabel.text = String(food[0])+"/"+String(food[1])
	$FoodLabel.hint_tooltip = "+" + String(food[2]) + " -" + String(food[3])
	$GoalLabel.text = String(turn)+"/"+String(end)+" sol"
	$SurvivorLabel.text = "Survivors : "+String(survivors)
	
	pass
	
func update(allTheThings):
	energy = allTheThings[0]
	oxy = allTheThings[1]
	shit = allTheThings[2]
	water = allTheThings[3]
	food = allTheThings[4]
	turn = allTheThings[5]
	survivors = allTheThings[6]

func passTurn():
	$Button.pressed = false
	$Button.disabled = false
	ending_Result()
	
func initialise(doom):
	end = doom

func phase():
	return phase

func _on_Button_toggled(button_pressed):
	phase = button_pressed
	$Button.disabled = true
	pass # Replace with function body.

func ending_Result():
	if survivors <= 0 :
		$EndingScreen.visible = true
		$EndingScreen/DetailedResultLabel.visible = true
		$EndingScreen/ResultLabel.visible = true
		$EndingScreen/ResultLabel.text = "Defeat"
		$EndingScreen/DetailedResultLabel.text = "You and all the persons you liked are dead. You survived "+String(turn)+" sol"
		$EndingScreen/Restart_button.disabled = false
	elif survivors >= 1 && turn >= end :
		$EndingScreen.visible = true
		$EndingScreen/DetailedResultLabel.visible = true
		$EndingScreen/ResultLabel.visible = true
		$EndingScreen/ResultLabel.text = "Victory"
		$EndingScreen/DetailedResultLabel.text = "You survive "+String(turn)+" sol and keep alive "+String(survivors)+" survivors"
		$EndingScreen/Restart_button.disabled = false

func _on_Button_pressed():
	emit_signal("restart")
