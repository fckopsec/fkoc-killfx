function ApplyKillEffect()
    SetTimecycleModifier(Config.KillTimecycleEffect)
    SetTimecycleModifierStrength(1.0)
    Citizen.Wait(Config.KillEffectDuration)
    ClearTimecycleModifier()
end

function IsNpcDead(ped)
    return GetEntityHealth(ped) <= 0
end

AddEventHandler('gameEventTriggered', function(name, args)
    if name == "CEventNetworkEntityDamage" then
        local victimId = args[1]
        local killerId = args[2]

        if victimId == PlayerPedId() then
            ApplyKillEffect()
	elseif IsPedAPlayer(victimId) == false and IsNpcDead(victimId) then
            if killerId == PlayerPedId() then
                ApplyKillEffect()
            end
        elseif IsPedAPlayer(victimId) == false then
            if IsNpcDead(victimId) then
                ApplyKillEffect()
            end
        end
    end
end)