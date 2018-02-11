disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]],
  ["_LoadoutName", "", [""]],
  ["_Posistion", [], [[]]]
];

[_CtrlTreeView, [[_LoadoutName, _Posistion]]] call VANA_fnc_TvValidateLoadouts;
