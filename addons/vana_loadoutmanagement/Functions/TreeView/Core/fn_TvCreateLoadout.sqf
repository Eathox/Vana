disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_Arguments", [], [[]]],
	["_Behavior", "", [""]],
	"_LoadoutData",
	"_LoadoutPath",
	"_LoadoutAdd"
];

_Arguments params
[
	["_TargetTv", (tvCurSel _CtrlTreeView), [[]]],
	["_LoadoutName", "", [""]]
];

_Behavior = tolower _Behavior;
_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];

If !(_LoadoutName in _LoadoutData) exitwith {[[-1], ""]};

//Create Loadout in treeview
_LoadoutPath = +_TargetTv;

_LoadoutAdd = _CtrlTreeView tvAdd [_TargetTv,_LoadoutName];
_LoadoutPath pushback _LoadoutAdd;

//Visualy/Technical classify Tab
_CtrlTreeView tvSetData [_LoadoutPath, "tvloadout"];

if !(_Behavior in ["firsttimesetup", "dragdrop"]) then
{
	_CtrlTreeView tvExpand _TargetTv;
	_CtrlTreeView tvSetCurSel ([_CtrlTreeView, [_TargetTv, _LoadoutName], "tvloadout"] call VANA_fnc_TvGetPosition);
};

[_LoadoutPath, _LoadoutName]
