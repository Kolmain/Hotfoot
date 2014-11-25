_loop = true;

/*points_west = 0;
points_east = 0;
points_guerrila = 0;
scoreToWin = 250;*/

while {_loop} do {
	if (points_west >= scoreToWin) then {
		_loop = false;
		winningSide = west;
		publicVariable "winningSide";
		[] spawn KOL_fnc_epilogue;
	} else {
		if (points_east >= scoreToWin) then {
			_loop = false;
			winningSide = east;
			publicVariable "winningSide";
			[] spawn KOL_fnc_epilogue;
		} else {
			if (points_guerrila >= scoreToWin) then {
				_loop = false;
				winningSide = RESISTANCE;
				publicVariable "winningSide";
				[] spawn KOL_fnc_epilogue;
			};
		};
	};
};