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