extends "res://Scripts/CameraNoise.gd"

const MYMOD_LOG = "Roadbobek-HelmetCam"

func _ready()->void:
    ModLoaderLog.info("CameraNoise.gd Extension Script Ready", MYMOD_LOG)

func _physics_process(delta: float) -> void:
    if get_node("/root/ModLoader/Roadbobek-HelmetCam/MyModLogic").cam_toggle == true:

        if gameData.freeze:
            return

        # 1. Crank up the noise calculation speed for a more frantic look
        delta *= 1.15

        # 2. HIJACK THE CAMERA STATE MACHINE
        if gameData.isFiring:
            if gameData.firemode == 1:
                targetFrequency = 6.0
                targetAmplitude = 0.025 
                targetLerpSpeed = 12.0
            else:
                targetFrequency = 6.0
                targetAmplitude = 0.025
                targetLerpSpeed = 100.0
                
        elif gameData.isMoving && gameData.isGrounded:
            if gameData.isRunning:
                targetFrequency = 1.0      # Cut from 4.0: Heavy, realistic sprinting step pace
                targetAmplitude = 0.04     # cut from 0.04: Solid running bounce without being blinding
                targetLerpSpeed = 5.0
                
            elif gameData.isCrouching:     
                targetFrequency = 1.0      # cut from 1.2: A very slow, methodical tactical creep
                targetAmplitude = 0.005    # clight reduction: Minimal reticle disturbance
                targetLerpSpeed = 3.0      
                
            elif gameData.isWalking:
                targetFrequency = 0.6      # cut from 2.0: Calm, natural footstep cadence
                targetAmplitude = 0.03     # cut from 0.015: Subtle, stable helmet sway
                targetLerpSpeed = 4.0
                
            else:
                # FALLBACK SAFETY NET (e.g.., strafing/aiming shuffles)
                targetFrequency = 1.1
                targetAmplitude = 0.007
                targetLerpSpeed = 4.0
                
        else:
            # PLAYER IS NOT MOVING
            if gameData.isGrounded && gameData.isCrouching: 
                targetFrequency = 0.3      
                targetAmplitude = 0.001    
                targetLerpSpeed = 4.0      
            else:
                targetFrequency = 0.5
                targetAmplitude = 0.002
                targetLerpSpeed = 2.0

        finalFrequency = lerp(finalFrequency, targetFrequency, delta * targetLerpSpeed)
        finalAmplitude = lerp(finalAmplitude, targetAmplitude, delta * targetLerpSpeed)

        var weaponScrollOffset = delta * finalFrequency

        weaponNoiseOffset.x += weaponScrollOffset
        weaponNoiseOffset.y += weaponScrollOffset
        weaponNoiseOffset.z += weaponScrollOffset

        weaponNoise.x = noise.get_noise_2d(weaponNoiseOffset.x, 0.0)
        weaponNoise.y = noise.get_noise_2d(weaponNoiseOffset.y, 1.0)
        weaponNoise.z = noise.get_noise_2d(weaponNoiseOffset.z, 2.0)

        weaponNoise *= finalAmplitude

        # 3. apply heavy rotation offsets directly to the camera view
        rotation.x = weaponNoise.x
        rotation.y = weaponNoise.y
        
        # give the z-axis (roll) a massive boost to mimic a heavy helmet 
        # tilting heavily side-to-side with every footstep.
        rotation.z = weaponNoise.z * 1.8

    else:
        super._physics_process(delta)

































## Noise.gd is a part of the camera system, it handles shake, sway, bob, ect, to do with weapons firing, so recoil.
## it does not affect walking or weapons effects.
#extends "res://Scripts/CameraNoise.gd"
#
#const MYMOD_LOG = "Roadbobek-HelmetCam"
#
#
#func _ready()->void:
    #ModLoaderLog.info("CameraNoise.gd Extension Script Ready", MYMOD_LOG)
    ## super._ready() # og script doesnt have one
#
#func _physics_process(delta: float) -> void:
    #if get_node("/root/ModLoader/Roadbobek-HelmetCam/MyModLogic").cam_toggle == true:
