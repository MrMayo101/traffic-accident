local isAccident = false -- 是否发生车祸
local oldBodyDamage = 0 -- veh生命值 上次记录数据
local oldSpeed = 0 -- veh速度 上次记录数据

-- 封装 黑屏函数
local function blackOut()
	if not isAccident then
		isAccident = true
		-- 此线程将在指定时间内使得玩家屏幕黑屏
		Citizen.CreateThread(function()
			DoScreenFadeOut(100) -- 淡入
			-- 在过渡时间内等待
			while not IsScreenFadedOut() do
				Citizen.Wait(0)
			end
			Citizen.Wait(Config.BlackoutTime) -- 配置的黑屏时间
			DoScreenFadeIn(500) -- 淡出
			isAccident = false
		end)
	end
end

-- 封装 窗口抖动函数
local function shakeCam()
	if not isAccident then
		isAccident = true
		-- 此线程将在指定时间内使得玩家窗口抖动
		Citizen.CreateThread(function()
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
		end)
	end
end

-- 封装 视觉模糊函数
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

-- 封装 窗口抖动 and 视觉模糊 函数
local function shakeCamAndBlurredVision()
	if not isAccident then
		isAccident = true
		-- 此线程将在指定时间内使得玩家窗口视觉模糊
		Citizen.CreateThread(function()
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
			Citizen.Wait(Config.BlurredVisionTime) -- 配置的黑屏时间
			ClearTimecycleModifier() -- 清除模糊效果
			isAccident = false
		end)
	end
end

-- 主线程 函数
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- 获取玩家所乘坐的车辆，如果存在则继续
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		-- 检查实体是否存在
		if DoesEntityExist(vehicle) then
			local currentDamage = GetVehicleBodyHealth(vehicle)
			-- 最大 1000，最小 0 (实际可能会出现负数)
			-- 车辆在 0 时不一定会爆炸或无法驾驶。

			-- 检查是否启用
			if Config.SlightFromDamage then
				-- 如果损坏情况发生变化，查看是否超出阈值
				if currentDamage ~= oldBodyDamage then
					if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.SlightDamageRequired) and ((oldBodyDamage - currentDamage) < Config.NormalDamageRequired) then
						shakeCam() -- 调用窗口抖动函数
					end
				end
			end

			-- 检查是否启用
			if Config.NormalFromDamage then
				-- 如果损坏情况发生变化，查看是否超出阈值
				if currentDamage ~= oldBodyDamage then
					if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.NormalDamageRequired) and ((oldBodyDamage - currentDamage) < Config.SevereDamageRequired)  then
						shakeCamAndBlurredVision() -- 调用窗口抖动 and 视觉模糊
					end
				end
			end

			-- 检查是否启用
			if Config.SevereFromDamage then
				-- 如果损坏情况发生变化，查看是否超出阈值
				if currentDamage ~= oldBodyDamage then
					if not isAccident and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.SevereDamageRequired) then
						blackOut() -- 调用黑屏函数
					end
				end
			end

			oldBodyDamage = currentDamage -- 记录损伤

			-- 是否启用速度检测
			if Config.BlackoutFromSpeed then
				local currentSpeed = GetEntitySpeed(vehicle) * 2.236936 -- 获取 车辆当前速度 速度单位：MPH
				--local currentSpeed = GetVehicleDashboardSpeed(vehicle) * 2.236936 -- 获取 车辆当前速度 速度单位：MPH
				-- 转换为 MPH: speed * 2.236936
				-- 转换为 KPH: speed * 3.6
				-- 速度检测
				if currentSpeed ~= oldSpeed then
					-- 当速度发生变化时，且属于减速并大于检测值时
					if not isAccident and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= Config.BlackoutSpeedRequired) then
						blackOut() -- 调用黑屏函数
					end
					oldSpeed = currentSpeed -- 记录速度
				end
			end
		else
			oldBodyDamage = 0
			oldSpeed = 0
		end
		
		-- 禁用玩家的控制
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
