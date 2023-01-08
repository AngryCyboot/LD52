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
	
func up():
	if (time - isUpTime) > 500 and not isUp :
		$Survivant_mesh.transform.origin += Vector3(0,0.5,0)
		isUpTime = time
		isUp = true
	pass

func _process(delta: float) -> void:
	time = Time.get_ticks_msec()
	if (time - isUpTime) > 499 and isUp :
		$Survivant_mesh.transform.origin += Vector3(0,-0.5,0)
		isUpTime = 0
		isUp = false
	pass