#
        #if gameData.freeze:
            #return
#
        ## 1. Boost frequency (Speed) by 25%
        ## Speeds up the noise sampling process, making the weapon fire shake 
        ## feel like a high-velocity jitter/rattle rather than a smooth sway.
        #delta *= 1.25
        #
        ## targetFrequency = The Speed/Pacing (The speed/rhythm of the shake)
        ## targetAmplitude = The Distance/Size (How far the camera physically moves)
        ## targetLerpSpeed = The Snappiness(How fast the camera transitions between states, coming in and out of shooting)
#
        #if gameData.isFiring:
            #if gameData.firemode == 1:
                #targetFrequency = 5.0
                #targetAmplitude = 0.01
                #targetLerpSpeed = 10.0
            #else:
                #targetFrequency = 5.0
                #targetAmplitude = 0.01
                #targetLerpSpeed = 100.0
        ##else:
            ##targetFrequency = 0.0
            ##targetAmplitude = 0.0
            ##targetLerpSpeed = 100.0
#
        ## Force procedural camera movement when walking or running
        #elif gameData.isMoving && gameData.isGrounded:
            #if gameData.isRunning:
                #targetFrequency = 4.0      # Fast, chaotic pacing
                #targetAmplitude = 0.04     # Heavy camera jostling/impacts
                #targetLerpSpeed = 6.0
            #elif gameData.isWalking:
                #targetFrequency = 2.0      # Natural walking step cadence
                #targetAmplitude = 0.015    # Visible, loose helmet sway
                #targetLerpSpeed = 4.0
            #else:
                #targetFrequency = 1.5
                #targetAmplitude = 0.01
                #targetLerpSpeed = 4.0
        #else: # Subtle lens breathing when standing completely still
            #targetFrequency = 0.5
            #targetAmplitude = 0.002
            #targetLerpSpeed = 2.0
#
        ## 2. Lower camera shake speed (Frequency) by 25%
        ## directly decreases the kickback speed
        ## since we are going to boost the camera shake distance vastly we lower the speed to make up
        #targetAmplitude *= 0.75
#
        ## 3. Boost camera shake distance (Amplitude) by 200%
        ## directly multiplies the kickback distance, This simulates the recoil shockwave
        ## physically rattling the camera, helmet mount and visor
        #targetAmplitude *= 3.0
#
#
        #finalFrequency = lerp(finalFrequency, targetFrequency, delta * targetLerpSpeed)
        #finalAmplitude = lerp(finalAmplitude, targetAmplitude, delta * targetLerpSpeed)
#
        #var weaponScrollOffset = delta * finalFrequency
#
        #weaponNoiseOffset.x += weaponScrollOffset
        #weaponNoiseOffset.y += weaponScrollOffset
        #weaponNoiseOffset.z += weaponScrollOffset
#
        #weaponNoise.x = noise.get_noise_2d(weaponNoiseOffset.x, 0.0)
        #weaponNoise.y = noise.get_noise_2d(weaponNoiseOffset.y, 1.0)
        #weaponNoise.z = noise.get_noise_2d(weaponNoiseOffset.z, 2.0)
#
        #weaponNoise *= finalAmplitude
#
        #rotation.x = weaponNoise.x
        #rotation.y = weaponNoise.y
        #
        ## 4. Exaggerate camera Z rotation (Roll) by 15%
        ## gives the camera a violent side-to-side twist/tilt when firing,
        ## mimicking a physical bodycam/helmet mount reacting to recoil
        #rotation.z = weaponNoise.z * 1.15
#
    #else:
        #super._physics_process(delta) 
































#extends "res://Scripts/CameraNoise.gd"
#
#const MYMOD_LOG = "Roadbobek-HelmetCam"
#
#
#func _ready()->void:
    #ModLoaderLog.info("CameraNoise.gd Extension Script Ready", MYMOD_LOG)
    ## super._ready() # og script doesnt have one
#
#func _physics_process(delta: float) -> void:
    #if get_node("/root/ModLoader/Roadbobek-HelmetCam/MyModLogic").cam_toggle == true:
        #
        #delta *= 1.25 # ( 1 )
            #
        #if gameData.freeze:
            #return
