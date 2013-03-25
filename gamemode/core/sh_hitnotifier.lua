
if ( CLIENT ) then 

	local hN = {}

	hN.Text = {};

	function hN.AddText( vec, dmg )

		local oX = math.random( -5, 5 );
		local oY = oX;
		local oZ = math.random( 25, 50 ); 

		local pos = vec + Vector( oX, oY, oZ );

		hN.Text[ #hN.Text + 1 ] = { text = (dmg > 0) and "+" .. dmg or dmg, pos = vec, tpos = pos, col = Color( (dmg > 0) and 255 or 0, (dmg < 0) and 255 or 0, 0, 255 ) };

	end

	function hN.Draw()

		cam.Start3D();

			cam.IgnoreZ(true);

			for k, data in pairs( hN.Text ) do 

				local ang = LocalPlayer():EyeAngles()
				local pos = data.pos + ang:Up()
			 
				ang:RotateAroundAxis( ang:Forward(), 90 )
				ang:RotateAroundAxis( ang:Right(), 90 )

				cam.Start3D2D( data.pos, Angle( 0, ang.y, 90 ), 1 );

					cam.IgnoreZ(true);



					draw.SimpleText( data.text, "default", 2 , 2, data.col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

					local xDif = math.abs( math.max( data.pos.x, data.tpos.x ) - math.min( data.pos.x, data.tpos.x ) );
					local yDif = math.abs( math.max( data.pos.y, data.tpos.y ) - math.min( data.pos.y, data.tpos.y ) );
					local zDif = math.abs( math.max( data.pos.z, data.tpos.z ) - math.min( data.pos.z, data.tpos.z ) );

					if ( xDif <= 1 && yDif <= 1 && zDif <= 1 ) then 

						data.col.a = Lerp( 0.10, data.col.a, 0 );

						if ( data.col.a <= 1 ) then 

							table.remove( hN.Text, k );

						end

					else 

						data.pos = LerpVector( 0.04, data.pos, data.tpos );

					end

					cam.IgnoreZ(false);

				cam.End3D2D();

			end

			cam.IgnoreZ(false);

		cam.End3D();

	end

	hook.Add( "PostDrawOpaqueRenderables", "DN", hN.Draw ); 

	net.Receive( "CHitNote", function( len )

		hN.AddText( net.ReadVector(), net.ReadInt( 32 ) );

	end);


else

	util.AddNetworkString( "CHitNote" );

	function TR.DrawHitNote( ply, pos, dmg )

		net.Start( "CHitNote" );

		net.WriteVector( pos );
		net.WriteInt( dmg, 32 ) 

		net.Send( ply );

	end

end
