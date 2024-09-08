Config = {}

-- 黑屏持续时间（时间单位：毫秒）
-- 2000 = 2 秒 / 3500 = 3.5 秒
Config.BlackoutTime = 5000

-- 视觉模糊持续视觉（时间单位：毫秒）
Config.BlurredVisionTime = 2000

-- 窗口抖动持续次数（整数 必须为正数）暂时未开放该功能
Config.ShakeCamNumber = 1

-- 启用车辆碰撞伤害检测（轻微）
Config.SlightFromDamage = true
Config.SlightDamageRequired = 0.25

-- 启用车辆碰撞伤害检测（普通）
Config.NormalFromDamage = true
Config.NormalDamageRequired = 10

-- 启用车辆碰撞伤害检测（严重）
Config.SevereFromDamage = true
Config.SevereDamageRequired = 30

-- 启用车辆减速检测
-- 如果车辆超过此阈值，玩家将昏迷
Config.BlackoutFromSpeed = true
Config.BlackoutSpeedRequired = 45 -- 速度单位：MPH

-- 如果玩家昏迷，则启用禁用控件的功能
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
-- 模糊和扭曲效果：
-- MP_corona_switch：一种模糊或过渡效果，通常用于触发类似昏迷或眩晕的场景。(当前)
-- CAMERA_BW：黑白效果。
-- REDMIST：屏幕泛红，适合用在玩家受伤或激怒的场景。
-- NG_filmnoir_BW01：一种经典的黑白滤镜，类似旧电影效果。

-- 视觉扭曲效果：
-- NG_filmic01：电影风格的滤镜，通常带有温暖色调。
-- NG_filmic02：稍微暗淡、带有冷色调的滤镜。
-- NG_filmic03：有更多的色调偏移和扭曲效果，适合某些特殊过场或梦境场景。

-- 迷幻或醉酒效果：
-- spectator5：带有强烈颜色变化的迷幻效果。
-- drug_wobbly：屏幕扭曲、颜色失真，通常用于模拟醉酒或吸毒后的视觉效果。
-- drug_flying_base：类似迷幻的颜色扭曲，给人一种漂浮感。

-- 亮度和对比度调整：
-- hud_def_blur：轻微的模糊效果，用于 HUD 界面显示时。
-- default：重置为默认状态，即取消所有滤镜效果。
-- rply_saturation：提高饱和度，颜色看起来更鲜艳。
-- rply_contrast：提高对比度，适合用在阳光明媚或高亮场景。

-- 战斗和惊悚场景效果：
-- rply_vignette：为屏幕添加黑暗的边缘，适合战斗或惊悚场景。
-- bullet_time：类似电影中的慢动作射击场景效果，屏幕有轻微模糊和时间扭曲。
-- WATER_splash：水下模糊效果，通常在玩家跳入水中时使用。
