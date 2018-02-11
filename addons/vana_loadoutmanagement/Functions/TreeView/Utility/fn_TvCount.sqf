disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]],
  ["_Arguments", [[-1], ""], [[]]],
	["_CheckSubTv", True, [True]]
];

_Arguments params
[
  ["_ParentTv", [], [[]]],
  ["_TypeData", "All", [""]]
];



//Call VANA_fnc_TvGetData in Count mode
[_CtrlTreeView, [_ParentTv, _TypeData], [], _CheckSubTv, True] call VANA_fnc_TvGetData;
