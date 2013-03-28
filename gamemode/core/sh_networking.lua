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

NETWORK_PROTOCOL_PRIVATE = 0x01;
NETWORK_PROTOCOL_PUBLIC  = 0x02;

TR.network_manager = TR.network_manager or { cache = {}, name = "TorrentNManager" };

local meta = debug.getregistry()[ "Entity" ];

function meta:GetNVar( name )

	return TR.network_manager[ self:EntIndex() ] and ( TR.network_manager[ self:EntIndex() ][ name ] or false ) or false;

end

if ( SERVER ) then 

	util.AddNetworkString( TR.network_manager.name .. "AddNetwork" );
	util.AddNetworkString( TR.network_manager.name .. "DataChannel" );

	function meta:SetNVar( name, value, nprot ) 

		TR.network_manager[ self:EntIndex() ] = TR.network_manager[ self:EntIndex() ] or {};

		TR.network_manager[ self:EntIndex() ][ name ] = value;

		net.Start( TR.network_manager.name .. "DataChannel" );

			net.WriteInt( self:EntIndex(), 32 );
			net.WriteString( name );
			net.WriteTable( {value} );

		net[ nprot == NETWORK_PROTOCOL_PUBLIC and "Broadcast" or "Send" ]( self );

	end

	function meta:GetNetworkManager()

		return TR.network_manager;

	end

else 

	net.Receive( TR.network_manager.name .. "DataChannel", function( len ) 

		local index = net.ReadInt( 32 );
		local name = net.ReadString();
		
		TR.network_manager[ index ] = TR.network_manager[ index ] or {};

		TR.network_manager[ index ][ name ] = net.ReadTable()[ 1 ];

	end)

end