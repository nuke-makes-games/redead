
include( 'translate.lua' )
include( 'player_class/player_base.lua' )
include( 'player_class/player_zombie.lua' )
include( 'map_defaults.lua' )
include( 'resource.lua' )
include( 'enums.lua' )
include( 'items.lua' )
include( 'events.lua' )
include( 'shared.lua' )
include( 'moddable.lua' )
include( 'ply_extension.lua' )
include( 'tables.lua' )
include( 'weather.lua' )

AddCSLuaFile( 'translate.lua' )
AddCSLuaFile( 'player_class/player_base.lua' )
AddCSLuaFile( 'player_class/player_zombie.lua' )
AddCSLuaFile( 'animations.lua' )
AddCSLuaFile( 'enums.lua' )
AddCSLuaFile( 'items.lua' )
AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'moddable.lua' )
AddCSLuaFile( 'cl_notice.lua' )
AddCSLuaFile( 'cl_hudstains.lua' )
AddCSLuaFile( 'cl_targetid.lua' )
AddCSLuaFile( 'cl_spawnmenu.lua' )
AddCSLuaFile( 'cl_inventory.lua' )
AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'cl_postprocess.lua' )
AddCSLuaFile( 'cl_scoreboard.lua' )
AddCSLuaFile( 'tables.lua' )
AddCSLuaFile( 'weather.lua' )
AddCSLuaFile( 'vgui/vgui_panelbase.lua' )
AddCSLuaFile( 'vgui/vgui_dialogue.lua' )
AddCSLuaFile( 'vgui/vgui_shopmenu.lua' )
AddCSLuaFile( 'vgui/vgui_classpicker.lua' )
AddCSLuaFile( 'vgui/vgui_zombieclasses.lua' )
AddCSLuaFile( 'vgui/vgui_itempanel.lua' )
AddCSLuaFile( 'vgui/vgui_helpmenu.lua' )
AddCSLuaFile( 'vgui/vgui_endgame.lua' )
AddCSLuaFile( 'vgui/vgui_itemdisplay.lua' )
AddCSLuaFile( 'vgui/vgui_playerdisplay.lua' )
AddCSLuaFile( 'vgui/vgui_playerpanel.lua' )
AddCSLuaFile( 'vgui/vgui_panelsheet.lua' )
AddCSLuaFile( 'vgui/vgui_goodmodelpanel.lua' )
AddCSLuaFile( 'vgui/vgui_categorybutton.lua' )
AddCSLuaFile( 'vgui/vgui_sidebutton.lua' )
AddCSLuaFile( 'vgui/vgui_scroller.lua' )

util.AddNetworkString( "InventorySynch" )
util.AddNetworkString( "StashSynch" )
util.AddNetworkString( "StatsSynch" )
util.AddNetworkString( "ItemPlacerSynch" )
util.AddNetworkString( "WeatherSynch" )

function GM:Initialize()
	
	GAMEMODE.NextZombieThink = CurTime() + GetConVar( "sv_redead_setup_time" ):GetInt()
	GAMEMODE.RandomLoot = {}
	GAMEMODE.PlayerIDs = {}
	GAMEMODE.Lords = {}
	GAMEMODE.Wave = 1
	GAMEMODE.NextWave = CurTime() + 60 * GetConVar( "sv_redead_wave_length" ):GetInt()
	
	local length = #GAMEMODE.Waves * ( GetConVar( "sv_redead_wave_length" ):GetInt() * 60 ) 
	
	for i=1, #GAMEMODE.Waves - 1 do
	
		local remain = length - i * GetConVar( "sv_redead_wave_length" ):GetInt() * 60
		local num = i * GetConVar( "sv_redead_wave_length" ):GetInt()
		
		timer.Simple( remain, function() for k,v in pairs( team.GetPlayers( TEAM_ARMY ) ) do v:Notice( translate.ClientFormat( v, "rd_notices_x_minutes_unit_evacuation", num ), GAMEMODE.Colors.White, 5 )  end end )
	 
	end
	
	timer.Simple( GetConVar( "sv_redead_setup_time" ):GetInt(), function() for k,v in pairs( player.GetAll() ) do v:Notice( translate.ClientGet( v, "rd_notices_undead_onslaught_has_begun" ), GAMEMODE.Colors.White, 5 ) end end )
	
	timer.Simple( GetConVar( "sv_redead_setup_time" ):GetInt() - 5, function() for k,v in pairs( team.GetPlayers( TEAM_ARMY ) ) do v:Notice( translate.ClientGet( v, "rd_notices_f4_if_you_want_to_be_zombie_lord" ), GAMEMODE.Colors.White, 5 ) end end )
	
	timer.Simple( GetConVar( "sv_redead_setup_time" ):GetInt() + 5, function() GAMEMODE:PickLord() GAMEMODE.EarlyPick = true end )
	
	timer.Simple( length - 60, function() 
	
		if GetGlobalBool( "GameOver", false ) then return end
		
		GAMEMODE.EvacAlert = true 
			
		for k,v in pairs( player.GetAll() ) do 
			
			v:ClientSound( GAMEMODE.LastMinute ) 
			v:Notice( translate.ClientGet( v, "rd_notices_the_evacuation_helicopter_is_en_route" ), GAMEMODE.Colors.White, 5 ) 
			
		end
		
	end )
	
	timer.Simple( length - 40, function() 
	
		if GetGlobalBool( "GameOver", false ) then return end
	
		for k,v in pairs( team.GetPlayers( TEAM_ARMY ) ) do 
		
			v:Notice( translate.ClientGet( v, "rd_notices_the_evacuation_helicopter_has_arrived" ), GAMEMODE.Colors.White, 5 ) 
			v:Notice( translate.ClientGet( v, "rd_notices_you_have_45_seconds_to_reach_evacuation_zone" ), GAMEMODE.Colors.White, 5, 2 )
			v:Notice( translate.ClientGet( v, "rd_notices_the_location_of_evacuation_zone_has_been_marked" ), GAMEMODE.Colors.White, 5, 4 )
			
		end 
		
		if IsValid( GAMEMODE.Antidote ) then
									
			GAMEMODE.Antidote:SetOverride()
									
		end
		
		GAMEMODE:SpawnEvac() 
		
	end )
	
	timer.Simple( length + 5, function() GAMEMODE:CheckGameOver( true ) end )
	
	GAMEMODE:WeatherInit()
	
	if math.random( 1, 10 ) == 1 then
	
		GAMEMODE.RandomEvent = CurTime() + ( 60 * math.Rand( 1.5, 3.5 ) )
	
	end
	
end

GM.Breakables = {}
GM.WoodLocations = {}
GM.WoodCount = 1
GM.WoodPercent = 1
GM.SpawnCounter = 0
GM.LordExists = false
GM.EarlyPick = false

