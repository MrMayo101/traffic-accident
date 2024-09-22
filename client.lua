Config = require 'config'

local isAccident = false -- Whether a car accident occurred
local oldBodyDamage = 0 -- veh health value last recorded data
local oldSpeed = 0 -- veh speed last recorded data

-- Blackout Function
local function blackOut()
	if not isAccident then
		isAccident = true
		DoScreenFadeOut(100) -- Fade out
		-- Wait during the transition time
		while not IsScreenFadedOut() do
		
		Wait(0)

		end

		Wait(Config.BlackoutTime) -- Configured black screen time
		DoScreenFadeIn(500) -- Fade in
		isAccident = false
	end
end

-- Camera Shake Function
local function shakeCam()
	if not isAccident then
		isAccident = true
			ShakeGameplayCam(Config.ShakeGameplayCam, 1.0) -- 抖动
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
			isAccident = false
	end
end

-- Blurred Vision Function
local function BlurredVision()
	if not isAccident then
		isAccident = true
		-- 此线程将在指定时间内使得玩家窗口视觉模糊
		Citizen.CreateThread(function()
			SetTimecycleModifier(Config.SetTimecycleModifier) -- 模糊效果
			Citizen.Wait(Config.BlurredVisionTime) -- 配置的黑屏时间
			ClearTimecycleModifier() -- 清除模糊效果
			isAccident = false
		end)
	end
end

-- Camera Shake and Blurred Vision Function
local function shakeCamAndBlurredVision()
	if not isAccident then
		isAccident = true
		-- 此线程将在指定时间内使得玩家窗口视觉模糊
			ShakeGameplayCam(Config.ShakeGameplayCam, 1.0) -- 抖动
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
			SetTimecycleModifier(Config.SetTimecycleModifier) -- 模糊效果
			Wait(Config.BlurredVisionTime) -- 配置的黑屏时间
			ClearTimecycleModifier() -- 清除模糊效果
			isAccident = false
	end
end


lib.onCache('vehicle', function()
	local vehicle = cache.vehicle
	if cache.vehicle ~= 0 or nil or false then
		if DoesEntityExist(cache.vehicle) then
			local currentDamage = GetVehicleBodyHealth(cache.vehicle)

			if Config.SlightFromDamage then
				if currentDamage ~= oldBodyDamage then
					if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.SlightDamageRequired) and ((oldBodyDamage - currentDamage) < Config.NormalDamageRequired) then
						shakeCam() -- Call camera shake function
					end
				end
			end
		-- Check if it is enabled
		if Config.NormalFromDamage then
			-- If the damage occurs, check if it exceeds the threshold
			if currentDamage ~= oldBodyDamage then
				if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.NormalDamageRequired) and ((oldBodyDamage - currentDamage) < Config.SevereDamageRequired)  then
					shakeCamAndBlurredVision() -- Call camera shake and blurred vision function
				end
			end
		end

		-- Check if it is enabled
		if Config.NormalFromDamage then
			-- If the damage occurs, check if it exceeds the threshold
			if currentDamage ~= oldBodyDamage then
				if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.NormalDamageRequired) and ((oldBodyDamage - currentDamage) < Config.SevereDamageRequired)  then
					shakeCamAndBlurredVision() -- Call camera shake and blurred vision function
				end
			end
		end

		-- Check if it is enabled
		if Config.SevereFromDamage then
			-- If the damage occurs, check if it exceeds the threshold
			if currentDamage ~= oldBodyDamage then
				if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.SevereDamageRequired) then
					blackOut() -- Call black out function
				end
			end
		end

		oldBodyDamage = currentDamage -- Record damage

		-- Whether to enable speed detection
		if Config.BlackoutFromSpeed then
			local currentSpeed = GetEntitySpeed(vehicle) * 2.236936 -- Get the current speed of the vehicle. Speed ​​unit: MPH
			--local currentSpeed ​​= GetVehicleDashboardSpeed(vehicle) * 2.236936 -- Get the current speed of the vehicle. Speed ​​unit: MPH
			-- Convert to MPH: speed * 2.236936
			-- Convert to KPH: speed * 3.6
			-- Speed ​​detection
			if currentSpeed ~= oldSpeed then
				-- When the speed changes, and it is deceleration and greater than the detection value
				if not isAccident and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= Config.BlackoutSpeedRequired) then
					blackOut() -- Call black out function
				end
				oldSpeed = currentSpeed -- Record speed
			end
		end
	else
		oldBodyDamage = 0
		oldSpeed = 0
	end
	
	-- Disable player controls
	if isAccident and Config.DisableControlsOnBlackout then
		-- https://github.com/Sighmir/FiveM-Scripts/blob/master/vrp/vrp_hotkeys/client.lua
		DisableControlAction(0,71,true)
		DisableControlAction(0,72,true)
		DisableControlAction(0,63,true)
		DisableControlAction(0,64,true)
		DisableControlAction(0,75,true)
	end

	end
