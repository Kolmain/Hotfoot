// [<newUnit>, <oldUnit>, <respawn>, <respawnDelay>]

if (("pfatigue" call BIS_fnc_getParamValue) == 0) then {
  player enableFatigue false;
} else {
   player enableFatigue true;
};
player addEventHandler ["HandleScore", {[] spawn KOL_fnc_handleScore}];
if (("weaponFX" call BIS_fnc_getParamValue) == 1) then {
	player addEventHandler ["Fired", {_this execVM "scripts\L_Twitch.sqf";}];
};
_respawnPos = [(side player), player] spawn BIS_fnc_addRespawnPosition;
if (("nvgs" call BIS_fnc_getParamValue) == 0) then {
	switch (side player) do {
	    case west: {
	    	player addItem "NVGoggles";
	    	player assignItem "NVGoggles";
	    };
	    case east: {
	    	player addItem "NVGoggles_OPFOR";
	    	player assignItem "NVGoggles_OPFOR";
	    };
	    case independent: {
	    	player addItem "NVGoggles_INDEP";
	    	player assignItem "NVGoggles_INDEP";
	    };
	};
};
