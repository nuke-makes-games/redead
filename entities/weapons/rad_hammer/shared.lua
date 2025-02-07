if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.ViewModelFOV		= 80
	SWEP.ViewModelFlip		= false
	
	SWEP.PrintName = "Hammer"
	SWEP.IconLetter = "j"
	SWEP.Slot = 1
	SWEP.Slotpos = 0
	
end

SWEP.HoldType = "melee"

SWEP.Base = "rad_base"

SWEP.ViewModel			= "models/weapons/v_hammer/v_hammer.mdl"
SWEP.WorldModel			= "models/weapons/w_hammer.mdl"

SWEP.Barricade = Model( "models/props_debris/wood_board04a.mdl" )

SWEP.HoldPos = Vector (1.1747, -16.6759, -5.7913)
SWEP.HoldAng = Vector (23.7548, -8.0105, -5.154)

SWEP.IsSniper = false
SWEP.AmmoType = "Knife"

SWEP.Click = Sound( "Buttons.snd14" )
SWEP.Deny = Sound( "HL1/fvox/buzz.wav" )

SWEP.Primary.Hit            = Sound( "weapons/crowbar/crowbar_impact1.wav" )
SWEP.Primary.Sound			= Sound( "weapons/iceaxe/iceaxe_swing1.wav" )
SWEP.Primary.Recoil			= 6.5
SWEP.Primary.Damage			= 50
SWEP.Primary.NumShots		= 1
SWEP.Primary.Delay			= 1.100

SWEP.Primary.ClipSize		= 1
SWEP.Primary.Automatic		= true

SWEP.Position = 35
SWEP.BuildAng = 0

function SWEP:GetViewModelPosition( pos, ang )

	return self.Weapon:MoveViewModelTo( self.HoldPos, self.HoldAng, pos, ang, 1 )
	
end

function SWEP:ReleaseGhost()

	if IsValid( self.GhostEntity ) then

		self.GhostEntity:Remove()
		self.GhostEntity = nil
		
	end
	
end

function SWEP:MakeGhost( model, pos, angle )

	self.GhostEntity = ents.CreateClientProp( model )
	//self.GhostEntity:SetModel( model )
	self.GhostEntity:SetPos( pos )
	self.GhostEntity:SetAngles( angle )
	self.GhostEntity:Spawn()
	
	self.GhostEntity:SetSolid( SOLID_VPHYSICS )
	self.GhostEntity:SetMoveType( MOVETYPE_NONE )
	self.GhostEntity:SetNotSolid( true )
	self.GhostEntity:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.GhostEntity:SetColor( Color( 255, 255, 255, 200 ) )
	
end

function SWEP:UpdateGhost()

	if not IsValid( self.GhostEntity ) then return end
	
	local tr = util.GetPlayerTrace( self.Owner )
	local trace = util.TraceLine( tr )
	
	if not trace.Hit then return end
	
	local ang = ( trace.HitNormal * -1 ):Angle() + Angle( 0, 0, math.NormalizeAngle( 90 + self.Weapon:GetNWInt( "BuildAng", 0 ) ) )
	local pos = trace.HitPos 
	
	local trlength = self.Weapon:GetOwner():GetPos() - trace.HitPos
	trlength = trlength:Length() 
	
	if trlength < 150 and ( trace.HitWorld or trace.Entity:GetClass() == "prop_door_rotating" ) then
	
		self.GhostEntity:SetColor( Color( 50, 255, 50, 200 ) )
		
	else
	
		self.GhostEntity:SetColor( Color( 255, 50, 50, 200 ) )
		
	end
	
	if not trace.HitWorld and not trace.Entity:GetClass() == "prop_door_rotating" then
	
		self.GhostEntity:SetColor( Color( 255, 50, 50, 200 ) )
		self.GhostEntity:SetModel( self.Barricade )
		self.GhostEntity:SetPos( pos + ( self.GhostEntity:GetUp() * self.Position ) )
		self.GhostEntity:SetAngles( ang )
		
	elseif string.find( trace.Entity:GetClass(), "prop_door" ) then
	
		self.GhostEntity:SetModel( "models/props_c17/tools_wrench01a.mdl" )
		self.GhostEntity:SetPos( trace.HitPos + trace.HitNormal * 5 )
		self.GhostEntity:SetAngles( ( trace.HitNormal * -1 ):Angle() + Angle(0,90,90) )
		
	else
	
		self.GhostEntity:SetModel( self.Barricade )
		self.GhostEntity:SetPos( pos + ( self.GhostEntity:GetUp() * self.Position ) )
		self.GhostEntity:SetAngles( ang )
		
	end
	
end

