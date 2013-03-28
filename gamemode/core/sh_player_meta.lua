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

local meta = debug.getregistry()[ "Player" ];

/* * * * * * * * * * * * * * 
	- OTHER
 * * * * * * * * * * * * * */

function meta:CanInteract( ent )

	// Do some team checking here later

	return ent.GetTOwner and ( ent:GetTOwner() == self ) or false;

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
