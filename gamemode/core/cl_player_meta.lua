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

local meta = debug.getregistry()[ "Player" ];

/* * * * * * * * * * * * * * 
	- MONEY
 * * * * * * * * * * * * * */

function meta:GetMoney()

	return self:GetNVar( "Money" ) or 0;

end

function meta:GetSpentMoney()

	local money = 0;

	for _, ent in pairs( ents.FindByClass( "torrent_prop" ) ) do 

		if ( ent:GetTOwner() == LocalPlayer() ) then 

			money = money + ent:GetRefundPrice();

		end

	end

	return money;

end

/* * * * * * * * * * * * * * 
	- WINS / LOSES
 * * * * * * * * * * * * * */

function meta:GetWins()

	return self:GetNVar( "Wins" ) or 0;

end

function meta:GetLoses()

	return self:GetNVar( "Loses" ) or 0;

end

/* * * * * * * * * * * * * * 
	- OTHER
* * * * * * * * * * * * * */

function meta:SendMessage( ... )
	
	local arg = { ... };

	chat.AddText( Color( 0, 0, 255, 255 ), "[", Color( 65, 65, 175, 175 ), "TORRENT", Color( 0, 0, 255, 255 ), "] ", Color( 255, 255, 255, 255 ), unpack( arg ) );

end
