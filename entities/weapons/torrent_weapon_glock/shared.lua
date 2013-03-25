
if SERVER then

	AddCSLuaFile("shared.lua");

else 

	SWEP.PrintName = "Glock";
	SWEP.Author = "Oubliette";
	SWEP.Slot = 1;
	SWEP.SlotPos = 2;

end

SWEP.Base = "torrent_weapon_base";

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.ViewModel = "models/weapons/v_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"

SWEP.Weight = 2;
SWEP.AutoSwitchTo = false;
SWEP.AutoSwitchFrom = false;

SWEP.HoldType = "ar2";

SWEP.Primary.Sound = Sound("Weapon_Glock.Single")
SWEP.Primary.Recoil = 0.9;
SWEP.Primary.Damage = 8;
SWEP.Primary.NumShots = 1;
SWEP.Primary.ClipSize = 8;
SWEP.Primary.Delay = 0.07
SWEP.Primary.DefaultClip = 8;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "9m"
SWEP.Primary.MaxAmmo = SWEP.Primary.ClipSize * 6;

SWEP.Primary.CurCone = 0.02;
SWEP.Primary.MaxCone = 0.04;
SWEP.Primary.MinCone = 0.02;


SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";

SWEP.ModeSwitch = false;