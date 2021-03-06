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

function string.FormatNumber( str )

	str = str tostring( str );

	local newStr = "";
	local ins = ( str:len() >= 4 and 1 or -1 );

	for i = 1, str:len() do 

		if ( ins == 0 ) then 

			newStr = newStr .. ",";

			ins = 3;

		else 

			ins = ins - 1;

		end

		newStr = newStr .. str[ i ];

	end

	return newStr;

end