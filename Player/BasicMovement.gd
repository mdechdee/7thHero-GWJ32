extends Node

var move: Vector2
var body: KinematicBody2D

func physics_process(delta):
	move.y += GlobalVar.GRAVITY
	move.y = clamp(move.y, -GlobalVar.MAX_Y_SPEED, GlobalVar.MAX_Y_SPEED)
	move.x = clamp(move.x, -GlobalVar.MAX_X_SPEED, GlobalVar.MAX_X_SPEED)
	move = body.move_and_slide(move)
	if move.length() < 0.01:
		move = Vector2.ZERO
