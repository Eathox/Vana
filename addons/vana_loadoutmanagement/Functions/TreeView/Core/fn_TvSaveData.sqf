disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	"_SavedData",
	"_VANAData"
];

_SavedData = (profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]]);
_VANAData = [_CtrlTreeView] call VANA_fnc_TvGetData;

if !(_SavedData isequalto _VANAData) exitwith
{
	profilenamespace setvariable ["VANA_fnc_TreeViewSave_Data", _VANAData];
	saveProfileNamespace;

	True
};

False
