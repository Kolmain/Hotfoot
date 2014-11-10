

["armory3DText", "onEachFrame", {
	private["_vis","_pos"];
	{
		if (player distance _x < 100) then
		{
			_vis = lineIntersects [eyePos player, eyePos _x, player, _x];
			if(!_vis) then
			{
				_pos = visiblePosition _x;
				_pos set[2,(getPosATL _x select 2) + 2.2];
				drawIcon3D ["\A3\ui_f\data\igui\cfg\weaponicons\arifle_ca.paa",[1,1,1,1],_pos,1,1,0, "Armory Officer",0,0.04];
			};
		};
	} foreach [va_west, va_east, va_guerrilla];	
}] call BIS_fnc_addStackedEventHandler;
	
["respawnVehicle3DText", "onEachFrame", {
	private["_vis","_pos"];
	{
		if(player distance _x < 100) then
		{
			_vis = lineIntersects [eyePos player, eyePos _x, player, _x];
			if(!_vis) then
			{
				_pos = visiblePosition _x;
				_pos set[2,(getPosATL _x select 2) + 2.2];
				drawIcon3D ["\A3\ui_f\data\map\markers\nato\b_mech_inf.paa",[1,1,1,1],_pos,1,1,0, "Arrival Truck",0,0.04];
			};
		};
	} foreach [respawnVehicle_west, respawnVehicle_east, respawnVehicle_guerrilla];
}] call BIS_fnc_addStackedEventHandler;

_mus = [] spawn BIS_fnc_jukebox;
_amb = [] spawn KOL_fnc_createAmbientEnviroment;
_ao = [aoTrig] spawn BIS_fnc_drawAO; 
player enableFatigue false;
_loadout = [(side player)] spawn KOL_fnc_initPlayerLoadout;
