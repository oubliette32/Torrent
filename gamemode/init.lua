include( "sh_init.lua" );

AddCSLuaFile( "sh_init.lua" );
AddCSLuaFile( "cl_init.lua" );

TR.CurRTime = GetConVarNumber( TR_TIMES[ TR_STATE_BUILD ] );
TR.CurState = TR_STATE_BUILD;

timer.Create( "serverTick", 1, 0, function()

	if ( #player.GetAll() == 1 ) then 
		TR.CurState = TR_STATE_BUILD;
		TR.CurRTime = GetConVarNumber( TR_TIMES[ TR_STATE_BUILD ] );
		return;
	end

	TR.CurRTime = TR.CurRTime - 1;

	if (TR.CurRTime <= 0) then 

		if (TR.CurState == TR_STATE_RESTART) then 

			TR.CurState = TR_STATE_BUILD;

		else 

			TR.CurState = TR.CurState + 1;

		end

		hook.Call("TorrentStateChange",TR,TR.CurState);

		TR.CurRTime = GetConVarNumber( TR_TIMES[ TR.CurState ] )

	end

	hook.Call("TorrentTick",TR,TR.CurRTime);

end);