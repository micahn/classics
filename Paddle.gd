
extends CharacterBody2D
class_name Paddle

@export var width : int = 20
@export var height : int = 100
@export var maxSpeed : float = 1000
var tendtowards : float
var bound : Rect2

var colorRect : ColorRect
var collider : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_child_count() == 0:
		colorRect = ColorRect.new()
		colorRect.material = load("res://Paddle.tres")
		colorRect.size = Vector2(width,height)
		colorRect.position = Vector2(-width/2.0,-height/2.0)
		
		collider = CollisionShape2D.new()
		collider.shape = RectangleShape2D.new()
		collider.shape.size = Vector2(width,height)
		add_child(colorRect,true)
		add_child(collider,true)


func _init(b:Rect2):
	bound = b

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if colorRect!=null:
		colorRect.material.set_shader_parameter("y", position.y/bound.size.y)

func _physics_process(delta):
	velocity.y = clamp((tendtowards - position.y)*16,-maxSpeed,maxSpeed)
	move_and_collide(velocity*delta)
