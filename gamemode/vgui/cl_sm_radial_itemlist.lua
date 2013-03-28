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

local panel = {};

function panel:Init()

	// The current angle of the radial panel
	self.angle = 0;

	// The maximum amount the angle can get to
	self.maxAngle = 0;

	// The current angular inertia of the radial panel
	self.inertia = 0;

	// All of the items that the panel contains
	self.Items = {};

	// All of the catergories
	self.Catergories = {};

	// Currently selected catergory
	self.CurrentCatergory = nil;

	// The function called when the panel has stopped moving
	self.stopFunc = false;

	// A variable used to tell whether the function called when the panel has stopped moving has been called
	self.hasStopped = false;

	// The mode of the panel.  -1 for inwards facing panels 1 for outwards facing panels
	self.mode = true;
	self.mul = 1;

	// This is added into the circular calculations to "stretch" the circle on the X axis
	self.stretch = 0;

	// The speed that the panel is opened and closed at 
	self.stateSpeed = 20;

end 

function panel:SetMode( mode )

	self.mode = mode;
	self.mul = (mode == 1) and 1 or -1;

end

// Hides all items in the current catergory
function panel:HideCatergoryContents()

	for name, panel in pairs( self.Items[ self.CurrentCatergory ] or {} ) do 

		panel:SetVisible( false );

	end

end

function panel:ValidateAngles()

	if ( self.mode ) then 

		if ( self.angle < 0 ) then 

			self.angle = 0;
			self.inertia = 0;

		end 

		if ( self.angle > self.maxAngle ) then 

			self.angle = self.maxAngle;
			self.inertia = 0;

		end

	else 

		if ( self.angle > 0 ) then 

			self.angle = 0;
			self.inertia = 0;

		end 

		if ( self.angle < -self.maxAngle ) then 

			self.angle = -self.maxAngle;
			self.inertia = 0;

		end

	end

end

function panel:Think()

	self:ValidateAngles();

	local i = 0;
	for name, panel in pairs( self.Items[ self.CurrentCatergory ] or {} ) do 

		if ( !ValidPanel( panel ) ) then continue; end

		if ( ( self.mode && ( ( self.angle + i ) >= 0 && ( self.angle + i ) <= 180 ) || !self.mode && ( ( self.angle + i ) <= 0 && ( self.angle + i ) >= -180 ) ) ) then 

			if ( !panel:IsVisible() ) then panel:SetVisible( true ); end
			
 			local x = ( math.sin( ( ( (self.angle + i) ) * math.pi ) / 180 ) ) * ( (ScrW() / 6) - 25 - self.stretch );
 			local y = ( math.cos( ( ( (self.angle + i) ) * math.pi ) / 180 ) ) * ( (ScrH() / 2) - 25 );

			panel:SetPos( ( self.x + x ) - 25, (self.y + y) - 25 );

		else 

			if ( panel:IsVisible() ) then  panel:SetVisible( false ); end

		end

		i = i - ( self.mul * ( 25 ) );


	end

	self:CalcRotate();

end 

function panel:CalcRotate()

	if ( self.isDepressed ) then 

		if ( self.lastY ) then 

			self.inertia = self.inertia + ( self.lastY - gui.MouseY() ) / 20;

		end

		if ( self.lastX ) then 

			self.stretch = self.stretch + ( self.lastX - gui.MouseX() );

		end
	else 

		self.stretch = Lerp( 0.30, self.stretch or 0, 0); 

	end

	// Apply inertial force
	self.angle = self.angle + self.mul * (self.inertia or 0);

	// Decrease inertia
	self.inertia = Lerp( 0.10, self.inertia or 0, self.shouldClose and -10 or 0 ); 


	if ( self.angle <= 0 ) then 

		if ( self.stopFunc && isfunction( self.stopFunc ) && !self.hasStopped ) then 

			self.stopFunc();
			self.hasStopped = true;

			// In every case the panel should stop it's eternal intertia when the panel has reached it's destination
			self.shouldClose = false;

		end

	else 

		self.hasStopped = false;

	end

	// Store last mouse position
	self.lastY = gui.MouseY();
	self.lastX = gui.MouseX();

end 

function panel:Open()

	if ( self.stopFunc ) then return; end

	self.angle = 0;

	// Kick the panel open
	self.inertia = self.stateSpeed;

end

function panel:Close()

	if ( self.stopFunc ) then return; end

	// Keep spinning the panel until it closes
	self.shouldClose = true;

end

function panel:SetStopFunction( func ) 

	self.stopFunc = func;

end

function panel:OnMousePressed( panel, func )
	
	panel.isDepressed = true;
	panel.startClickX, panel.startClickY = gui.MouseX(), gui.MouseY();
	panel.pressedAt = CurTime();

end

function panel:OnMouseReleased( panel, func )

	if ( !panel.pressedAt ) then return; end 

	panel.isDepressed = false;

	if ( panel.inertia && ( panel.inertia < 1 && panel.inertia > -1 ) && ( CurTime() - panel.pressedAt ) < 0.2 ) then 

		if ( func && isfunction(func) ) then 
			func();
		end

	end

