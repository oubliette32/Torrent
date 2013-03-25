local meta = debug.getregistry()[ "Entity" ];

/* * * * * * * * * * * * * * 
	- OTHER
* * * * * * * * * * * * * */

function meta:GetRefundPrice()

	local price = TR.Props[ self:GetModel() ] and TR.Props[ self:GetModel() ].price or 0;
	local hDiff = ( self.MaxHealth or 0 ) - ( self.EHealth or 0);

	price = price - hDiff;

	return price > 0 and price or 0;

end

function meta:EnterRefundPhase( func )

	local time = math.random( 1, 3.5 );

	self:Ignite( time );

	timer.Simple( time, function()

		self:Remove();
		if ( func && isfunction( func ) ) then func(); end

	end);

end

/* * * * * * * * * * * * * * 
	- HEALTH / DAMAGE
* * * * * * * * * * * * * */

function meta:CanDamage()

	return tobool( self:GetTHealth() );

end

function meta:DealDamage( damage )

	if ( !self:CanDamage() ) then return; end

	self:SetHealth( self:GetTHealth() - damage );

	if ( self:GetTHealth() <= 0 ) then 

		self:Remove();

	end

end
