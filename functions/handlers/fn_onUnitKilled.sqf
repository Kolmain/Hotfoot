private ["_killed","_killer","_score","_scoreToAdd","_vis"];


_killed = _this select 0;
_killer = _this select 1;
_score = _killer getVariable "KOL_score";
_scoreToAdd = 0;



if (KOL_debug) then {
	systemChat format["%1 KILLED %2.", name _killer, name _killed];
};

if (isPlayer _killer) then {
	if (_killer == player) then {
		if ((side _killed) != (side _killer)) then {
			_vis = lineIntersects [eyePos player, eyePos _killed, player, _killed];
			if(!_vis) then {
				if (_killed isKindOf "Man") then {
					//man kill
					if (isPlayer _killed) then {
						//player kill
						_score = _score + 5;
						_scoreToAdd = 5;
						_killer setVariable ["KOL_score", _score, true];
						["PointsAdded",["Player Kill", 5]] call BIS_fnc_showNotification;
					} else {
						//npc kill
						_score = _score + 1;
						_scoreToAdd = 1;
						_killer setVariable ["KOL_score", _score, true];
						["PointsAdded",["NPC Kill", 1]] call BIS_fnc_showNotification;
					};
				};
				if (_killed isKindOf "Car") then {
					//support car
					_scoreToAdd = 7;
					_score = _score + 7;
					_killer setVariable ["KOL_score", _score, true];
					["PointsAdded",["Support Unit Kill", 7]] call BIS_fnc_showNotification;
				};
				if (_killed isKindOf "Helicopter") then {
					//transport kill
					_scoreToAdd = 7;
					_score = _score + 7;
					_killer setVariable ["KOL_score", _score, true];
					["PointsAdded",["Transport Kill", 7]] call BIS_fnc_showNotification;
				};
			};
		} else {
			["PointsRemoved",["Friendly Fire Kill", 7]] call BIS_fnc_showNotification;
			_score = _score - 7;
			_scoreToAdd = 0;
			_killer setVariable ["KOL_score", _score, true];
		};
	} ;
} else {
	_scoreToAdd = 1;
};

[_killer, _scoreToAdd] call BIS_fnc_addScore;

switch (side _killer) do {
    case west: {
		points_west = points_west + _scoreToAdd;
		publicVariable "points_west";
	};
    case east: {
		points_east = points_east + _scoreToAdd;
		publicVariable "points_east";
	};
	case RESISTANCE: {
		points_guerrila = points_guerrila + _scoreToAdd;
		publicVariable "points_guerrila";
	};
};

if (KOL_debug) then {
	systemChat format["WEST: %1 EAST: %2 GUER: %3", points_west, points_east, points_guerrila];
};
