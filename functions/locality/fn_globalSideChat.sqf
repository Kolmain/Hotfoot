/*if (isMultiplayer) then {

  //[compile format ["%1 sideChat %2", (_this select 0), (_this select 1)], "BIS_fnc_spawn", true] call BIS_fnc_MP; 
  [[[_this select 0, _this select 1], {(_this select 0) sideChat (_this select 1)}], "BIS_fnc_spawn", true] call BIS_fnc_MP;  
  
} else {

  (_this select 0) sideChat (_this select 1);
  
};
*/
[[[_this select 0, _this select 1], {(_this select 0) sideChat (_this select 1)}], "BIS_fnc_spawn", true] call BIS_fnc_MP;  
