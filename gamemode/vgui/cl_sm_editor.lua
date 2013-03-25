// Reformatted code from OubHack, c_basepanel

local panel = {};

panel.SelectedEntities = {}

function panel:GetMouseEntity()

	local trace = {};
	trace.start = LocalPlayer():GetShootPos();
	trace.endpos = trace.start + gui.ScreenToVector( gui.MousePos() ) * 3200;
	trace.filter = { LocalPlayer() };

	trace = util.TraceLine( trace );

	return trace.Entity;

end

function panel:Init()

	self.SelectedTool = "none";

	self.tools = {};
	self.functions = {};

	/**********************************************************************************************
	**
	****		MOVE TOOL
	**
	**********************************************************************************************/

	self:AddTool( "Move", nil, nil, function()

		for _, ent in pairs( self.SelectedEntities ) do 

			if ( !ent || !IsValid( ent ) ) then continue; end

			net.Start( "TITS" )

			net.WriteEntity( ent );

			net.SendToServer();

		end


	end, "Used to move all selected props using arrow widgets from the spawnmenu.");

	/**********************************************************************************************
	**
	****		SELECT TOOL
	**
	**********************************************************************************************/

	self:AddTool( "Select", function() 
		
		local ent = self:GetMouseEntity();

		if ( !ent || !IsValid( ent ) || ent:GetTOwner() != LocalPlayer() ) then return; end

		table.Empty( self.SelectedEntities );

	end,
	function()

		local ent = self:GetMouseEntity();

		if ( !ent || !IsValid( ent ) || ent:GetTOwner() != LocalPlayer() ) then return; end

		if ( ( ent.lClick or 0 ) >= CurTime() ) then 

			ent.tClicks = ( ent.tClicks or 1 ) + 1

		else 

			ent.tClicks = 0;
			
		end

		ent.lClick = CurTime() + 0.2;
		
		if ( ( ent.tClicks or 0) == 1 ) then 

			for _, _ent in pairs( ents.FindByClass( "torrent_prop" ) ) do 

				if ( _ent:GetModel() == ent:GetModel() && _ent:GetTOwner() == LocalPlayer() ) then 

					net.Start( "TorrentEntitySelect" );
						net.WriteEntity( _ent );
					net.SendToServer();

				end

			end 

		elseif ( ( ent.tClicks or 0) >= 2 ) then 

			for _, _ent in pairs( ents.FindByClass( "torrent_prop" ) ) do 

				if ( _ent:GetTOwner() == LocalPlayer() ) then 

					net.Start( "TorrentEntitySelect" );
						net.WriteEntity( _ent );
					net.SendToServer();

				end

			end 

		elseif ( !self.SelectedEntities[ ent ] ) then 

			net.Start( "TorrentEntitySelect" );
				net.WriteEntity( ent );
			net.SendToServer();

		else 

			self.SelectedEntities[ ent ] = nil;

		end

	end, nil, "Click on an entity to select / deselect it.  Double click an entity to select all entities of that type.  Triple click to select all entities.  Right click to deselect all entities.");

	/**********************************************************************************************
	**
	****		ROTATE TOOL
	**
	**********************************************************************************************/

	self:AddTool( "Rotate", nil, function()

	end, nil, "Rotate currently selected entities with axis widgets from the spawnmenu.");


	/**********************************************************************************************
	**
	****		WELD FUNCTION
	**
	**********************************************************************************************/

	self:AddFunction( "Weld", function()

		net.Start( "TorrentRequestWeld" );

			net.WriteString( "C" );
			net.WriteTable( table.ClearKeys( self.SelectedEntities ) );

		net.SendToServer();

		table.Empty( self.SelectedEntities );

	end, "Welds all currently selected entities together.");

	/**********************************************************************************************
	**
	****		EXPENSIVE WELD FUNCTION
	**
	**********************************************************************************************/

	self:AddFunction( "Expensive Weld", function()

		net.Start( "TorrentRequestWeld" );

			net.WriteString( "E" );
			net.WriteTable( table.ClearKeys( self.SelectedEntities ) );

		net.SendToServer();

		table.Empty( self.SelectedEntities );

	end, "Welds all currently selected entities together in an expesive manner.  The weld will be stronger and it will use more constraints.");

	/**********************************************************************************************
	**
	****		REMOVE FUNCTION
	**
	**********************************************************************************************/

	self:AddFunction( "Remove", function()

		net.Start( "TorrentRequestRemove" );

			net.WriteTable( table.ClearKeys( self.SelectedEntities ) );

		net.SendToServer();

		table.Empty( self.SelectedEntities );

	end, "Removes all currently selected entities.");

	/**********************************************************************************************
	**
	****		REMOVE ALL FUNCTION
	**
	**********************************************************************************************/

	self:AddFunction( "Remove All", function()

		net.Start( "TorrentRequestCleanup" );
		net.SendToServer();

		table.Empty( self.SelectedEntities );

	end, "Removes all entities.");

	/**********************************************************************************************
	**
	****		REMOVE ALL FUNCTION
	**
	**********************************************************************************************/

	self:AddFunction( "Un-weld", function()

		net.Start( "TorrentRequestUnweld" );

			net.WriteTable( table.ClearKeys( self.SelectedEntities ) );

		net.SendToServer();

		table.Empty( self.SelectedEntities );

	end, "Removes selected entities' welds");

	self.SelectedTool = "Select";

	self:DoLayout()

	/**********************************************************************************************
	**
	****		END OF TOOLS / FUNCTIONS
	**
	**********************************************************************************************/

	self.conCount = vgui.Create( "DButton", self );
	self.conCount.Think = function( panel ) 

		panel:SetText( "Welds : " .. LocalPlayer():GetConstraintCount() .. " / " .. LocalPlayer():MaxConstraints() );

		panel:SetTextColor( LocalPlayer():CanConstrain() and Color( 0, 125, 125, 255 ) or Color( 255, 0, 0, 255 ) );

		self.conCount:SetPos( ( ScrW() / 2 ) - ( self.conCount:GetWide() / 2 ), 140 );

		self.conCount:SizeToContentsX( 10 );

	end; 