function GM:InitPostEntity()	

	GAMEMODE.Trader = ents.Create( "info_trader" )
	GAMEMODE.Trader:Spawn()
	
	GAMEMODE.SpecialTrader = ents.Create( "info_trader" )
	GAMEMODE.SpecialTrader:SetSpecial( true )
	GAMEMODE.SpecialTrader:Spawn()

	local badshit = ents.FindByClass( "npc_*" )
	badshit = table.Add( badshit, ents.FindByClass( "weapon_*" ) )
	badshit = table.Add( badshit, ents.FindByClass( "prop_ragdoll" ) )
	badshit = table.Add( badshit, ents.FindByClass( "item_*" ) )
	badshit = table.Add( badshit, ents.FindByClass( "point_servercommand" ) )
	badshit = table.Add( badshit, ents.FindByClass( "env_entity_maker" ) )
	badshit = table.Add( badshit, ents.FindByClass( "point_template" ) )
	badshit = table.Add( badshit, ents.FindByClass( "game_text" ) )
	
	for k,v in pairs( ents.FindByClass( "prop_phys*" ) ) do
	
		if string.find( v:GetModel(), "explosive" ) or string.find( v:GetModel(), "propane" ) or string.find( v:GetModel(), "gascan" ) or string.find( v:GetModel(), "gib" ) then
		
			table.insert( badshit, v )
		
		end
		
		local phys = v:GetPhysicsObject()
		
		if IsValid( phys ) and table.HasValue( { "wood", "wood_crate", "wood_furniture", "wood_plank", "default" }, phys:GetMaterial() ) and phys:GetMass() > 8 then
		
			table.insert( GAMEMODE.WoodLocations, { Pos = v:GetPos(), Ang = v:GetAngles(), Model = v:GetModel(), Health = v:Health() } )
			
			GAMEMODE.WoodCount = GAMEMODE.WoodCount + 1
			
			v.IsWooden = true
			
			if v:Health() == 0 then
			
				v:SetHealth( 100 )
			
			end
			
			if phys:IsAsleep() then
			
				phys:Wake()
			
			end
		
		end
	
	end

	for k,v in pairs( badshit ) do
	
		v:Remove()
	
	end
	
	GAMEMODE.WoodPercent = math.floor( table.Count( ents.FindByClass( "prop_phys*" ) ) * GAMEMODE.WoodPercentage )
	
	for k,v in pairs( ents.FindByClass( "prop_phys*" ) ) do
		
		local tbl = item.GetByModel( v:GetModel() )
		local phys = v:GetPhysicsObject()
		
		if tbl or ( IsValid( phys ) and phys:GetMass() <= 3 ) then
		
			v:Remove()
		
		end
	
	end
	
	GAMEMODE:LoadAllEnts()
	
	local tbl = ents.FindByClass( "prop_door_rotating" )
	tbl = table.Add( tbl, ents.FindByClass( "func_breakable*" ) )
	tbl = table.Add( tbl, ents.FindByClass( "func_door*" ) )
	
	GAMEMODE.Breakables = tbl
	GAMEMODE.NPCSpawns = ents.FindByClass( "info_npcspawn" )
	
	local num = #ents.FindByClass( "point_radiation" )
	
	if num < 5 then return end
	
	for i=1, math.floor( num * GAMEMODE.RadiationAmount ) do
	
		local rad = table.Random( ents.FindByClass( "point_radiation" ) )
		
		while !rad:IsActive() do
		
			rad = table.Random( ents.FindByClass( "point_radiation" ) )
		
		end
		
		rad:SetActive( false )
	
	end
	
end

function GM:SaveAllEnts()

	MsgN( "Saving ReDead map config data..." )

	local enttbl = {
		info_player_zombie = {},
		info_player_army = {},
		info_lootspawn = {},
		info_npcspawn = {},
		info_evac = {},
		point_stash = {},
		point_radiation = {},
		prop_physics = {}
	}
	
	for k,v in pairs( enttbl ) do
	
		for c,d in pairs( ents.FindByClass( k ) ) do
		
			if k == "prop_physics" then
			
				if d.AdminPlaced then
				
					local phys = d:GetPhysicsObject()
					
					if IsValid( phys ) then
				
						table.insert( enttbl[k], { d:GetPos(), d:GetModel(), d:GetAngles(), phys:IsMoveable() } )
						
					end
				
				end
			
			elseif d.AdminPlaced then
		
				table.insert( enttbl[k], d:GetPos() )
				
			end
		
		end
		
	end
	
	file.Write( "redead/" .. string.lower( game.GetMap() ) .. "_json.txt", util.TableToJSON( enttbl ) )

end

function GM:LoadAllEnts()

	MsgN( "Loading ReDead map config data..." )

	local read = file.Read( "redead/" .. string.lower( game.GetMap() ) .. "_json.txt", "DATA" )
	
	if not read then
	
		MsgN( "No map config data found for " .. game.GetMap() .. "." )
		
		return
	
	end
	
	local config = util.JSONToTable( read )
	
	if not config then 
	
		MsgN( "ERROR: ReDead map config data file was empty!" ) 
		
		return 
		
	end
	
	MsgN( "Loaded ReDead map config data successfully!" )
	
	for k,v in pairs( config ) do
	
		if v[1] then
		
			if k == "prop_physics" then
			
				for c,d in pairs( v ) do
				
					local function spawnent()
					
						local ent = ents.Create( k )
						ent:SetPos( d[1] )
						ent:SetModel( d[2] )
						ent:SetAngles( d[3] )
						ent:SetSkin( math.random( 0, 6 ) )
						ent:Spawn()
						ent.AdminPlaced = true
						
						local phys = ent:GetPhysicsObject()
						
						if IsValid( phys ) and not d[4] then
						
							phys:EnableMotion( false )
						
						end
						
					end
					
					timer.Simple( c * 0.1, function() spawnent() end )
					
				end
			
			else
			
				for c,d in pairs( ents.FindByClass( k ) ) do
					
					d:Remove()
					
				end

				for c,d in pairs( v ) do
				
					if k != "point_radiation" and k != "info_lootspawn" and k != "info_npcspawn" then
				
						local function spawnent()
						
							local ent = ents.Create( k )
							ent:SetPos( d )
							ent:Spawn()
							ent.AdminPlaced = true
						
						end
					
						timer.Simple( c * 0.1, function() spawnent() end )
						
					else
					
						local ent = ents.Create( k )
						ent:SetPos( d )
						ent:Spawn()
						ent.AdminPlaced = true
				
					end

				end
				
			end
			
		end
		
	end

end

function GM:AddToZombieList( ply ) 

	if team.NumPlayers( TEAM_ZOMBIES ) > 0 then 
	
		ply:ClientSound( "HL1/fvox/buzz.wav", 100 )
		ply:Notice( translate.ClientGet( ply, "rd_notices_you_cannot_be_the_zombie_lord_now" ), GAMEMODE.Colors.Red, 5 )
	
		return
	
	end

	if not table.HasValue( GAMEMODE.Lords, ply ) and not GAMEMODE.LordExists then
	
		table.insert( GAMEMODE.Lords, ply )
		
		local snd = table.Random( GAMEMODE.AmbientScream )
		ply:ClientSound( snd, 100 )
		ply:Notice( translate.ClientGet( ply, "rd_notices_you_have_volunteered_to_be_the_zombie_lord" ), GAMEMODE.Colors.White, 5 )
		
	end

end

