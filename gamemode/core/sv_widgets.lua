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