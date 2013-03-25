TR = {};
TR.Author = "Oubliette";
TR.Contact = "http://facepunch.com/member.php?u=469591";
TR.Name = "Torrent";
TR.Descrpition = "Torrent - A Garry's Mod 13 Flood make-over";

TEAM_ALIVE = 2;
TEAM_DEAD = 1;

team.SetUp( "Dead", TEAM_DEAD, Color(0,0,0,255) );
team.SetUp( "Alive", TEAM_ALIVE, Color(0,255,0,255) );

// Automated inclusion

local function aInclude( files, folder )

	for k,v in pairs( files ) do 

		local p = string.Left( v, 2 );

		if ( p == "sh" ) then 
			if ( SERVER ) then AddCSLuaFile( folder .. "/" .. v ); end
			include( folder .. "/" .. v );
			MsgN(folder .. "/" .. v .. " loaded!");
		elseif ( p == "sv" ) then 
			if ( SERVER ) then 
				include( folder .. "/" .. v );
				MsgN(folder .. "/" .. v .. " loaded!");
			end
		elseif ( p == "cl" ) then 
			if ( SERVER ) then 
				AddCSLuaFile( folder .. "/" .. v );
			else 
				include( folder .. "/" .. v );
				MsgN(folder .. "/" .. v .. " loaded!");
			end
		else 
			ErrorNoHalt( "Unknown prefix '" .. tostring( p ) .. "'\n" );
		end

	end

end

aInclude( file.Find( "torrent/gamemode/configs/*", "LUA" ), "configs" );
aInclude( file.Find( "torrent/gamemode/vgui/*", "LUA" ), "vgui" );
aInclude( file.Find( "torrent/gamemode/core/*", "LUA" ), "core" );
aInclude( file.Find( "torrent/gamemode/util/*", "LUA" ), "util" );