end

function panel:AddTool( name, rfunc, lfunc, on_s, text  )

	self.tools[ name ] = { rc_func = rfunc, lc_func = lfunc };
	self.tools[ name ].Button = vgui.Create( "DButton", self );
	self.tools[ name ].Button:SetText( name );
	self.tools[ name ].Button:SetSize( 0, 25 )
	self.tools[ name ].Button:SizeToContentsX( 10 );
	self.tools[ name ].Button:SetVisible( false );
	self.tools[ name ].Button:SetTooltip( text );
	self.tools[ name ].Button.DoClick = function( panel )
 	
 		if ( isfunction(on_s) ) then 

			on_s( panel );

		end

		for name, data in pairs( self.tools ) do data.Button:SetEnabled( true ); end

		self.SelectedTool = panel:GetText();
		panel:SetEnabled( false );

	end

end

function panel:AddFunction( name, func, text )

	self.functions[ name ] = vgui.Create( "DButton", self );
	self.functions[ name ]:SetText( name );
	self.functions[ name ]:SetSize( 0, 25 )
	self.functions[ name ]:SizeToContentsX( 10 );
	self.functions[ name ]:SetVisible( false );
	self.functions[ name ]:SetTooltip( text );
	self.functions[ name ]:SetTextColor( Color( 255, 0, 0, 255 ) );
	self.functions[ name ].DoClick = func;

end


function panel:DoLayout()

	local toolsWidth, functionsWidth = 0, 0;

	for name, data in pairs( self.tools ) do 

		toolsWidth = toolsWidth + data.Button:GetWide();

	end

	for name, panel in pairs( self.functions ) do 

		functionsWidth = functionsWidth + panel:GetWide();

	end

	local i = 0;
	for name, data in pairs( self.tools ) do 

		local xOrigin = ( ScrW() / 2 ) - ( toolsWidth / 2 );

		data.Button:SetPos( xOrigin + i, 115 ); // Y is increased to put it below the timer.
		data.Button:SetVisible( true );

		i = i + data.Button:GetWide();

	end

	i = 0;
	for name, panel in pairs( self.functions ) do 

		local xOrigin = ( ScrW() / 2 ) - ( functionsWidth / 2 );

		panel:SetPos( xOrigin + i, 90 ); // Y is increased to put it below the timer.
		panel:SetVisible( true );

		i = i + panel:GetWide();

	end

	self.tools[ self.SelectedTool ].Button:SetEnabled( false );

end

function panel:OnMousePressed()

	if ( self.SelectedTool == "none") then return; end

	if ( input.IsMouseDown( MOUSE_LEFT ) ) then

		if  ( self.tools[ self.SelectedTool ] && isfunction( self.tools[ self.SelectedTool ].lc_func ) ) then 

			self.tools[ self.SelectedTool ].lc_func();

		end

	elseif ( input.IsMouseDown( MOUSE_RIGHT ) ) then 

		if  ( self.tools[ self.SelectedTool ] && isfunction( self.tools[ self.SelectedTool ].rc_func ) ) then 

			self.tools[ self.SelectedTool ].rc_func();

		end

	end

end

net.Receive( "TorrentEntitySelectCB", function( len ) 

	local ent = net.ReadEntity();
 
	panel.SelectedEntities[ ent ] = ent;

end);

vgui.Register( "sm_editor", panel, "Panel" )