disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_LoadoutName", "", [""]],
  "_Center",
  "_DuplicateLoadout",
	"_TargetTv",
	"_TvData",
	"_ReturnValue"
];

//Check if loadout is duplicate
_DuplicateLoadout = _LoadoutName in (profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]] select {_x isequaltype ""});

//Normal Save function (Has to be run in order to acctuly save the loadout)
_Center = (missionnamespace getvariable ["BIS_fnc_arsenal_Center",player]);
[
  _center,
  [profilenamespace,_LoadoutName],
  [
    _center getvariable ["BIS_fnc_arsenal_face",face _center],
    speaker _center,
    _center call bis_fnc_getUnitInsignia
  ]
] call bis_fnc_saveInventory;

//Find and Validate Updated Loadout
if _DuplicateLoadout exitwith
{
	[_CtrlTreeView, [([_CtrlTreeView, [[-1], _LoadoutName], "TvLoadout"] Call VANA_fnc_TvGetPosition), _LoadoutName]] call VANA_fnc_TvValidateLoadout;
	["showMessage",[(ctrlparent _CtrlTreeView), (format ["Replaced existing loadout: ""%1""", _LoadoutName])]] spawn BIS_fnc_arsenal;

 	[[-1], _LoadoutName]
};

//Create Subtv for loadout
_TargetTv = tvCurSel _CtrlTreeView;
_TvData = tolower (_CtrlTreeView tvData _TargetTv);

if (_TvData isEqualto "tvloadout") then
{
  _TargetTv resize (Count _TargetTv-1);
};

_ReturnValue = [_CtrlTreeView, [_TargetTv, _LoadoutName]] call VANA_fnc_TvCreateLoadout;

[_CtrlTreeView, _ReturnValue] call VANA_fnc_TvValidateLoadout;
["showMessage",[(ctrlparent _CtrlTreeView), (format ["Loadout: ""%1"" Saved", _LoadoutName])]] spawn BIS_fnc_arsenal;

_ReturnValue
