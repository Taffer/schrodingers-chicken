extends Area2D

@export var speed: float = 250.0  # 400 pixels/sec
var screen: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = Vector2.ZERO
	var peck = false
	
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1.0
	if Input.is_action_pressed("ui_right"):
		dir.x += 1.0
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1.0
	if Input.is_action_pressed("ui_down"):
		dir.y += 1.0

	if Input.is_action_pressed("ui_accept"):
		peck = true
		
	dir = dir.normalized()
	if dir.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += dir * speed * delta
	position.x = clamp(position.x, 0, screen.x)
	position.y = clamp(position.y, 0, screen.y)
	
	if dir.x != 0.0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = dir.x > 0.0
		
	if peck:
		$AnimatedSprite2D.animation = "peck"
