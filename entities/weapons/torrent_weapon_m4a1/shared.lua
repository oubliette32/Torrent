
if SERVER then

	AddCSLuaFile("shared.lua");

else 

	SWEP.PrintName = "M4A1";
	SWEP.Author = "Oubliette";
	SWEP.Slot = 2;
	SWEP.SlotPos = 1;

end

SWEP.Base = "torrent_weapon_base";

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.ViewModel = "models/weapons/v_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight = 6;
SWEP.AutoSwitchTo = false;
SWEP.AutoSwitchFrom = false;

SWEP.HoldType = "ar2";

SWEP.Primary.Sound = Sound("Weapon_M4A1.Single")
SWEP.Primary.Recoil = 0.6;
SWEP.Primary.Damage = 6;
SWEP.Primary.NumShots = 1;
SWEP.Primary.ClipSize = 30;
SWEP.Primary.Delay = 0.06
SWEP.Primary.DefaultClip = 30;
SWEP.Primary.Automatic = true;
SWEP.Primary.Ammo = "9m"
SWEP.Primary.MaxAmmo = SWEP.Primary.ClipSize * 9;

SWEP.Primary.CurCone = 0.02;
SWEP.Primary.MaxCone = 0.08;
SWEP.Primary.MinCone = 0.02;


SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";

SWEP.ModeSwitch = true;