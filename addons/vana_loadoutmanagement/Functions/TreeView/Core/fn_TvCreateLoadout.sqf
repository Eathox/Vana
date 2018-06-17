disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params
[
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Arguments", [], [[]]],
	["_Behavior", "", [""]],
	"_CtrlTreeView",
	"_LoadoutPath",
	"_LoadoutAdd"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_Arguments params
[
	["_TargetTv", (tvCurSel _CtrlTreeView), [[]]],
	["_LoadoutName", "", [""]]
];

_Behavior = tolower _Behavior;

//Create Loadout in treeview
_LoadoutPath = +_TargetTv;

_LoadoutAdd = _CtrlTreeView tvAdd [_TargetTv,_LoadoutName];
_LoadoutPath pushback _LoadoutAdd;

//Visualy/Technical classify Tab
_CtrlTreeView tvSetData [_LoadoutPath, "tvloadout"];

if !(_Behavior in ["firsttimesetup", "dragdrop"]) then
{
	_CtrlTreeView tvExpand _TargetTv;
	_CtrlTreeView tvSetCurSel ([_ArsenalDisplay, [_TargetTv, _LoadoutName], "tvloadout"] call VANA_fnc_TvGetPosition);
};

[_LoadoutPath, _LoadoutName]
