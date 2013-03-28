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

TR.SpawnMenu = {};
TR.SpawnMenu.Open = false;

function TR.SpawnMenu.Create()

	TR.SpawnMenu.BackPanel = vgui.Create( "sm_editor" );
	TR.SpawnMenu.BackPanel:SetPos( 0, 0 );
	TR.SpawnMenu.BackPanel:SetSize( ScrW(), ScrH() );
	TR.SpawnMenu.BackPanel:SetVisible( false );
	TR.SpawnMenu.BackPanel.Paint = function() end;
	TR.SpawnMenu.BackPanel.Think = function() end;

	TR.SpawnMenu.PropList = vgui.Create( "sm_radial_itemlist", TR.SpawnMenu.BackPanel );
	TR.SpawnMenu.PropList:SetPos( 25, ScrH() / 2 );

	TR.SpawnMenu.EntityList = vgui.Create( "sm_radial_itemlist", TR.SpawnMenu.BackPanel );
	TR.SpawnMenu.EntityList:SetPos( ScrW() - 25, ScrH() / 2 );
	TR.SpawnMenu.EntityList:SetMode( false );

	for model, data in pairs( TR.Props ) do 

		TR.SpawnMenu.PropList:AddCat( data.cat );
		TR.SpawnMenu.PropList:AddItem( model, model, "price : " .. data.price .. "\nhealth : " .. data.health .. "\nmodel : " .. model, data.price, function() TR.BuyItem( model ); end, data.cat);

	end

	for model, data in pairs( TR.Entities ) do 

		TR.SpawnMenu.EntityList:AddCat( data.cat );
		TR.SpawnMenu.EntityList:AddItem( model, model, "price : " .. data.price .. "\nhealth : " .. data.health .. "\nmodel : " .. model, data.price, function() TR.BuyItem( model ); end, data.cat);

	end

	// Construct prop favourite catergories

	TR.SpawnMenu.PropList:AddCat("Favourites");

	for _, model in pairs( string.Explode( ",", cookie.GetString("torrent_prop_favourites") or "" ) or {} ) do

		if ( !TR.Props[ model ] ) then continue; end

		local data = TR.Props[ model ];

		TR.SpawnMenu.PropList:AddItem( model, model, "price : " .. data.price .. "\nhealth : " .. data.health .. "\nmodel : " .. model, data.price, function() TR.BuyItem( model ); end, "Favourites" );

	end

	TR.SpawnMenu.PropList:DoLayout( true );
	TR.SpawnMenu.EntityList:DoLayout( true );

end

hook.Add( "OnSpawnMenuOpen", "OSMO", function()

	if ( !TR.SpawnMenu.BackPanel ) then 

		TR.SpawnMenu.Create();

	end

	if ( !TR.SpawnMenu.BackPanel:IsVisible() ) then

		TR.SpawnMenu.BackPanel:SetVisible( true );

		TR.SpawnMenu.PropList:Open();
		TR.SpawnMenu.EntityList:Open();

		TR.SpawnMenu.Open = true;

		gui.EnableScreenClicker(true);

	else 

		TR.SpawnMenu.Open = false;

		TR.SpawnMenu.PropList:Close();
		TR.SpawnMenu.EntityList:Close();

		TR.SpawnMenu.PropList:SetStopFunction( function()

			TR.SpawnMenu.BackPanel:SetVisible( false );
			TR.SpawnMenu.PropList:SetStopFunction(nil);
			TR.SpawnMenu.Open = false;

		end);

		gui.EnableScreenClicker(false);

	end

end)
