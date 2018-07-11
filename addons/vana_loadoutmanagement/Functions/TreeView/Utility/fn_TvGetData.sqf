disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Arguments", [], [[]]],
	["_ExportDataArray", [], [[],0]],
	["_CheckSubTv", True, [True]],
	["_Count", False, [False]],
	"_CtrlTreeView",
	"_ExportDataArray",
	"_TargetTv",
	"_TvData",
	"_DataExport"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_Arguments params [
	["_ParentTv", [], [[]]],
	["_TypeData", "All", [""]]
];

_TypeData = toLower _TypeData;
_ExportDataArray = ([+_ExportDataArray, 0] Select _Count);

for "_i" from 0 to (_CtrlTreeView tvCount _ParentTv)-1 do {

	//Declare current SubTv
	_TargetTv = +_ParentTv;
	_TargetTv Pushback _i;

	_TvData = tolower (_CtrlTreeView tvData _TargetTv);

	//Get currentSubTv Data
	_DataExport = [
		(_CtrlTreeView tvText _TargetTv), //"Name"
		_TargetTv, //Position
		_TvData, //"Data"
		(_CtrlTreeView tvValue _TargetTv) //"Value"
	];

	//Add data to Export Array/Value
	if (_TypeData isequalto _TvData || _TypeData isequalto "all") then {
		call ([{_ExportDataArray append [_DataExport]}, {_ExportDataArray = _ExportDataArray +1}] select _Count);
	};

	//Execute function for all Subtv's
	if (_CheckSubTv && _CtrlTreeView tvCount _TargetTv > 0) then {
		_ExportDataArray = [_ArsenalDisplay, [_TargetTv, _TypeData], _ExportDataArray, True, _Count] call VANA_fnc_TvGetData;
	};
};

_ExportDataArray
