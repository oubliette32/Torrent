
if ( CLIENT ) then 

	function TR.BuyItem( m_index )

		net.Start( "CPurchaseRequest" );

		net.WriteString( m_index ); 

		net.SendToServer();

	end

else 

	util.AddNetworkString( "CPurchaseRequest" );

	net.Receive( "CPurchaseRequest", function( len, ply )

		local model = net.ReadString();
		local item = TR.Props[ model ];

		if ( !ply:CanBuild() ) then

			ply:SendMessage( Color( 255, 0, 0, 255 ), "You've reached the prop limit!" );
			return;

		end

		if ( ply:GetMoney() >= item.price && TR.CurState == TR_STATE_BUILD ) then

			ply:TakeMoney( item.price );

			local ent = ents.Create( "torrent_prop" );

			ent:SetModel( model );
			ent:SetPos( ply:GetEyeTrace().HitPos + Vector( 0, 0, ent:OBBCenter():Distance( ent:OBBMaxs() ) ) );
			ent:SetAngles( ply:GetAngles() );
			ent:Spawn();

			ent:SetTHealth( item.health );
			ent:SetTMaxHealth( item.health );

			ent:SetTOwner( ply );

			ply:SetPropCount( ply:GetPropCount() + 1 );

		end

	end);

end

