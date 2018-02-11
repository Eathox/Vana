disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]],
  ["_Arguments", [], [[]]]
];

_Arguments params
[
  ["_Posistion", [], [[]]],
  ["_LoadoutName", "", [""]]
];


[_CtrlTreeView, [[_LoadoutName, _Posistion]]] call VANA_fnc_TvValidateLoadouts;
