
/* 

	The bullets are added here, you can change the force and splashes if need be.	

*/

game.AddAmmoType({
	name = "5.56m NATO",
	dmgtype = DMG_BULLET,
	plydmg = 0,
	npcdmg = 0,
	force = 100,
	minsplash = 20,
	maxsplash = 40
});

game.AddAmmoType({
	name = "9m",
	dmgtype = DMG_BULLET,
	plydmg = 0,
	npcdmg = 0,
	force = 20,
	minsplash = 10,
	maxsplash = 20
});

game.AddAmmoType({
	name = ".44 magnum",
	dmgtype = DMG_BULLET,
	plydmg = 0,
	npcdmg = 0,
	force = 250,
	minsplash = 60,
	maxsplash = 75
});

game.AddAmmoType({
	name = ".307",
	dmgtype = DMG_BULLET,
	plydmg = 0,
	npcdmg = 0,
	force = 650,
	minsplash = 30,
	maxsplash = 50
});

game.AddAmmoType({
	name = "50. CAL",
	dmgtype = DMG_BULLET,
	plydmg = 0,
	npcdmg = 0,
	force = 1550,
	minsplash = 150,
	maxsplash = 250
});

/*
	The price, max amount and weight of ammo is listed here.
	'price' is how much it costs to purchase a single bullet of that type.
	'max' is the maximum amount of ammo you can carry at once ( per round ).
	'weight' is how much one bullet of this type will weigh when put in ammo crate. 
*/

TR.Ammo = {

	["5.56m NATO"] = {
		price = 2,
		max = 750,
	},

	["9m"] = {
		price = 1,
		max = 1000,
		weight = 1
	},

	[".44 magnum"] = {
		price = 5,
		max = 500,
		weight = 1.5
	},

	[".307"] = {
		price = 10,
		max = 350,
		weight = 2.5
	},

	["50. CAL"] = {
		price = 125,
		max = 100,
		weight = 3
	}

}