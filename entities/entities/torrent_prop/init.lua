include( "shared.lua" );

AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "cl_init.lua" );

function ENT:Initialize()

	self:SetCollisionGroup( COLLISION_GROUP_NONE );
	self:SetSolid( SOLID_VPHYSICS );
	self:PhysicsInit( SOLID_VPHYSICS );
	self:SetMoveType( MOVETYPE_VPHYSICS );

	self:GetPhysicsObject():Wake();
end

function ENT:Think()

	// Override

end

function ENT:PhysicsCollide( colData, physObj )

	local ent = colData.HitEntity;

	if ( ent && IsValid( ent ) && ent:IsPlayer() ) then 

		if ( TR && TR.CurState == TR_STATE_FIGHT && !ent:CanInteract( self ) ) then 

			ent:SetPos( ent:GetPos() + Vector( 0, 0, 3 ) );
			ent:SetLocalVelocity( Vector( math.random( -150, 150 ), math.random( -150, 150 ), 350 ) );
			ent:ViewPunch( Angle( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -10, 10 ) ) );

			ent:TakeDamage( math.random( 5, 10 ), self );

		end

	end

end
