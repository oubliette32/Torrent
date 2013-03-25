/*
	The HUD that has far too many polygons.
*/

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


// Anyone think of a better way to draw the HUD than listing a bunch of matrix co ords? nope? cool.

/* 
 == The black bar to the left of the timer.
*/

local polyTimerLW = {
	[1] = { x = ( ScrW() / 2 ) - 100, y = 0 },
	[2] = { x = ( ScrW() / 2 ) - 80, y = 0 },
	[3] = { x = ( ScrW() / 2 ) - 50, y = 75 },
	[4] = { x = ( ScrW() / 2 ) - 70, y = 75 }
}

/* 
 == The smaller black bar to the left of the timer encapsulating the prop's health bar
*/

local polyTimerLB = {
	[1] = { x = ( ScrW() / 2 ) - 130, y = 0 },
	[2] = { x = ( ScrW() / 2 ) - 120, y = 0 },
	[3] = { x = ( ScrW() / 2 ) - 90, y = 75 },
	[4] = { x = ( ScrW() / 2 ) - 100, y = 75 }
}

/*
 == The black bar to the right of the tiemr. 
*/

local polyTimerRW = {
	[1] = { x = ( ScrW() / 2 ) + 100, y = 0 },
	[2] = { x = ( ScrW() / 2 ) + 80, y = 0 },
	[3] = { x = ( ScrW() / 2 ) + 50, y = 75 },
	[4] = { x = ( ScrW() / 2 ) + 70, y = 75 }
}

/* 
== The black bar to the right of the timer encaspulating the second prop health bar
*/

local polyTimerRB = {
	[1] = { x = ( ScrW() / 2 ) + 130, y = 0 },
	[2] = { x = ( ScrW() / 2 ) + 120, y = 0 },
	[3] = { x = ( ScrW() / 2 ) + 90, y = 75 },
	[4] = { x = ( ScrW() / 2 ) + 100, y = 75 }
}

/* 
== The black bar at the bottom of the timer
*/

local polyTimerBottom = {
	[1] = { x = ( ScrW() / 2 ) + 100, y = 75 },
	[2] = { x = ( ScrW() / 2 ) + 95, y = 85 },
	[3] = { x = ( ScrW() / 2 ) - 95, y = 85 },
	[4] = { x = ( ScrW() / 2 ) - 100, y = 75 }
}

/* 
 == Prop health bar one ( not static )
*/

local polyPropHealth1 = {
	[1] = { x = ( ScrW() / 2 ) + 120, y = 0 },
	[2] = { x = ( ScrW() / 2 ) + 100, y = 0 },
	[3] = { x = ( ScrW() / 2 ) + 70, y = 75 },
	[4] = { x = ( ScrW() / 2 ) + 90, y = 75 }
}

/* 
 == Prop health bar two ( not static )
*/

local polyPropHealth2 = {
	[1] = { x = ( ScrW() / 2 ) - 120, y = 0 },
	[2] = { x = ( ScrW() / 2 ) - 100, y = 0 },
	[3] = { x = ( ScrW() / 2 ) - 70, y = 75 },
	[4] = { x = ( ScrW() / 2 ) - 90, y = 75 }
}

/*
 == Main HUD frame left wing
*/

local polyMainLW = {
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 165 ) , y = ScrH() },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 190 ), y = ScrH() },
	[3] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 275 ), y = ScrH() - 100 },
	[4] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 250 ), y = ScrH() - 100 }
}



local polyMainLW2 = {
	[1] = { x = ( ScrW() / 2 ) - 75, y = ScrH() },
	[2] = { x = ( ScrW() / 2 ) - 100, y = ScrH() },
	[3] = { x = ( ScrW() / 2 ) - 40, y = ScrH() - 100 },
	[4] = { x = ( ScrW() / 2 ) - 15, y = ScrH() - 100 }
}

/*
 == Main HUD frame right wing
*/

local polyMainRW = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 250 ), y = ScrH() - 100 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 275 ), y = ScrH() - 100 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 190 ), y = ScrH() },
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 165 ) , y = ScrH() }
}



local polyMainRW2 = {
	[1] = { x = ( ScrW() / 2 ) + 15, y = ScrH() - 100 },
	[2] = { x = ( ScrW() / 2 ) + 40, y = ScrH() - 100 },
	[3] = { x = ( ScrW() / 2 ) + 100, y = ScrH() },
	[4] = { x = ( ScrW() / 2 ) + 75, y = ScrH() }
}

/*
 == Main HUD frame left roof
*/

