disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Arguments", [], [[]]],
	"_CtrlTreeView",
	"_TvData",
	"_TvName",
	"_LoadoutData"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_Arguments params [
	["_TargetTv", (tvCurSel _CtrlTreeView), [[]]],
	["_Name", "", [""]]
];

_TvData = tolower (_CtrlTreeView tvData _TargetTv);
_TvName = _CtrlTreeView tvText _TargetTv;

_CtrlTreeView tvSetText [_TargetTv, _Name];
if (_TvData isequalto "tvloadout") then {
	//rename loadout in profile data
	_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];
	_LoadoutData set [(_LoadoutData find _TvName), _Name];
};

True
