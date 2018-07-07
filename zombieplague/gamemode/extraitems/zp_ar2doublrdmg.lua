 http://ExtraItem.Name = "AR2 (Damage x2)"
ExtraItem.Price = 1
function ExtraItem:OnBuy(ply)
	ply.HasDoubleDamageAr2 = true
	
	hook.Add("PlayerSwitchWeapon", "DoubleAr2" .. ply:SteamID(), function(ply, oldWeapon, newWeapon)
		if (ply.HasDoubleDamageAr2) then
			if (newWeapon:GetClass() == "weapon_ar2") then
				ply:SetDamageAmplifier(ply:GetDamageAmplifier() * 2)
				ply.IsUsingDoubleDamageAr2 = true
			elseif (oldWeapon:GetClass() == "weapon_ar2") then
				ply:SetDamageAmplifier(ply:GetDamageAmplifier() / 2)
				ply.IsUsingDoubleDamageAr2 = false
			end
		end
	end)
	hook.Add("PlayerDeath", "PlayerDeathDoubleAr2" .. ply:SteamID(), function(victim, inflictor, attacker)
		if (victim == ply) then
			if (ply.IsUsingDoubleDamageAr2) then
				ply:SetDamageAmplifier(ply:GetDamageAmplifier() / 2)
			end
			ply.HasDoubleDamageAr2 = false
			hook.Remove("PlayerSwitchWeapon", "DoubleAr2" .. ply:SteamID())
			hook.Remove("PlayerDeath", "PlayerDeathDoubleAr2" .. ply:SteamID())
			hook.Remove("ZPInfectionEvent", "ZPInfectionEventDoubleAr2" .. ply:SteamID())
		end
	end)
	hook.Add("ZPInfectionEvent", "ZPInfectionEventDoubleAr2" .. ply:SteamID(), function(Infected, Attacker)
		if (Infected == ply) then
			if (ply.IsUsingDoubleDamageAr2) then
				ply:SetDamageAmplifier(ply:GetDamageAmplifier() / 2)
			end
			ply.HasDoubleDamageAr2 = false
			hook.Remove("PlayerSwitchWeapon", "DoubleAr2" .. ply:SteamID())
			hook.Remove("PlayerDeath", "PlayerDeathDoubleAr2" .. ply:SteamID())
			hook.Remove("ZPInfectionEvent", "ZPInfectionEventDoubleAr2" .. ply:SteamID())
		end
	end)
	
	local Weap = ply:Give("weapon_ar2")
	
	if IsValid(Weap) then
		ply:GiveAmmo(300, Weap:GetPrimaryAmmoType(), true) 
	end
end
function ExtraItem:CanBuy(ply)
	return ply:Alive() && !ply.HasDoubleDamageAr2
end