function SWEP:SetPlacePosition( ent )

	local tr = util.GetPlayerTrace( self:GetOwner() )
	local trace = util.TraceLine( tr )
	
	if not trace.Hit then return end
	
	local ang = ( trace.HitNormal * -1 ):Angle() + Angle( 0, 0, math.NormalizeAngle( 90 + self.Weapon:GetNWInt( "BuildAng", 0 ) ) )
	ent:SetAngles( ang )
	
	local pos = trace.HitPos 
	ent:SetPos( pos + ( ent:GetUp() * self.Position ) )
	
	local phys = ent:GetPhysicsObject()
	
	if IsValid( phys ) then
	
		phys:EnableMotion( false )
		
	end

end

function SWEP:Deploy()

	if SERVER then
	
		self.Owner:DrawViewModel( true )
		self.Owner:NoticeOnce( translate.Get( "rd_notices_toggle_build_mode_reload_key" ), GAMEMODE.Colors.Blue, 5, 2 )
		
	else
	
		self.Weapon:ReleaseGhost()
	
	end
	
	self.InIron = false

	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	
	return true
	
end  

function SWEP:Holster()

	if CLIENT then
	
		self.Weapon:ReleaseGhost()
	
	end
	
	return true

end

function SWEP:Reload()

	if CLIENT then return end
	
	if ( self.ReloadTime or 0 ) < CurTime() then
	
		self.ReloadTime = CurTime() + 0.75
		
		self.Weapon:SetNWBool( "BuildMode", !self.Weapon:GetNWBool( "BuildMode", false ) )
		
		self.Owner:EmitSound( self.Click, 50, 120 )
		self.Owner:NoticeOnce( translate.Get( "rd_notices_rotate_barricade_by_rmb_key" ), GAMEMODE.Colors.Blue, 5, 2 )
	
	end

end

function SWEP:SecondaryAttack()

	if CLIENT then return end
	
	if ( self.SecondDelay or 0 ) < CurTime() and self.Weapon:GetNWBool( "BuildMode", false ) then
	
		self.SecondDelay = CurTime() + 0.25
		self.BuildAng = self.BuildAng + 45
		
		if self.BuildAng == 360 then
		
			self.BuildAng = 0
		
		end
		
		self.Weapon:SetNWInt( "BuildAng", self.BuildAng )
		self.Owner:EmitSound( self.Click )
		
	end
	
end

function SWEP:PrimaryAttack()

	if not self.Weapon:GetNWBool( "BuildMode", false ) then

		if SERVER then
		
			self.Owner:AddStamina( -2 )
		
		end

		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:MeleeTrace( self.Primary.Damage )
		
	else
	
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:BarricadeTrace()
	
	end
	
end

function SWEP:BarricadeTrace()

	if CLIENT then return end

	local trace = util.GetPlayerTrace( self.Owner )
	local tr = util.TraceLine( trace )
	local trlength = self.Weapon:GetOwner():GetPos() - tr.HitPos
	trlength = trlength:Length() 
	
	local has, id = self.Owner:GetWood()
	
	if not has then
	
		self.Owner:Notice( translate.Get( "rd_notices_you_dont_have_enough_wood" ), GAMEMODE.Colors.Red )
		self.Owner:EmitSound( self.Deny, 50, 100 )
		
		return
	
	end
	
	if tr.HitWorld and trlength < 150 then
	
		self.Owner:Notice( translate.Get( "rd_notices_built_a_barricade_1_piece_of_wood" ), GAMEMODE.Colors.Green )
		self.Owner:NoticeOnce( translate.Get( "rd_notices_you_can_also_repair_door" ), GAMEMODE.Colors.Blue, 5, 2 )
		
		local prop = ents.Create( "prop_physics" )
		prop:SetModel( self.Barricade )
		prop:Spawn()
		prop:SetHealth( 350 )
		prop:SetCustomCollisionCheck()
		prop.IsWood = true
		
		self.Weapon:SetPlacePosition( prop )
		
	elseif string.find( tr.Entity:GetClass(), "prop_door" ) and trlength < 150 then
	
		self.Owner:Notice( translate.Get( "rd_notices_fortified_a_door_using_1_piece_of_wood" ), GAMEMODE.Colors.Green )
		
		tr.Entity.MaxHits = 30
		tr.Entity.Hits = 0
		
	else
	
		self.Owner:Notice( translate.Get( "rd_notices_you_cant_build_a_barricade_here" ), GAMEMODE.Colors.Red )
		self.Owner:EmitSound( self.Deny, 50, 100 )
		
		return
		
	end
	
	self.Owner:AddStamina( -15 )
	self.Owner:RemoveFromInventory( id )
	self.Owner:AddStat( "rd_items_wood_name" )
	self.Owner:AddCash( 1 )
	
	self.Owner:EmitSound( table.Random( GAMEMODE.Drill ), 100, math.random(90,110) )
	self.Owner:EmitSound( table.Random( GAMEMODE.WoodHammer ), 100, math.random(90,110) )

