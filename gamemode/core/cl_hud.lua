/*
 *  Torrent - 2013 Illuminati Productions
 *
 *  This product is licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  
 */

/*
	The HUD that has far too many polygons.
*/


local HUD = {};

HUD.poly = {};

/* Prop Health */
local pHealthY, pHealthX = 0, 0;
local ent, clearEnt = nil, 0;
local propColour = 0;
local lPropHealth = 0;

/* Player Health */
local lHealth = 100;

/* Money / Spent money */
local lerpMoney, lerpSpentMoney = 0, 0;
local lerpLoses, lerpWins = 0, 0;

local width = ( ( ScrW() / 2 ) - 275 ) - 30;

HUD.DrawInfo = tobool( cookie.GetString( "torrent_drawinfo" ) );

HUD.tex_bg = Material( "console/background01" );

surface.CreateFont( "TorrentTimerFont", {
	font = "Arial",
	size = ScreenScale( 19 ),
	weight = 600,
	blursize = 0,
	antialias = true,
} )

surface.CreateFont( "TorrentFontVerySmall", {
	font = "Arial",
	size = ScreenScale( 5 ),
	weight = 600,
	blursize = 0,
	antialias = true,
} )

surface.CreateFont( "TorrentFontMedium", {
	font = "Arial",
	size = ScreenScale( 10 ),
	weight = 600,
	blursize = 0,
	antialias = true,
} )

surface.CreateFont( "TorrentLogoFont", {
	font = "Arial",
	size = ScreenScale( 9 ),
	weight = 900,
	blursize = 1,
	antialias = true,
} )


// Anyone think of a better way to draw the HUD than listing a bunch of matrix co ords? nope? cool.

/* 
 == The black bar to the left of the timer.
*/

HUD.poly.TimerLW = {
	[1] = { x = ( ScrW() / 2 ) - 100, y = 0 },
	[2] = { x = ( ScrW() / 2 ) - 80, y = 0 },
	[3] = { x = ( ScrW() / 2 ) - 50, y = 75 },
	[4] = { x = ( ScrW() / 2 ) - 70, y = 75 }
}

/* 
 == The smaller black bar to the left of the timer encapsulating the prop's health bar
*/

HUD.poly.TimerLB = {
	[1] = { x = ( ScrW() / 2 ) - 130, y = 0 },
	[2] = { x = ( ScrW() / 2 ) - 120, y = 0 },
	[3] = { x = ( ScrW() / 2 ) - 90, y = 75 },
	[4] = { x = ( ScrW() / 2 ) - 100, y = 75 }
}

/*
 == The black bar to the right of the tiemr. 
*/

HUD.poly.TimerRW = {
	[4] = { x = ( ScrW() / 2 ) + 100, y = 0 },
	[3] = { x = ( ScrW() / 2 ) + 80, y = 0 },
	[2] = { x = ( ScrW() / 2 ) + 50, y = 75 },
	[1] = { x = ( ScrW() / 2 ) + 70, y = 75 }
}

/* 
== The black bar to the right of the timer encaspulating the second prop health bar
*/

HUD.poly.TimerRB = {
	[4] = { x = ( ScrW() / 2 ) + 130, y = 0 },
	[3] = { x = ( ScrW() / 2 ) + 120, y = 0 },
	[2] = { x = ( ScrW() / 2 ) + 90, y = 75 },
	[1] = { x = ( ScrW() / 2 ) + 100, y = 75 }
}

/* 
== The black bar at the bottom of the timer
*/

HUD.poly.TimerBottom = {
	[1] = { x = ( ScrW() / 2 ) + 100, y = 75 },
	[2] = { x = ( ScrW() / 2 ) + 95, y = 85 },
	[3] = { x = ( ScrW() / 2 ) - 95, y = 85 },
	[4] = { x = ( ScrW() / 2 ) - 100, y = 75 }
}

/* 
 == Prop health bar one ( not static )
*/

HUD.poly.PropHealth1 = {
	[4] = { x = ( ScrW() / 2 ) + 120, y = 0 },
	[3] = { x = ( ScrW() / 2 ) + 100, y = 0 },
	[2] = { x = ( ScrW() / 2 ) + 70, y = 75 },
	[1] = { x = ( ScrW() / 2 ) + 90, y = 75 }
}

