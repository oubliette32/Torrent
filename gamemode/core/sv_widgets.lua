util.AddNetworkString("TITS");
util.AddNetworkString("TorrentStateChanged");

net.Receive( "TITS", function( len, ply  )

	local ent = net.ReadEntity();

	ent.axis = ents.Create( "widget_torrent_move" );
	ent.axis:Setup( ent, nil, false, 100 );
	ent.axis:Spawn();
	ent.axis:SetNWFloat( "Priority", 0.5 );
	ent.axis:InvalidateSize();
	ent:DeleteOnRemove( ent.axis );

end);

net.Receive( "TorrentRequestAxisWidget", function( len, ply  )

end);