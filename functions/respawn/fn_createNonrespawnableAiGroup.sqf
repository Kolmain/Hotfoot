_grpSide = (_this select 0);
if (_grpSide == independent) then {_grpSide = RESISTANCE;};
_grp = group player;
_pos2 = [0,0,0];
_pos = [0,0,0]; //select LZ

switch (_grpSide) do {
    case west: {
		_grp = [getMarkerPos "arespawn_west", WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		_rifles = units _grp;
		_retArray2 = [getMarkerPos "arespawn_west", 180, "B_Heli_Transport_03_F", WEST] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_west";
	};
    case east: {
		_grp = [getMarkerPos "arespawn_east", EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		_rifles = units _grp;
		_retArray2 = [getMarkerPos "arespawn_east", 180, "O_Heli_Transport_04_F", EAST] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_east";
	};
    case RESISTANCE: {
		_grp = [getMarkerPos "arespawn_guerrila", RESISTANCE, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
		_rifles = units _grp;
		_retArray2 = [getMarkerPos "arespawn_guerrila", 180, "I_Heli_Transport_02_F", RESISTANCE] call bis_fnc_spawnvehicle;
		_pos2 = getMarkerPos "arespawn_guerrila";
	};
};

	_heli = _retArray2 select 0;
	_heliCrew = _retArray2 select 1;
	_heliGrp = _retArray2 select 2;
	_heliDriver = driver _heli;
	
	{
		_x assignAsCargo _heli;
		_x moveInCargo _heli;
	} forEach units _grp;
	
[_caller, format["%2, this is %1, requesting QRF, over.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
sleep 3;
[(leader _grp), format["%1, this is %2, copy your last. Send landing grid, over.", groupID (group _caller), groupID _grp]] call KOL_fnc_globalSideChat;
sleep 3;
[_caller, format["Grid %1, over.", mapGridPosition _pos]] call KOL_fnc_globalSideChat;
sleep 3;

	_heliDriver disableAI "FSM";
	_heliDriver disableAI "TARGET";
	_heliDriver disableAI "AUTOTARGET";
	_heliGrp setBehaviour "AWARE";
	_heliGrp setCombatMode "RED";
	_heliGrp setSpeedMode "NORMAL";
	
	_heliDriver move _pos;
	_heli flyInHeight 150;
	_heli lock 3;
	
	if (isMultiplayer) then {
	{
		_x addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _heliGrp; 
	{
		_x addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
	}  forEach units _grp; 
	_heli addMPEventHandler ["MPKilled", {_this spawn KOL_fnc_onUnitKilled}];
} else {
	{
		_x addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}]; 
	}  forEach units _heliGrp; 
	{
		_x addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}]; 
	}  forEach units _grp; 
	_heli addEventHandler ["Killed", {_this spawn KOL_fnc_onUnitKilled}]; 
};

	waitUntil {(_heli distance _pos < 200)};
	_heli flyInHeight 0;
	_heli land "LAND";
	waitUntil {(isTouchingGround _heli)};
	_grp leaveVehicle _heli;
	[(leader _grp) , "city", "ASSUALT"] execvm "scripts\UPSMON.sqf";
	sleep 8;
	_heli land "NONE";
	_heliDriver move _pos2;
	_heli flyInHeight 90;
	waitUntil {(_heli distance _pos2 < 300)};
	{
		deleteVehicle _x;
	} forEach _heliCrew;
	deleteVehicle _heli;
	deleteGroup _heliGrp;
};