/* 
 == Prop health bar two ( not static )
*/

HUD.poly.PropHealth2 = {
	[1] = { x = ( ScrW() / 2 ) - 120, y = 0 },
	[2] = { x = ( ScrW() / 2 ) - 100, y = 0 },
	[3] = { x = ( ScrW() / 2 ) - 70, y = 75 },
	[4] = { x = ( ScrW() / 2 ) - 90, y = 75 }
}

/*
 == Main HUD frame left wing
*/

HUD.poly.MainLW = {
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 165 ) , y = ScrH() },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 190 ), y = ScrH() },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 275 ), y = ScrH() - 100 },
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 250 ), y = ScrH() - 100 }
}



HUD.poly.MainLW2 = {
	[1] = { x = ( ScrW() / 2 ) - 75, y = ScrH() },
	[2] = { x = ( ScrW() / 2 ) - 100, y = ScrH() },
	[3] = { x = ( ScrW() / 2 ) - 25, y = ScrH() - 125 },
	[4] = { x = ( ScrW() / 2 ), y = ScrH() - 125 }
}

/*
 == Main HUD frame right wing
*/

HUD.poly.MainRW = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 250 ), y = ScrH() - 100 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 275 ), y = ScrH() - 100 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 190 ), y = ScrH() },
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 165 ) , y = ScrH() }
}



HUD.poly.MainRW2 = {
	[1] = { x = ( ScrW() / 2 ), y = ScrH() - 125 },
	[2] = { x = ( ScrW() / 2 ) + 25, y = ScrH() - 125 },
	[3] = { x = ( ScrW() / 2 ) + 100, y = ScrH() },
	[4] = { x = ( ScrW() / 2 ) + 75, y = ScrH() }
}

/*
 == Main HUD frame left roof
*/

HUD.poly.MainLR = {
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 275 ) , y = ScrH() - 100 },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 262 ), y = ScrH() - 85 },
	[2] = { x = ( ScrW() / 2 ) - 49, y = ScrH() - 85 },
	[1] = { x = ( ScrW() / 2 ) - 40, y = ScrH() - 100 }
}

/*
 == Main HUD frame right roof
*/

HUD.poly.MainRR = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 275 ) , y = ScrH() - 100 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 262 ), y = ScrH() - 85 },
	[3] = { x = ( ScrW() / 2 ) + 49, y = ScrH() - 85 },
	[4] = { x = ( ScrW() / 2 ) + 40, y = ScrH() - 100 }
}

/*
 == The health bar
*/

HUD.poly.MainHB = {
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 262 ) , y = ScrH() - 85 },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 240 ), y = ScrH() - 60 },
	[2] = { x = ( ScrW() / 2 ) - 64, y = ScrH() - 60 },
	[1] = { x = ( ScrW() / 2 ) - 49, y = ScrH() - 85 }
}

/* 
 == The bar that seperates the health from the ammo
*/

HUD.poly.MainHS = {
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 241 ) , y = ScrH() - 60 },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 228 ), y = ScrH() - 45 },
	[2] = { x = ( ScrW() / 2 ) - 73, y = ScrH() - 45 },
	[1] = { x = ( ScrW() / 2 ) - 64, y = ScrH() - 60 }
}

/*
 == The ammo bar
*/

HUD.poly.MainAB = {
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 228 ) , y = ScrH() - 45 },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 207 ), y = ScrH() - 20 },
	[2] = { x = ( ScrW() / 2 ) - 84, y = ScrH() - 20 },
	[1] = { x = ( ScrW() / 2 ) - 74, y = ScrH() - 45 }
}

/*
 == The bar that seperates the ammo from the spare ammo
*/

HUD.poly.MainSAT = {
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 208 ) , y = ScrH() - 20 },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 202 ), y = ScrH() - 15 },
	[2] = { x = ( ScrW() / 2 ) - 91, y = ScrH() - 15 },
	[1] = { x = ( ScrW() / 2 ) - 88, y = ScrH() - 20 }
}

/*
 == The spare ammo bar
*/

HUD.poly.MainSA = {
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 202 ) , y = ScrH() - 15 },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 194 ), y = ScrH() - 5 },
	[2] = { x = ( ScrW() / 2 ) - 97, y = ScrH() - 5 },
	[1] = { x = ( ScrW() / 2 ) - 90, y = ScrH() - 15 }
}

