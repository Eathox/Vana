disableserialization;

//Private ["_ParentTv","_ExportDataArray","_TypeData"]; //Sets Private Values so they dont get redefined by loop

params
[
	["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
	["_ParentTv", [], [[]]], //Gets ParentTv
	["_ExportDataArrayOriginal", [], [[]]], //Get assinged data
	["_TypeData", "All", [""]], //Allows user to only get one type of data. "tvtab" or "tvloadout"
	["_CheckSubTv", True, [True]], //Allows user to not get data from SubTv's of all SubTv's under Parent Tv
	["_DuplicateDataArray", True, [True]],
	//Makes more private varibales but does not define em
	"_ExportDataArray",
	"_i"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_TreeViewGetData]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

_TypeData = toLower _TypeData;
if (_DuplicateDataArray) then
{
	_ExportDataArray = +_ExportDataArrayOriginal; //Duplicates _ExportDataArrayOriginal so it doesnt get redefined
} else {
	_ExportDataArray = _ExportDataArrayOriginal;
};

for [{_i = 0},{_i <= (_CtrlTreeView tvCount _ParentTv)-1},{_i = _i+1}] do //Executes this loop for all SubTv's of ParentTv
{
	params ["_TargetTv","_TvName","_TvData","_DataExport","_SubTvCount"];

	_TargetTv = +_ParentTv; //Duplicates ParentTv so it doesnt get redefined (For later math)
	_TargetTv Pushback _i; //Adds current Tv Number to parent Tv outcome: path of currentTv (So the path of the Tv wich is currently being handeld in the loop)

	_TvName = _CtrlTreeView tvText _TargetTv;
	_TvData = tolower (_CtrlTreeView tvData _TargetTv);

	if !(_TypeData isequalto "all") then //Checks if _TypeData is defined by user
	{
		if (_TypeData isequalto _TvData) then //Checks if SubTv's data is _TypeData
		{
			_DataExport = //Gets currentTv's Data
			[
				/* 00 */	_TvName,
				/* 01 */	_TargetTv, //TvPosition
				/* 02 */	_TvData
			];
			_ExportDataArray set [(Count _ExportDataArray), _DataExport]; //Adds Data to allready exsiting Data
		};
	} else { //Gets Data of all SubTv's
		_DataExport = //Gets currentTv's Data
		[
			/* 00 */	_TvName,
			/* 01 */	_TargetTv, //TvPosition
			/* 02 */	_TvData
		];
		_ExportDataArray set [(Count _ExportDataArray), _DataExport]; //Adds Data to allready exsiting Data
	};

	if _CheckSubTv then //Checks if SubTv's Should be checked
	{
		_SubTvCount = _CtrlTreeView tvCount _TargetTv; //Counts the amount of subTv's under current Tv
		if (_SubTvCount > 0) then //Checks if there are any SubTv's
		{
			[_CtrlTreeView, _TargetTv, _ExportDataArray, _TypeData, True, False] call VANA_fnc_TreeViewGetData; //Executes this function with the allready acquired data (As its not saved anywhere it has to be passed trough)
		};
	};
};

_ExportDataArray; //Returns acquired data
