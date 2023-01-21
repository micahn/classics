extends Node2D

@export var left: int = 10:
	set(val):
		left = val
		_on_changed()
		


var paddle : Paddle 
var paddle2 : Paddle

var delay = 5.0;
var delayTimer :=Timer.new()

var scoreoverlay: ScoreOverlay = preload("res://scenes/score_overlay.tscn").instantiate()
var score = 0.0


func _on_changed():
	paddle.position.x = left + paddle.width/2.0



func _ready():
	delayTimer.wait_time = delay
	delayTimer.connect("timeout", autoSpawnBall)
	delayTimer.autostart = true
	
	
	add_child(scoreoverlay)
	if paddle == null:
		paddle = Paddle.new(get_viewport_rect())
		paddle2 = Paddle.new(get_viewport_rect())
	var vp_size = get_viewport_rect().size
	add_child(paddle,true)
	add_child(paddle2,true)
	var wallDown = Wall.new(Vector2.UP, -vp_size.y)
	wallDown.add_to_group("obstical")
	add_child(wallDown)
	var wallUp = Wall.new(Vector2.DOWN, 0)
	wallUp.add_to_group("obstical")
	add_child(wallUp)
	var wallRight = Wall.new(Vector2.LEFT, -vp_size.x)
	wallRight.add_to_group("player2")
	add_child(wallRight)
	var wallLeft = Wall.new(Vector2.RIGHT, 0)
	wallLeft.add_to_group("player1")
	add_child(wallLeft)
	paddle.position.x = left + paddle.width/2.0
	paddle.position.y = get_viewport_rect().size.y/2.0
	paddle.tendtowards = paddle.position.y
	paddle2.position.x = get_viewport_rect().size.x - (left + paddle.width/2.0)
	paddle2.position.y = get_viewport_rect().size.y/2.0
	paddle2.tendtowards = paddle2.position.y
	
	add_child(delayTimer)
	
func _hit_players_wall(ball:Ball, collider:KinematicCollision2D):
	if collider.get_collider().is_in_group("player1"):
		score -= 10
		scoreoverlay._on_score_changed(score)
		ball.queue_free()
	elif collider.get_collider().is_in_group("player2"):
		score += 10
		scoreoverlay._on_score_changed(score)
		ball.queue_free()

func autoSpawnBall():
	spawnNewBall()
	delayTimer.wait_time *= .95 
	

func spawnNewBall():
	var b = Ball.new()
	b.add_to_group("projectiles")
	b.connect("hit", _hit_players_wall)
	b.position = get_viewport_rect().size/2.0
	add_child(b)

func _process(delta):
	paddle.tendtowards = get_local_mouse_position().y #paddle.position.y - Input.get_axis("move_DOWN","move_UP")*10.0

	if Input.is_action_just_released("SpawnNewBall"):
		spawnNewBall()
		
	var balls = get_tree().get_nodes_in_group("projectiles")
	if balls.size() > 0:
		balls.sort_custom(func(a,b):return paddle2.position.x - a.position.x < paddle2.position.x - b.position.x)
		var closest_ball = balls[0]
		paddle2.tendtowards = closest_ball.position.y
	
		
		
