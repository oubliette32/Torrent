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

util.AddNetworkString("TorrentTick");
util.AddNetworkString("TorrentStateChanged");

/* * * * * * * * * * * * * * 
	- STATE HOOKS
 * * * * * * * * * * * * * */

hook.Add( "TorrentStateChange", "TSC", function( state )

	if ( state == TR_STATE_BUILD ) then 
		hook.Call("TorrentStateBuild",TR);
	elseif ( state == TR_STATE_MOUNT ) then 
		hook.Call("TorrentStateMount",TR);
	elseif ( state == TR_STATE_FIGHT ) then 
		hook.Call("TorrentStateFight",TR);
	elseif ( state == TR_STATE_RESTART ) then
		hook.Call("TorrentStateRestart",TR);
	end

	net.Start( "TorrentStateChanged" );

	net.WriteInt( state, 32 );

	net.Broadcast();

end);

hook.Add( "TorrentStateBuild", "TSB", function()

	for _, ply in pairs( player.GetAll() ) do 

		// Spawn players

		if ( ply:Team() == TEAM_SPECTATOR || ply:Team() == TEAM_DEAD ) then 

			ply:UnSpectate();
			ply:Spawn();
			ply:SetTeam(TEAM_ALIVE);

		end 

		// Give weapons

		ply:StripWeapons();

		ply:GiveAllWeapons( TR_WEAPONS_BUILD );

		// Reset Health

		ply:SetHealth( ply:GetMaxHealth() );

	end

	for _, ent in pairs( ents.FindByClass( "trigger_teleport" ) ) do 

		ent:Fire( "Enable" );

	end

end);

hook.Add( "TorrentStateMount", "TSM", function()

		for _, ply in pairs( player.GetAll() ) do 

			// Strip weapons

			ply:StripWeapons();

		end

end);

hook.Add( "TorrentStateFight", "TSF", function()

	// Unfreeze props 

	for _, ent in pairs( ents.FindByClass( "torrent_prop" ) ) do 

		if ( ent && IsValid( ent ) ) then 

			ent:GetPhysicsObject():EnableMotion( true );
			ent:GetPhysicsObject():Wake();

		end

	end

	for _, ply in pairs( player.GetAll() ) do 

		// Give fighting weapons

		ply:GiveAllWeapons( ply:GetPurchasedWeapons() );

		ply:GiveAmmo( 5000, "9m" );
		ply:GiveAmmo( 5000, "5.56m NATO" );

	end

	// Raise water, disable teleporters, break glass

	local fireTable = {
		["func_water_analog"] = "Open",
		["trigger_teleport"] = "Disable",
		["func_breakable"] = "Break"
	}

	for class, action in pairs( fireTable ) do 

		for _, ent in pairs( ents.FindByClass( class ) ) do 

			ent:Fire( action );

		end

	end

end);