local polyMainLR = {
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 275 ) , y = ScrH() - 100 },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 262 ), y = ScrH() - 85 },
	[3] = { x = ( ScrW() / 2 ) - 49, y = ScrH() - 85 },
	[4] = { x = ( ScrW() / 2 ) - 40, y = ScrH() - 100 }
}

/*
 == Main HUD frame right roof
*/

local polyMainRR = {
	[1] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 275 ) , y = ScrH() - 100 },
	[2] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 262 ), y = ScrH() - 85 },
	[3] = { x = ( ScrW() / 2 ) + 49, y = ScrH() - 85 },
	[4] = { x = ( ScrW() / 2 ) + 40, y = ScrH() - 100 }
}

/*
 == The health bar
*/

local polyMainHB = {
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 262 ) , y = ScrH() - 85 },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 240 ), y = ScrH() - 60 },
	[3] = { x = ( ScrW() / 2 ) - 64, y = ScrH() - 60 },
	[4] = { x = ( ScrW() / 2 ) - 49, y = ScrH() - 85 }
}

/* 
 == The bar that seperates the health from the ammo
*/

local polyMainHS = {
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 241 ) , y = ScrH() - 60 },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 228 ), y = ScrH() - 45 },
	[3] = { x = ( ScrW() / 2 ) - 73, y = ScrH() - 45 },
	[4] = { x = ( ScrW() / 2 ) - 64, y = ScrH() - 60 }
}

/*
 == The ammo bar
*/

local polyMainAB = {
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 228 ) , y = ScrH() - 45 },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 207 ), y = ScrH() - 20 },
	[3] = { x = ( ScrW() / 2 ) - 84, y = ScrH() - 20 },
	[4] = { x = ( ScrW() / 2 ) - 74, y = ScrH() - 45 }
}

/*
 == The bar that seperates the ammo from the spare ammo
*/

local polyMainSAT = {
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 208 ) , y = ScrH() - 20 },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 202 ), y = ScrH() - 15 },
	[3] = { x = ( ScrW() / 2 ) - 91, y = ScrH() - 15 },
	[4] = { x = ( ScrW() / 2 ) - 88, y = ScrH() - 20 }
}

/*
 == The spare ammo bar
*/

local polyMainSA = {
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 202 ) , y = ScrH() - 15 },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 194 ), y = ScrH() - 5 },
	[3] = { x = ( ScrW() / 2 ) - 97, y = ScrH() - 5 },
	[4] = { x = ( ScrW() / 2 ) - 90, y = ScrH() - 15 }
}

/*
 == The bar that fills the space in between the spare ammo and the bottom of thue HUD
*/

local polyMainSAB = {
	[1] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 195 ) , y = ScrH() - 5 },
	[2] = { x = ( ScrW() / 2 ) - ( ( ScrW() / 2 ) - 189 ), y = ScrH() },
	[3] = { x = ( ScrW() / 2 ) - 100, y = ScrH() },
	[4] = { x = ( ScrW() / 2 ) - 97, y = ScrH() - 5 }
}

/*
 ==	The money bar, alongside the boat cost bar 
*/

local polyMainMB = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 262 ) , y = ScrH() - 85 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 240 ), y = ScrH() - 60 },
	[2] = { x = ( ScrW() / 2 ) + 64, y = ScrH() - 60 },
	[1] = { x = ( ScrW() / 2 ) + 49, y = ScrH() - 85 }
}

/*
 ==	The boat cost bar, alongside the money bar
*/

local polyMainBC = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 262 ) , y = ScrH() - 85 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 240 ), y = ScrH() - 60 },
	[2] = { x = ( ScrW() / 2 ) + 64, y = ScrH() - 60 },
	[1] = { x = ( ScrW() / 2 ) + 49, y = ScrH() - 85 }
}

/*
 == The seperating between money/boat cost and wins/loses bars
*/

local polyMainMBCS = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 241 ) , y = ScrH() - 60 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 228 ), y = ScrH() - 45 },
	[2] = { x = ( ScrW() / 2 ) + 73, y = ScrH() - 45 },
	[1] = { x = ( ScrW() / 2 ) + 64, y = ScrH() - 60 }
}

/*
 == The wins bar, alongside the loses bar
*/

local polyMainWB = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 228 ) , y = ScrH() - 45 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 207 ), y = ScrH() - 20 },
	[2] = { x = ( ScrW() / 2 ) + 88, y = ScrH() - 20 },
	[1] = { x = ( ScrW() / 2 ) + 72, y = ScrH() - 45 }
}