end)


-- -- Main Thread Function
-- CreateThread(function()
-- 	while true do
-- 		Wait(0)
-- 		-- Get the vehicle the player is in, if it exists continue
-- 		local vehicle = cache.vehicle
-- 		-- Check if the entity exists
-- 		if DoesEntityExist(vehicle) then
-- 			local currentDamage = GetVehicleBodyHealth(vehicle)
-- 			-- Maximum 1000, minimum 0 (actual may occur a negative number)
-- 			-- A car that is in 0 will not necessarily explode or cannot drive.

-- 			-- Check if it is enabled
-- 			if Config.SlightFromDamage then
-- 				-- If the damage occurs, check if it exceeds the threshold
-- 				if currentDamage ~= oldBodyDamage then
-- 					if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.SlightDamageRequired) and ((oldBodyDamage - currentDamage) < Config.NormalDamageRequired) then
-- 						shakeCam() -- Call camera shake function
-- 					end
-- 				end
-- 			end

-- 			-- Check if it is enabled
-- 			if Config.NormalFromDamage then
-- 				-- If the damage occurs, check if it exceeds the threshold
-- 				if currentDamage ~= oldBodyDamage then
-- 					if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.NormalDamageRequired) and ((oldBodyDamage - currentDamage) < Config.SevereDamageRequired)  then
-- 						shakeCamAndBlurredVision() -- Call camera shake and blurred vision function
-- 					end
-- 				end
-- 			end

-- 			-- Check if it is enabled
-- 			if Config.SevereFromDamage then
-- 				-- If the damage occurs, check if it exceeds the threshold
-- 				if currentDamage ~= oldBodyDamage then
-- 					if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.SevereDamageRequired) then
-- 						blackOut() -- Call black out function
-- 					end
-- 				end
-- 			end

-- 			oldBodyDamage = currentDamage -- Record damage

-- 			-- Whether to enable speed detection
-- 			if Config.BlackoutFromSpeed then
-- 				local currentSpeed = GetEntitySpeed(vehicle) * 2.236936 -- Get the current speed of the vehicle. Speed ​​unit: MPH
-- 				--local currentSpeed ​​= GetVehicleDashboardSpeed(vehicle) * 2.236936 -- Get the current speed of the vehicle. Speed ​​unit: MPH
-- 				-- Convert to MPH: speed * 2.236936
-- 				-- Convert to KPH: speed * 3.6
-- 				-- Speed ​​detection
-- 				if currentSpeed ~= oldSpeed then
-- 					-- When the speed changes, and it is deceleration and greater than the detection value
-- 					if not isAccident and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= Config.BlackoutSpeedRequired) then
-- 						blackOut() -- Call black out function
-- 					end
-- 					oldSpeed = currentSpeed -- Record speed
-- 				end
-- 			end
-- 		else
-- 			oldBodyDamage = 0
-- 			oldSpeed = 0
-- 		end
		
-- 		-- Disable player controls
-- 		if isAccident and Config.DisableControlsOnBlackout then
-- 			-- https://github.com/Sighmir/FiveM-Scripts/blob/master/vrp/vrp_hotkeys/client.lua
-- 			DisableControlAction(0,71,true)
-- 			DisableControlAction(0,72,true)
-- 			DisableControlAction(0,63,true)
-- 			DisableControlAction(0,64,true)
-- 			DisableControlAction(0,75,true)
-- 		end
-- 	end
-- end)
