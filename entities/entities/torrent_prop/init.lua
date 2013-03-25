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

	if ( ent && IsValid( ent ) && ent:IsPlayer() && TR ) then // The TR check is to make sure that the gamemode is Torrent thus checking if the functions inside it are available

		if ( TR.CurState == TR_STATE_FIGHT && !ent:CanInteract( ent ) ) then

			local phys = ent:GetPhysicsObject();
			local vel = phys:GetVelocity();

			phys:SetVelocity( -vel + Vector( 0, 0, 400 ) );

			ent:TakeDamage( math.random( 5, 15 ), self, self );

		end

	end

end