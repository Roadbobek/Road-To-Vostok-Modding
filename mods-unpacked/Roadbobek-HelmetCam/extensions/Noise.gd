# Noise.gd is attached to every weapon in the game, it handles sway, bob, ect. it does not affect camera or character.
extends "res://Scripts/Noise.gd"

const MYMOD_LOG = "Roadbobek-HelmetCam"


func _ready()->void:
    ModLoaderLog.info("Noise.gd Extension Script Ready", MYMOD_LOG)
    # super._ready() # og script doesnt have one

func _physics_process(delta: float) -> void:
    if get_node("/root/ModLoader/Roadbobek-HelmetCam/MyModLogic").cam_toggle == true:
        
        # 1. Boost frequency (Speed) by 15%
        # By scaling delta locally at the start, every time-based calculation 
        # (headbob speed, noise scroll speed) automatically runs 15% faster/more chaotic
        delta *= 1.15
        
        # headbobIndex = The Speed (Rhythm)
        # headbobIntensity = The Distance (Size)
        
        if gameData.isMoving && gameData.isGrounded && !gameData.freeze:

            if gameData.isAiming && !gameData.isCrouching && !gameData.isRunning:
                headbobIntensity = 0.004
                headbobIndex += 10.0 * delta

            elif gameData.isAiming && gameData.isCrouching && !gameData.isRunning:
                headbobIntensity = 0.005
                headbobIndex += 8.0 * delta

            elif gameData.isAiming && gameData.isRunning: # 2.1:
                headbobIntensity = 0.007 # from 0.01, 30% decrease
                headbobIndex += 12.0 * delta # from 15.0, 20% decrease

            elif gameData.isWalking:
                headbobIntensity = 0.005
                headbobIndex += 10.0 * delta

            elif gameData.isRunning: # 2.2:
                headbobIntensity = 0.007 # from 0.01, 30% decrease
                headbobIndex += 12.0 * delta # from 15.0, 20% decrease

            elif gameData.isCrouching:
                headbobIntensity = 0.005
                headbobIndex += 8.0 * delta

            # 3. Boost bob distance (Amplitude) by 100%
            # Right before the game uses headbobIntensity multiply it by 2.0
            headbobIntensity *= 2.0

            if gameData.isCanted:
                headbobVector.x = sin(headbobIndex + 1.5)
                headbobVector.y = sin(headbobIndex - 1.5)
                position.x = lerp(position.x, headbobVector.x * headbobIntensity, delta * bobLerpSpeed)
                position.y = lerp(position.y, headbobVector.y * headbobIntensity, delta * bobLerpSpeed)
            else:
                headbobVector.x = sin(headbobIndex / 2)
                headbobVector.y = sin(headbobIndex)
                position.x = lerp(position.x, headbobVector.x * headbobIntensity, delta * bobLerpSpeed)
                position.y = lerp(position.y, headbobVector.y * (headbobIntensity * 2), delta * bobLerpSpeed)


        else:
            position.x = lerp(position.x, 0.0, delta * bobLerpSpeed)
            position.y = lerp(position.y, 0.0, delta * bobLerpSpeed)



        if gameData.isGrounded:

            if gameData.freeze:
                targetFrequency = 0.2
                targetAmplitude = 0.05
                targetLerpSpeed = 2.0

            else:

                if gameData.isIdle:
                    targetFrequency = 0.2
                    targetAmplitude = 0.05
                    targetLerpSpeed = 2.0

                if gameData.isWalking:
                    targetFrequency = 1.0
                    targetAmplitude = 0.04
                    targetLerpSpeed = 2.0

                if gameData.isRunning:
                    targetFrequency = 2.0
                    targetAmplitude = 0.08
                    targetLerpSpeed = 2.0

                if gameData.isCrouching && gameData.isMoving:
                    targetFrequency = 1.0
                    targetAmplitude = 0.05
                    targetLerpSpeed = 2.0

                if gameData.isAiming:
                    targetFrequency = 0.5
                    targetAmplitude = 0.005
                    targetLerpSpeed = 4.0

                if gameData.isFiring:
                    targetFrequency = 4.0
                    targetAmplitude = 0.02
                    targetLerpSpeed = 1.0
        else:
            targetFrequency = 0.2
            targetAmplitude = 0.05
            targetLerpSpeed = 50.0
            
        # 4. Boost sway distance (Amplitude) by 100%
        # Right before the script figures out finalAmplitude multiply by 2.0
        targetAmplitude *= 2.0


        if gameData.isAiming && !gameData.isFiring:
            var armInversion = inverse_lerp(100, 0, gameData.armStamina)
            armMultiplier = 1 + armInversion * 2.0
        else:
            armMultiplier = 1.0


        finalFrequency = lerp(finalFrequency, targetFrequency * armMultiplier, delta * targetLerpSpeed)
        finalAmplitude = lerp(finalAmplitude, targetAmplitude * armMultiplier, delta * targetLerpSpeed)
        var weaponScrollOffset = delta * finalFrequency


        weaponNoiseOffset.x += weaponScrollOffset
        weaponNoiseOffset.y += weaponScrollOffset
        weaponNoiseOffset.z += weaponScrollOffset
        weaponNoise.x = noise.get_noise_2d(weaponNoiseOffset.x, 0.0)
        weaponNoise.y = noise.get_noise_2d(weaponNoiseOffset.y, 1.0)
        weaponNoise.z = noise.get_noise_2d(weaponNoiseOffset.z, 2.0)
        weaponNoise *= finalAmplitude
        rotation.x = weaponNoise.x
        rotation.y = weaponNoise.y
        # 5. Exagerate weapons Z rotation by 10%
        rotation.z = weaponNoise.z * 1.1
        
    else:
        super._physics_process(delta)































