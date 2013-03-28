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

local meta = debug.getregistry()[ "Entity" ];

/* * * * * * * * * * * * * * 
	- OTHER
* * * * * * * * * * * * * */

function meta:GetRefundPrice()

	local price = TR.Props[ self:GetModel() ] and TR.Props[ self:GetModel() ].price or 0;
	local hDiff = ( self:GetTMaxHealth() or 0 ) - ( self:GetTHealth() or 0 );
 
	price = price - hDiff;

	return ( price > 0 and price or 0 );

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

	self:SetTHealth( self:GetTHealth() - damage );

	if ( self:GetTHealth() <= 0 ) then 

		self:Remove();

	end

end