hook.Add( "TorrentStateRestart", "TSR", function()

	local aCount = 0;

	for _, ply in pairs( player.GetAll() ) do 
		if ( ply:Team() == TEAM_ALIVE ) then 

			aCount = aCount + 1;

		else 

			ply:AddLoss();

		end
	end

	for _, ply in pairs( player.GetAll() ) do 

		if ( ply:Team() != TEAM_ALIVE ) then continue; end

		// Strip weapons

		ply:StripWeapons();

		// Reward money 

		local per = math.random( 250, 500 );
		local amount = (per * (#player.GetAll())) / aCount;

		if (aCount > 1) then 
			ply:SendMessage( Color( 255, 255, 255, 255 ), "You were awarded $", Color( 0, 255, 0, 255), amount, Color( 255, 255, 255, 255 ), "! (" .. per .. " x " .. #player.GetAll() .. " / " .. aCount .. ")" );
		else
			ply:SendMessage( Color( 255, 255, 255, 255 ), "You were awarded $", Color( 0, 255, 0, 255), amount, Color( 255, 255, 255, 255 ), "! (" .. per .. " x " .. #player.GetAll() .. ")" );
		end

		ply:AddMoney( amount ); 
		ply:AddWin();

		// Refund props

		local tProps, tRefund = ply:RefundProps();

		ply:SendMessage( Color( 255, 255, 255, 255 ), "Props were refunded $", Color( 0, 255, 0, 255), tRefund, Color( 255, 255, 255, 255 ), " (" .. tProps .. " props)" );
		
	end

	// Lower water

	local fireTable = {
		["func_water_analog"] = "Close"
	}

	for class, action in pairs( fireTable ) do 

		for _, ent in pairs( ents.FindByClass( class ) ) do 

			ent:Fire( action );

		end

	end

end);

/* * * * * * * * * * * * * * 
	- OTHER TORRENT HOOKS
 * * * * * * * * * * * * * */

hook.Add( "TorrentTick", "TSB", function( time )

	net.Start( "TorrentTick" );

	net.WriteInt( time, 32 );

	net.Broadcast();

	if ( #team.GetPlayers(TEAM_ALIVE) <= 1 && TR.CurState == TR_STATE_FIGHT ) then 

		TR.CurRTime = 0;

	end

end);

/* * * * * * * * * * * * * * 
	- SERVER HOOKS
 * * * * * * * * * * * * * */

hook.Add( "Initialize", "Init", function()

	if ( !sql.TableExists( "TorrentPD" ) ) then 

		sql.Begin();

		sql.Query( [[CREATE TABLE `TorrentPD` (
	  		`SID` VARCHAR(30),
	 		`PurchasedWeapons` VARCHAR(255),
	  		`Money` INT,
	  		`Wins` INT,
	  		`Loses` INT
		);]] );

		sql.Commit();

	end

end);

/* * * * * * * * * * * * * * 
	- PLAYER HOOKS
 * * * * * * * * * * * * * */

hook.Add( "PlayerSpawn", "PS", function( ply )

	if ( TR.CurState == TR_STATE_BUILD || TR.CurState == TR_STATE_MOUNT ) then 

		// Give weapons

		ply:GiveAllWeapons( TR_WEAPONS_BUILD );
		ply:SetTeam(TEAM_ALIVE);

	else 

		// Enter spectate mode

		ply:Spectate( OBS_MODE_IN_EYE );
		ply:SetTeam( TEAM_SPECTATOR );

	end

end);

hook.Add( "PlayerDeath", "PD", function( ply ) 

	if ( TR.CurState != TR_STATE_BUILD ) then

		ply:SetTeam(TEAM_DEAD);

		// Prop clean-up

		local tProps, tRefund = ply:RefundProps();

		ply:SendMessage( Color( 255, 255, 255, 255 ), "Props were refunded $", Color( 0, 255, 0, 255), tRefund, Color( 255, 255, 255, 255 ), " (" .. tProps .. " props)" );

	end

end);

hook.Add( "PlayerInitialSpawn", "PIS", function( ply ) 

	// Set up networked variables

	timer.Simple( 2, function()

		ply:CacheClientMoney();
		ply:CacheClientWeapons();
		ply:CacheClientWL();

	end);

	if (ply:HasSQLRow()) then return; end

	sql.Begin();

	sql.Query("INSERT INTO `TorrentPD` VALUES('" .. ply:SteamID() .. "','torrent_weapon_fiveseven', '" .. GetConVarNumber( "tr_startingmoney" ) .. "',0,0);");

	sql.Commit();

end);

hook.Add( "PlayerShouldTakeDamage", "PSTD", function( ent, inflictor )

	if ( TR.CurState != TR_STATE_FIGHT ) then 

		return false;

	else 

		return inflictor and ( inflictor:GetClass() == "trigger_hurt"  or inflictor:GetClass() == "torrent_prop" ) or false;

	end 

end);

/* * * * * * * * * * * * * * 
	- ENTITY HOOKS
 * * * * * * * * * * * * * */

// Not using this hook was causing problems
hook.Add( "EntityTakeDamage", "ETD", function( ent, dmginfo ) 

	if ( ent:IsPlayer() || ( ent:GetClass() == "torrent_prop" && TR.CurState != TR_STATE_FIGHT ) ) then 

		return false;

	end

	if ( ent:IsPlayer() && IsValid( dmginfo:GetAttacker() ) && dmginfo:GetAttacker():IsPlayer() ) then

		return false;

	end

	if ( IsValid( dmginfo:GetAttacker() ) && dmginfo:GetAttacker():IsPlayer() && ent:CanDamage() ) then 

		ent:DealDamage( dmginfo:GetDamage() );

		dmginfo:GetAttacker():AddMoney( dmginfo:GetDamage() );

		TR.DrawHitNote( dmginfo:GetAttacker(), dmginfo:GetDamagePosition(), dmginfo:GetDamage() );

	end

end);

/* * * * * * * * * * * * * * 
	- OTHER HOOKS
 * * * * * * * * * * * * * */

hook.Add( "PhysgunPickup", "PP", function( ply, ent ) 

	return ply:CanInteract( ent );

end);

hook.Add( "EntityRemoved", "ER", function( ent ) 

	if ( ent:GetClass() == "torrent_prop" ) then 

		local ply = ent:GetTOwner();

		if ( ply && IsValid( ply ) && ply:IsPlayer() ) then ply:SetPropCount( ply:GetPropCount() - 1 ); end

	elseif ( ent:GetClass() == "phys_constraint" ) then

		local ply = ent.Ent1 and ent.Ent1:GetTOwner() or ( ent.Ent2 and ent.Ent2:GetTOwner() or false );

		if ( ply && IsValid( ply ) && ply:IsPlayer() ) then ply:SetConstraintCount( ply:GetConstraintCount() - 1 ); end

	end

end);

