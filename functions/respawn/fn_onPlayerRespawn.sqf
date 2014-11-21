// [<newUnit>, <oldUnit>, <respawn>, <respawnDelay>]

if (("pfatigue" call BIS_fnc_getParamValue) == 0) then {
  player enableFatigue false;
} else {
   player enableFatigue true;
};
_EHkilledIdx = player addEventHandler ["HandleScore", "[] spawn KOL_fnc_handleScore"}];
_respawnPos = [(side player), player] spawn BIS_fnc_addRespawnPosition;
