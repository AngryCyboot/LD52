extends Spatial

var isUpTime = 0
var time = 0
var isUp = false

var Botanist = int()
var Engineering = int()
var Chemistry = int()

var Class = "Survivant"

var Class_list = [
				"Survivant",  # Sans spé
				"Ingénieur",
				"Botaniste",
				"Chimiste"
				]

func _ready():
	pass # Replace with function body.
		
func placing(var pos):
	self.transform.origin=pos
	isUpTime = time
	isUp = true
	
func up():
	time = Time.get_ticks_msec()
	if (time - isUpTime) > 100 and not isUp :
		$Survivant_mesh.transform.origin.y = 1
		isUpTime = Time.get_ticks_msec()
		isUp = true
	pass

func _process(delta: float) -> void:
	time = Time.get_ticks_msec()
	if (time - isUpTime) > 300 and isUp :
		$Survivant_mesh.transform.origin.y = 0.5
		isUp = false
	pass
