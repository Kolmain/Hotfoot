_increment = 15; //increments of 15
_score = 0;
_lastSupportScore = 0;
_lastSupport = "nil";
_newSupport = "nil";
player setVariable ["KOL_lastSupportScore", _lastSupportScore, true];
player setVariable ["KOL_lastSupport", _newSupport, true];
player setVariable ["KOL_score", _score, true];

while { true } do {
	_score = player getVariable "KOL_score";
	_lastSupportScore = player getVariable "KOL_lastSupportScore";
	_lastSupport = player getVariable "KOL_lastSupport";
	_newSupport = "mortarStrike";
	
	switch (_lastSupport) do {
		case "nil": {
			_newSupport = "mortarStrike";
		};
		case "mortarStrike": {
			_newSupport = "fixedCas";
		};
		case "fixedCas": {
			_newSupport = "ugvRequest";
		};
		case "ugvRequest": {
			_newSupport = "artyStrike";
		};
		case "artyStrike": {
			_newSupport = "qrfRequest";
		};
		case "qrfRequest": {
			_newSupport = "mortarStrike";
		};
		
	};
	
	if (_score > (_lastSupportScore + _increment)) then {
		player setVariable ["KOL_lastSupportScore", _score, true];
		player setVariable ["KOL_lastSupport", _newSupport, true];
		[player, _newSupport] call BIS_fnc_addCommMenuItem; 
		[["Support", _newSupport], 15, "", 35, "", true, true, true, true] call BIS_fnc_advHint; 
	};
	sleep 5;
};
