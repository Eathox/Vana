disableserialization;

params
[
  ["_CtrlTreeView", controlnull, [controlnull]],
  ["_Arguments", ["",[-1]], [[]]],
  ["_TypeData", "All", [""]],
  "_Name",
  "_TvParent",
  "_FncArguments",
  "_Target"
];

_Arguments params
[
  ["_Name", "", [""]],
  ["_TvParent", [-1], [[]]]
];

//Find Correct SubTv
_FncArguments = [[_CtrlTreeView, [_TvParent, (toLower _TypeData)], [], False], [_CtrlTreeView]] select (_TvParent isequalto [-1]);
_Target = (_FncArguments call VANA_fnc_TvGetData) select {(_x select 0) isequalto _Name};

if (_Target isequalto []) exitwith {[-1]};

(_Target select 1)
