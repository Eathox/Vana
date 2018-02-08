disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_TargetTv", (tvCurSel _CtrlTreeView), [[]]],
  "_HasName",
  "_HasData"
];

//Check if Text and Data are defined
_HasName = !(_CtrlTreeView tvText _TargetTv isequalto "");
_HasData = !(_CtrlTreeView tvdata _TargetTv isequalto "");

[False, True] select (_HasName && _HasData)
