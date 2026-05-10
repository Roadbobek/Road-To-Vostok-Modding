# res://mods-unpacked/Roadbobek-DetectAIVoiceTest/extensions/AI.gd

# Script to extend
extends "res://Scripts/AI.gd"


const MYMOD_LOG = "Roadbobek-DetectAIVoiceTest"



#func _ready() -> void:
    ## 1. Basic Info
    #var node_name = self.name
    #var node_path = self.get_path()
    #var script_path = self.get_script().get_path()
    #
    #ModLoaderLog.info("--- AI Extension Diagnostic ---", MYMOD_LOG)
    #ModLoaderLog.info("Node Name: " + str(node_name), MYMOD_LOG)
    #ModLoaderLog.info("Full Path: " + str(node_path), MYMOD_LOG)
    #ModLoaderLog.info("Attached Script: " + str(script_path), MYMOD_LOG)
#
    ## 2. Check for "Shadowing" (Inheritance check)
    ## This checks if the node thinks its class is AI or something more specific
    #ModLoaderLog.info("Class Name: " + self.get_class(), MYMOD_LOG)
#
    ## 3. Check for the 'currentState' variable specifically
    #if "currentState" in self:
        #ModLoaderLog.info("Current State: " + str(self.currentState), MYMOD_LOG)
    #else:
        #ModLoaderLog.warning("WARNING: 'currentState' variable not found on this node!", MYMOD_LOG)
    #
    ## 4. Check if PlayIdle even exists on this specific instance
    #if self.has_method("PlayIdle"):
        #ModLoaderLog.info("Method 'PlayIdle' IS present on this node.", MYMOD_LOG)
    #
    #ModLoaderLog.info("-------------------------------", MYMOD_LOG)
    #
    ## Don't forget to call the original ready!
    #super._ready()


func _ready()->void:
    ModLoaderLog.info("AI Extension Script Ready", MYMOD_LOG)
    super._ready()



#func PlayIdle() -> void:
    #print("DEBUG: PlayIdle Called ! ! ! ! ! ! ! ! ! !")
    #super.PlayIdle()
#
#func PlayCombat() -> void:
    #print("DEBUG: PlayCombat Called ! ! ! ! ! ! ! ! ! !")
    #super.PlayCombat()
    #
#func PlayDamage() -> void:
    #print("DEBUG: PlayDamage Called ! ! ! ! ! ! ! ! ! !")
    #super.PlayDamage()
    #
#func PlayDeath() -> void:
    #print("DEBUG: PlayDeath Called ! ! ! ! ! ! ! ! ! !")
    #super.PlayCombat()
#
#
#func Voices(delta) -> void:
    #print("DEBUG: Voices Alive ! ! ! ! ! ! ! ! ! !")
    #super.Voices(delta)


# PlayIdle() Override
func PlayIdle() -> void:
    # Run the original game code first!
    # This ensures activeVoice is set and the sound plays ect
    super.PlayIdle()    
    # After the original logic run our custom mod logic!
    _on_mod_idle_detected()

# Our custom logic
func _on_mod_idle_detected() -> void:
    # 'self' refers to the specific NPC instance that just spoke
    print("Mod detected PlayIdle on NPC: ", self.name)
    
    # You can access variables from the original AI.gd directly
    if is_instance_valid(activeVoice):
        # Maybe you want to make modded voices louder?
        pass
        # activeVoice.unit_size = 200.0



# PlayCombat() Override
func PlayCombat() -> void:
    # Run the original game code first!
    # This ensures activeVoice is set and the sound plays ect
    super.PlayCombat()
    
    # After the original logic run our custom mod logic!
    _on_mod_combat_detected()

# Our custom logic
func _on_mod_combat_detected() -> void:
    # 'self' refers to the specific NPC instance that just spoke
    print("Mod detected PlayCombat on NPC: ", self.name)
    
    # You can access variables from the original AI.gd directly
    if is_instance_valid(activeVoice):
        # Maybe you want to make modded voices louder?
        pass
        # activeVoice.unit_size = 200.0



# PlayDamage() Override
func PlayDamage() -> void:
    # Run the original game code first!
    # This ensures activeVoice is set and the sound plays ect
    super.PlayDamage()
    
    # After the original logic run our custom mod logic!
    _on_mod_damage_detected()

# Our custom logic
func _on_mod_damage_detected() -> void:
    # 'self' refers to the specific NPC instance that just spoke
    print("Mod detected PlayDamage on NPC: ", self.name)
    
    # You can access variables from the original AI.gd directly
    if is_instance_valid(activeVoice):
        # Maybe you want to make modded voices louder?
        pass
        # activeVoice.unit_size = 200.0



# PlayDeath() Override
func PlayDeath() -> void:
    # Run the original game code first!
    # This ensures activeVoice is set and the sound plays ect
    super.PlayDeath()
    
    # After the original logic run our custom mod logic!
    _on_mod_death_detected()

# Our custom logic
func _on_mod_death_detected() -> void:
    # 'self' refers to the specific NPC instance that just spoke
    print("Mod detected PlayDeath on NPC: ", self.name)
    
    # You can access variables from the original AI.gd directly
    if is_instance_valid(activeVoice):
        # Maybe you want to make modded voices louder?
        pass
        # activeVoice.unit_size = 200.0
