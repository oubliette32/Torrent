
if SERVER then

	AddCSLuaFile("shared.lua");

else 

	SWEP.PrintName = "Ak47";
	SWEP.Author = "Oubliette";
	SWEP.Slot = 2;
	SWEP.SlotPos = 2;

end

SWEP.Base = "torrent_weapon_base";

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.ViewModel = "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.Weight = 9;
SWEP.AutoSwitchTo = false;
SWEP.AutoSwitchFrom = false;

SWEP.HoldType = "ar2";

SWEP.Primary.Sound = Sound("Weapon_Ak47.Single")
SWEP.Primary.Recoil = 1.9;
SWEP.Primary.Damage = 19;
SWEP.Primary.NumShots = 1;
SWEP.Primary.ClipSize = 25;
SWEP.Primary.Delay = 0.11
SWEP.Primary.DefaultClip = 25;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "5.56m NATO"
SWEP.Primary.MaxAmmo = SWEP.Primary.ClipSize * 6;

SWEP.Primary.CurCone = 0.02;
SWEP.Primary.MaxCone = 0.08;
SWEP.Primary.MinCone = 0.02;


SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";

SWEP.ModeSwitch = true;