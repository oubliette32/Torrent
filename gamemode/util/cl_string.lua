
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