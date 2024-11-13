extends CharacterBody2D

# Scene-Tree Node references
@onready var animated_sprite = $AnimatedSprite2D

# Variables
@export var speed = 100

var oldman_in_range = false

# Input for movement
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

# Movement & Animation
func _physics_process(delta):
	
	if oldman_in_range == true:
		if Input.is_action_just_pressed("oke"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialog/dialogue.dialogue"), "start")
			return
	get_input()
	move_and_slide()  # Tambahkan velocity sebagai parameter
	update_animation()
 
# Animation
func update_animation():
	if velocity == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		# Menggunakan animasi "walk_right" untuk semua arah
		animated_sprite.play("walk_right")
		
		# Menentukan arah flip berdasarkan velocity
		animated_sprite.flip_h = velocity.x < 0  # Balik secara horizontal jika bergerak ke kiri
		velocity.y > 0 and abs(velocity.y) > abs(velocity.x)  # Balik secara vertikal jika bergerak ke bawah


func _on_detection_body_entered(body: Node2D) -> void:
	if body.has_method("old_man"):
		oldman_in_range = true
		
func _on_detection_body_exited(body: Node2D) -> void:
	if body.has_method("old_man"):
		oldman_in_range = false
