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

/*
	This file is pretty much is just net messages sent from the client
	To the server regarding editor functions, such as welding, moving
	rotating, un-welding, removing, etc
*/


util.AddNetworkString( "TorrentRequestWeld" );
util.AddNetworkString( "TorrentEntitySelect" );
util.AddNetworkString( "TorrentEntitySelectCB" );
util.AddNetworkString( "TorrentRequestRemove" );
util.AddNetworkString( "TorrentRequestCleanup" );
util.AddNetworkString( "TorrentRequestUnweld" );

/*********************************************************************************
****** Name : TorrentRequestWeld
**
****  contains a string either E or C representing expensive
**** Or cheap welds and a table of entities that the client wants to weld together
**** This will also send a chat-message back to the client telling them how many
**** Welds were successful and how many failed.
**
**********************************************************************************/

net.Receive( "TorrentRequestWeld", function( len, ply )

	local weld = net.ReadString();
	local entities = net.ReadTable();

	local failedWelds, succesfulWelds = 0, 0;
	local reachedLimit = false;

	if ( #entities > 1 ) then 

		local target = entities[1];

		if ( !ply:CanInteract( target ) ) then return; end

		for i = 1, #entities do 

			if ( weld == "E" ) then

				for j = i + 1, #entities do 

					if ( !IsValid( entities[ i ] ) && !ply:CanInteract( entities[ i ] ) ) then continue; end
					if ( !IsValid( entities[ j ] ) && !ply:CanInteract( entities[ j ] ) ) then continue; end

					local cons = ply:CanConstrain() and constraint.Weld( entities[ i ], entities[ j ], 0, 0, 0, true ) or false;

					if ( cons ) then 

						succesfulWelds = succesfulWelds + 1;

						ply:SetConstraintCount( ply:GetConstraintCount() + 1 );

					else failedWelds = failedWelds + 1; end

				end

			else

				if ( entities[ i ] == target ) then continue; end
				if ( !IsValid( entities[ i ] ) && ply:CanInteract( entities[ i ] ) ) then continue; end

				local cons = ply:CanConstrain() and constraint.Weld( entities[ i ], target, 0, 0, 0, true ) or false;

				if ( cons ) then 

					succesfulWelds = succesfulWelds + 1;

					ply:SetConstraintCount( ply:GetConstraintCount() + 1 );

				else failedWelds = failedWelds + 1; end

			end

		end 

	end 

	// There's no case that there's no successful or failed welds and that we want to tell them that.

	if ( succesfulWelds > 0 && failedWelds > 0 ) then 

		ply:SendMessage( Color( 0, 255, 0, 255 ), succesfulWelds .. " constraints added, ", Color( 255, 0, 0, 255 ), failedWelds .. " constraints failed" );

	elseif ( succesfulWelds == 0 && failedWelds > 0 ) then 

		ply:SendMessage( Color( 255, 0, 0, 255 ), failedWelds .. " constraints failed" );

	elseif ( failedWelds == 0 && succesfulWelds > 0 ) then

		ply:SendMessage( Color( 0, 255, 0, 255 ), succesfulWelds .. " constraints added" );

	end

end);

/*********************************************************************************
****** Name : TorrentEntitySelect
**
**** Contains one entity that the client wants to select, this sends back a table
**** Of selected entities to the client, this happens because only the server has
**** Access to the welds table that is needed when selecting groups, which is done
**** By default from the editor menu. 
**
**********************************************************************************/

net.Receive( "TorrentEntitySelect", function( len, ply )

	local ent = net.ReadEntity();

	net.Start( "TorrentEntitySelectCB" );

		net.WriteEntity( ent );

	net.Send( ply );

	for _, e in pairs( constraint.GetAllConstrainedEntities( ent ) or {} ) do 

		if ( e && IsValid( e ) && e != ent ) then

			net.Start( "TorrentEntitySelectCB" );

				net.WriteEntity( e );

			net.Send( ply );

		end

	end 

end);

/*********************************************************************************
****** Name : TorrentRequestCleanup
**
**** Simply removes all entities that the sender owns, no data is sent in this net
**** Message.
**
**********************************************************************************/

net.Receive( "TorrentRequestCleanup", function( len, ply )

	local props, refund = ply:RefundProps();

	ply:SendMessage( Color( 255, 255, 255, 255 ), "Props were refunded $", Color( 0, 255, 0, 255), refund, Color( 255, 255, 255, 255 ), " (" .. props .. " props)" );

end);

/*********************************************************************************
****** Name : TorrentRequestRemove
**
**** Attempts to remove a table of entities sent from the client, it will only remove
**** Entities owned by the sender for safety reasons.
**
**********************************************************************************/

net.Receive( "TorrentRequestRemove", function( len, ply )

	local entities = net.ReadTable();

	local props, refund = 0, 0;

	for _, ent in pairs( entities ) do 

		if ( ent && IsValid( ent ) && ply:CanInteract( ent ) ) then 

			props = props + 1;

			refund = refund + ent:GetRefundPrice();

			ent:EnterRefundPhase( function() ply:AddMoney( ent:GetRefundPrice() ) end );

		end

	end

	ply:SendMessage( Color( 255, 255, 255, 255 ), "Props were refunded $", Color( 0, 255, 0, 255), refund, Color( 255, 255, 255, 255 ), " (" .. props .. " props)" );

end);

/*********************************************************************************
****** Name : TorrentRequestUnweld
**
**** Attempts to remove all welds associated with a table of entities sent from the 
**** Client.
**
**********************************************************************************/

net.Receive( "TorrentRequestUnweld", function( len, ply )

	local entities = net.ReadTable();
	local props = 0;

	for _, ent in pairs( entities ) do 

		if ( ent && IsValid( ent ) && ent:GetTOwner() == ply ) then 

			for _, weld in pairs( constraint.FindConstraints( ent, "Weld" ) ) do 

				local owner = weld.Ent1 and weld.Ent1:GetTOwner() or ( weld.Ent2 and weld.Ent2:GetTOwner() or false );

				// Welds should never been owned by someone that doesn't own the prop the weld is latched too.
				if ( owner && IsValid( owner ) && owner == ply ) then 

					props = props + 0.5; // There's two constraints for every prop

					weld.Constraint:Remove();

				end

			end

		end

	end

	ply:SendMessage( Color( 0, 255, 0, 255 ), props, Color( 255, 255, 255, 255 ), " constraints removed!");

end);
