extends Node

## Instead of extending sm bs we js do ts
var gameData = preload("res://Resources/GameData.tres")

const MYMOD_LOG = "Roadbobek-HelmetCam"

var cam_toggle = false
var base_fov

func _input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.pressed and event.keycode == KEY_BRACKETLEFT:
            print("Helmet Cam - On")
            cam_toggle = true

        if event.pressed and event.keycode == KEY_BRACKETRIGHT:
            print("Helmet Cam - Off")
            cam_toggle = false
            
func _ready()->void:
    ModLoaderLog.info("Main script Ready", MYMOD_LOG)
    base_fov = gameData.baseFOV

func _process(_delta: float) -> void:
    if cam_toggle == true:
        #if has_node("/root/Map/Core/Camera"):
            #get_node("/root/Map/Core/Camera").position = Vector3(-0.25, 1.75, 0.0)
            #get_node("/root/Map/Core/Camera").rotation = Vector3(-3.0, -2.25, 0.1)
        if has_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera"):
            if gameData.isAiming:
                #we could use gameData.cameraPosition but fuck you i could do a lot of things i dont
                get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").position = Vector3(-0.17, 0.13, 0.0)
                get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").rotation = Vector3(-0.1, 0.0, -0.15)
            else:
                get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").position = Vector3(-0.17, 0.13, 0.0)
                get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").rotation = Vector3(-0.1, 0.0, 0.0)
        if has_node("/root/Map/Core/Camera/Manager"):
            get_node("/root/Map/Core/Camera/Manager").position = Vector3(0.06, -0.04, 0.05)
            get_node("/root/Map/Core/Camera/Manager").rotation = Vector3(0.0, -3.14, -0.314)
        if gameData.isAiming:
            gameData.baseFOV = base_fov * 0.9
        else:
            gameData.baseFOV = base_fov * 1.15
        
    else:
        #if has_node("/root/Map/Core/Camera"):
            #get_node("/root/Map/Core/Camera").position = Vector3(0.0, 0.0, 0.0)
            #get_node("/root/Map/Core/Camera").rotation = Vector3(0.0, 0.0, 0.0)
        if has_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera"):
            get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").position = Vector3(0.0, 0.0, 0.0)
            get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").rotation = Vector3(0.0, 0.0, 0.0)
        if has_node("/root/Map/Core/Camera/Manager"):
            get_node("/root/Map/Core/Camera/Manager").position = Vector3(0.0, 0.0, 0.0)
            get_node("/root/Map/Core/Camera/Manager").rotation = Vector3(0.0, -3.14, 0.0)
        gameData.baseFOV = base_fov

    # Increase noise / screen shake for cam and guns in Noise.gd plus CameraNoise.gd !








#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##
##extends "res://Scripts/Controller.gd" # Extend / latch onto the player controller script
### res://Scenes/Core.tscn
### res://Scenes/Core/Controller
### res://Scripts/Controller.gd
##
##
### Brief overview of what the changes in this file do...
##const MYMOD_LOG = "Roadbobek-InfiniteHealth" # ! Change `MODNAME` to your actual mod's name
##
##
### Extensions
### =============================================================================
##
##
##func _ready()->void:
    ### ! Note that we're *not* calling `.return` here. This is because, unlike
    ### ! all other vanilla funcs (eg `get_gold_bag_pos` below), _ready will
    ### ! always fire, regardless of your code. In all other cases, we would still
    ### ! need to call it
##
    ### ! Note that you won't see this in the log immediately, because main.gd
    ### ! doesn't run until you start a run
    ##ModLoaderLog.info("Ready", MYMOD_LOG)
##
    ### ! These are custom functions. It will run after vanilla's own _ready is
    ### ! finished
    ##inf_health()
    ##log_bs()
##
##
##
### Vanilla Function: This is the name of a func in vanilla
###func get_gold_bag_pos()->Vector2:
    ### ! This calls vanilla's version of this func. The period (.) before the
    ### func lets you call it without triggering an infinite loop. In this case,
    ### we're calling the vanilla func to get the original value; then, we can
    ### modify it to whatever we like
    ### Use 'super' instead of '.' to call the original function
    ###var gold_bag_pos = super.get_gold_bag_pos()
##
    ### ! If a vanilla func returns something (just as this one returns a Vector2),
    ### ! your modded funcs should also return something with the same type
    ###return gold_bag_pos
##
##
##
### Custom
### =============================================================================
##
##func inf_health()->void: # ! `void` means it doesn't return anything
    ##if "gameData" in self:
        ##self.gameData.health = 676767
        ##print("Mod: Health set to 676767 in Controller")
##
##
##func log_bs()->void:
    ##ModLoaderLog.info("Main.gd has been modified", MYMOD_LOG)
##
##
##
##
##
###func _ready()->void:
    #### ! Note that we're *not* calling `.return` here. This is because, unlike
    #### ! all other vanilla funcs (eg `get_gold_bag_pos` below), _ready will
    #### ! always fire, regardless of your code. In all other cases, we would still
    #### ! need to call it
###
    #### ! Note that you won't see this in the log immediately, because main.gd
    #### ! doesn't run until you start a run
    ###ModLoaderLog.info("Ready", MYMOD_LOG)
###
    #### ! These are custom functions. It will run after vanilla's own _ready is
    #### ! finished
    ###_modname_my_custom_edit_1()
    ###_modname_my_custom_edit_2()
###
###
#### This is the name of a func in vanilla
###func get_gold_bag_pos()->Vector2:
    #### ! This calls vanilla's version of this func. The period (.) before the
    #### func lets you call it without triggering an infinite loop. In this case,
    #### we're calling the vanilla func to get the original value; then, we can
    #### modify it to whatever we like
    #### Use 'super' instead of '.' to call the original function
    ###var gold_bag_pos = super.get_gold_bag_pos()
###
    #### ! If a vanilla func returns something (just as this one returns a Vector2),
    #### ! your modded funcs should also return something with the same type
    ###return gold_bag_pos
###
###
#### Custom
#### =============================================================================
###
###func _modname_my_custom_edit_1()->void: # ! `void` means it doesn't return anything
    ###pass # ! Using `pass` here allows you to have a empty func without causing errors
###
###
###func _modname_my_custom_edit_2()->void:
    ###ModLoaderLog.info("Main.gd has been modified", MYMOD_LOG)
