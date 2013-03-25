
NETWORK_PROTOCOL_PRIVATE = 0x01;
NETWORK_PROTOCOL_PUBLIC  = 0x02;

local meta = debug.getregistry()[ "Entity" ];

meta.network_manager = meta.network_manager or { name = "TorrentNManager", cache = {} };

function meta:GetNVar( name )

	return self.network_manager.cache[ name ];

end

if ( SERVER ) then 

	util.AddNetworkString( meta.network_manager.name .. "AddNetwork" );
	util.AddNetworkString( meta.network_manager.name .. "DataChannel" );

	function meta:SetNVar( name, value, nprot ) 

		self.network_manager.cache[ name ] = value;

		net.Start( meta.network_manager.name .. "DataChannel" );

			net.WriteEntity( self )
			net.WriteString( name );
			net.WriteTable( {value} );

		net[ nprot == NETWORK_PROTOCOL_PUBLIC and "Broadcast" or "Send" ]( self );

	end

	function meta:GetNetworkManager()

		return network_manager;

	end

else 

	net.Receive( meta.network_manager.name .. "DataChannel", function( len ) 

		local ent = net.ReadEntity();
		local name = net.ReadString();
		
		ent.network_manager.cache[ name ] = net.ReadTable()[ 1 ];

	end)

end