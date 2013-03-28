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

 // Working progress.

local panel = {};

function panel:Init()

	self.polyData = {};

	self.triWidth = 15;

end 

function panel:Think()

	self.polyData = {

		[1] = {

			[1] = { x = self.triWidth , y = self:GetTall() - ( self.triWidth * 0.50 ) },
			[2] = { x = 0, y = self:GetTall() },
			[3] = { x = self:GetWide() * 0.50, y = 0 },
			[4] = { x = self:GetWide() * 0.50, y = self.triWidth * 1.5 }

		},
		[2] = {

			[1] = { x = self:GetWide() * 0.50, y = 0 },
			[2] = { x = self:GetWide() * 0.50, y = self.triWidth * 1.5 },
			[3] = { x = self:GetWide() - self.triWidth, y = self:GetTall() - ( self.triWidth * 0.50 ) },
			[4] = { x = self:GetWide(), y = self:GetTall() }

		},
		[3] = {

			[1] = { x = 0, y = self:GetTall() },
			[2] = { x = self.triWidth, y = self:GetTall() - ( self.triWidth * 0.75 ) },
			[3] = { x = self:GetWide() - self.triWidth, y = self:GetTall() - ( self.triWidth * 0.75 ) },
			[4] = { x = self:GetWide(), y = self:GetTall() }

		}

	};

end 

function panel:Paint()

	surface.SetDrawColor( Color( 0, 0, 0, 255 ) );

	surface.DrawOutlinedRect( 0, 0, self:GetWide(), self:GetTall() );

	surface.SetDrawColor( Color( 0, 20, 0, 255 ) );

	for _, data in pairs( self.polyData ) do 

		surface.DrawPoly( data );

	end

end


vgui.Register( "tr_logo", panel, "Panel" )