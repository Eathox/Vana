disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_ParentTv", [], [[]]],
	["_ExportDataArray", [], [[],0]],
	["_TypeData", "All", [""]],
	["_CheckSubTv", True, [True]],
	["_Count", False, [False]],
	"_ExportDataArray"
];

_TypeData = toLower _TypeData;
_ExportDataArray = ([+_ExportDataArray, 0] Select _Count);

for "_i" from 0 to (_CtrlTreeView tvCount _ParentTv)-1 do
{
	params ["_TargetTv","_TvName","_TvData","_DataExport"];

	//Declare current SubTv
	_TargetTv = +_ParentTv;
	_TargetTv Pushback _i;

	_TvName = _CtrlTreeView tvText _TargetTv;
	_TvData = tolower (_CtrlTreeView tvData _TargetTv);

	//Get currentSubTv Data
	_DataExport =
	[
		_TvName,
		_TargetTv,
		_TvData
	];

	//Add data to Export Array/Value
	if (_TypeData isequalto _TvData || _TypeData isequalto "all") then
	{
		if _Count then
		{
			_ExportDataArray = _ExportDataArray +1;
		} else {
			_ExportDataArray append [_DataExport];
		};
	};

	//Execute function for all Subtv's
	if (_CheckSubTv && _CtrlTreeView tvCount _TargetTv > 0) then
	{
		_ExportDataArray = [_CtrlTreeView, _TargetTv, _ExportDataArray, _TypeData, True, False] call VANA_fnc_TvGetData;
	};
};

_ExportDataArray
