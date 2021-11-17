extends Spatial

var player_inside := false

var door_state := 0
enum door{OPEN = 1, CLOSE = 2}

var anim_is_playing = false

export var key_press := "ui_up"

func _input(event: InputEvent) -> void:
	
	# disabled further input when animation is playing
	if anim_is_playing == true:
		return
	
	if Input.is_action_just_pressed(key_press) and player_inside:
		print("door animation playing")
		
		# alternating the between door open and close
		door_state += 1
		if door_state > 2:
			door_state = 1
		print("door state:", door_state)
		
		# two animation depending on current door state 
		if door_state == door.OPEN:
			$AnimationPlayer.play("DOOR_CLOSED")
			print("closing door")
		if door_state == door.CLOSE:
			$AnimationPlayer.play("DOOR_OPEN")
			print("opening door")


func _on_Area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = true
	door_state = door.OPEN

func _on_Area_body_exited(body: Node) -> void:
	player_inside = false


func _on_AnimationPlayer_animation_started(anim_name: String) -> void:
	anim_is_playing = true

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	anim_is_playing = false