#
        #if gameData.isFiring:
            #if gameData.firemode == 1:
                #targetFrequency = 5.0 # 5.0
                #targetAmplitude = 0.01 # 0.01
                #targetLerpSpeed = 5.0 # 10.0
            #else:
                #targetFrequency = 5.0 # 5.0
                #targetAmplitude = 0.01 # 0.01
                #targetLerpSpeed = 50.0 # 100.0
        #else:
            #targetFrequency = 0.0 # 0.0
            #targetAmplitude = 0.0 # 0.0
            #targetLerpSpeed = 100.0 # 100.0
        #
        #targetFrequency *= 1.5 # ( 2 )
        #targetAmplitude *= 1.5 # ( 3 )
        #targetLerpSpeed *= 1.5 # ( 4 )
        #
        #finalFrequency = lerp(finalFrequency, targetFrequency, delta * targetLerpSpeed)
        #finalAmplitude = lerp(finalAmplitude, targetAmplitude, delta * targetLerpSpeed)
        #
        ##finalFrequency * 1.5 # ( 2 )
        ##finalAmplitude * 1.5 # ( 3 )
        #
        #var weaponScrollOffset = delta * finalFrequency
#
        #weaponNoiseOffset.x += weaponScrollOffset
        #weaponNoiseOffset.y += weaponScrollOffset
        #weaponNoiseOffset.z += weaponScrollOffset
#
        #weaponNoise.x = noise.get_noise_2d(weaponNoiseOffset.x, 0.0)
        #weaponNoise.y = noise.get_noise_2d(weaponNoiseOffset.y, 1.0)
        #weaponNoise.z = noise.get_noise_2d(weaponNoiseOffset.z, 2.0)
#
        #weaponNoise *= finalAmplitude
#
        #rotation.x = weaponNoise.x
        #rotation.y = weaponNoise.y
        #rotation.z = weaponNoise.z
#
    #else:
        #super._physics_process(delta) 
























#extends Node3D
#
#
#var gameData = preload("res://Resources/GameData.tres")
#
#@export var noise: FastNoiseLite
#
#var weaponNoiseOffset = Vector3.ZERO
#var weaponNoise = Vector3.ZERO
#var weaponRotation = Vector3.ZERO
#var time
#
#var targetFrequency = 0.0
#var targetAmplitude = 0.0
#var targetLerpSpeed = 0.0
#
#var finalFrequency = 0.0
#var finalAmplitude = 0.0
#
#func _physics_process(delta):
    #if gameData.freeze:
        #return
#
    #if gameData.isFiring:
        #if gameData.firemode == 1:
            #targetFrequency = 5.0
            #targetAmplitude = 0.01
            #targetLerpSpeed = 10.0
        #else:
            #targetFrequency = 5.0
            #targetAmplitude = 0.01
            #targetLerpSpeed = 100.0
    #else:
        #targetFrequency = 0.0
        #targetAmplitude = 0.0
        #targetLerpSpeed = 100.0
#
    #finalFrequency = lerp(finalFrequency, targetFrequency, delta * targetLerpSpeed)
    #finalAmplitude = lerp(finalAmplitude, targetAmplitude, delta * targetLerpSpeed)
#
    #var weaponScrollOffset = delta * finalFrequency
#
    #weaponNoiseOffset.x += weaponScrollOffset
    #weaponNoiseOffset.y += weaponScrollOffset
    #weaponNoiseOffset.z += weaponScrollOffset
#
    #weaponNoise.x = noise.get_noise_2d(weaponNoiseOffset.x, 0.0)
    #weaponNoise.y = noise.get_noise_2d(weaponNoiseOffset.y, 1.0)
    #weaponNoise.z = noise.get_noise_2d(weaponNoiseOffset.z, 2.0)
#
    #weaponNoise *= finalAmplitude
#
    #rotation.x = weaponNoise.x
    #rotation.y = weaponNoise.y
    #rotation.z = weaponNoise.z
