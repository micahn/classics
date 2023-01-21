extends StaticBody2D
class_name Wall


var collider : CollisionShape2D

var normal : Vector2
var distance : float

func _init(normal, distance):
	self.normal = normal
	self.distance = distance
	collider = CollisionShape2D.new()
	var boundary := WorldBoundaryShape2D.new()
	boundary.normal = normal
	boundary.distance = distance
	collider.shape = boundary
	add_child(collider)
	

