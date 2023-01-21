
extends CharacterBody2D
class_name Ball

signal hit

@export var radius : int = 20
@export var speed : float = 600
var colorRect : ColorRect
var collider : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():

	collision_layer = 2
	collision_mask = 1
	if get_child_count() == 0:
		colorRect = ColorRect.new()
		colorRect.material = load("res://Ball.tres")
		colorRect.size = Vector2(radius*2,radius*2)
		colorRect.position = Vector2(-radius,-radius)
		collider = CollisionShape2D.new()
		collider.shape = CircleShape2D.new()
		collider.shape.radius = radius
		add_child(colorRect,true)
		add_child(collider,true)
		colorRect.set_owner(get_tree().edited_scene_root)
		collider.set_owner(get_tree().edited_scene_root)
	velocity = Vector2(sign(randf()-.5), randf()-.5).normalized()*speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		var v = velocity
		v = v.reflect(collision.get_normal().orthogonal())
		
		v = v + collision.get_collider_velocity()
		velocity = v.normalized()*speed if v.length() > speed else v
		emit_signal("hit", self, collision)
		
	
	
