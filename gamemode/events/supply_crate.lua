
local EVENT = {}

EVENT.Chance = 0.95
EVENT.Type = EVENT_BONUS

function EVENT:Start()
	
	local spawns = ents.FindByClass( "info_lootspawn" )
	local loot = table.Random( spawns )
	
	if not IsValid( loot ) then MsgN( "ERROR: Unable to locate loot spawns. Map not configured?" ) return end
	
	local ent = ents.Create( "sent_bonuscrate" )
	ent:SetPos( loot:GetPos() + Vector(0,0,10) )
	ent:Spawn()
	
	for k,v in pairs( team.GetPlayers( TEAM_ARMY ) ) do
		
		v:Notice( translate.ClientGet( v, "rd_notices_keep_an_eye_for_bonus_crate" ), GAMEMODE.Colors.White, 5 )
		
	end
	
end
	
function EVENT:Think()

end

function EVENT:EndThink()

	return true // true ends this immediately

end

function EVENT:End()

end

event.Register( EVENT )