/*
 == The bar that fills the space in between the spare ammo and the bottom of the HUD
*/

HUD.poly.MainSAB = {
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 195 ) , y = ScrH() - 5 },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 189 ), y = ScrH() },
	[2] = { x = ( ScrW() / 2 ) - 100, y = ScrH() },
	[1] = { x = ( ScrW() / 2 ) - 97, y = ScrH() - 5 }
}

/*
 ==	The money bar, alongside the boat cost bar 
*/

HUD.poly.MainMB = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 262 ) , y = ScrH() - 85 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 240 ), y = ScrH() - 60 },
	[3] = { x = ( ScrW() / 2 ) + 64, y = ScrH() - 60 },
	[4] = { x = ( ScrW() / 2 ) + 49, y = ScrH() - 85 }
}

/*
 ==	The boat cost bar, alongside the money bar
*/

HUD.poly.MainBC = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 262 ) , y = ScrH() - 85 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 240 ), y = ScrH() - 60 },
	[3] = { x = ( ScrW() / 2 ) + 64, y = ScrH() - 60 },
	[4] = { x = ( ScrW() / 2 ) + 49, y = ScrH() - 85 }
}

/*
 == The seperating between money/boat cost and wins/loses bars
*/

HUD.poly.MainMBCS = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 241 ) , y = ScrH() - 60 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 228 ), y = ScrH() - 45 },
	[3] = { x = ( ScrW() / 2 ) + 73, y = ScrH() - 45 },
	[4] = { x = ( ScrW() / 2 ) + 64, y = ScrH() - 60 }
}

/*
 == The wins bar, alongside the loses bar
*/

HUD.poly.MainWB = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 228 ) , y = ScrH() - 45 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 207 ), y = ScrH() - 20 },
	[3] = { x = ( ScrW() / 2 ) + 88, y = ScrH() - 20 },
	[4] = { x = ( ScrW() / 2 ) + 72, y = ScrH() - 45 }
}

/*
 == The loses bar, alongside the wins bar
*/

HUD.poly.MainWLB = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 228 ) , y = ScrH() - 45 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 207 ), y = ScrH() - 20 },
	[3] = { x = 0, y = ScrH() - 20 },
	[4] = { x = 0, y = ScrH() - 45 }
}

/*
 == The upper prop count seperator
*/

HUD.poly.MainSPCT = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 208 ) , y = ScrH() - 20 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 202 ), y = ScrH() - 15 },
	[3] = { x = ( ScrW() / 2 ) + 91, y = ScrH() - 15 },
	[4] = { x = ( ScrW() / 2 ) + 88, y = ScrH() - 20 }
}

/*
 == The prop count bar
*/

HUD.poly.MainPC = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 202 ) , y = ScrH() - 15 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 194 ), y = ScrH() - 5 },
	[3] = { x = ( ScrW() / 2 ) + 97, y = ScrH() - 5 },
	[4] = { x = ( ScrW() / 2 ) + 90, y = ScrH() - 15 }
}

/*
 == The bar that fills the space in between the spare ammo and the bottom of thue HUD
*/

HUD.poly.MainSPCB = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 195 ) , y = ScrH() - 5 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 189 ), y = ScrH() },
	[3] = { x = ( ScrW() / 2 ) + 100, y = ScrH() },
	[4] = { x = ( ScrW() / 2 ) + 97, y = ScrH() - 5 }
}

function HUD.DrawRightFrame()

	surface.SetMaterial( HUD.tex_bg );

	// Main hud right frame
	surface.SetDrawColor( 0, 0, 0, 200 );

	surface.DrawPoly( HUD.poly.MainRW );
	surface.DrawPoly( HUD.poly.MainRW2 );
	surface.DrawPoly( HUD.poly.MainRR );

	// Prop count seperating bar
	surface.DrawPoly( HUD.poly.MainSPCT );
	surface.DrawPoly( HUD.poly.MainSPCB );

	// Win/loss money/cost seperator
	surface.DrawPoly( HUD.poly.MainMBCS );

end

