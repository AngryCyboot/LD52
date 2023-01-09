extends Spatial

var turn = 0 #change me plz
var end = 50
var survivors = 15 #change me plz
var UI 

# [stock,max,prod,conso,frozen*]

var food = [0,0,0,0]
var energy = [0,0,0,0]
var oxy = [0,0,0,0]
var water = [0,0,0,0,0]
var shit = [0,0,0,0,0]
var allTheThings

func _ready():
	UI = $Camera/UI
	allTheThings = [energy,oxy,shit,water,food,turn,survivors]
	UI.initialise(end)
	pass
	
func _process(delta):
	allTheThings = [energy,oxy,shit,water,food,turn,survivors]
	UI.update(allTheThings)
	if UI.phase():
		UI.passTurn()
		turn += 1
	
	pass