end

function panel:AddItem( name, model, info, price, func, cat ) 

	if ( !ValidPanel( self:GetParent() ) ) then return; end

	self.Items[ cat ] = self.Items[ cat ] or {};

	self.Items[ cat ][ name ] = vgui.Create( "DPanel", self:GetParent() );
	self.Items[ cat ][ name ]:SetSize( 50, 50 );
	self.Items[ cat ][ name ].Paint = function( panel )

		local w, h = panel:GetSize();

		if ( self.Items[ "Favourites" ] && self.Items[ "Favourites" ][ name ] ) then 

			surface.SetDrawColor( Color( 255, 255, 0, 255 ) );
			surface.DrawOutlinedRect( 0, 0, w, h );

		elseif ( LocalPlayer():GetMoney() < ( price or 0) ) then 

			surface.SetDrawColor( Color( 255, 0, 0, 255 ) );
			surface.DrawOutlinedRect( 0, 0, w, h );

		else

			surface.SetDrawColor( Color( 0, 255, 0, 255 ) );
			surface.DrawOutlinedRect( 0, 0, w, h );

		end

	end

	self.Items[ cat ][ name ].Icon = vgui.Create( "SpawnIcon", self.Items[ cat ][name] );
	self.Items[ cat ][ name ].Icon:SetModel( model );
	self.Items[ cat ][ name ].Icon:SetPos( 1, 1 );
	self.Items[ cat ][ name ].Icon:SetSize( 48, 48 );
	self.Items[ cat ][ name ].Icon:SetTooltip( info );

	local f_oldP = self.Items[ cat ][ name ].Icon.OnMousePressed;
	local f_oldR = self.Items[ cat ][ name ].Icon.OnMouseReleased;

	local _self = self;

	self.Items[ cat ][ name ].Icon.OnMousePressed = function( panel, t )

		if ( input.IsMouseDown( MOUSE_LEFT ) ) then 

			_self:OnMousePressed(_self,func);
			f_oldP( panel, t );

		elseif ( input.IsMouseDown( MOUSE_RIGHT ) ) then

			local tbl = string.Explode( ",", cookie.GetString( "torrent_prop_favourites" ) or "" ) or {};

			if ( table.HasValue( tbl, model ) ) then 

				local _cookie = "";
				for _, mdl in pairs( tbl ) do 
					if ( mdl == model || mdl == "" ) then continue; end
					_cookie = _cookie .. mdl .. ",";
				end

				if ( self.Items[ "Favourites" ] && self.Items[ "Favourites" ][ name ] ) then 

					self.Items[ "Favourites" ][ name ]:Remove();
					self.Items[ "Favourites" ][ name ] = nil;

				end

				cookie.Set( "torrent_prop_favourites", _cookie );

			else

				cookie.Set( "torrent_prop_favourites", ( cookie.GetString( "torrent_prop_favourites" ) or "" ) .. model .. "," );

				self:AddItem( name, model, info, price, func, "Favourites" ); 

			end

			self:DoLayout();

		end

	end

	self.Items[ cat ][ name ].Icon.OnMouseReleased = function( panel, t )

		_self:OnMouseReleased(_self,func);
		f_oldR( panel, t );

	end

	self.Items[ cat ][ name ]:SetVisible( false );

end

function panel:DoLayout( switch )

	local count = table.Count( self.Catergories ) + 1;
	local height, width = 25, 150;

	local i = 0;

	local amount = 0;

	for name, panel in pairs( self.Catergories ) do

		local lAmount = amount;
		amount = table.Count( self.Items[ name ] or {} );

		if ( amount > lAmount && switch ) then

			self.CurrentCatergory = name;

		end

		panel:SetPos( self.mode and 1 or ScrW() - width - 1, ( (ScrH() / 2) - ( count * height ) ) + i );
		panel:SetSize( width, height );
		panel:SetText( panel:GetName() .. " (".. amount .. ")" )

		i = i + height;

	end

	local cmax = ( table.Count( self.Items[ self.CurrentCatergory ] or {} )-1 ) * 20;
	self.maxAngle = ( cmax > 180 ) and cmax or 180;

end

function panel:AddCat( name )

	if ( self.Catergories[ name ] ) then return; end

	self.Catergories[ name ] = vgui.Create( "DButton", self:GetParent() );

	self.Catergories[ name ]:SetName( name );

	self.Catergories[ name ].DoClick = function( panel )

		self:Close();

		self:SetStopFunction( function()

			// Clean up panels
			self:HideCatergoryContents();

			self.CurrentCatergory = panel:GetName();

			self.angle = 0;

			local cmax = ( ( table.Count( self.Items[ self.CurrentCatergory ] or {} ) ) * 25) + ( self.mul * 1 );
			self.maxAngle = ( cmax > 180 ) and cmax or 180 ;

			self:SetStopFunction( nil );

			self:Open();

		end);

	end

	self.CurrentCatergory = name;

end

vgui.Register( "sm_radial_itemlist", panel, "Panel" )