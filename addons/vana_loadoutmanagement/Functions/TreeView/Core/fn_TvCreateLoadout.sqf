disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_Arguments", [[-1], ""], [[]]],
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

if (_LoadoutName isequalto "" && _Behavior isequalto "firsttimesetup") exitwith
{
	//Load all Loadouts
	{
		[_CtrlTreeView, [[], _x], "FirstTimeSetup"] call VANA_fnc_TvCreateLoadout;
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

if !(_Behavior in ["firsttimesetup", "dragdrop"]) then
{
	_CtrlTreeView tvExpand _TargetTv;
	_CtrlTreeView tvSetCurSel ([_CtrlTreeView,[_LoadoutName,_TargetTv],"tvloadout"] call VANA_fnc_TvGetPosition);

	[_CtrlTreeView, _LoadoutName, _LoadoutPath] call VANA_fnc_TvValidateLoadout;
};

[_LoadoutPath,_LoadoutName]
