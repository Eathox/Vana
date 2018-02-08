disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]],
	["_ParentTv", [], [[]]],
	["_TypeData", "All", [""]],
	["_CheckSubTv", True, [True]]
];

//Call VANA_fnc_TvGetData in Count mode
[_CtrlTreeView, _ParentTv, [], _TypeData, _CheckSubTv, True] call VANA_fnc_TvGetData;
