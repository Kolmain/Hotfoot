//end of match notification
//hotfoot_epilogue = true;
_hardpoint = hardpoint;
_heli = init_obj;
_extractionPoints = [];
_spawnPos = [0,0,0];
_max_distance = 100;
while{ count _extractionPoints < 1 } do
{
	_extractionPoints = hardpoint findEmptyPosition[ 30 , 1000 , "B_Heli_Transport_03_F" ];
	_max_distance = _max_distance + 50;
};
_extractionPoint = _extractionPoints select 0;

switch (winningSide) do {
  case west: {
    _spawnPos = getMarkerPos "arespawn_west";
		_spawnPos = [((_spawnPos select 0) + 100), _spawnPos select 1, _spawnPos select 2];
		_ret = [_spawnPos, 0, "B_Heli_Transport_01_camo_F", WEST] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		extractionChopper = _heli;

	};
  case east: {
    _spawnPos = getMarkerPos "arespawn_east";
		_spawnPos = [((_spawnPos select 0) + 100), _spawnPos select 1, _spawnPos select 2];
		_ret = [_spawnPos, 0, "O_Heli_Light_02_F", EAST] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		extractionChopper = _heli;
	};
	case RESISTANCE: {
    _spawnPos = getMarkerPos "arespawn_guerrila";
		_spawnPos = [((_spawnPos select 0) + 100), _spawnPos select 1, _spawnPos select 2];
		_ret = [_spawnPos, 0, "I_Heli_light_03_F", RESISTANCE] call bis_fnc_spawnvehicle;
		//_ret = [getMarkerPos "arespawn_guerrila", 0, "I_Heli_Transport_02_F", RESISTANCE] call bis_fnc_spawnvehicle;
		_heli = _ret select 0;
		extractionChopper = _heli;
	};
};

_heliDriver = driver _heli;
_heliGrp = group _heliDriver;
_heliDriver move _extractionPoint;
_heli setVariable ["exfil", false, true];

_empty = [_heli, _grpSide] spawn {
  _heli = _this select 0;
  _grpSide = _this select 1;
	waitUntil {!(canMove _heli)};
	[_heli, format["Mayday! Mayday! %1 going down!", groupID (group _heli)]] call KOL_fnc_globalSideChat;
};
[_heli, format["All units be advised, %1 is en route to extract friendly units, out.", groupID (group _heli)]] call KOL_fnc_globalSideChat;
sleep 2;

waitUntil {(_heli distance _extractionPoint < 150)};

  _heli flyInHeight 0;
	_heli land "LAND";
	waitUntil {(isTouchingGround _heli)};
	//get in task to all players
	_heliDriver action ["engineOn", vehicle _heliDriver];
	_heli flyInHeight 0;
	_heli setVariable ["exfil", true, true];
	_heliDriver action ["engineOn", vehicle _heliDriver];
	
	//WAIT FOR HOW LONG?
	sleep 60;
	
	{
		_x enableAI "MOVE";
		_x allowFleeing 0;
		_x enableAttack false;
	} forEach units _heliGrp;
	[_heli, "We're dusting off, thats it!"] call KOL_fnc_globalVehicleChat;
	_heli land "NONE";
	[_heli, format["%1 is RTB, out.", groupID (group _heli)]] call KOL_fnc_globalSideChat;
	_heliDriver disableAI "FSM";
	_heliDriver disableAI "TARGET";
	_heliDriver disableAI "AUTOTARGET";
	_heliDriver move _spawnPos;
	_heliGrp setBehaviour "AWARE";
	_heliGrp setCombatMode "RED";
	_heliGrp setSpeedMode "FULL";
	_heli flyInHeight 50;
	waitUntil {(_heli distance _insertPoint < 150)};
	
	

