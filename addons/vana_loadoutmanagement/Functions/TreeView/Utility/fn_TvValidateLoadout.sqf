params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Arguments", [], [[]]]
];

_Arguments params [
	["_Posistion", [], [[]]],
	["_LoadoutName", "", [""]]
];

[_ArsenalDisplay, [[_LoadoutName, _Posistion]]] call VANA_fnc_TvValidateLoadouts;
