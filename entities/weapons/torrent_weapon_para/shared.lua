
if SERVER then

	AddCSLuaFile("shared.lua");

else 

	SWEP.PrintName = "M249 - 5m";
	SWEP.Author = "Oubliette";
	SWEP.Slot = 3;
	SWEP.SlotPos = 1;

end

SWEP.Base = "torrent_weapon_base";

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.ViewModelFlip = false;SWEP.ViewModel = "models/weapons/v_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"

SWEP.Weight = 18;
SWEP.AutoSwitchTo = false;
SWEP.AutoSwitchFrom = false;

SWEP.HoldType = "ar2";

SWEP.Primary.Sound = Sound("Weapon_M249.Single")
SWEP.Primary.Recoil = 0.8;
SWEP.Primary.Damage = 9;
SWEP.Primary.NumShots = 1;
SWEP.Primary.ClipSize = 100;
SWEP.Primary.Delay = 0.04
SWEP.Primary.DefaultClip = 100;
SWEP.Primary.Automatic = true;
SWEP.Primary.Ammo = "9m"
SWEP.Primary.MaxAmmo = SWEP.Primary.ClipSize * 2;

SWEP.Primary.CurCone = 0.05;
SWEP.Primary.MaxCone = 0.12;
SWEP.Primary.MinCone = 0.05;


SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";

SWEP.ModeSwitch = false;