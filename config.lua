Config = {}

-- Black screen duration (time unit: milliseconds)
-- 2000 = 2 秒 / 3500 = 3.5 秒
Config.BlackoutTime = 5000

-- Blurred vision duration (time unit: milliseconds)
Config.BlurredVisionTime = 2000

-- Camera Shake duration (integer must be positive) This function is not available yet
Config.ShakeCamNumber = 1

-- Enable vehicle collision damage detection (minor)
Config.SlightFromDamage = true
Config.SlightDamageRequired = 0.25

-- Enable vehicle collision damage detection (normal)
Config.NormalFromDamage = true
Config.NormalDamageRequired = 10

-- Enable vehicle collision damage detection (normal)
Config.SevereFromDamage = true
Config.SevereDamageRequired = 30

-- Enable vehicle deceleration detection
-- If the vehicle exceeds this threshold, the player will be stunned
Config.BlackoutFromSpeed = true
Config.BlackoutSpeedRequired = 45 -- Speed ​​Unit: MPH

-- Enables disabling of controls if the player is unconscious
Config.DisableControlsOnBlackout = true


Config.ShakeGameplayCam = 'SMALL_EXPLOSION_SHAKE'
-- 抖动类型 (更新版本 b617d):
-- DEATH_FAIL_IN_EFFECT_SHAKE  
-- DRUNK_SHAKE  
-- FAMILY5_DRUG_TRIP_SHAKE  
-- HAND_SHAKE  
-- JOLT_SHAKE  
-- LARGE_EXPLOSION_SHAKE  
-- MEDIUM_EXPLOSION_SHAKE  
-- SMALL_EXPLOSION_SHAKE  (目前使用)
-- ROAD_VIBRATION_SHAKE  
-- SKY_DIVING_SHAKE  
-- VIBRATE_SHAKE

Config.SetTimecycleModifier = 'MP_corona_switch'
-- TimecycleModifier timecycle_mods_1.xml
-- Blur and distortion effects:
-- MP_corona_switch: A blur or transition effect, often used to trigger scenes like coma or dizziness. (Current)
-- CAMERA_BW: Black and white effect.
-- REDMIST: Reddish screen, suitable for scenes where the player is injured or angry.
-- NG_filmnoir_BW01: A classic black and white filter, similar to the effect of old movies.

-- Visual distortion effects:
-- NG_filmic01: Film-style filter, usually with warm tones.
-- NG_filmic02: A slightly darker filter with cold tones.
-- NG_filmic03: Has more hue shifts and distortion effects, suitable for some special cutscenes or dream scenes.

-- Psychedelic or drunken effects:
-- spectator5: Psychedelic effect with strong color changes.
-- drug_wobbly: Screen distortion and color distortion, often used to simulate the visual effects of being drunk or taking drugs.
-- drug_flying_base: Psychedelic-like color distortion, giving a floating feeling.

-- Brightness and contrast adjustment:
-- hud_def_blur: A slight blur effect, used when the HUD interface is displayed.
-- default: Reset to the default state, that is, cancel all filter effects.
-- rply_saturation: Increase saturation, colors look more vivid.
-- rply_contrast: Increase contrast, suitable for sunny or high-light scenes.

-- Combat and thriller scene effects:
-- rply_vignette: Adds dark edges to the screen, suitable for combat or thriller scenes.
-- bullet_time: Similar to the slow-motion shooting scene effect in movies, the screen has a slight blur and time distortion.
-- WATER_splash: Underwater blur effect, usually used when the player jumps into the water.