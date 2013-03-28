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

// Reformatted code from OubHack, c_basepanel

local panel = {};

local function compLHB(a,b) return (a==math.ceil(b)) or (a==math.floor(b)); end

function panel:Init()

	self.reqx, self.reqy, self.reqw, self.reqh = 0, 0, 0, 0;

end 

function panel:Think() -- Linear Movement.
	if (!self.sw or !self.sh) or ( !compLHB(self.reqw,self.sw) or !compLHB(self.reqh,self.sh) ) then 
		self.sw = Lerp(0.10,self.sw or self:GetWide(),self.reqw);
		self.sh = Lerp(0.10,self.sh or self:GetTall(),self.reqh);
		self:SetSize(self.sw,self.sh);
	else 
		if self.SizeCBFunction then self.SizeCBFunction(); end 
	end 
	if (!self.sx or !self.sy) or (!compLHB(self.reqx,self.sx) or !compLHB(self.reqy,self.sy)) then 
		self.sx = Lerp(0.10,self.sx or self.x,self.reqx);
		self.sy = Lerp(0.10,self.sy or self.y,self.reqy);
		self:SetPos(self.sx,self.sy);
	else
		if self.PosCBFunction then self.PosCBFunction(); end 
	end
end 

function panel:RequestPos( x, y )

	self.reqx, self.reqy = x or 0, y or 0;

end 

function panel:RequestSize( w, h )

	self.reqw, self.reqh = w or 0, h or 0;

end 

function panel:SetCBPosFunction( func )

	self.PosCBFunction = func;

end 

function panel:SetCBSizeFunction( func )

	self.SizeCBFunction = func;

end

function panel:Paint()

end 

vgui.Register( "sp_backpanel", panel, "Panel" )