/*
 == The loses bar, alongside the wins bar
*/

local polyMainWLB = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 228 ) , y = ScrH() - 45 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 207 ), y = ScrH() - 20 },
	[2] = { x = 0, y = ScrH() - 20 },
	[1] = { x = 0, y = ScrH() - 45 }
}

/*
 == The upper prop count seperator
*/

local polyMainSPCT = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 208 ) , y = ScrH() - 20 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 202 ), y = ScrH() - 15 },
	[2] = { x = ( ScrW() / 2 ) + 91, y = ScrH() - 15 },
	[1] = { x = ( ScrW() / 2 ) + 88, y = ScrH() - 20 }
}

/*
 == The prop count bar
*/

local polyMainPC = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 202 ) , y = ScrH() - 15 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 194 ), y = ScrH() - 5 },
	[2] = { x = ( ScrW() / 2 ) + 97, y = ScrH() - 5 },
	[1] = { x = ( ScrW() / 2 ) + 90, y = ScrH() - 15 }
}

/*
 == The bar that fills the space in between the spare ammo and the bottom of thue HUD
*/

local polyMainSPCB = {
	[4] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 195 ) , y = ScrH() - 5 },
	[3] = { x = ( ScrW() / 2 ) + ( ( ScrW() / 2 ) - 189 ), y = ScrH() },
	[2] = { x = ( ScrW() / 2 ) + 100, y = ScrH() },
	[1] = { x = ( ScrW() / 2 ) + 97, y = ScrH() - 5 }
}



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

local HUD = {};

HUD.DrawInfo = tobool( cookie.GetString( "torrent_drawinfo" ) );

function HUD.DrawRightFrame()

	// Main hud right frame
	surface.SetDrawColor( 0, 0, 0, 200 );

	surface.DrawPoly( polyMainRW );
	surface.DrawPoly( polyMainRW2 );
	surface.DrawPoly( polyMainRR );

	// Prop count seperating bar
	surface.DrawPoly( polyMainSPCT );
	surface.DrawPoly( polyMainSPCB );

end

function HUD.DrawLeftFrame()

	// Main hud left frame
	surface.SetDrawColor( 0, 0, 0, 200 );

	surface.DrawPoly( polyMainLW );
	surface.DrawPoly( polyMainLW2 );
	surface.DrawPoly( polyMainLR );

	// Health seperating bar
	surface.DrawPoly( polyMainHS );

	// Spare ammo upper padding
	surface.SetDrawColor( 0, 0, 0, 200 );
	surface.DrawPoly( polyMainSAT );

	// Spare ammo lower padding
	surface.SetDrawColor( 0, 0, 0, 200 );
	surface.DrawPoly( polyMainSAB );

end

