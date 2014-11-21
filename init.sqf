enableSaving [false,false];
enableTeamswitch false;

weatherClouds = "weatherClouds" call BIS_fnc_getParamValue; 
 switch (weatherClouds) do { 
    case 1: {0 setOvercast 0};                     // Clear 
    case 2: {0 setOvercast .2};                 // Partly Cloudy 
    case 3: {0 setOvercast .5};                    // Light Rain 
    case 4: {0 setOvercast .95};                // Heavy Rain 
    case 5: {0 setOvercast random(floor(1))};        // Random 
};     

weatherFog = "weatherFog" call BIS_fnc_getParamValue; 
 switch (weatherFog) do { 
    case 1: {0 setFog 0};                         // No Fog 
    case 2: {0 setFog .35};                     // Light Fog 
    case 3: {0 setFog .60};                     // Medium Fog 
    case 4: {0 setFog .90};                    // Heavy Fog 
    case 5: {0 setFog (random(1))};                // Random 
};  

TimeHour = "TimeHour" call BIS_fnc_getParamValue; 
if (isNil "curTimeHour") then {curTimeHour = 9}; 
setDate [2035, 7, 4, curTimeHour, 0];  
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";
[] call KOL_fnc_initHotfoot;
