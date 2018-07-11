params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Arguments", [], [[]]],
	["_CheckSubTv", True, [True]]
];

_Arguments params [
	["_ParentTv", [], [[]]],
	["_TypeData", "All", [""]]
];

//Call VANA_fnc_TvGetData in Count mode
[_ArsenalDisplay, [_ParentTv, _TypeData], [], _CheckSubTv, True] call VANA_fnc_TvGetData;
