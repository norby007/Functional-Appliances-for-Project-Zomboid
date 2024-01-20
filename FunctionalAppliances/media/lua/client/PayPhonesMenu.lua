FAPayPhones = FAPayPhones or {}

FAPayPhones.doBuildMenu = function(player, menu, square, PayPhones)
	local soundFile = "payphone_busy_sound"

	if PayPhones:getModData()['Ring'] == true and SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier then
		local randomNumb = ZombRand(1,100)

		if randomNumb < 40 then
			square:playSound("payphone_ringing_1x_sound")
		elseif randomNumb < 80 then
			square:playSound("payphone_ringing_2x_sound")
		elseif randomNumb < 90 then
			square:playSound("payphone_ringing_3x_sound")
		elseif randomNumb < 97 then
			square:playSound("payphone_ringing_4x_sound")
		else
			square:playSound("payphone_ringing_5x_sound")
		end

		PayPhones:getModData()['Ring'] = false

		local FAPayPhonesAttractZombies = SandboxVars.FunctionalAppliances.FAPayPhonesAttractZombies 

		if FAPayPhonesAttractZombies then
  			addSound(PayPhones, PayPhones:getX(), PayPhones:getY(), PayPhones:getZ(), 10, 10) 
 		end
	elseif PayPhones:getModData()['Ring'] == false then
		menu:addOption(FA.translation.checkphone,
				  nil,	
				  FAPayPhones.onUsePayPhones,
				  getSpecificPlayer(player),
				  PayPhones, soundFile)
	end

	PayPhones:transmitModData()
end

FAPayPhones.onUsePayPhones = function(junk, player, PayPhones, soundFile)
	if not FA.walkToFront(player, PayPhones) then
		return
	end

	local square = PayPhones:getSquare()

	if SandboxVars.ElecShutModifier > -1 and GameTime:getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier then
		square:playSound(soundFile)
		local FAPayPhonesAttractZombies = SandboxVars.FunctionalAppliances.FAPayPhonesAttractZombies

		if FAPayPhonesAttractZombies then
			addSound(PayPhones, PayPhones:getX(), PayPhones:getY(), PayPhones:getZ(), 5, 5) 
		end
	else
		player:Say(FA.translation.saythelineisdead)
	end
	PayPhones:transmitModData()
end