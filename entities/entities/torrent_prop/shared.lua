ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.Author = "Oubliette";

ENT.Spawnable = false;
ENT.AdminSpawnable = false;

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "THealth" );
	self:NetworkVar( "Int", 1, "TMaxHealth" );

	self:NetworkVar( "Entity", 0, "TOwner" );

end

function ENT:Initialize()
	
	// Override

end

function ENT:Think()

	// Override

end