end

function SWEP:MeleeTrace( dmg )
	
	self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
	
	if CLIENT then return end
	
	local pos = self.Owner:GetShootPos()
	local aim = self.Owner:GetAimVector() * 64
	
	local line = {}
	line.start = pos
	line.endpos = pos + aim
	line.filter = self.Owner
	
	local linetr = util.TraceLine( line )
	
	local tr = {}
	tr.start = pos + self.Owner:GetAimVector() * -5
	tr.endpos = pos + aim
	tr.filter = self.Owner
	tr.mask = MASK_SHOT_HULL
	tr.mins = Vector(-20,-20,-20)
	tr.maxs = Vector(20,20,20)

	local trace = util.TraceHull( tr )
	local ent = trace.Entity
	local ent2 = linetr.Entity
	
	if not IsValid( ent ) and IsValid( ent2 ) then
	
		ent = ent2
	
	end

	if not IsValid( ent ) then 
		
		self.Owner:EmitSound( self.Primary.Sound, 100, math.random(60,80) )
		return 
		
	elseif not ent:IsWorld() then
	
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		
		if ent:IsPlayer() then 
			
			local snd = table.Random( GAMEMODE.BluntHit )
			ent:EmitSound( snd, 100, math.random(90,110) )
			
			if ent:Team() != self.Owner:Team() then
		
				ent:TakeDamage( dmg, self.Owner, self.Weapon )
			
				self.Owner:DrawBlood()
			
				local ed = EffectData()
				ed:SetOrigin( trace.HitPos )
				util.Effect( "BloodImpact", ed, true, true )
				
			end
			
		elseif string.find( ent:GetClass(), "npc" ) then
		
			local snd = table.Random( GAMEMODE.BluntHit )
			ent:EmitSound( snd, 100, math.random(90,110) )
		
			if math.random(1,3) == 1 then
		
				ent:SetHeadshotter( self.Owner, true )
				
			end
			
			ent:TakeDamage( dmg, self.Owner, self.Weapon )
			
			self.Owner:DrawBlood()
			
			local ed = EffectData()
			ed:SetOrigin( trace.HitPos )
			util.Effect( "BloodImpact", ed, true, true )
		
		elseif !ent:IsPlayer() then 
		
			if string.find( ent:GetClass(), "breakable" ) then
			
				ent:TakeDamage( 50, self.Owner, self.Weapon )
				
				if ent:GetClass() == "func_breakable_surf" then
				
					ent:Fire( "shatter", "1 1 1", 0 )
				
				end
			
			end
		
			ent:EmitSound( self.Primary.Hit, 100, math.random(90,110) )
			
			local phys = ent:GetPhysicsObject()
			
			if IsValid( phys ) then
			
				if ent.IsWooden then
				
					ent:Fire( "break", 0, 0 )
				
				else
				
					ent:SetPhysicsAttacker( self.Owner )
					ent:TakeDamage( 10, self.Owner, self.Weapon )
					
					phys:Wake()
					phys:ApplyForceCenter( self.Owner:GetAimVector() * phys:GetMass() * 200 )
					
				end
				
			end
			
		end
		
	end

end

function SWEP:Think()	

	if CLIENT then
	
		if self.Weapon:GetNWBool( "BuildMode", false ) then
	
			if not self.GhostEntity then
				
				self.Weapon:MakeGhost( self.Barricade, self.Owner:GetPos() + Vector(0,0,100), Angle(0,0,0))
				
			else
				
				self.Weapon:UpdateGhost()
				
			end
			
		elseif IsValid( self.GhostEntity ) then
		
			self.Weapon:ReleaseGhost()
		
		end
	
	end

	if self.Owner:GetVelocity():Length() > 0 then
	
		if self.Owner:KeyDown( IN_SPEED ) then
		
			self.LastRunFrame = CurTime() + 0.3
		
		end
		
		if self.Weapon:GetZoomMode() != 1 then
		
			self.Weapon:UnZoom()
			
		end
		
	end
	
	if self.MoveTime and self.MoveTime < CurTime() and SERVER then
	
		self.MoveTime = nil
		self.Weapon:SetZoomMode( self.Weapon:GetZoomMode() + 1 )
		self.Owner:DrawViewModel( false )
		
	end

end

function SWEP:DrawHUD()
	
end
