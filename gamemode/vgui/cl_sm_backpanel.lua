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