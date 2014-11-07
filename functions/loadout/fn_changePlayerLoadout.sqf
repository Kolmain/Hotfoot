_va = _this select 0;
_player = _this select 1;
_id = _this select 2;

	["Open",true] call BIS_fnc_arsenal;
	waitUntil {(_player distance _va > 10)};
	[player, [missionnamespace, "Current"]] call bis_fnc_saveInventory;
