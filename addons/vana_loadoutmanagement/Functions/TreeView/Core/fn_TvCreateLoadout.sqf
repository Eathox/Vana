disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_TargetTv", (tvCurSel (_this select 0)), [[]]],
	["_LoadoutName", "", [""]],
	["_FirstTimeSetup", False, [False]],
	"_LoadoutData",
	"_LoadoutPath",
	"_LoadoutAdd"
];

_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];

if (_LoadoutName isequalto "" && _FirstTimeSetup) exitwith
{
	//Load all Loadouts
	{
		[_CtrlTreeView, [], _x] call VANA_fnc_TvCreateLoadout;
	} foreach (_LoadoutData select {_x isequaltype ""});

	[[-1], ""]
};

If (!(_LoadoutName in _LoadoutData) && !(_LoadoutName isEqualType "")) exitwith {[[-1], ""]};

//Create Loadout in treeview
_LoadoutPath = +_TargetTv;

_LoadoutAdd = _CtrlTreeView tvAdd [_TargetTv,_LoadoutName];
_LoadoutPath pushback _LoadoutAdd;

//Visualy/Technical classify Tab
_CtrlTreeView tvSetData [_LoadoutPath, "tvloadout"];

_CtrlTreeView tvExpand _TargetTv;
_CtrlTreeView tvSetCurSel ([_CtrlTreeView,[_LoadoutName,_TargetTv],"tvloadout"] call VANA_fnc_TvGetPosition);

if _FirstTimeSetup then {_CtrlTreeView setvariable ["TvLoadData_Count", (_CtrlTreeView getvariable ["TvLoadData_Count", 0])+1]};

[_LoadoutPath,_LoadoutName]
