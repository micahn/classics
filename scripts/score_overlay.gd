extends Control
class_name ScoreOverlay


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_score_changed(score):
	(get_node("ScorePanel/scoreLabel") as Label).text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
