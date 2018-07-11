disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_LoadoutName", "", [""]],
	"_CtrlTreeView",
	"_Center",
	"_DuplicateLoadout",
	"_TargetTv",
	"_TvData",
	"_ReturnValue"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;

//Check if loadout is duplicate
_DuplicateLoadout = _LoadoutName in (profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]] select {_x isequaltype ""});

//Normal Save function (Has to be run in order to acctuly save the loadout)
_Center = (missionnamespace getvariable ["BIS_fnc_arsenal_Center",player]);
[
	_center,
	[profilenamespace,_LoadoutName], [
		_center getvariable ["BIS_fnc_arsenal_face",face _center],
		speaker _center,
		_center call bis_fnc_getUnitInsignia
	]
] call bis_fnc_saveInventory;

//Find and Validate Updated Loadout
if _DuplicateLoadout exitwith {
	[_ArsenalDisplay, [([_ArsenalDisplay, [[-1], _LoadoutName], "TvLoadout"] Call VANA_fnc_TvGetPosition), _LoadoutName]] call VANA_fnc_TvValidateLoadout;
	["showMessage",[(ctrlparent _CtrlTreeView), (format ["Replaced existing loadout: ""%1""", _LoadoutName])]] spawn BIS_fnc_arsenal; //LOCALIZE

	 [[-1], _LoadoutName]
};

//Create Subtv for loadout
_TargetTv = tvCurSel _CtrlTreeView;
_TvData = tolower (_CtrlTreeView tvData _TargetTv);

if (_TvData isEqualto "tvloadout") then {
	_TargetTv resize (Count _TargetTv-1);
};

_ReturnValue = [_ArsenalDisplay, [_TargetTv, _LoadoutName]] call VANA_fnc_TvCreateLoadout;

[_ArsenalDisplay, _ReturnValue] call VANA_fnc_TvValidateLoadout;
["showMessage",[(ctrlparent _CtrlTreeView), (format ["Loadout: ""%1"" Saved", _LoadoutName])]] spawn BIS_fnc_arsenal; //LOCALIZE

_ReturnValue