#extends Node3D
#
#
#var gameData = preload("res://Resources/GameData.tres")
#
#
#@export var noise: FastNoiseLite
#
#
#var weaponNoiseOffset = Vector3.ZERO
#var weaponNoise = Vector3.ZERO
#var weaponRotation = Vector3.ZERO
#var time
#
#
#var targetFrequency = 0.0
#var targetAmplitude = 0.0
#var targetLerpSpeed = 0.0
#var finalFrequency = 0.0
#var finalAmplitude = 0.0
#
#
#var headbobIndex = 0.0
#var headbobIntensity = 0.0
#var headbobVector = Vector2.ZERO
#var bobLerpSpeed = 5.0
#
#
#var armMultiplier = 1.0
#
#func _physics_process(delta):
#
#
    #if gameData.isMoving && gameData.isGrounded && !gameData.freeze:
#
        #if gameData.isAiming && !gameData.isCrouching && !gameData.isRunning:
            #headbobIntensity = 0.004
            #headbobIndex += 10.0 * delta
#
        #elif gameData.isAiming && gameData.isCrouching && !gameData.isRunning:
            #headbobIntensity = 0.005
            #headbobIndex += 8.0 * delta
#
        #elif gameData.isAiming && gameData.isRunning:
            #headbobIntensity = 0.01
            #headbobIndex += 15.0 * delta
#
        #elif gameData.isWalking:
            #headbobIntensity = 0.005
            #headbobIndex += 10.0 * delta
#
        #elif gameData.isRunning:
            #headbobIntensity = 0.01
            #headbobIndex += 15.0 * delta
#
        #elif gameData.isCrouching:
            #headbobIntensity = 0.005
            #headbobIndex += 8.0 * delta
#
#
        #if gameData.isCanted:
            #headbobVector.x = sin(headbobIndex + 1.5)
            #headbobVector.y = sin(headbobIndex - 1.5)
            #position.x = lerp(position.x, headbobVector.x * headbobIntensity, delta * bobLerpSpeed)
            #position.y = lerp(position.y, headbobVector.y * headbobIntensity, delta * bobLerpSpeed)
        #else:
            #headbobVector.x = sin(headbobIndex / 2)
            #headbobVector.y = sin(headbobIndex)
            #position.x = lerp(position.x, headbobVector.x * headbobIntensity, delta * bobLerpSpeed)
            #position.y = lerp(position.y, headbobVector.y * (headbobIntensity * 2), delta * bobLerpSpeed)
#
#
    #else:
        #position.x = lerp(position.x, 0.0, delta * bobLerpSpeed)
        #position.y = lerp(position.y, 0.0, delta * bobLerpSpeed)
#
#
#
    #if gameData.isGrounded:
#
        #if gameData.freeze:
            #targetFrequency = 0.2
            #targetAmplitude = 0.05
            #targetLerpSpeed = 2.0
#
        #else:
#
            #if gameData.isIdle:
                #targetFrequency = 0.2
                #targetAmplitude = 0.05
                #targetLerpSpeed = 2.0
#
            #if gameData.isWalking:
                #targetFrequency = 1.0
                #targetAmplitude = 0.04
                #targetLerpSpeed = 2.0
#
            #if gameData.isRunning:
                #targetFrequency = 2.0
                #targetAmplitude = 0.08
                #targetLerpSpeed = 2.0
#
            #if gameData.isCrouching && gameData.isMoving:
                #targetFrequency = 1.0
                #targetAmplitude = 0.05
                #targetLerpSpeed = 2.0
#
            #if gameData.isAiming:
                #targetFrequency = 0.5
                #targetAmplitude = 0.005
                #targetLerpSpeed = 4.0
#
            #if gameData.isFiring:
                #targetFrequency = 4.0
                #targetAmplitude = 0.02
                #targetLerpSpeed = 1.0
    #else:
        #targetFrequency = 0.2
        #targetAmplitude = 0.05
        #targetLerpSpeed = 50.0
#
#
    #if gameData.isAiming && !gameData.isFiring:
        #var armInversion = inverse_lerp(100, 0, gameData.armStamina)
        #armMultiplier = 1 + armInversion * 2.0
    #else:
        #armMultiplier = 1.0
#
#
    #finalFrequency = lerp(finalFrequency, targetFrequency * armMultiplier, delta * targetLerpSpeed)
    #finalAmplitude = lerp(finalAmplitude, targetAmplitude * armMultiplier, delta * targetLerpSpeed)
    #var weaponScrollOffset = delta * finalFrequency
#
#
    #weaponNoiseOffset.x += weaponScrollOffset
    #weaponNoiseOffset.y += weaponScrollOffset
    #weaponNoiseOffset.z += weaponScrollOffset
    #weaponNoise.x = noise.get_noise_2d(weaponNoiseOffset.x, 0.0)
    #weaponNoise.y = noise.get_noise_2d(weaponNoiseOffset.y, 1.0)
    #weaponNoise.z = noise.get_noise_2d(weaponNoiseOffset.z, 2.0)
    #weaponNoise *= finalAmplitude
    #rotation.x = weaponNoise.x
    #rotation.y = weaponNoise.y
    #rotation.z = weaponNoise.z
