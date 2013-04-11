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

// Variables

local fMenus = {};

fMenus.help = {};
fMenus.stats = {};
fMenus.teams = {};
fMenus.store = {};

// Key bind system

hook.Add( "CreateMove", "TorrentFMKB", function( cmd )

	for key, data in pairs( fMenus.binds ) do 

		if ( input.IsKeyDown( key ) && !data.pressed ) then 

			data.pressed = true;
			data.func();

		elseif ( !input.IsKeyDown( key ) ) then 

			data.pressed = false;

		end

	end

end);

function fMenus.CloseAll()

	if ( fMenus.help.panel ) then fMenus.help.Close(); end
	if ( fMenus.stats.panel ) then fMenus.stats.Close(); end
	if ( fMenus.teams.panel ) then fMenus.teams.Close(); end
	if ( fMenus.store.panel ) then fMenus.store.Close(); end

end

/****************************************************************************************************************************************
		-- H E L P 
 ****************************************************************************************************************************************/

function fMenus.help.Create() 

	fMenus.help.panel = vgui.Create( "DFrame" );
	fMenus.help.panel:SetSize( 400, 700 );
	fMenus.help.panel:Center();

	fMenus.help.panel:SetTitle( "Torrent - Help" );
	fMenus.help.panel:ShowCloseButton( false );
	fMenus.help.panel:SetDraggable( true );  

	fMenus.help.panel:SetVisible( false );

end

function fMenus.help.Open() 

	fMenus.CloseAll();

	if ( !fMenus.help.panel ) then fMenus.help.Create(); end

	fMenus.help.panel:SetVisible( true );
	fMenus.help.panel:MakePopup();

end

function fMenus.help.Close() 

	fMenus.help.panel:SetVisible( false );

end

function fMenus.help.Toggle() 

	if ( !fMenus.help.panel ) then fMenus.help.Create(); end
	fMenus.help[ fMenus.help.panel:IsVisible() and "Close" or "Open" ]();

end

/****************************************************************************************************************************************
		-- S T A T S
 ****************************************************************************************************************************************/

function fMenus.stats.Create() 

	fMenus.stats.panel = vgui.Create( "DFrame" );
	fMenus.stats.panel:SetSize( 400, 700 );
	fMenus.stats.panel:Center();

	fMenus.stats.panel:SetTitle( "Torrent - Statistics" );
	fMenus.stats.panel:ShowCloseButton( false );
	fMenus.stats.panel:SetDraggable( true );  

	fMenus.stats.panel:SetVisible( false );

end

function fMenus.stats.Open() 

	fMenus.CloseAll();

	if ( !fMenus.stats.panel ) then fMenus.stats.Create(); end

	fMenus.stats.panel:SetVisible( true );
	fMenus.stats.panel:MakePopup();

end

function fMenus.stats.Close() 

	fMenus.stats.panel:SetVisible( false );

end

function fMenus.stats.Toggle() 

	if ( !fMenus.stats.panel ) then fMenus.stats.Create(); end
	fMenus.stats[ fMenus.stats.panel:IsVisible() and "Close" or "Open" ]();

end

/****************************************************************************************************************************************
		-- T E A M S 
 ****************************************************************************************************************************************/

function fMenus.teams.Create() 

	fMenus.teams.panel = vgui.Create( "DFrame" );
	fMenus.teams.panel:SetSize( 400, 700 );
	fMenus.teams.panel:Center();

	fMenus.teams.panel:SetTitle( "Torrent - Teams" );
	fMenus.teams.panel:ShowCloseButton( false );
	fMenus.teams.panel:SetDraggable( true );  

	fMenus.teams.panel:SetVisible( false );

end

function fMenus.teams.Open() 

	fMenus.CloseAll();

	if ( !fMenus.teams.panel ) then fMenus.teams.Create(); end

	fMenus.teams.panel:SetVisible( true );
	fMenus.teams.panel:MakePopup();

end

function fMenus.teams.Close() 

	fMenus.teams.panel:SetVisible( false );

end

function fMenus.teams.Toggle() 

	if ( !fMenus.teams.panel ) then fMenus.teams.Create(); end
	fMenus.teams[ fMenus.teams.panel:IsVisible() and "Close" or "Open" ]();

end

/****************************************************************************************************************************************
		-- S T O R E
 ****************************************************************************************************************************************/

function fMenus.store.Create() 

	fMenus.store.panel = vgui.Create( "DFrame" );
	fMenus.store.panel:SetSize( 400, 400 );
	fMenus.store.panel:Center();

	fMenus.store.panel:SetTitle( "Torrent - Store" );
	fMenus.store.panel:ShowCloseButton( false );
	fMenus.store.panel:SetDraggable( true );  

	fMenus.store.panel:SetVisible( false );

	fMenus.store.panel.pSheet = vgui.Create( "DPropertySheet", fMenus.store.panel );
	fMenus.store.panel.pSheet:SetPos( 4, 24 );
	fMenus.store.panel.pSheet:SetSize( fMenus.store.panel:GetWide() - 8, fMenus.store.panel:GetTall() - 22 - 4 );

	fMenus.store.panel.weaponPanel = vgui.Create( "DPanel" );
	fMenus.store.panel.ammoPanel = vgui.Create( "DPanel" );


	fMenus.store.panel.pSheet:AddSheet( "Weapons", fMenus.store.panel.weaponPanel, "gui/silkicons/user", false, false, "Buy weapons" );
	fMenus.store.panel.pSheet:AddSheet( "Ammo", fMenus.store.panel.ammoPanel, "gui/silkicons/user", false, false, "Buy ammo" );

end

function fMenus.store.Open() 

	fMenus.CloseAll();

	if ( !fMenus.store.panel ) then fMenus.store.Create(); end

	fMenus.store.panel:SetVisible( true );
	fMenus.store.panel:MakePopup();

end

function fMenus.store.Close() 

	fMenus.store.panel:SetVisible( false );

end

function fMenus.store.Toggle() 

	if ( !fMenus.store.panel ) then fMenus.store.Create(); end
	fMenus.store[ fMenus.store.panel:IsVisible() and "Close" or "Open" ]();

end

// Bind listed loaded last so functions binded actually exist 
fMenus.binds = {
	[KEY_ESCAPE] = { func = fMenus.CloseAll, pressed = false },
	[KEY_F1] = { func = fMenus.help.Toggle, pressed = false },
	[KEY_F2] = { func = fMenus.stats.Toggle, pressed = false },
	[KEY_F3] = { func = fMenus.teams.Toggle, pressed = false },
	[KEY_F4] = { func = fMenus.store.Toggle, pressed = false }
}
