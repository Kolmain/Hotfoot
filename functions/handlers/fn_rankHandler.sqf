_unit = _this select 0;

while {true} do {
	_rank = rank _unit;
	_increment = "rankPointIncrement" call BIS_fnc_getParamValue;
	_score = _unit getVariable "KOL_score";
	_newRank = rank _unit;
	switch (_rank) do {
		case "PRIVATE": {
			if (_score > (_increment * 1)) then {
				_newRank ="CORPROAL";
				//notification
			};

		};
		case "CORPROAL": {
			if (_score > (_increment * 2)) then {
				_newRank ="SERGEANT";
				//notification
			};
		};
		case "SERGEANT": {
			if (_score > (_increment * 3)) then {
				_newRank ="LIEUTENANT";
				//notification
			};
		};
		case "LIEUTENANT": {
			if (_score > (_increment * 4)) then {
				_newRank ="CAPTAIN";
				//notification
			};
		};
		case "CAPTAIN": {
			if (_score > (_increment * 5)) then {
				_newRank ="MAJOR";
				//notification
			};
		};
		case "MAJOR": {
			if (_score > (_increment * 6)) then {
				_newRank ="COLONEL";
				//notification
			};
		};
	};
	if (_newRank != _rank) then {
		[[[_unit, _newRank], {(_this select 0) setUnitRank (_this select 1)}], "BIS_fnc_spawn", true] call BIS_fnc_MP;
	};
	sleep 10;
};