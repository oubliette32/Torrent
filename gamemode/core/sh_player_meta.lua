local meta = debug.getregistry()[ "Player" ];

/* * * * * * * * * * * * * * 
	- OTHER
 * * * * * * * * * * * * * */

function meta:CanInteract( ent )

	// Do some team checking here later

	return ent:GetTOwner() == self;

end

function meta:CanBuild()

	// Do some team checking here later 

	return self:GetPropCount() < TR_MAX_PROPS;

end

function meta:CanConstrain()
	
	// Do some team checking here later 

	return self:GetConstraintCount() < self:MaxConstraints();

end

function meta:MaxProps()

	// Do some team checking here later

	return TR_MAX_PROPS;

end

function meta:MaxConstraints()

	// Do some team checking here later

	return TR_MAX_CONSTRAINTS;

end

/* * * * * * * * * * * * * * 
	- PROPS / CONSTRAINTS
 * * * * * * * * * * * * * */

function meta:SetPropCount( count )

	if ( !SERVER ) then return; end

	self:SetNVar( "PropCount", count, NETWORK_PROTOCOL_PRIVATE );

end

function meta:GetPropCount()

	return self:GetNVar( "PropCount" ) or 0

end

function meta:SetConstraintCount( count )

	if ( !SERVER ) then return; end

	self:SetNVar( "ConstraintCount", count, NETWORK_PROTOCOL_PRIVATE );

end

function meta:GetConstraintCount()

	return self:GetNVar( "ConstraintCount" ) or 0

end
