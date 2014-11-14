if (isMultiplayer) then {

  [compile format ["%1 vehicleChat %2", (_this select 0), (_this select 1)], "BIS_fnc_spawn", true] call BIS_fnc_MP; 
  
} else {

  (_this select 0) vehicleChat (_this select 1);
  
};
