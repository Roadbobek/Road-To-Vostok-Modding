extends Node

## Instead of extending sm bs we js do ts
var gameData = preload("res://Resources/GameData.tres")

const MYMOD_LOG = "Roadbobek-HelmetCam"

var cam_toggle = false
var base_fov


var smooth_speed = 8.0

var fx_layer: CanvasLayer = null

func _input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.pressed and event.keycode == KEY_BRACKETRIGHT:
            if cam_toggle:
                cam_toggle = false
            else:
                cam_toggle = true
                
        #if event.pressed and event.keycode == KEY_BRACKETLEFT:
            #print("Helmet Cam - On")
            #cam_toggle = true
#
        #if event.pressed and event.keycode == KEY_BRACKETRIGHT:
            #print("Helmet Cam - Off")
            #cam_toggle = false
            
func _ready()->void:
    ModLoaderLog.info("Main script Ready", MYMOD_LOG)
    base_fov = gameData.baseFOV

func _process(_delta: float) -> void:
    if cam_toggle == true:
        
        # If the effect doesn't exist yet, build it!
        if fx_layer == null:
            create_webcam_filter()
        
        #var manager = get_node_or_null("/root/Map/Core/Camera/Manager")
#
        #if manager:
            ## 1. FIXED: Set recursive to 'true' so it finds the rig no matter how deep it is
            #var rigs = manager.find_children("*Rig*", "Node3D", true, false)
            #
            #if rigs.size() > 0:
                #var weapon_rig = rigs[0]
                #var meshes = weapon_rig.find_children("*", "MeshInstance3D", true, false)
                #
                #for mesh_node in meshes:
                            ## 1. FIXED: Added 'and mesh_node.mesh' to make sure the node actually has a 3D model loaded
                            #if mesh_node is MeshInstance3D and mesh_node.mesh:
                                #
                                ## 2. FIXED: Pointed to mesh_node.mesh to get the surface count correctly
                                #for i in range(mesh_node.mesh.get_surface_count()):
                                    #var current_mat = mesh_node.get_surface_override_material(i)
                                    #
                                    #if current_mat == null:
                                        #var original_mat = mesh_node.get_active_material(i)
                                        #
                                        #if original_mat and original_mat is BaseMaterial3D:
                                            #var new_mat = original_mat.duplicate()
                                            #new_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
                                            #new_mat.albedo_color.a = 0.3 
                                            #mesh_node.set_surface_override_material(i, new_mat)
                                    #else:
                                        #if current_mat is BaseMaterial3D:
                                            #if current_mat.transparency != BaseMaterial3D.TRANSPARENCY_ALPHA:
                                                #current_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
                                            #
                                            #if current_mat.albedo_color.a != 0.3:
                                                #current_mat.albedo_color.a = 0.3   
        
        # we check once now arfe u happy!!
        var cam = get_node_or_null("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera")
        
        #if has_node("/root/Map/Core/Camera"):
            #get_node("/root/Map/Core/Camera").position = Vector3(-0.25, 1.75, 0.0)
            #get_node("/root/Map/Core/Camera").rotation = Vector3(-3.0, -2.25, 0.1)
        if cam:
        #if has_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera"):
            var target_position = Vector3.ZERO
            var target_rotation = Vector3.ZERO
            if gameData.isAiming:
                target_position = Vector3(-0.17, 0.13, 0.0)
                target_rotation = Vector3(-0.1, 0.0, -0.15) 
            else:
                target_position = Vector3(-0.17, 0.13, 0.0)
                target_rotation = Vector3(-0.1, 0.0, 0.0)
            #if gameData.isAiming:
                ## we could prob use gameData.cameraPosition but fuck you i could do a lot of things i dont
                ## i know calling get node so often is bad btui am too lasy to amek another var so just do it yourself if its sucha  big deal
                #get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").position = Vector3(-0.17, 0.13, 0.0)
                #get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").rotation = Vector3(-0.1, 0.0, -0.15)
            #else:
                #get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").position = Vector3(-0.17, 0.13, 0.0)
                #get_node("/root/Map/Core/Controller/Pelvis/Riser/Head/Bob/Impulse/Damage/Noise/Camera").rotation = Vector3(-0.1, 0.0, 0.0)
            cam.position = lerp(cam.position, target_position, _delta * smooth_speed)
            cam.rotation = lerp(cam.rotation, target_rotation, _delta * smooth_speed)
                
        if has_node("/root/Map/Core/Camera/Manager"):
            get_node("/root/Map/Core/Camera/Manager").position = Vector3(0.06, -0.04, 0.05)
            get_node("/root/Map/Core/Camera/Manager").rotation = Vector3(0.0, -3.14, -0.314)
        if gameData.isAiming:
            gameData.baseFOV = base_fov * 0.9
        else:
            gameData.baseFOV = base_fov * 1.25
        
    else:
        # If mod is toggled off, safely destroy the effect
        if fx_layer != null:
            fx_layer.queue_free()
            fx_layer = null
                
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




func create_webcam_filter() -> void:
    # 1. Create a CanvasLayer so it draws directly on top of the screen UI/Game
    fx_layer = CanvasLayer.new()
    fx_layer.layer = 100 # Put it on a high layer so it sits on top
    get_tree().root.add_child(fx_layer)
    
    # 2. Create a ColorRect that fills the entire screen
    var rect = ColorRect.new()
    rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT) # Make it full screen
    rect.mouse_filter = Control.MOUSE_FILTER_IGNORE # Make sure it doesn't block mouse clicks!
    fx_layer.add_child(rect)
    
    # 3. Create the Shader Material
    var mat = ShaderMaterial.new()
    var shader = Shader.new()
    
    # Paste the shader code below into the shader object
    shader.code = """
    shader_type canvas_item;
    render_mode unshaded;

    uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
    
    uniform float target_width = 1280.0;   // 480p width
    uniform float target_height = 720.0;  // 480p height
    uniform float grain_amount : hint_range(0.0, 0.2) = 0.04; // Webcam static/noise

    void fragment() {
        // --- 1. RESOLUTION DOWNSCALING ---
        // Force the screen coordinates to snap to a fixed grid (e.g., 1280x720)
        vec2 grid = vec2(target_width, target_height);
        vec2 low_res_uv = floor(SCREEN_UV * grid) / grid;
        
        // Grab the game screen color at that pixelated coordinate
        vec4 col = texture(screen_texture, low_res_uv);
        
        // --- 2. WEBCAM SENSOR NOISE (GRAIN) ---
        // A math trick to generate a pseudo-random number based on pixel position and time
        float noise = fract(sin(dot(low_res_uv * TIME, vec2(12.9898, 78.233))) * 43758.5453);
        
        // Apply the grain to the final color (subtract 0.5 so it balances dark/light grains)
        col.rgb += (noise - 0.5) * grain_amount;
        
        COLOR = col;
    }
    """
    
    mat.shader = shader
    rect.material = mat




















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