function GM:PickLord( force )

	if table.Count( player.GetAll() ) < GetConVar( "sv_redead_minimum_players" ):GetInt() and not force then 
	
		for k,v in pairs( player.GetAll() ) do
		
			v:Notice( translate.ClientGet( v, "rd_notices_a_zombie_lord_cannot_be_chosen_at_this_time" ), GAMEMODE.Colors.White, 5 )
				
		end
	
		return 
		
	end

	local tbl = team.GetPlayers( TEAM_ZOMBIES )
		
	for k,v in pairs( GAMEMODE.Lords ) do
		
		if IsValid( v ) then
			
			table.insert( tbl, v )
			
		end
		
	end
	
	if table.Count( tbl ) < 1 then
	
		tbl = team.GetPlayers( TEAM_ARMY )
	
	end
		
	local ply = table.Random( tbl )
	
	local snd = table.Random( GAMEMODE.AmbientScream )
	ply:ClientSound( snd, 100 )
		
	if ply:Team() == TEAM_ZOMBIES then
		
		ply:Notice( translate.ClientGet( ply, "rd_notices_you_have_become_the_zombie_lord" ), GAMEMODE.Colors.White, 5 )
		
		timer.Simple( 3, function() ply:Gib() ply:SetLord( true ) end )
		
	else
		
		ply:Notice( translate.ClientGet( ply, "rd_notices_you_will_become_the_zombie_lord" ), GAMEMODE.Colors.White, 5 )
			
		timer.Simple( 3, function() ply:SetTeam( TEAM_ZOMBIES ) ply:SetPlayerClass( CLASS_RUNNER ) ply:SetCash( 0 ) ply:Gib() ply:SetLord( true ) end )
		
	end
		
	for k,v in pairs( player.GetAll() ) do
		
		if v != ply and not force then
		
			v:Notice( translate.ClientGet( v, "rd_notices_a_zombie_lord_has_been_chosen" ), GAMEMODE.Colors.White, 5 )
				
		end
		
	end
	
	GAMEMODE.LordExists = true

end

function GM:RespawnAntidote()
	
	if IsValid( ents.FindByClass( "sent_antidote" )[1] ) and ents.FindByClass( "sent_antidote" )[1]:CuresLeft() > 0 then return end
	
	if #ents.FindByClass( "info_lootspawn" ) < 3 then return end

	local ent = table.Random( ents.FindByClass( "info_lootspawn" ) )
	local pos = ent:GetPos()
	local close = true
	
	while close do
	
		ent = table.Random( ents.FindByClass( "info_lootspawn" ) )
		pos = ent:GetPos()
		close = false
		
		for k,v in pairs( ents.FindByClass( "sent_antidote" ) ) do
		
			if v:GetPos():Distance( pos ) < 500 then
			
				close = true
			
			end
		
		end
	
	end
	
	local ant = ents.Create( "sent_antidote" )
	ant:SetPos( pos )
	ant:Spawn()
	
	GAMEMODE.Antidote = ant
	
	for k,v in pairs( team.GetPlayers( TEAM_ARMY ) ) do
	
		v:Notice( translate.ClientGet( v, "rd_notices_the_antidote_resupply_location_has_changed" ), GAMEMODE.Colors.White, 5 )
	
	end

end

function GM:SpawnEvac()

	local pos = Vector(0,0,0)

	if #ents.FindByClass( "info_evac" ) < 1 then
	
		local loot = ents.FindByClass( "info_lootspawn" )
		
		if #loot < 1 then
		
			MsgN( "ERROR: Map not configured properly." )
			
			return
		
		end
		
		local prop = table.Random( loot )
		
		pos = prop:GetPos()
	
	else
	
		local point = table.Random( ents.FindByClass( "info_evac" ) )
		pos = point:GetPos()
	
	end
	
	local evac = ents.Create( "point_evac" )
	evac:SetPos( pos )
	evac:Spawn()

end

function GM:GetGeneratedLoot()

	local tbl = {}

	for k,v in pairs( GAMEMODE.RandomLoot ) do
	
		if IsValid( v ) then
		
			table.insert( tbl, v )
		
		end
	
	end
	
	for k,v in pairs( GAMEMODE.RandomLoot ) do
	
		if not IsValid( v ) then
		
			table.remove( tbl, k )
			
			return tbl
		
		end
	
	end
	
	return tbl

end

