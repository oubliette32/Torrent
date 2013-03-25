util.AddNetworkString("TorrentCMoneyCache");
util.AddNetworkString("TorrentCWeaponsCache");
util.AddNetworkString("TorrentCCLCache");

local meta = debug.getregistry()[ "Player" ];

 /* * * * * * * * * * * * * * 
	- SQL
 * * * * * * * * * * * * * */

function meta:SQLSet( name, var )

	sql.Begin();

	sql.Query( "UPDATE `TorrentPD` SET `" .. name .. "`='" .. var .. "' WHERE `SID`='" .. self:SteamID() .. "';" );

	sql.Commit();

end

function meta:SQLGet( name, format_func )

	sql.Begin();

	local res = sql.Query( "SELECT `" .. name .. "` FROM `TorrentPD` WHERE `SID` = '" .. self:SteamID() .. "';" );

	sql.Commit();

	if ( istable( res ) ) then 

		return format_func( res[1][ name ] ) or false;

	end 

end

/* * * * * * * * * * * * * * 
	- WEAPONS
 * * * * * * * * * * * * * */

function meta:GiveAllWeapons( tbl ) 

	for _, wep in pairs( tbl ) do 

		self:Give( wep );

	end 

end

function meta:AddPurchasedWeapon( wep )

	local newWeps = "";

	for _, wep in pairs( self:GetPurchasedWeapons() ) do 
		newWeps = newWeps .. wep .. ",";
	end

	newWeps = newWeps .. wep

	self:SQLSet( "PurchasedWeapons", newWeps );

	self:CacheClientWeapons();

end

function meta:RemovePurchasedWeapon( rwep )

	local newWeps = "";

	for _, wep in pairs( self:GetPurchasedWeapons() ) do 
		if (wep == rwep) then continue; end
		newWeps = newWeps .. wep .. ",";
	end

	newWeps = newWeps:sub( 1, newWeps:len() );

	self:SQLSet( "PurchasedWeapons", newWeps );

	self:CacheClientWeapons();

end

function meta:GetPurchasedWeaponsData()

	return self:SQLGet( "PurchasedWeapons", tostring ) or "";

end

function meta:GetPurchasedWeapons()

	local res = string.Explode( "," , self:GetPurchasedWeaponsData() );

	return res;

end

function meta:CacheClientWeapons()

	self:SetNVar( "PurchasedWeapons", self:GetPurchasedWeapons(), NETWORK_PROTOCOL_PRIVATE );

end

/* * * * * * * * * * * * * * 
	- MONEY
 * * * * * * * * * * * * * */

function meta:CacheClientMoney()

	self:SetNVar( "Money", self:GetMoney(), NETWORK_PROTOCOL_PUBLIC );

end

function meta:AddMoney( money )

	self:SQLSet( "Money", self:GetMoney() + money );

	self:CacheClientMoney();

end 

function meta:TakeMoney( money )

	self:SQLSet( "Money", self:GetMoney() - money );

	self:CacheClientMoney();

end

function meta:SetMoney( money )

	self:SQLSet( "Money", money );

	self:CacheClientMoney();

end

function meta:GetMoney()

	return self:SQLGet( "Money", tonumber ) or 0; 

end

/* * * * * * * * * * * * * * 
	- WINS / LOSES
 * * * * * * * * * * * * * */

function meta:CacheClientWL()

	self:SetNVar( "Wins", self:GetWins(), NETWORK_PROTOCOL_PUBLIC );
	self:SetNVar( "Loses", self:GetWins(), NETWORK_PROTOCOL_PUBLIC );

end

function meta:AddWin()

	self:SQLSet( "Wins", self:GetWins() + 1 );

	self:CacheClientWL();

end 

function meta:AddLoss()

	self:SQLSet( "Loses", self:GetLoses() - 1 );

	self:CacheClientWL();

end 

function meta:SetWins( wins )

	self:SQLSet( "Wins", wins );

	self:CacheClientWL();

end 

function meta:SetLoses( loses )

	self:SQLSet( "Loses", wins );

	self:CacheClientWL();

end 

function meta:GetWins()

	return self:SQLGet( "Wins", tonumber ) or 0;

end

function meta:GetLoses()

	return self:SQLGet( "Loses", tonumber ) or 0;

end

 /* * * * * * * * * * * * * * 
	- OTHER
 * * * * * * * * * * * * * */

function meta:SendMessage( ... )
	
	local arg, str = { ... }, "";

	for _, obj in pairs(arg) do

		if ( istable( obj ) ) then 
			str = str .. "Color(" .. obj.r .. "," .. obj.g .. "," .. obj.b .. "," .. obj.a .. "),";
		else 
			str = str .. [["]] .. obj .. [[",]];
		end

	end

	str = str:sub( 1, str:len()-1 );

	self:SendLua( "LocalPlayer():SendMessage(" .. str .. ")" );

end

function meta:RefundProps()

	local tProps, tRefund = 0,0;

	for _, ent in pairs( ents.FindByClass( "torrent_prop" ) ) do 

		if ( ent:GetTOwner() == self ) then 

			tProps = tProps + 1;

			tRefund = tRefund + ent:GetRefundPrice();

			ent:EnterRefundPhase( function() self:AddMoney( ent:GetRefundPrice() ) end );

		end

	end

	return tProps, tRefund;

end

function meta:HasSQLRow()

	sql.Begin();

	local res = sql.Query( "SELECT `Money` FROM `TorrentPD` WHERE `SID` = '" .. self:SteamID() .. "';" );

	sql.Commit();

	// Can be nil and we want to return booleans
	if ( res ) then 
		return true;
	else 
		return false;
	end

end

