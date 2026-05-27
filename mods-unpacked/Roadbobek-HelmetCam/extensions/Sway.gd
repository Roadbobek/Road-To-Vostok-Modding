
extends "res://Scripts/Sway.gd"

const MYMOD_LOG = "Roadbobek-HelmetCam"


# Varaibles avaliable for editing,
# and their defaults:
  # baseMultiplier = 0.2
  # aimMultiplier = 0.2
  # cantedMultiplier = 0.2
  # smoothing = 5.0


func _ready()->void:
    ModLoaderLog.info("Sway.gd Extension Script Ready", MYMOD_LOG)
    super._ready()

func _input(event):
    super._input(event)

func _physics_process(delta):
    if get_node("/root/ModLoader/Roadbobek-HelmetCam/MyModLogic").cam_toggle == true:
        # Edited variables
        #baseMultiplier = 0.2
        aimMultiplier = 0.125 # 0.2
        #cantedMultiplier = 0.2
        smoothing = 10.0 # 5.0
    else:
        # Original variables
        #baseMultiplier = 0.2
        aimMultiplier = 0.2
        #cantedMultiplier = 0.2
        smoothing = 5.0
    super._physics_process(delta)





















































#extends Node3D
#
#
#var gameData = preload("res://Resources/GameData.tres")
#
#var baseMultiplier = 0.2
#var aimMultiplier = 0.2
#var cantedMultiplier = 0.2
#var smoothing = 5.0
#
#var originalRotation = Vector3.ZERO
#var targetRotation = Vector3.ZERO
#var relativeInput = Vector2.ZERO
#
#func _ready():
    #originalRotation = rotation_degrees
#
#func _input(event):
    #if event is InputEventMouseMotion:
        #if gameData.mouseMode == 2:
            #relativeInput.x = event.relative.x
            #relativeInput.y = - event.relative.y
        #else:
            #relativeInput.x = event.relative.x
            #relativeInput.y = event.relative.y
#
#func _physics_process(delta):
    #if gameData.freeze || gameData.isInspecting:
        #return
#
    #if gameData.isAiming && gameData.isScoped:
        #targetRotation = Vector3(
        #originalRotation.x + relativeInput.y * aimMultiplier * clampf(gameData.scopeSensitivity, 0.1, 1.0), 
        #originalRotation.y + - relativeInput.x * aimMultiplier * clampf(gameData.scopeSensitivity, 0.1, 1.0), 
        #originalRotation.z)
    #elif gameData.isAiming:
        #targetRotation = Vector3(
        #originalRotation.x + relativeInput.y * aimMultiplier * clampf(gameData.aimSensitivity, 0.1, 1.0), 
        #originalRotation.y + - relativeInput.x * aimMultiplier * clampf(gameData.aimSensitivity, 0.1, 1.0), 
        #originalRotation.z)
    #elif gameData.isCanted:
        #targetRotation = Vector3(
        #originalRotation.x, 
        #originalRotation.y, 
        #originalRotation.z + relativeInput.x * cantedMultiplier * clampf(gameData.aimSensitivity, 0.1, 1.0))
    #else:
        #targetRotation = Vector3(
        #originalRotation.x + relativeInput.y * baseMultiplier * clampf(gameData.lookSensitivity, 0.1, 1.0), 
        #originalRotation.y + - relativeInput.x * baseMultiplier * clampf(gameData.lookSensitivity, 0.1, 1.0), 
        #originalRotation.z)
#
    #rotation_degrees = rotation_degrees.lerp(targetRotation, delta * smoothing)
    #relativeInput = Vector2.ZERO
