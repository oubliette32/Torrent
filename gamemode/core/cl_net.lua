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

TR.CurRTime = 0;
TR.CurState = TR_STATE_BUILD

net.Receive( "TorrentTick", function( len )

	TR.CurRTime = net.ReadInt( 32 ); 

end);

net.Receive( "TorrentStateChanged", function( len )

	TR.CurState = net.ReadInt( 32 );

end);

net.Receive( "TorrentCMoneyCache", function( len ) 

	LocalPlayer():SetMoney( net.ReadInt( 32 ) );

end);

net.Receive( "TorrentCCLCache", function( len ) 

	LocalPlayer():SetWins( net.ReadInt( 32 ) );
	LocalPlayer():SetLoses( net.ReadInt( 32 ) );

end);
