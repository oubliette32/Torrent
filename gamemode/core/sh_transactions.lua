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