function HUD.DrawLeftFrame()

	surface.SetMaterial( HUD.tex_bg );

	// Main hud left frame
	surface.SetDrawColor( 0, 0, 0, 200 );

	surface.DrawPoly( HUD.poly.MainLW );
	surface.DrawPoly( HUD.poly.MainLW2 );
	surface.DrawPoly( HUD.poly.MainLR );

	// Health seperating bar
	surface.DrawPoly( HUD.poly.MainHS );

	// Spare ammo upper padding
	surface.DrawPoly( HUD.poly.MainSAT );

	// Spare ammo lower padding
	surface.DrawPoly( HUD.poly.MainSAB );

end

function HUD.DrawTimer()

	surface.SetMaterial( HUD.tex_bg );

	// Timer text
	draw.SimpleText( string.FormattedTime( TR.CurRTime, "%02i:%02i" ), "TorrentTimerFont", ScrW() / 2, 13, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

	surface.SetDrawColor( 0, 0, 0, 200 );

	// Timer body
	surface.DrawPoly( HUD.poly.TimerLW );
	surface.DrawPoly( HUD.poly.TimerRW );
	surface.DrawPoly( HUD.poly.TimerLB );
	surface.DrawPoly( HUD.poly.TimerRB );
	surface.DrawPoly( HUD.poly.TimerBottom );

	// Prop Health bars
	if ( IsValid( LocalPlayer():GetEyeTrace().Entity ) ) then 

		ent = LocalPlayer():GetEyeTrace().Entity;

		clearEnt = CurTime() + 3;

	elseif ( CurTime() >= clearEnt ) then

		ent = nil;

	end

	// A lot of linear interpolation, I know, it's the only way to get the effect I want.
	if ( ent && IsValid( ent ) && ent.GetTOwner && ent:GetTOwner() && ent:GetTOwner():IsPlayer() ) then

		local name = ( ent:GetTOwner():GetName():len() <= 15 ) and ent:GetTOwner():GetName() or ent:GetTOOwner():GetName():sub( 1, 15 ) .. ".. ";

		draw.SimpleText( name, "TorrentFontVerySmall", ScrW() / 2, 60, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

		lPropHealth = Lerp( 0.10, lPropHealth, ent:GetTHealth() );

		propColour = Lerp( 0.10, propColour, ( ( ent:GetTHealth() / ent:GetTMaxHealth() ) * 255 ) );

		surface.SetDrawColor( Color( 255 - propColour, propColour, 0, 200 ) );

		surface.DrawPoly( HUD.poly.PropHealth1 );
		surface.DrawPoly( HUD.poly.PropHealth2 );

		pHealthY = Lerp( 0.10, pHealthY, ( ent:GetTHealth() / ent:GetTMaxHealth() ) * 75 );
		pHealthX = Lerp( 0.10, pHealthX, ( ent:GetTHealth() / ent:GetTMaxHealth() ) * 30 );

		HUD.poly.PropHealth1[ 1 ].y = pHealthY;
		HUD.poly.PropHealth1[ 2 ].y = pHealthY;
		HUD.poly.PropHealth1[ 2 ].x = ( ScrW() / 2 ) + ( 100 - pHealthX );
		HUD.poly.PropHealth1[ 1 ].x = ( ScrW() / 2 ) + ( 120 - pHealthX );

		HUD.poly.PropHealth2[ 3 ].y = pHealthY;
		HUD.poly.PropHealth2[ 4 ].y = pHealthY;
		HUD.poly.PropHealth2[ 3 ].x = ( ScrW() / 2 ) - ( 100 - pHealthX );
		HUD.poly.PropHealth2[ 4 ].x = ( ScrW() / 2 ) - ( 120 - pHealthX );

		local prefix = HUD.DrawInfo and "Target Health : " or "";

		draw.SimpleText( prefix .. "" .. math.Round( lPropHealth ) .. " / " .. ent:GetTMaxHealth(), "TorrentFontVerySmall", ScrW() / 2, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

	else 

		lPropHealth = 0;

	end

end

function HUD.DrawHealth()

	surface.SetMaterial( HUD.tex_bg );

	// Health bar
	if ( LocalPlayer():Alive() ) then 

		lHealth = Lerp( 0.10, lHealth, LocalPlayer():Health() );

		local percent = ( lHealth / 100 ) * width;

		local col = lHealth * 2.55;

		surface.SetDrawColor( Color( 255 - col, col, 0, 255 ) );

		HUD.poly.MainHB[ 2 ].x = HUD.poly.MainHB[ 3 ].x + percent + 1;
		HUD.poly.MainHB[ 1 ].x = HUD.poly.MainHB[ 4 ].x + percent - 5;

		surface.DrawPoly( HUD.poly.MainHB );

		local prefix = HUD.DrawInfo and "Health : " or "";

		draw.SimpleText( prefix .. "" .. math.Round( lHealth ), "TorrentFontMedium", HUD.poly.MainHB[ 4 ].x + ( percent / 2 ), HUD.poly.MainHB[ 4 ].y, Color( 255 - col, 255 - col, 255 - col, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

	end

end

function HUD.DrawSpareAmmo()

	surface.SetMaterial( HUD.tex_bg );

	// Spare ammo bar
	if ( LocalPlayer():GetActiveWeapon() && LocalPlayer():GetActiveWeapon():IsValid() && LocalPlayer():GetActiveWeapon().Primary ) then 

		local aType = LocalPlayer():GetActiveWeapon().Primary.Ammo or "9m";

		local spareAmmo, max = LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() ), TR.Ammo[ aType ].max or 1;

		if ( spareAmmo > max ) then spareAmmo = max; end

		local percent = ( spareAmmo / max ) * width;

		HUD.poly.MainSA[ 2 ].x = HUD.poly.MainSA[ 3 ].x + percent + 14;
		HUD.poly.MainSA[ 1 ].x = HUD.poly.MainSA[ 4 ].x + percent + 12;

		if ( spareAmmo > 0 ) then 

			surface.SetDrawColor( 50, 50, 50, 255 );
			surface.DrawPoly( HUD.poly.MainSA );

			local prefix = HUD.DrawInfo and "Spare Ammo : " or "";

			draw.SimpleText( prefix .. "" .. spareAmmo .. " / " .. max, "TorrentFontVerySmall", HUD.poly.MainSA[ 4 ].x + ( percent / 2), HUD.poly.MainSA[ 4 ].y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

		end

	end

end

function HUD.DrawAmmo()

	surface.SetMaterial( HUD.tex_bg );

	// Ammo bar
	if ( LocalPlayer():GetActiveWeapon() && LocalPlayer():GetActiveWeapon():IsValid() && LocalPlayer():GetActiveWeapon().Primary ) then 

		surface.SetDrawColor( 50, 50, 50, 255 );

		local wep = LocalPlayer():GetActiveWeapon();

		local ammo = wep:Clip1();

		if ( ammo > 0 ) then 

			local maxAmmo = wep.Primary.ClipSize or 0;

			local percent = ( ammo / maxAmmo ) * width;

			local size = ( width / maxAmmo );

			HUD.poly.MainAB[ 1 ].x = ( ( ScrW() / 2 ) - 72 ) - ( width - percent );
			HUD.poly.MainAB[ 2 ].x = ( ( ScrW() / 2 ) - 87 ) - ( width - percent );

			surface.DrawPoly( HUD.poly.MainAB );

			for i = 1, ( ammo - 1 ) do 

				surface.SetDrawColor( 0,0,0,255 );

				surface.DrawLine( HUD.poly.MainAB[ 3 ].x + ( i * size ), HUD.poly.MainAB[ 3 ].y, HUD.poly.MainAB[ 4 ].x + ( i * size ), HUD.poly.MainAB[ 4 ].y );

			end

			local prefix = HUD.DrawInfo and "Clip Ammo : " or "";

			draw.SimpleText( prefix .. "" .. ammo, "TorrentFontMedium", HUD.poly.MainAB[ 4 ].x + ( percent / 2 ), HUD.poly.MainAB[ 4 ].y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

		end

	end

end

function HUD.DrawMoney() // Also draws spent money

	surface.SetMaterial( HUD.tex_bg );

	// Lerp the values
	lerpMoney = Lerp( 0.10, lerpMoney, LocalPlayer():GetMoney() );
	lerpSpentMoney = Lerp( 0.10, lerpSpentMoney, LocalPlayer():GetSpentMoney() );

	// Use rounded variables for percentage calculations
	local money, boat_cw = math.Round( lerpMoney ), math.Round( lerpSpentMoney );

	local mwidth, bwidth = ( money / (money + boat_cw) ) * width, ( boat_cw / (money + boat_cw) ) * width;

	// Check if they have 0 money and have spent 0 money, in that case we want to draw 50 / 50 bar
	if ( money == 0 && boat_cw == 0 ) then mwidth = width / 2; bwidth = width / 2; end 

	HUD.poly.MainMB[ 1 ].x = HUD.poly.MainMB[ 4 ].x + math.max( mwidth - 5, 0 );
	HUD.poly.MainMB[ 2 ].x = HUD.poly.MainMB[ 3 ].x + mwidth;

	HUD.poly.MainBC[ 3 ].x = HUD.poly.MainMB[ 2 ].x;
	HUD.poly.MainBC[ 4 ].x = HUD.poly.MainMB[ 1 ].x;

	local dMoney = string.FormatNumber( tostring( money ) ) ;

	if ( mwidth > 0 ) then 

		surface.SetDrawColor( 0, 255, 0, 255 );
		surface.DrawPoly( HUD.poly.MainMB );	

	end

	if ( bwidth > 0 ) then

		surface.SetDrawColor( 255, 0, 0, 255 );
		surface.DrawPoly( HUD.poly.MainBC );

		dMoney = dMoney  .. " + " .. string.FormatNumber( tostring( boat_cw ) );

	end

	local prefix = HUD.DrawInfo and "Funds : " or "";

	draw.SimpleText( prefix .. "€" .. dMoney, "TorrentFontMedium", HUD.poly.MainMB[ 4 ].x + ( width / 2 ), HUD.poly.MainMB[ 1 ].y, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

end

function HUD.DrawWins() // Also draws loses

	surface.SetMaterial( HUD.tex_bg );

	// Lerp the values

	// ==
	// Why are we lerping these if they get changed every 30ish mins?
	// Because, when the player joins, there's around 3 seconds of
	// Time before the wins and loses are sent to the client and
	// As all of HUD elements are going to Lerp there way to those
	// Values, this wiil not if we don't Lerp it.
 	// ==

	lerpWins = Lerp( 0.10, lerpWins, LocalPlayer():GetWins() );
	lerpLoses = Lerp( 0.10, lerpLoses, LocalPlayer():GetLoses() );

	// Use rounded variables for percentage calculations
	local wins, loses = math.Round( lerpWins ), math.Round( lerpLoses );

	local prefix = HUD.DrawInfo and "W / L : " or ""; 

	local dWL = prefix .. wins .. " / " .. loses;

	mwidth, bwidth = ( wins / (wins + loses) ) * width, ( loses / (wins + loses) ) * width;

	// Check if they have 0 money and have spent 0 money, in that case we want to draw 50 / 50 bar
	if ( wins == 0 && loses == 0 ) then mwidth = width / 2; bwidth = width / 2; dWL = HUD.DrawInfo and "No W / L" or "W / L"; end 

	HUD.poly.MainWB[ 1 ].x = HUD.poly.MainWB[ 4 ].x + mwidth + ( mwidth > 0 and 4 or 0 );
	HUD.poly.MainWB[ 2 ].x = HUD.poly.MainWB[ 3 ].x + mwidth +  ( mwidth > 0 and 10 or 0 );

	HUD.poly.MainWLB[ 3 ].x = HUD.poly.MainWB[ 2 ].x;
	HUD.poly.MainWLB[ 4 ].x = HUD.poly.MainWB[ 1 ].x;

	
 
	if ( mwidth > 0 ) then 

		surface.SetDrawColor( 0, 255, 0, 255 );
		surface.DrawPoly( HUD.poly.MainWB );	

	end

	if ( bwidth > 0 ) then

		surface.SetDrawColor( 255, 0, 0, 255 );
		surface.DrawPoly( HUD.poly.MainWLB );

	end

	draw.SimpleText( dWL, "TorrentFontMedium", HUD.poly.MainWB[ 4 ].x + ( width / 2 ), HUD.poly.MainWB[ 1 ].y, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

end

function HUD.DrawPropCount()

	surface.SetMaterial( HUD.tex_bg );

	// Prop count bar

	local propCount, maxProps = LocalPlayer():GetPropCount(), LocalPlayer():MaxProps();

	if ( propCount > maxProps ) then propCount = maxProps; end

	local percent = ( propCount / maxProps ) * width;



	HUD.poly.MainPC[ 2 ].x = HUD.poly.MainPC[ 3 ].x + percent + 14;
	HUD.poly.MainPC[ 1 ].x = HUD.poly.MainPC[ 4 ].x + percent + 13;

	if ( propCount > 0 ) then 

		surface.SetDrawColor( 50, 50, 50, 255 );
		surface.DrawPoly( HUD.poly.MainPC );

		local prefix = HUD.DrawInfo and "props : " or ""; 

		draw.SimpleText( prefix .. propCount .. " / " .. maxProps, "TorrentFontVerySmall", HUD.poly.MainPC[ 1 ].x - ( percent / 2 ), HUD.poly.MainPC[ 1 ].y - 1, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

	end

end

HUD.illuminati_bg = Material( "logo/illuminati.png" );
HUD.illuminati_eye = Material( "logo/illuminati_eye.png" );
HUD.illuminati_eye_bg = Material( "logo/illuminati_eye_bg.png" );

HUD.eye_offx = 0;
HUD.eye_offy = 0;

HUD.t_eye_offx = 0;
HUD.t_eye_offy = 0;

HUD.eye_last_move = CurTime();

function HUD.DrawLogo()

	// Move the offset to the generated target position

	HUD.eye_offx = Lerp( 0.05, HUD.eye_offx, HUD.t_eye_offx );
	HUD.eye_offy = Lerp( 0.05, HUD.eye_offy, HUD.t_eye_offy );

	surface.SetDrawColor( Color( 255, 255, 255, 255 ) );

	// Draw the eye background

	surface.SetMaterial( HUD.illuminati_eye_bg );

	surface.DrawTexturedRect( ScrW() / 2 - 15, ScrH() - 130, 40, 40 );

	// Draw the eye
	surface.SetMaterial( HUD.illuminati_eye );

	local eye_x, eye_y = ( ScrW() / 2 - 7 ), ( ScrH() - 114 );

	surface.DrawTexturedRect( eye_x + HUD.eye_offx, eye_y + HUD.eye_offy, 20, 20 );

	// Draw the pyramid
	surface.SetMaterial( HUD.illuminati_bg );

	surface.DrawTexturedRect( ScrW() / 2 - 102, ScrH() - 140, ScreenScale( 80 ), ScreenScale( 70 ) );

	// Calculate the eye's position
	local x, y = gui.MousePos();

	if ( HUD.eye_last_move <= CurTime() || ( x > 0 || y > 0 ) ) then 

		HUD.eye_last_move = CurTime() + 1.2;

		local ang = ( x > 0 or y > 0 ) and math.atan2( eye_x - x, eye_y - y ) * ( 180 / math.pi ) or math.random( -180, 180 );

		HUD.t_eye_offx = -math.sin( ( ang * math.pi ) / 180 ) * 7; // 44 = width of the eye socket
		HUD.t_eye_offy = -math.cos( ( ang * math.pi ) / 180 ) * 3; // 24 = height of the eye socket

	end

	// Draw "Illuminati Productions" text

	draw.SimpleText( "ILLUMINATI ", "TorrentLogoFont", ScrW() / 2 - 50, ScrH() - 100, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP );
	draw.SimpleText( "PRODUCTIONS", "TorrentLogoFont", ScrW() / 2 + 50, ScrH() - 100, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP );

end

hook.Add( "HUDPaint", "HUD", function()

	for _, element in pairs( HUD ) do 

		if ( isfunction( element ) ) then 

			element();

		end

	end

end);

/*
	== Context menu hook doesn't work, using this instead.
*/

local pressed = false;
hook.Add( "Tick", "CMO", function()

	if ( input.IsKeyDown( KEY_C ) && !pressed ) then 

		HUD.DrawInfo = !HUD.DrawInfo;

		cookie.Set( "torrent_drawinfo", tostring( HUD.DrawInfo ) );

		pressed = true;

	elseif ( !input.IsKeyDown( KEY_C ) && pressed ) then 

		pressed = false;

	end

end);

local badElems = {
	["CHudHealth"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudAmmo"] = true,
}

// Had to use this type of hook..
function GM:HUDShouldDraw( elem )

	if ( badElems[ elem ] ) then return false; end

	return true;

end