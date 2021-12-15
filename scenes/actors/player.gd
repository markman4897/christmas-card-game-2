extends Actor

const control_deadzone := 3

func _init():

	sprites = {
		"player": preload("res://assets/aseprite_files/npcs/player.ase")
	}

	sprite = "player"
	idle_animation = "idle"


func _get_motion():
	# keyboard input
	var motion = Vector2(0,0)
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# touch/mouse input
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		# get mouse pos
		var res = get_viewport().get_mouse_position() - self.position
		
		if abs(res.x) > control_deadzone or abs(res.y) > control_deadzone:
			motion = res
			# so that left/right animations don't get ignored
			if abs(motion.y) < control_deadzone: motion.y = 0
	
	motion = motion.normalized() * speed
	
	print(motion)
	
	return motion
