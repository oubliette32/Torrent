
if ( SERVER ) then

	AddCSLuaFile("shared.lua");
	SWEP.Weight = 5;
	SWEP.AutoSwitchTo = false;
	SWEP.AutoSwitchFrom = false;

end

if CLIENT then

	SWEP.DrawAmmo			= true;
	SWEP.DrawCrosshair		= false;
	SWEP.ViewModelFOV		= 82;
	SWEP.ViewModelFlip		= true;
	SWEP.CSMuzzleFlashes	= true;

end

SWEP.Base = "weapon_base";

SWEP.Author = "Oubliette";
SWEP.Contact = "http://facepunch.com/member.php?u=469591";
SWEP.Purpose = "Torrent Weapon Base";
SWEP.Instructions = "";

SWEP.Spawnable = false
SWEP.AdminSpawnable = false

SWEP.HoldType = "normal"

SWEP.Primary.Sound = Sound( "Weapon_AK47.Single" );
SWEP.Primary.Recoil = 0;
SWEP.Primary.Damage = 1;
SWEP.Primary.NumShots = 1;
SWEP.Primary.Delay = 0.15;

SWEP.Primary.CurCone = 0.02;
SWEP.Primary.MaxCone = 0.05;
SWEP.Primary.MinCone = 0.01;

SWEP.Primary.ClipSize = -1;
SWEP.Primary.DefaultClip = -1;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "none";
SWEP.Primary.MaxAmmo = 0;

SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";

SWEP.LastPrimaryAttack = 0;
SWEP.NextSecondaryAttack = 0;

SWEP.FireMode = "semi";
SWEP.ModeSwitch = false;


/*---------------------------------------------------------
	-- INITIALIZE
---------------------------------------------------------*/

function SWEP:Initialize()



end

/*---------------------------------------------------------
	-- DEPLOY
---------------------------------------------------------*/

function SWEP:Deploy()

	return true;

end

/*---------------------------------------------------------
	-- HOLSTER
---------------------------------------------------------*/

function SWEP:Holster()

	return true;

end

/*---------------------------------------------------------
	-- RELOAD
---------------------------------------------------------*/

function SWEP:Reload()

	if ( !self.Weapon:DefaultReload(ACT_VM_RELOAD) ) then return end

	self.Owner:SetAnimation(PLAYER_RELOAD);

end

/*---------------------------------------------------------
	-- PRIMARY ATTACK
---------------------------------------------------------*/

function SWEP:PrimaryAttack( partofburst )

	if ( self:Clip1() <= 0 ) then

		self:EmitSound("weapons/clipempty_rifle.wav")
		self:SetNextPrimaryFire(CurTime() + 2)

	else 

		if ( !self:CanPrimaryAttack() ) then return; end

		self.Weapon:EmitSound(self.Primary.Sound);

		self:ShootBullet(self.Primary.Damage, self.Primary.Recoil + 3, self.Primary.NumShots, self.Primary.CurCone * 2);

		self:TakePrimaryAmmo(1);

		self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.Primary.Recoil, 0, 0 ) );
		self.Owner:ViewPunch( Angle( -1 * self.Primary.Recoil, 0, 0 ) );

		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	end

	return true;

end

/*---------------------------------------------------------
	-- SHOOT BULLET
---------------------------------------------------------*/

function SWEP:ShootBullet(damage, recoil, numbul, cone)

	if ( !IsValid(self.Owner) ) then return; end

	cone = cone or 0.01;

	local bullet = {};

	bullet.Num = numbul or 1;
	bullet.Src = self.Owner:GetShootPos();
	bullet.Dir = self.Owner:GetAimVector();
	bullet.Spread = Vector(cone or 0.01, cone or 0.01, 0);
	bullet.Tracer = 1;
	bullet.Force = 10;
	bullet.Damage = damage;

	self.Owner:FireBullets(bullet);
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK);
	self.Owner:MuzzleFlash();
	self.Owner:SetAnimation(PLAYER_ATTACK1);

end

/*---------------------------------------------------------
	-- DRAW WEAPON SELECTION
---------------------------------------------------------*/

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)

end

/*---------------------------------------------------------
	-- GET VIEW MODEL POSITION
---------------------------------------------------------*/
function SWEP:GetViewModelPosition(pos, ang)

end

/*---------------------------------------------------------
	-- SECONDARY ATTACK
---------------------------------------------------------*/

function SWEP:SecondaryAttack()

	if ( self.ModeSwitch ) then 

		if (self.Primary.Automatic) then 

			self.FireMode = "semi";
			self.Primary.Automatic = false;
			self.Owner:SendMessage("Switched fire mode to semi-automatic");

		else 

			self.FireMode = "auto";
			self.Primary.Automatic = true;
			self.Owner:SendMessage("Switched fire mode to automatic");

		end

		self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 );
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.5 );

	end

	return true;

end

/*---------------------------------------------------------
	-- DRAW HUD
---------------------------------------------------------*/

function SWEP:DrawHUD()

	local x, y = ScrW() / 2, ScrH() / 2;
	local height, width = 12, 2;

	local spread = self.Primary.CurCone * 1000

	surface.SetDrawColor( Color( 146, 146, 146, 255 ) );

	surface.DrawRect( x  - (width / 2), y - spread - height - 2, width, height );
	surface.DrawRect( x + spread + 2, y - (width / 2), height, width );
	surface.DrawRect( x  - (width / 2), y + spread + 2, width, height );
	surface.DrawRect( x - spread - height - 2, y - (width / 2), height, width );

end

/*---------------------------------------------------------
	-- THINK
---------------------------------------------------------*/

function SWEP:Think()

	if ( self.Owner:Crouching() ) then 

		self.Primary.CurCone = Lerp( 0.10, self.Primary.CurCone, self.Primary.MinCone / 100 );

	elseif ( ( self.Owner:KeyDown(IN_FORWARD) || self.Owner:KeyDown(IN_LEFT) || self.Owner:KeyDown(IN_RIGHT) || self.Owner:KeyDown(IN_BACK) ) && ( self.Owner:KeyDown(IN_SPEED) && !self.Owner:Crouching() ) ) then 

		self.Primary.CurCone = Lerp( 0.10, self.Primary.CurCone, self.Primary.MaxCone );

	elseif ( self.Owner:KeyDown(IN_FORWARD) || self.Owner:KeyDown(IN_LEFT) || self.Owner:KeyDown(IN_RIGHT) || self.Owner:KeyDown(IN_BACK) ) then

		self.Primary.CurCone = Lerp( 0.05, self.Primary.CurCone, self.Primary.MaxCone );

	end 

	if ( self.Owner:KeyDown(IN_ATTACK) && self:Clip1() > 0 && self:CanPrimaryAttack() ) then 

		self.Primary.CurCone = Lerp( 0.01, self.Primary.CurCone, self.Primary.MaxCone * 2);


	else

		self.Primary.CurCone = Lerp( 0.05, self.Primary.CurCone, self.Primary.MinCone );

	end

end