function HUD.DrawTimer()

	// Timer text
	draw.SimpleText( string.FormattedTime(TR.CurRTime,"%02i:%02i"), "TorrentTimerFont", ScrW() / 2, 13, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

	surface.SetDrawColor( 0, 0, 0, 200 );

	// Timer body
	surface.DrawPoly( polyTimerLW );
	surface.DrawPoly( polyTimerRW );
	surface.DrawPoly( polyTimerLB );
	surface.DrawPoly( polyTimerRB );
	surface.DrawPoly( polyTimerBottom );

	// Prop Health bars
	if ( IsValid( LocalPlayer():GetEyeTrace().Entity ) ) then 

		ent = LocalPlayer():GetEyeTrace().Entity;

		clearEnt = CurTime() + 3;

	elseif ( CurTime() >= clearEnt ) then

		ent = nil;

	end

	// A lot of linear interpolation, I know, it's the only way to get the effect I want.
	if ( ent && IsValid( ent ) && ent:GetTOwner() && ent:GetTOwner():IsPlayer() ) then

		local name = ( ent:GetTOwner():GetName():len() <= 15 ) and ent:GetTOwner():GetName() or ent:GetTOOwner():GetName():sub( 1, 15 ) .. ".. ";

		draw.SimpleText( name, "TorrentFontVerySmall", ScrW() / 2, 60, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

		lPropHealth = Lerp( 0.10, lPropHealth, ent:GetTHealth() );

		propColour = Lerp( 0.10, propColour, ( ( ent:GetTHealth() / ent:GetTMaxHealth() ) * 255 ) );

		surface.SetDrawColor( Color( 255 - propColour, propColour, 0, 200 ) );

		surface.DrawPoly( polyPropHealth1 );
		surface.DrawPoly( polyPropHealth2 );

		pHealthY = Lerp( 0.10, pHealthY, ( ent:GetTHealth() / ent:GetTMaxHealth() ) * 75 );
		pHealthX = Lerp( 0.10, pHealthX, ( ent:GetTHealth() / ent:GetTMaxHealth() ) * 30 );

		polyPropHealth1[ 3 ].y = pHealthY;
		polyPropHealth1[ 4 ].y = pHealthY;
		polyPropHealth1[ 3 ].x = ( ScrW() / 2 ) + ( 100 - pHealthX );
		polyPropHealth1[ 4 ].x = ( ScrW() / 2 ) + ( 120 - pHealthX );

		polyPropHealth2[ 3 ].y = pHealthY;
		polyPropHealth2[ 4 ].y = pHealthY;
		polyPropHealth2[ 3 ].x = ( ScrW() / 2 ) - ( 100 - pHealthX );
		polyPropHealth2[ 4 ].x = ( ScrW() / 2 ) - ( 120 - pHealthX );

		local prefix = HUD.DrawInfo and "Target Health : " or "";

		draw.SimpleText( prefix .. "" .. math.Round( lPropHealth ) .. " / " .. ent:GetTMaxHealth(), "TorrentFontVerySmall", ScrW() / 2, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

	else 

		lPropHealth = 0;

	end

end

function HUD.DrawHealth()

	// Health bar
	if ( LocalPlayer():Alive() ) then 

		lHealth = Lerp( 0.10, lHealth, LocalPlayer():Health() );

		local percent = ( lHealth / 100 ) * width;

		local col = lHealth * 2.55;

		surface.SetDrawColor( Color( 255 - col, col, 0, 255 ) );

		polyMainHB[ 3 ].x = polyMainHB[ 2 ].x + percent;
		polyMainHB[ 4 ].x = polyMainHB[ 1 ].x + percent - 5;

		surface.DrawPoly( polyMainHB );

		local prefix = HUD.DrawInfo and "Health : " or "";

		draw.SimpleText( prefix .. "" .. math.Round( lHealth ), "TorrentFontMedium", polyMainHB[ 4 ].x - ( percent / 2 ), polyMainHB[ 4 ].y, Color( 255 - col, 255 - col, 255 - col, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

	end

end

function HUD.DrawSpareAmmo()

	// Spare ammo bar
	if ( LocalPlayer():GetActiveWeapon() && LocalPlayer():GetActiveWeapon():IsValid() && LocalPlayer():GetActiveWeapon().Primary ) then 

		local aType = LocalPlayer():GetActiveWeapon().Primary.Ammo or "9m";

		local spareAmmo, max = LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() ), TR.Ammo[ aType ].max or 1;

		if ( spareAmmo > max ) then spareAmmo = max; end

		local percent = ( spareAmmo / max ) * width;

		polyMainSA[ 3 ].x = ( ScrW() / 2 ) - 97 - ( width - percent );
		polyMainSA[ 4 ].x = ( ScrW() / 2 ) - 90 - ( width - percent );

		if ( spareAmmo > 0 ) then 

			surface.SetDrawColor( 50, 50, 50, 255 );
			surface.DrawPoly( polyMainSA );

			local prefix = HUD.DrawInfo and "Spare Ammo : " or "";

			draw.SimpleText( prefix .. "" .. spareAmmo .. " / " .. max, "TorrentFontVerySmall", polyMainSA[ 4 ].x - ( percent / 2), polyMainSA[ 4 ].y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

		end

	end

end

function HUD.DrawAmmo()

	// Ammo bar
	if ( LocalPlayer():GetActiveWeapon() && LocalPlayer():GetActiveWeapon():IsValid() && LocalPlayer():GetActiveWeapon().Primary ) then 

		surface.SetDrawColor( 50, 50, 50, 255 );

		local wep = LocalPlayer():GetActiveWeapon();

		local ammo = wep:Clip1();

		if ( ammo > 0 ) then 

			local maxAmmo = wep.Primary.ClipSize or 0;

			local percent = ( ammo / maxAmmo ) * width;

			local size = ( width / maxAmmo );

			polyMainAB[ 3 ].x = ( ( ScrW() / 2 ) - 87 ) - ( width - percent );
			polyMainAB[ 4 ].x = ( ( ScrW() / 2 ) - 72 ) - ( width - percent );

			surface.DrawPoly( polyMainAB );

			for i = 1, ( ammo - 1 ) do 

				surface.SetDrawColor( 0,0,0,255 );

				surface.DrawLine( polyMainAB[ 1 ].x + ( i * size ), polyMainAB[ 1 ].y, polyMainAB[ 2 ].x + ( i * size ), polyMainAB[ 2 ].y );

			end

			local prefix = HUD.DrawInfo and "Clip Ammo : " or "";

			draw.SimpleText( prefix .. "" .. ammo, "TorrentFontMedium", polyMainAB[ 4 ].x - ( percent / 2 ), polyMainAB[ 4 ].y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

		end

	end

end

function HUD.DrawMoney() // Also draws spent money

	// Money / Boat cost

	// Lerp the values
	lerpMoney = Lerp( 0.10, lerpMoney, LocalPlayer():GetMoney() );
	lerpSpentMoney = Lerp( 0.10, lerpSpentMoney, LocalPlayer():GetSpentMoney() );

	// Use rounded variables for percentage calculations
	local money, boat_cw = math.Round( lerpMoney ), math.Round( lerpSpentMoney );

	local mwidth, bwidth = ( money / (money + boat_cw) ) * width, ( boat_cw / (money + boat_cw) ) * width;

	// Check if they have 0 money and have spent 0 money, in that case we want to draw 50 / 50 bar
	if ( money == 0 && boat_cw == 0 ) then mwidth = width / 2; bwidth = width / 2; end 

	polyMainMB[ 4 ].x = polyMainMB[ 1 ].x + math.max( mwidth - 5, 0 );
	polyMainMB[ 3 ].x = polyMainMB[ 2 ].x + mwidth;

	polyMainBC[ 2 ].x = polyMainMB[ 3 ].x;
	polyMainBC[ 1 ].x = polyMainMB[ 4 ].x;

	local dMoney = string.FormatNumber( tostring( money ) ) ;

	if ( mwidth > 0 ) then 

		surface.SetDrawColor( 0, 255, 0, 255 );
		surface.DrawPoly( polyMainMB );	

	end

	if ( bwidth > 0 ) then

		surface.SetDrawColor( 255, 0, 0, 255 );
		surface.DrawPoly( polyMainBC );

		dMoney = dMoney  .. " + " .. string.FormatNumber( tostring( boat_cw ) );

	end

	local prefix = HUD.DrawInfo and "Funds : " or "";

	draw.SimpleText( prefix .. "€" .. dMoney, "TorrentFontMedium", polyMainMB[ 1 ].x + ( width / 2 ), polyMainMB[ 4 ].y, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

end

function HUD.DrawWins() // Also draws loses

	surface.SetDrawColor( 0, 0, 0, 200 );

	surface.DrawPoly( polyMainMBCS );

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

	polyMainWB[ 4 ].x = polyMainWB[ 1 ].x + mwidth + ( mwidth > 0 and 4 or 0 );
	polyMainWB[ 3 ].x = polyMainWB[ 2 ].x + mwidth +  ( mwidth > 0 and 10 or 0 );

	polyMainWLB[ 2 ].x = polyMainWB[ 3 ].x;
	polyMainWLB[ 1 ].x = polyMainWB[ 4 ].x;

	
 
	if ( mwidth > 0 ) then 

		surface.SetDrawColor( 0, 255, 0, 255 );
		surface.DrawPoly( polyMainWB );	

	end

	if ( bwidth > 0 ) then

		surface.SetDrawColor( 255, 0, 0, 255 );
		surface.DrawPoly( polyMainWLB );

	end

	draw.SimpleText( dWL, "TorrentFontMedium", polyMainWB[ 1 ].x + ( width / 2 ), polyMainWB[ 4 ].y, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

end

function HUD.DrawPropCount()

	// Prop count bar

	local propCount, maxProps = LocalPlayer():GetPropCount(), TR_MAX_PROPS;

	if ( propCount > maxProps ) then propCount = maxProps; end

	local percent = ( propCount / maxProps ) * width;



	polyMainPC[ 3 ].x = polyMainPC[ 2 ].x + percent + 14;
	polyMainPC[ 4 ].x = polyMainPC[ 1 ].x + percent + 13;

	if ( propCount > 0 ) then 

		surface.SetDrawColor( 50, 50, 50, 255 );
		surface.DrawPoly( polyMainPC );

		local prefix = HUD.DrawInfo and "props : " or ""; 

		draw.SimpleText( prefix .. propCount .. " / " .. maxProps, "TorrentFontVerySmall", polyMainPC[ 4 ].x - ( percent / 2 ), polyMainPC[ 4 ].y - 1, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );

	end

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