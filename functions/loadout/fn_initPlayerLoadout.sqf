_grpSide = _this select 0;
_va = init_obj;
switch (_grpSide) do {
    case west: {
		_gear = [_grpSide, 'rifleman_west'] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "grenadier_west"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "at_west"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "autorifleman_west"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "sniper_west"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "specops_west"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "uav_west"] call BIS_fnc_addRespawnInventory;
	};
    case east: {
		_gear = [_grpSide, 'rifleman_east'] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "grenadier_east"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "at_east"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "autorifleman_east"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "sniper_east"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "specops_east"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "uav_east"] call BIS_fnc_addRespawnInventory;
	};
	case independent: {
		_gear = [_grpSide, 'rifleman_guer'] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "grenadier_guer"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "at_guer"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "autorifleman_guer"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "sniper_guer"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "specops_guer"] call BIS_fnc_addRespawnInventory;
		_gear = [_grpSide, "uav_guer"] call BIS_fnc_addRespawnInventory;
	};
};
