
extends "res://Scripts/Recoil.gd"

const MYMOD_LOG = "Roadbobek-HelmetCam"

func _ready()->void:
    ModLoaderLog.info("Recoil.gd Extension Script Ready", MYMOD_LOG)
    super._ready()

func _physics_process(delta):
    super._physics_process(delta)

func ApplyRecoil() -> void:
    if get_node("/root/ModLoader/Roadbobek-HelmetCam/MyModLogic").cam_toggle == true:
        
        # 1. force and distance multipliers 
        var vert_multiplier = 2.2       # upward muzzle climb multiplier
        var horiz_multiplier = 1.8      # side-to-side horizontal jump multiplier
        var kick_multiplier = 2.5       # backward physical punch into the screen multiplier
        var twist_multiplier = 3.0      # new, exaggerates z-axis twisting/rolling in the hands
        
        # pull baseline stats from the weapons resource file
        var v_recoil = data.verticalRecoil * vert_multiplier
        var h_recoil = data.horizontalRecoil * horiz_multiplier
        
        if gameData.firemode == 1: # (semi / semi-auto)
            currentRotation.x = -v_recoil
            currentRotation.y = randf_range(-h_recoil, h_recoil)
            
            # inject a random left/right twist along the z-axis (vanilla left this at 0.0)
            currentRotation.z = randf_range(-h_recoil * twist_multiplier, h_recoil * twist_multiplier)
        else:
            # secondary firemode (full auto)
            currentRotation.x = -(v_recoil / 2.0)
            currentRotation.y = randf_range(-h_recoil, h_recoil)
            currentRotation.z = randf_range(-h_recoil * (twist_multiplier * 0.6), h_recoil * (twist_multiplier * 0.6))
            
        # forces the gun model to smash backward into the camera on the z axis
        currentKick = Vector3(0.0, 0.0, -data.kick * kick_multiplier)
        
    else:
        super.ApplyRecoil()

func CalculateRecoil(delta: float) -> void:
    if get_node("/root/ModLoader/Roadbobek-HelmetCam/MyModLogic").cam_toggle == true:
        
        if gameData.freeze || gameData.flycam:
            return

        # 2. weight and recovery speed multipliers
        # higher power_mult makes the gun slam back instantly
        # lower recovery_mult makes the gun settle slowly, giving it a heavy, high-caliber weight
        var snap_power_mult = 1.3        
        var recovery_speed_mult = 0.75   
        
        # process the interpolation over time
        currentRotation = lerp(currentRotation, Vector3.ZERO, delta * (data.rotationRecovery * recovery_speed_mult))
        rotation = lerp(rotation, currentRotation, delta * (data.rotationPower * snap_power_mult))

        currentKick = lerp(currentKick, Vector3.ZERO, delta * (data.kickRecovery * recovery_speed_mult))
        position = lerp(position, currentKick, delta * (data.kickPower * snap_power_mult))
        
    else:
        super.CalculateRecoil(delta)





















#extends "res://Scripts/Recoil.gd"
#
#const MYMOD_LOG = "Roadbobek-HelmetCam"
#
#func _ready()->void:
    #ModLoaderLog.info("Recoil.gd Extension Script Ready", MYMOD_LOG)
    #super._ready()
#
#func _physics_process(delta):
    #super._physics_process(delta)
#func CalculateRecoil(delta):
    #super.CalculateRecoil(delta)
#
#func ApplyRecoil():
    #if get_node("/root/ModLoader/Roadbobek-HelmetCam/MyModLogic").cam_toggle == true:
#
        #if gameData.firemode == 1:
            #currentRotation = Vector3( - data.verticalRecoil, randf_range( - data.horizontalRecoil, data.horizontalRecoil), 0.0)
        #else:
            #currentRotation = Vector3( - data.verticalRecoil / 2, randf_range( - data.horizontalRecoil, data.horizontalRecoil), 0.0)
        #currentKick = Vector3(0.0, 0.0, - data.kick)
        #
        #currentRotation *= 3.5 # 1. %50 increase
        #currentKick *= 3.5 # 2. %50 increase
        ##position *= 3.5 # 1. %50 increase
        #
        ##if gameData.firemode == 1:
            ##currentRotation = Vector3( - data.verticalRecoil, randf_range( - data.horizontalRecoil, data.horizontalRecoil), 0.0)
        ##else:
            ##currentRotation = Vector3( - data.verticalRecoil / 2, randf_range( - data.horizontalRecoil, data.horizontalRecoil), 0.0)
        ##currentKick = Vector3(0.0, 0.0, - data.kick)
        #
    #else:
        #super.ApplyRecoil()




























#extends Node3D
#
#
#var gameData = preload("res://Resources/GameData.tres")
#
#var data: Resource
#var currentKick = Vector3.ZERO
#var currentRotation = Vector3.ZERO
#
#func _ready():
    #data = owner.data
#
#func _physics_process(delta):
    #if gameData.freeze || gameData.flycam:
        #return
#
    #CalculateRecoil(delta)
#
#func CalculateRecoil(delta):
    #currentRotation = lerp(currentRotation, Vector3.ZERO, delta * data.rotationRecovery)
    #rotation = lerp(rotation, currentRotation, delta * data.rotationPower)
#
    #currentKick = lerp(currentKick, Vector3.ZERO, delta * data.kickRecovery)
    #position = lerp(position, currentKick, delta * data.kickPower)
#
#func ApplyRecoil():
    #if gameData.firemode == 1:
        #currentRotation = Vector3( - data.verticalRecoil, randf_range( - data.horizontalRecoil, data.horizontalRecoil), 0.0)
    #else:
        #currentRotation = Vector3( - data.verticalRecoil / 2, randf_range( - data.horizontalRecoil, data.horizontalRecoil), 0.0)
    #currentKick = Vector3(0.0, 0.0, - data.kick)