function GM:LootThink()

	for k,v in pairs( ents.FindByClass( "prop_phys*" ) ) do
	
		if v.Removal and v.Removal < CurTime() and IsValid( v ) then
		
			v:Remove()
		
		end
		
		if v:IsOnFire() then
		
			v:Extinguish()
		
		end
	
	end

	if #ents.FindByClass( "info_lootspawn" ) < 10 then return end

	local amt = math.floor( GAMEMODE.MaxLoot * #ents.FindByClass( "info_lootspawn" ) )
	local total = 0
	
	local loots = GAMEMODE:GetGeneratedLoot()
	
	local num = amt - #loots
	
	if num > 0 then
	
		local tbl = { ITEM_SUPPLY, ITEM_LOOT, ITEM_AMMO, ITEM_MISC, ITEM_SPECIAL, ITEM_WPN_COMMON, ITEM_WPN_SPECIAL, ITEM_EXPLOSIVE }
		local chancetbl = { 0.60,     0.70,      0.70,     0.95,       0.05,           0.03,           0.02,             0.10 }
		
		for i=1, num do
			
			local ent = table.Random( ents.FindByClass( "info_lootspawn" ) )
			local pos = ent:GetPos()
			local rnd = math.Rand(0,1)
			local choice = math.random( 1, table.Count( tbl ) ) 
				
			while rnd > chancetbl[ choice ] do
					
				rnd = math.Rand(0,1)
				choice = math.random( 1, table.Count( tbl ) ) 
					
			end
				
			local rand = item.RandomItem( tbl[choice] )
			local proptype = "prop_physics"
				
			if rand.TypeOverride then
				
				proptype = rand.TypeOverride
				
			end
				
			local loot = ents.Create( proptype )
			loot:SetPos( pos + Vector(0,0,5) )
			loot:SetAngles( VectorRand():Angle() )
			
			if rand.DropModel then
			
				loot:SetModel( rand.DropModel )
			
			else
			
				loot:SetModel( rand.Model )
			
			end
			
			loot:Spawn()
			loot.RandomLoot = true
			loot.IsItem = true
				
			if not rand.CollisionOverride then
				
				loot:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			
			end
			
			table.insert( GAMEMODE.RandomLoot, loot )
			
		end
	
	end

end

function GM:WoodThink()

	if table.Count( GAMEMODE.WoodLocations ) < 1 then return end

	if GAMEMODE.WoodCount < GAMEMODE.WoodPercent then
	
		local tbl = table.Random( GAMEMODE.WoodLocations ) 
		local prop = ents.Create( "prop_physics" )
		prop:SetPos( tbl.Pos )
		prop:SetAngles( tbl.Ang )
		prop:SetModel( tbl.Model )
		prop:SetHealth( math.Clamp( tbl.Health, 50, 500 ) )
		prop:Spawn()
		prop.IsWooden = true
		
		GAMEMODE.WoodCount = GAMEMODE.WoodCount + 1
	
	elseif GAMEMODE.WoodCount > GAMEMODE.WoodPercent then
	
		local ent = table.Random( ents.FindByClass( "prop_phys*" ) )
		local phys = ent:GetPhysicsObject()
		
		if IsValid( phys ) and not ent.IsItem and ent.IsWooden then
		
			ent:Remove()
			
			GAMEMODE.WoodCount = GAMEMODE.WoodCount - 1
		
		end
	
	end

end

function GM:EventThink()

	if not GAMEMODE.RandomEvent then
	
		GAMEMODE.RandomEvent = CurTime() + ( 60 * math.Rand( 3.5, 9.5 ) )
	
	end
	
	if GAMEMODE.RandomEvent and GAMEMODE.RandomEvent < CurTime() then
		
		local ev = event.GetRandom()
		
		while ( ( ev.Type == EVENT_WEATHER and GAMEMODE.WeatherHappened ) or ev.Chance < math.Rand(0,1) ) do
		
			ev = event.GetRandom()
		
		end
		
		if ev.Type == EVENT_WEATHER then
		
			GAMEMODE.WeatherHappened = true
		
		end
		
		ev.Start()
	
		GAMEMODE.Event = ev
		GAMEMODE.RandomEvent = nil
	
	end
	
	if GAMEMODE.Event then
	
		GAMEMODE.Event:Think()
		
		if GAMEMODE.Event:EndThink() then
		
			GAMEMODE.Event:End()
			GAMEMODE.Event = nil
		
		end
	
	end

end

function GM:WaveThink()

	if GAMEMODE.NextWave < CurTime() then
	
		GAMEMODE.NextWave = CurTime() + 60 * GetConVar( "sv_redead_wave_length" ):GetInt()
		GAMEMODE.Wave = GAMEMODE.Wave + 1
		
		if GAMEMODE.Wave > #GAMEMODE.Waves then return end
		
		for k,v in pairs( player.GetAll() ) do
		
			v:Notice( translate.ClientGet( v, "rd_notices_new_undead_mutations_have_been_spotted" ), GAMEMODE.Colors.White, 5 )
			v:ClientSound( table.Random( GAMEMODE.AmbientScream ) )
		
		end
	
	end

end

function GM:GetZombieClass()

	local rand = math.Rand(0,1)
	local class = table.Random( GAMEMODE.Waves[ GAMEMODE.Wave ] or { "npc_nb_common" } )
	
	while #GAMEMODE.Waves[ GAMEMODE.Wave ] != 1 and rand > GAMEMODE.SpawnChance[ class ] do
	
		rand = math.Rand(0,1)
		class = table.Random( GAMEMODE.Waves[ GAMEMODE.Wave ] or { "npc_nb_common" } )
	
	end
	
	return class

end

function GM:NPCRespawnThink()

	for k,v in pairs( ( GAMEMODE.NPCSpawns or {} ) ) do
	
		if IsValid( v ) then
	
			local box = ents.FindInBox( v:GetPos() + Vector( -32, -32, 0 ), v:GetPos() + Vector( 32, 32, 64 ) )
			local can = true
			
			for k,v in pairs( box ) do
			
				if v.NextBot then
				
					can = false
				
				end
			
			end
			
			if can and GAMEMODE.SpawnCounter > 0 then 
			
				local ent = ents.Create( GAMEMODE:GetZombieClass() )
				ent:SetPos( v:GetPos() )
				ent:Spawn()
				
				GAMEMODE.SpawnCounter = GAMEMODE.SpawnCounter - 1
			
			end
			
		end
		
	end

end

function GM:NPCThink()

	if GAMEMODE.Wave > #GAMEMODE.Waves then return end
	
	local tbl = ents.FindByClass( "npc_nb*" )
	
	if #tbl < GetConVar( "sv_redead_max_zombies" ):GetInt() and #tbl < GetConVar( "sv_redead_zombies_per_player" ):GetInt() * team.NumPlayers( TEAM_ARMY ) then
	
		local total = math.Round( GetConVar( "sv_redead_zombies_per_player" ):GetInt() * team.NumPlayers( TEAM_ARMY ) + GetConVar( "sv_redead_zombies_per_player_zombie" ):GetFloat() * team.NumPlayers( TEAM_ZOMBIES ) )
		local num = math.Clamp( total, 1, math.Min( GetConVar( "sv_redead_max_zombies" ):GetInt() - #tbl, total ) )
		
		GAMEMODE.SpawnCounter = num
		
		--[[for i=1, num do
	
			local tbl = ents.FindByClass( "info_npcspawn" )
			
			if #tbl < 1 then return end
			
			local spawn = table.Random( tbl )
			local vec = VectorRand() * 5
			
			vec.z = 1
			
			local ent = ents.Create( GAMEMODE:GetZombieClass() )
			ent:SetPos( spawn:GetPos() + vec )
			ent:Spawn()
			
		end]]
	
	end

end

function GM:Think()

	if ( GAMEMODE.NextGameThink or 0 ) < CurTime() then

		if ( GAMEMODE.NextZombieThink or 0 ) < CurTime() then
		
			GAMEMODE:NPCThink()
			
			GAMEMODE.NextZombieThink = CurTime() + GetConVar( "sv_redead_wave_time" ):GetInt()
			
		end
		
		GAMEMODE:NPCRespawnThink()
		GAMEMODE:RespawnAntidote()
		GAMEMODE:EventThink()
		GAMEMODE:LootThink()
		GAMEMODE:WoodThink()
		GAMEMODE:WaveThink()
		GAMEMODE:WeatherThink()
		GAMEMODE:CheckGameOver( false )
		GAMEMODE.NextGameThink = CurTime() + 1
		
	end

	for k,v in pairs( player.GetAll() ) do
	
		if v:Team() != TEAM_UNASSIGNED then
		
			v:Think()
		
		end
	
	end

end

function GM:PhysgunPickup( ply, ent )

	if ply:IsAdmin() or ply:IsSuperAdmin() then return true end

	if ent:IsPlayer() then return false end
	
	if not ent.Placer or ent.Placer != ply then return false end
	
	return true 

end

function GM:PlayerDisconnected( pl )

	if pl:Alive() then
	
		pl:DropLoot()
		
	end
	
	if not table.HasValue( GAMEMODE.PlayerIDs, pl:SteamID() ) then
	
		table.insert( GAMEMODE.PlayerIDs, pl:SteamID() )
	
	end
	
	if pl:IsLord() then
	
		GAMEMODE.LordExists = false
	
	end
	
end

function GM:PlayerInitialSpawn( pl )

	pl:GiveAmmo( 200, "Pistol", false )

	if table.HasValue( GAMEMODE.PlayerIDs, pl:SteamID() ) then
	
		pl:SetTeam( TEAM_ZOMBIES )
	
	elseif pl:IsBot() then
	
		pl:SetTeam( TEAM_ARMY )
		pl:Spawn()
	
	else
	
		pl:SetTeam( TEAM_UNASSIGNED )
		pl:Spectate( OBS_MODE_ROAMING )
		
	end
	
end

function GM:PlayerSpawn( pl )

	if pl:Team() == TEAM_UNASSIGNED then
	
		pl:Spectate( OBS_MODE_ROAMING )
		pl:SetPos( pl:GetPos() + Vector( 0, 0, 50 ) )
		
		return
		
	end
	
	GAMEMODE:RespawnAntidote()
	
	if pl:Team() == TEAM_ARMY then
	
		local music = table.Random( GAMEMODE.OpeningMusic )
	
		pl:ClientSound( music, 100 )
		
	end
	
	pl:NoticeOnce( translate.ClientGet( pl, "rd_notices_press_f1_to_view_the_help_menu" ), GAMEMODE.Colors.Blue, 7, 15 )
	pl:NoticeOnce( translate.ClientGet( pl, "rd_notices_press_f2_to_buy_items_and_weapons" ), GAMEMODE.Colors.Blue, 7, 17 )
	pl:NoticeOnce( translate.ClientGet( pl, "rd_notices_press_f3_to_activate_the_panic_button" ), GAMEMODE.Colors.Blue, 7, 19 )
	pl:InitializeInventory()
	pl:OnSpawn()
	pl:OnLoadout()
	
	local oldhands = pl:GetHands()
	
	if IsValid( oldhands ) then
	
		oldhands:Remove()
		
	end
	
	local hands = ents.Create( "gmod_hands" )
	
	if IsValid( hands ) then
	
		hands:DoSetup( pl )
		hands:Spawn()
		
	end	

end

function GM:PlayerSetModel( pl )

end

function GM:PlayerLoadout( pl )
	
end

function GM:PlayerJoinTeam( ply, teamid )
	
	local oldteam = ply:Team()
	
	if ply:Alive() and ply:Team() != TEAM_UNASSIGNED then return end
	
	if teamid != TEAM_UNASSIGNED and ply:Team() == TEAM_UNASSIGNED then
	
		ply:UnSpectate()
	
	end
	
	if teamid == TEAM_SPECTATOR or teamid == TEAM_UNASSIGNED then
	
		teamid = TEAM_ARMY
	
	end
	
	ply:SetTeam( teamid )
	
	if ply.NextSpawn and ply.NextSpawn > CurTime() then
	
		ply.NextSpawn = CurTime() + 5
	
	else
	
		ply:Spawn()
	
	end
	
end

function GM:PlayerSwitchFlashlight( ply, on )

	return ply:Team() == TEAM_ARMY
	
end

function GM:GetFallDamage( ply, speed )

	if ply:Team() == TEAM_ZOMBIES then
	
		return 5
	
	end

	local pain = speed * 0.12
	
	ply:AddStamina( math.floor( pain * -0.25 ) )

	return pain
	
end

function GM:PlayerDeathSound()

	return true
	
end

function GM:CanPlayerSuicide( ply )

	return false
	
end

function GM:KeyRelease( ply, key )

	if ply:Team() != TEAM_ARMY then return end

	if key == IN_JUMP then
	
		ply:AddStamina( -2 )
	
	end
	
	if key != IN_USE then return end
	
	local trace = {}
    trace.start = ply:GetShootPos()
    trace.endpos = trace.start + ply:GetAimVector() * 80
    trace.filter = ply
	
	local tr = util.TraceLine( trace )
	
	if IsValid( tr.Entity ) and tr.Entity:GetClass() == "prop_physics" then
        
        if IsValid( ply.Stash ) then
            
            ply.Stash:OnExit( ply )
            
			return true
            
        end
        
        ply:AddToInventory( tr.Entity )
	
		return true
        
    elseif IsValid( tr.Entity ) and tr.Entity:GetClass() == "point_stash" then
        
        if IsValid( ply.Stash ) then
            
            ply.Stash:OnExit( ply )
            
        else
           
            tr.Entity:OnUsed( ply )
            
        end
        
    elseif not IsValid( tr.Entity ) then
        
        if IsValid( ply.Stash ) then
            
            ply.Stash:OnExit( ply )
            
        end
        
    end
    
	return true

end

function GM:PropBreak( att, prop )

	local phys = prop:GetPhysicsObject()
	
	if IsValid( phys ) and prop:GetModel() != "models/props_debris/wood_board04a.mdl" then
	
		if prop.IsWooden then
		
			GAMEMODE:SpawnChunk( prop:LocalToWorld( prop:OBBCenter() ) )
			GAMEMODE.WoodCount = GAMEMODE.WoodCount - 1
		
		end
	
	end

end 

function GM:SpawnChunk( pos )

	local ent = ents.Create( "prop_physics" )
	ent:SetPos( pos )
	ent:SetModel( "models/props_debris/wood_chunk04a.mdl" )
	ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	ent:Spawn()
	ent.IsItem = true

end

function GM:AllowPlayerPickup( ply, ent )

	local tbl = item.GetByModel( ent:GetModel() )
	
	if tbl and tbl.AllowPickup then
	
		return true
	
	end

	return false
	
end

function GM:PlayerUse( ply, entity )

	if ply:Team() == TEAM_ARMY and ( ply.LastUse or 0 ) < CurTime() then
	
		if table.HasValue( { "sent_propane_canister", "sent_propane_tank", "sent_fuel_diesel", "sent_fuel_gas" }, entity:GetClass() ) then 
		
			ply.LastUse = CurTime() + 0.5
		
			if not IsValid( ply.HeldObject ) and not IsValid( entity.Holder ) then 
	
				ply:PickupObject( entity )
				ply.HeldObject = entity
				entity.Holder = ply
				entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
				
			elseif entity == ply.HeldObject then 
			
				ply:DropObject( entity )
				ply.HeldObject = nil
				entity.Holder = nil
				entity:SetCollisionGroup( COLLISION_GROUP_NONE )
			
			end
	
		end
		
		return true
	
	end
	
	if ply:Team() != TEAM_ZOMBIES then return false end
	
	local trace = {}
    trace.start = ply:GetShootPos()
    trace.endpos = trace.start + ply:GetAimVector() * 80
    trace.filter = ply
	
	local tr = util.TraceLine( trace )
	
	if entity:GetClass() == "prop_door_rotating" or entity:GetClass() == "func_button" then

		return false
		
	end
	
	return true
	
end

function GM:EntityTakeDamage( ent, dmginfo )

	if ent.IsWooden then
	
		ent.WoodHealth = ( ent.WoodHealth or 150 ) - dmginfo:GetDamage() 
		
		if ent.WoodHealth < 1 then
		
			ent:Fire( "break", 0, 0 )
		
		end
	
	end

	if not ent:IsPlayer() and ent.IsItem then 

		dmginfo:ScaleDamage( 0 )
		
		return
		
	end
	
	local attacker = dmginfo:GetAttacker()
	
	if ent:IsPlayer() and ent:Team() == TEAM_ARMY and IsValid( attacker ) and ( attacker:IsNPC() or ( ( attacker:IsPlayer() and attacker:Team() == TEAM_ZOMBIES ) or ( attacker:IsPlayer() and attacker == ent ) ) ) then
	
		if ent:Health() <= 50 then
	
			ent:NoticeOnce( translate.Get( "rd_notices_your_health_has_dropped_below_30" ), GAMEMODE.Colors.Red, 5 )
			ent:NoticeOnce( translate.Get( "rd_notices_health_doesnt_regenerate_when_below_30" ), GAMEMODE.Colors.Blue, 5, 2 )
			
		end
	
		if dmginfo:IsDamageType( DMG_BURN ) then
	
			ent:ViewBounce( 30 )
			
		else
		
			ent:ViewBounce( 25 )
			ent:RadioSound( VO_PAIN )
			ent:DrawBlood()
		
		end
		
		if ent:GetPlayerClass() == CLASS_COMMANDO then
		
			dmginfo:ScaleDamage( GetConVar( "sv_redead_dmg_scale" ):GetFloat() * 0.85 )
		
		else
		
			dmginfo:ScaleDamage( GetConVar( "sv_redead_dmg_scale" ):GetFloat() ) 
		
		end
		
		if dmginfo:IsExplosionDamage() and attacker:Team() == TEAM_ZOMBIES then
	
			dmginfo:ScaleDamage( 0 )
	
		else
		
			ent:AddStat( "Damage", math.Round( dmginfo:GetDamage() ) )
			
			--[[if attacker:IsPlayer() then
			
				attacker:AddZedDamage( math.Round( dmginfo:GetDamage() ) )
				
			end]]
		
		end
		
	elseif ent:IsPlayer() and ent:Team() == TEAM_ZOMBIES and IsValid( attacker ) and attacker:IsPlayer() and dmginfo:GetDamage() > 30 then
	
		sound.Play( table.Random( GAMEMODE.GoreBullet ), ent:GetPos() + Vector(0,0,50), 75, math.random( 90, 110 ), 0.8 )
	
	end
	
	return self.BaseClass:EntityTakeDamage( ent, dmginfo )
	
end

function GM:ScaleNPCDamage( npc, hitgroup, dmginfo ) // obsolete!

	if hitgroup == HITGROUP_HEAD then
	
		npc:EmitSound( "Player.DamageHeadShot" )
		npc:SetHeadshotter( dmginfo:GetAttacker(), true )
		
		local effectdata = EffectData()
		effectdata:SetOrigin( dmginfo:GetDamagePosition() )
		util.Effect( "headshot", effectdata, true, true )
	
		dmginfo:ScaleDamage( math.Rand( 2.50, 3.00 ) ) 
		dmginfo:GetAttacker():NoticeOnce( translate.Get( "rd_notices_headshots_combos_earn_you_more_bones" ), GAMEMODE.Colors.Blue, 5 )
		dmginfo:GetAttacker():AddHeadshot()
		
    elseif hitgroup == HITGROUP_CHEST then
	
		dmginfo:ScaleDamage( 1.25 ) 
		
		npc:SetHeadshotter( dmginfo:GetAttacker(), false )
		dmginfo:GetAttacker():ResetHeadshots()
		
	elseif hitgroup == HITGROUP_STOMACH then
	
		dmginfo:ScaleDamage( 0.75 ) 
		
		npc:SetHeadshotter( dmginfo:GetAttacker(), false )
		dmginfo:GetAttacker():ResetHeadshots()
		
	else
	
		dmginfo:ScaleDamage( 0.50 )
		
		npc:SetHeadshotter( dmginfo:GetAttacker(), false )
		dmginfo:GetAttacker():ResetHeadshots()
		
	end
	
	return dmginfo

end 

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )

	if IsValid( ply.Stash ) then
		
		return
	
	end

	if hitgroup == HITGROUP_HEAD then
	
		ply:EmitSound( "Player.DamageHeadShot" )
		ply:ViewBounce( 25 )
		
		dmginfo:ScaleDamage( 1.75 * GetConVar( "sv_redead_dmg_scale" ):GetFloat() ) 
		
		return
		
    elseif hitgroup == HITGROUP_CHEST then
	
		ply:ViewBounce( 15 )
	
		dmginfo:ScaleDamage( 1.50 * GetConVar( "sv_redead_dmg_scale" ):GetFloat() ) 
		
		return
		
	elseif hitgroup == HITGROUP_STOMACH then
	
		dmginfo:ScaleDamage( 1.25 * GetConVar( "sv_redead_dmg_scale" ):GetFloat() ) 
		
	else
	
		dmginfo:ScaleDamage( 0.50 * GetConVar( "sv_redead_dmg_scale" ):GetFloat() )
		
	end
	
	ply:ViewBounce( ( dmginfo:GetDamage() / 20 ) * 10 )

end 

function GM:PlayerShouldTakeDamage( ply, attacker )

	if ply:Team() == TEAM_UNASSIGNED then return false end
	
	if IsValid( attacker ) and attacker:IsPlayer() and attacker != ply then
	
		return ( ply:Team() != attacker:Team() or GetConVar( "sv_redead_team_dmg" ):GetBool() ) 
	
	end

	return true
	
end

function GM:OnDamagedByExplosion( ply, dmginfo )

	if dmginfo:GetDamage() > 25 then
	
		ply:SetBleeding( true )
		
	end

	ply:SetDSP( 35, false )
	
	umsg.Start( "GrenadeHit", ply )
	umsg.End()
	
end

function GM:PlayerDeathThink( ply )

	if ply.NextSpawn and ply.NextSpawn > CurTime() then return end
	
	if ply:KeyDown( IN_JUMP ) or ply:KeyDown( IN_ATTACK ) or ply:KeyDown( IN_ATTACK2 ) then

		ply:Spawn()
		
	end
	
end

function GM:DoPlayerDeath( ply, attacker, dmginfo )

	ply:OnDeath()

	if ply:Team() == TEAM_ARMY then
	
		if team.NumPlayers( TEAM_ZOMBIES ) < 1 then
		
			ply:AddStat( "Martyr" )
		
		end
	
		local music = table.Random( GAMEMODE.DeathMusic )
		
		ply:ClientSound( music, 100 )
		ply:RadioSound( VO_DEATH )
		ply:SetTeam( TEAM_ZOMBIES )
		
		if not GAMEMODE.LordExists and GAMEMODE.EarlyPick then
		
			GAMEMODE:PickLord( true )
		
		end
		
		if IsValid( attacker ) and attacker:IsPlayer() and attacker != ply then
		
			attacker:AddZedDamage( 50 )
		
		end
	
	elseif ply:Team() == TEAM_ZOMBIES then

		if IsValid( attacker ) and attacker:IsPlayer() then
	
			attacker:AddCash( GAMEMODE.PlayerZombieKillValue )
			attacker:AddFrags( 1 )
			
		end
		
		if ply:IsLord() and ply:GetZedDamage() >= GAMEMODE.RedemptionDamage then
		
			ply:SetTeam( TEAM_ARMY )
			ply:Notice( translate.ClientGet( ply, "rd_notices_prepare_to_respawn_as_a_human" ), GAMEMODE.Colors.Blue, 5, 2 )
		
		end
	
	end

	if dmginfo:IsExplosionDamage() then
	
		ply:SetModel( table.Random( GAMEMODE.Corpses ) )
		
		local ed = EffectData()
		ed:SetOrigin( ply:GetPos() )
		util.Effect( "gore_explosion", ed, true, true )
	
	end
	
	ply:CreateRagdoll()
	
end

function GM:SynchStats()

	net.Start( "StatsSynch" )
	net.WriteInt( table.Count( player.GetAll() ), 8 )

	for k,v in pairs( player.GetAll() ) do
	
		net.WriteEntity( v )
		net.WriteTable( v:GetStats() )
	
	end
	
	net.Broadcast()

end

function GM:EndGame( winner )

	GAMEMODE:SynchStats()

	SetGlobalBool( "GameOver", true )
	SetGlobalInt( "WinningTeam", winner )
	
	for k,v in pairs( player.GetAll() ) do
	
		if winner == TEAM_ZOMBIES then
		
			v:NoticeOnce( translate.ClientFormat( v, "rd_notices_the_undead_have_overwhelmed_x", translate.Get(team.GetName( TEAM_ARMY )) ), GAMEMODE.Colors.White, 7, 2 )
		
		elseif team.NumPlayers( TEAM_ARMY ) > 0 then
		
			v:NoticeOnce( translate.ClientFormat( v, "rd_notices_x_has_successfully_evacuated", translate.Get(team.GetName( TEAM_ARMY )) ), GAMEMODE.Colors.White, 7, 2 )
		
		end
	
		if v:Team() == winner and winner == TEAM_ARMY then
		
			local music = table.Random( GAMEMODE.WinMusic )
		
			v:ClientSound( music, 100 )
			v:GodEnable()
			
		else
		
			local music = table.Random( GAMEMODE.LoseMusic )
		
			v:ClientSound( music, 100 )
			
		end
		
		v:NoticeOnce( translate.ClientFormat( v, "rd_notices_next_map_x", game.GetMapNext() ), GAMEMODE.Colors.White, 7, 4 )
	
	end
	
	timer.Simple( GetConVar( "sv_redead_post_game_time" ):GetInt(), function() game.LoadNextMap() end )

end

function GM:CheckGameOver( canend )

	if GetGlobalBool( "GameOver", false ) then return end

	if team.NumPlayers( TEAM_ARMY ) < 1 and team.NumPlayers( TEAM_ZOMBIES ) > 0 then
	
		GAMEMODE:EndGame( TEAM_ZOMBIES )
	
	elseif GAMEMODE.Wave > #GAMEMODE.Waves and canend then
	
		for k,v in pairs( team.GetPlayers( TEAM_ARMY ) ) do
		
			if not v:IsEvacuated() then
			
				v:Notice( translate.ClientGet( v, "rd_notices_helicopter_left_without_you" ), GAMEMODE.Colors.Red, 5 )
				v:SetTeam( TEAM_ZOMBIES )
			 
			end
		
		end
	
		GAMEMODE:EndGame( TEAM_ARMY )
	
	end

end

function GM:ShowHelp( ply )

	ply:SendLua( "GAMEMODE:ShowHelp()" ) 

end

function GM:ShowTeam( ply )

	if ply:Team() == TEAM_ZOMBIES then
	
		ply:SendLua( "GAMEMODE:ShowZombieClasses()" )
		
		return
	
	end
	
	if not ply:Alive() then return end
	
	if ply:IsIndoors() then
	
		ply:Notice( translate.ClientGet( ply, "rd_notices_you_cannot_use_your_radio_indoors" ), GAMEMODE.Colors.Red )
	
	else
	
		if ply:GetPlayerClass() == CLASS_SPECIALIST then
	
			if IsValid( ply.Stash ) then
			
				GAMEMODE.SpecialTrader:OnExit( ply )
			
			else
		
				if GAMEMODE.RadioBlock and GAMEMODE.RadioBlock > CurTime() then
		
					ply:Notice( translate.ClientGet( ply, "rd_notices_radio_communications_are_offline" ), GAMEMODE.Colors.Red )
					return
		
				end
		
				GAMEMODE.SpecialTrader:OnUsed( ply )
				
			end
			
		else
		
			if IsValid( ply.Stash ) then
			
				GAMEMODE.Trader:OnExit( ply )
			
			else
			
				if GAMEMODE.RadioBlock and GAMEMODE.RadioBlock > CurTime() then
		
					ply:Notice( translate.ClientGet( ply, "rd_notices_radio_communications_are_offline" ), GAMEMODE.Colors.Red )
					return
				
				end
		
				GAMEMODE.Trader:OnUsed( ply )
				
			end
		
		end
	
	end

end

function GM:ShowSpare1( ply )

	GAMEMODE:PanicButton( ply )

end

function GM:ShowSpare2( ply )

	GAMEMODE:AddToZombieList( ply )

end

function GM:PanicButton( ply )

	if ( ply.Panic or 0 ) > CurTime() or ply:Team() == TEAM_ZOMBIES then return end
	
	ply.Panic = CurTime() + 0.5

	local panic = { { ply:IsBleeding(), { "rd_items_bandage_name" }, "rd_notices_panic_block_status1" },
	{ ply:GetRadiation() > 0, { "rd_items_vodka_name", "rd_items_moonshine_vodka_name", "rd_items_anti_rad_name" }, "rd_notices_panic_block_status2" },
	{ ply:Health() < 50, { "rd_items_advanced_medkit_name", "rd_items_basic_medkit_name", "rd_items_canned_food_name" }, "rd_notices_panic_block_status3" },
	{ ply:Health() < 100, { "rd_items_basic_medkit_name", "rd_items_canned_food_name" }, "rd_notices_panic_block_status4" },
	{ ply:GetStamina() < 100, { "rd_items_energy_drink_name" }, "rd_notices_panic_block_status5" },
	{ ply:GetStamina() < 100, { "rd_items_water_name" }, "rd_notices_panic_block_status6" } }

	for k,v in pairs( panic ) do
	
		if v[1] then
		
			for c,d in pairs( v[2] ) do
			
				local tbl = item.GetByName( d )
			
				if tbl and ply:HasItem( tbl.ID ) then
                
					tbl.Functions[ 1 ]( ply, tbl.ID )
					
					ply:Notice( translate.ClientFormat( ply, "rd_notices_panic_button_detected_that_you_were_x", translate.ClientGet( ply, v[3] ) ), GAMEMODE.Colors.Blue )
					
					return

				end
			
			end
		
		end
	
	end
	
	ply:Notice( translate.ClientGet( ply, "rd_notices_panic_button_did_not_detect_items" ), GAMEMODE.Colors.Red )
	ply:ClientSound( "items/suitchargeno1.wav" )

end

function DropItem( ply, cmd, args )

	local id = tonumber( args[1] )
	local count = math.Clamp( tonumber( args[2] ), 1, 100 )
	
	if not ply:HasItem( id ) then return end
	
	local tbl = item.GetByID( id )
	
	if count == 1 then
	
		if ply:HasItem( id ) then
		
			local makeprop = true
		
			if tbl.DropFunction then
			
				makeprop = tbl.DropFunction( ply, id, true )
			
			end
			
			if makeprop then
		
				local prop = ents.Create( "prop_physics" )
				prop:SetPos( ply:GetItemDropPos() )
				prop:SetAngles( ply:GetAimVector():Angle() )
				
				if tbl.DropModel then
			
					prop:SetModel( tbl.DropModel )
				
				else
				
					prop:SetModel( tbl.Model )
				
				end
				
				prop:SetCollisionGroup( COLLISION_GROUP_WEAPON )
				prop:Spawn()
				prop.IsItem = true
				prop.Removal = CurTime() + 5 * 60
				
			end
			
			ply:RemoveFromInventory( id, true )
			ply:EmitSound( Sound( "items/ammopickup.wav" ) )
		
		end
		
		return
	
	end
	
	local itemcount = math.min( ply:GetItemCount( id ), count )
	local loot = ents.Create( "sent_lootbag" )
	
	for i=1, itemcount do
	
		loot:AddItem( id )
	
	end
	
	loot:SetAngles( ply:GetAimVector():Angle() )
	loot:SetPos( ply:GetItemDropPos() )
	loot:SetRemoval( 60 * 5 )
	loot:Spawn()
	//loot:SetUser( ply ) 
	
	ply:EmitSound( Sound( "items/ammopickup.wav" ) )
	ply:RemoveMultipleFromInventory( loot:GetItems() )
	
	if tbl.DropFunction then
		
		tbl.DropFunction( ply, id )
		
	end

end

concommand.Add( "inv_drop", DropItem )

function UseItem( ply, cmd, args )

	local id = tonumber( args[1] )
	local pos = tonumber( args[2] )
	
	if ply:HasItem( id ) then
	
		local tbl = item.GetByID( id )
		
		if not tbl.Functions[pos] then return end
		
		tbl.Functions[pos]( ply, id )
	
	end

end

concommand.Add( "inv_action", UseItem )

function TakeItem( ply, cmd, args )

	local id = tonumber( args[1] )
	local count = math.Clamp( tonumber( args[2] ), 1, 100 )
	
	if not IsValid( ply.Stash ) or not table.HasValue( ply.Stash:GetItems(), id ) or string.find( ply.Stash:GetClass(), "npc" ) then return end
	
	local tbl = item.GetByID( id )
	
	if count == 1 then
		
		ply:AddIDToInventory( id )
		ply.Stash:RemoveItem( id )
		
		return
	
	end
	
	local items = {}
	
	if IsValid( ply.Stash ) then
	
		for i=1, count do
	
			if table.HasValue( ply.Stash:GetItems(), id ) then
			
				table.insert( items, id )
				ply.Stash:RemoveItem( id )
			
			end
			
		end
		
		ply:AddMultipleToInventory( items )
		ply:EmitSound( Sound( "items/itempickup.wav" ) )
	
	end

end

concommand.Add( "inv_take", TakeItem )

function StoreItem( ply, cmd, args )

	local id = tonumber( args[1] )
	local count = math.Clamp( tonumber( args[2] ), 1, 100 )
	
	if not IsValid( ply.Stash ) or not ply:HasItem( id ) then return end
	
	local tbl = item.GetByID( id )
	
	if count == 1 then

		ply.Stash:AddItem( id )
		
		ply:RemoveFromInventory( id )
		ply:EmitSound( Sound( "c4.disarmfinish" ) )
		
		if tbl.DropFunction then
			
			tbl.DropFunction( ply, id )
			
		end
		
		return
	
	end
	
	local items = {}
	
	for i=1, count do
	
		if ply:HasItem( id ) then
	
			table.insert( items, id )
			ply.Stash:AddItem( id )
			
		end
	
	end
	
	ply:RemoveMultipleFromInventory( items )
	ply:EmitSound( Sound( "c4.disarmfinish" ) )
	
	if tbl.DropFunction then
		
		tbl.DropFunction( ply, id )
		
	end

end

concommand.Add( "inv_store", StoreItem )

function SellbackItem( ply, cmd, args )

	if not IsValid( ply ) then return end

	local id = tonumber( args[1] )
	
	if not table.HasValue( ply:GetShipment(), id ) then return end
	
	local tbl = item.GetByID( id )

	ply:AddCash( tbl.Price )
	ply:RemoveFromShipment( id )

end

concommand.Add( "inv_refund", SellbackItem )

function OrderShipment( ply, cmd, args )

	ply:SendShipment()

end

concommand.Add( "ordershipment", OrderShipment )

function BuyItem( ply, cmd, args )

	local id = tonumber( args[1] )
	local count = tonumber( args[2] )
	
	if not IsValid( ply.Stash ) or not ply.Stash:GetClass() == "info_trader" or not table.HasValue( ply.Stash:GetItems(), id ) or count < 0 then return end
	
	local tbl = item.GetByID( id )
	
	if tbl.Price > ply:GetCash() then 
		
		return 
		
	end 
	
	if tbl.Price > ply:GetStat( "Pricey" ) then
	
		ply:SetStat( "Pricey", tbl.Price )
	
	end
	
	if count == 1 then
		
		ply:AddToShipment( { id } )
		ply:AddCash( -tbl.Price )
		
		return
	
	end
	
	if ( tbl.Price * count ) > ply:GetCash() then 
		
		return 
		
	end 
	
	local items = {}
	
	for i=1, count do
		
		table.insert( items, id )
	
	end
	
	ply:AddToShipment( items )
	ply:AddCash( -tbl.Price * count )
	
end

concommand.Add( "inv_buy", BuyItem )

function DropCash( ply, cmd, args )

	local amt = tonumber( args[1] )
	
	if amt > ply:GetCash() or amt < 5 then return end
	
	ply:AddCash( -amt )
	
	local money = ents.Create( "sent_cash" )
	money:SetPos( ply:GetItemDropPos() )
	money:Spawn()
	money:SetCash( amt )

end

concommand.Add( "cash_drop", DropCash )

function StashCash( ply, cmd, args )

	local amt = tonumber( args[1] )
	
	if not IsValid( ply.Stash ) or amt > ply:GetCash() or amt < 5 or string.find( ply.Stash:GetClass(), "npc" ) then return end
	
	ply:AddCash( -amt )
	ply:SynchCash( ply.Stash:GetCash() + amt )
	ply.Stash:SetCash( ply.Stash:GetCash() + amt )

end

concommand.Add( "cash_stash", StashCash )

function TakeCash( ply, cmd, args )

	local amt = tonumber( args[1] )
	
	if not IsValid( ply.Stash ) or amt > ply.Stash:GetCash() or amt < 5 or string.find( ply.Stash:GetClass(), "npc" ) then return end
	
	ply:AddCash( amt )
	ply:SynchCash( ply.Stash:GetCash() - amt )
	ply.Stash:SetCash( ply.Stash:GetCash() - amt )

end

concommand.Add( "cash_take", TakeCash )

function SetPlyClass( ply, cmd, args )

	local class = tonumber( args[1] )
	
	if not GAMEMODE.ClassLogos[ class ] then return end
	
	if ply:Team() == TEAM_ARMY then return end
	
	if ply:Team() == TEAM_ZOMBIES then
	
		ply.NextClass = class
		
	else
	
		ply:SetPlayerClass( class )
	
	end
	
end

concommand.Add( "changeclass", SetPlyClass )

function SaveGameItems( ply, cmd, args )

	if ( !ply:IsAdmin() or !ply:IsSuperAdmin() ) then return end
	
	GAMEMODE:SaveAllEnts()
	
end

concommand.Add( "sv_redead_save_map_config", SaveGameItems )

function MapSetupMode( ply, cmd, args )

	if not IsValid( ply ) then 
	
		for k, ply in pairs( player.GetAll() ) do
		
			if ply:IsAdmin() or ply:IsSuperAdmin() then
	
				ply:Give( "rad_itemplacer" )
				ply:Give( "rad_propplacer" )
				ply:Give( "weapon_physgun" )
			
			end
		
		end
		
		return
		
	end

	if ply:IsAdmin() or ply:IsSuperAdmin() then
	
		ply:Give( "rad_itemplacer" )
		ply:Give( "rad_propplacer" )
		ply:Give( "weapon_physgun" )
		ply:AddCash( 500 )
	
	end

end

concommand.Add( "sv_redead_dev_mode", MapSetupMode )

function ItemListing( ply, cmd, args )

	if IsValid( ply ) and ply:IsAdmin() then
	
		local itemlist = item.GetList()
		
		for k,v in pairs( itemlist ) do
		
			print( v.ID .. ": " .. v.Name )
		
		end
	
	end

end

concommand.Add( "sv_redead_dev_itemlist", ItemListing )

function TestItem( ply, cmd, args )

	if IsValid( ply ) and ply:IsAdmin() then
	
		local id = tonumber( args[1] )
		local tbl = item.GetByID( id )
		
		if tbl then
		
			ply:AddIDToInventory( id )
		
		end
	
	end

end

concommand.Add( "sv_redead_dev_give", TestItem )