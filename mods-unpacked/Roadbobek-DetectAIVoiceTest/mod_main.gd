# res://mods-unpacked/Roadbobek-DetectAIVoiceTest/mod_main.gd
extends Node

const MOD_DIR = "Roadbobek-DetectAIVoiceTest/"
const MYMOD_LOG = "Roadbobek-DetectAIVoiceTest"
const AI_EXT_PATH = "res://mods-unpacked/" + MOD_DIR + "extensions/AI.gd"

func _init() -> void:
    # This is the magic line that hooks your script into the game
    ModLoaderMod.install_script_extension(AI_EXT_PATH)

#func _ready():
    ## Wait 30 seconds so we are in the level and AI has spawned
    #await get_tree().create_timer(30.0).timeout
    #
    #ModLoaderLog.info("--- GLOBAL AI SEARCH ---", MYMOD_LOG)
    #var all_nodes = get_tree().get_nodes_in_group("AI") # If they are in a group
    ## If not in a group, we search the whole tree:
    #find_ai_nodes(get_tree().root)
#
#func find_ai_nodes(node):
    #if node.get_script() and node.get_script().resource_path.contains("AI.gd"):
        #print("FOUND AI NODE: ", node.get_path(), " | Script: ", node.get_script().resource_path)
    #
    #for child in node.get_children():
        #find_ai_nodes(child)

#func _ready() -> void:
    #ModLoaderLog.info("AI Extension successfully registered!", MYMOD_LOG)
