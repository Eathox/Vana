disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_Arguments", [[-1], ""], [[]]],
	["_ExportDataArray", [], [[],0]],
	["_CheckSubTv", True, [True]],
	["_Count", False, [False]],
	"_ExportDataArray"
];

_Arguments params
[
  ["_ParentTv", [], [[]]],
  ["_TypeData", "All", [""]]
];

_TypeData = toLower _TypeData;
_ExportDataArray = ([+_ExportDataArray, 0] Select _Count);

for "_i" from 0 to (_CtrlTreeView tvCount _ParentTv)-1 do
{
	params ["_TargetTv","_TvData","_DataExport"];

	//Declare current SubTv
	_TargetTv = +_ParentTv;
	_TargetTv Pushback _i;

	_TvData = tolower (_CtrlTreeView tvData _TargetTv);

	//Get currentSubTv Data
	_DataExport =
	[
		(_CtrlTreeView tvText _TargetTv), //"Name"
		_TargetTv, //Position
		_TvData, //"Data"
		(_CtrlTreeView tvValue _TargetTv) //"Value"
	];

	//Add data to Export Array/Value
	if (_TypeData isequalto _TvData || _TypeData isequalto "all") then
	{
		call ([{_ExportDataArray append [_DataExport]}, {_ExportDataArray = _ExportDataArray +1}] select _Count);
	};

	//Execute function for all Subtv's
	if (_CheckSubTv && _CtrlTreeView tvCount _TargetTv > 0) then
	{
		_ExportDataArray = [_CtrlTreeView, [_TargetTv, _TypeData], _ExportDataArray, True, False] call VANA_fnc_TvGetData;
	};
};

_ExportDataArray
