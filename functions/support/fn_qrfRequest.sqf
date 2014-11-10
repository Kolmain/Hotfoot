_caller = _this select 0;
_pos = _this select 1;
_target = _this select 2;
_is3D = _this select 3;
_ID = _this select 4;
_grpSide = side _caller;
if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_grp = group caller;
_rifles = units group caller;
_pos2 = [0,0,0];

_dis = _pos distance hardpoint;

if (_dis > 1200) then {

	(leader _grp) sideChat format["%1, requested coordinates are outside of the AO, request denied, out.", groupID (group _caller), groupID _grp];
	sleep 3;
	_newQrf = [_caller, "qrf"] call BIS_fnc_addCommMenuItem;
	
} else {

switch (_grpSide) do {
    case west: {
		_grp = [getMarkerPos "arespawn_west", WEST [B_soldier_F", "B_soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup
		_rifles = units _grp;
		_retArray = [getMarkerPos "arespawn_west", 180, "B_MRAP_01_hmg_F", _grp] call bis_fnc_spawnvehicle
		_retArray2 = [getMarkerPos "arespawn_west", 180, "B_Heli_Transport_03_F", WEST] call bis_fnc_spawnvehicle
		_pos2 = getMarkerPos "arespawn_west";
	};
    case east: {
		_grp = [getMarkerPos "arespawn_west", EAST, ["O_Soldier_F", "O_Soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup
		_rifles = units _grp;
		_retArray = [getMarkerPos "arespawn_east", 180, "O_MRAP_02_hmg_F", _grp] call bis_fnc_spawnvehicle
		_retArray2 = [getMarkerPos "arespawn_east", 180, "O_Heli_Transport_04_F", EAST] call bis_fnc_spawnvehicle
		_pos2 = getMarkerPos "arespawn_east";
	};
    case RESISTANCE: {
		_grp = [getMarkerPos "arespawn_west", RESISTANCE, ["I_soldier_F", "I_soldier_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup
		_rifles = units _grp;
		_retArray = [getMarkerPos "arespawn_west", 180, "I_MRAP_03_hmg_F", _grp] call bis_fnc_spawnvehicle
		_retArray2 = [getMarkerPos "arespawn_guerrila", 180, "I_Heli_Transport_02_F", RESISTANCE] call bis_fnc_spawnvehicle
		_pos2 = getMarkerPos "arespawn_guerrila";
	};
};

_caller sideChat format["%2, this is %1, we're requesting a QRF, over.", groupID (group _caller), groupID _grp];
sleep 3;
(leader _grp) sideChat format["%1, this is %2, copy your last. Send landing grid, over.", groupID (group _caller), groupID _grp];
sleep 3;
_caller sideChat format["Grid %1, over.", mapGridPosition _pos];
sleep 3;


	(leader _grp) sideChat format["Copy that %1, dispatching to requested coordinates, out.", groupID (group _caller), groupID _grp];
	sleep 3;
	_vehicle = _retArray select 0;
	_crew = _retArray select 1;
	//_grp = _retArary select 2;
	
	_heli = _retArray2 select 0;
	_heliCrew = _retArray2 select 1;
	_heliGrp = _retArray2 select 2;
	_heliDriver = driver _heli;
	
	{
		_x assignAsCargo _vehicle;
		_x moveInCargo _vehicle;
	} forEach _rifles;
	
	_heli setSlingLoad _vehicle;
	
	_heliDriver disableAI "FSM";
	_heliDriver disableAI "TARGET";
	_heliDriver disableAI "AUTOTARGET";
	_heliGrp setBehaviour "AWARE";
	_heliGrp setCombatMode "RED";
	_heliGrp setSpeedMode "NORMAL";
	
	_attackWP =_grp addWaypoint [_hardpoint, 25];
	_attackWP setWPPos _hardpoint;
	_attackWP setWaypointBehaviour "AWARE";
	_attackWP setWaypointCombatMode "RED";
	_attackWP setWaypointSpeed "NORMAL";
	_attackWP setWaypointType "SAD";
	_attackWP setWaypointFormation "DIAMOND";
	
	_heliDriver move _pos;
	_heli flyInHeight 150;
	_heli lock 3;
	
	waitUntil {(_heli distance _pos < 200)};
	_heli flyInHeight 0;
	_heli land "LAND";
	waitUntil {(isTouchingGround _vehicle)};
	{
		ropeCut [ _x, 5];
	} forEach ropes _heli;
	(leader _grp) sideChat format["Be advised, QRF %1 is in the AO and engaging hostiles, out.", groupID _grp];
	_heliDriver move _pos2;
	_heli flyInHeight 150;
	waitUntil {(_heli distance _pos2 < 300)};
	{
		deleteVehicle _x;
	} forEach _heliCrew;
	deleteVehicle _heli;
	deleteGroup _heliGrp;

};


{
	_x addEventHandler ["MPKilled",{
		_killed = _this select 0;
		_killer = _this select 1;
		if (_killer == player) then {
		_vis = lineIntersects [eyePos player, eyePos _killed, player, _killed];
			if(!_vis) then {
			_printText = [       
				["MINION KILL (+1pt)","<t align = 'right' shadow = '1' size = '0.7'>%1</t><br/>"],       
				["",""]   
			] spawn KOL_fnc_printText;  
			};
		};
		if (KOL_debug) then {
				systemChat format ["Respawnable AI %1 Died.", (name _x)];
		};
	}]
}  forEach units _spawnedGrp; 
