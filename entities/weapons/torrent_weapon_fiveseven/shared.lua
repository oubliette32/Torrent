
if SERVER then

	AddCSLuaFile("shared.lua");

else 

	SWEP.PrintName = "Five-Seven";
	SWEP.Author = "Oubliette";
	SWEP.Slot = 1;
	SWEP.SlotPos = 1;

end

SWEP.Base = "torrent_weapon_base";

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.ViewModel = "models/weapons/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_five_seven.mdl"

SWEP.Weight = 2;
SWEP.AutoSwitchTo = false;
SWEP.AutoSwitchFrom = false;

SWEP.HoldType = "ar2";

SWEP.Primary.Sound = Sound("Weapon_Fiveseven.Single")
SWEP.Primary.Recoil = 0.2;
SWEP.Primary.Damage = 2;
SWEP.Primary.NumShots = 1;
SWEP.Primary.ClipSize = 12;
SWEP.Primary.Delay = 0.03
SWEP.Primary.DefaultClip = 12;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "9m"
SWEP.Primary.MaxAmmo = SWEP.Primary.ClipSize * 8;

SWEP.Primary.CurCone = 0.01;
SWEP.Primary.MaxCone = 0.02;
SWEP.Primary.MinCone = 0.01;


SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";

SWEP.ModeSwitch = false;