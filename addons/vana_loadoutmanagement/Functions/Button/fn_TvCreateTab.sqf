disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_TargetTv", (tvCurSel _CtrlTreeView), [[]]],
	["_TabName", []],
	"_TvData",
	"_NewSubTvPath",
	"_TabCount",
	"_AddSubTv"
];

_TargetTv = +_TargetTv;
_TvData = tolower (_CtrlTreeView tvData _TargetTv);

//Get parent
if (!(_TargetTv isEqualto []) && !(_TvData isEqualto "tvtab")) then
{
  _TargetTv resize (Count _TargetTv) - 1;
};

//Create Tab in treeview
_NewSubTvPath = +_TargetTv;
if (_TabName isEqualType "") then
{
	_AddSubTv = _CtrlTreeView tvAdd [_TargetTv, _TabName];
} else {
	_TabCount = [_CtrlTreeView, _TargetTv, "tvtab", False] call VANA_fnc_TvCount;
	_AddSubTv = _CtrlTreeView tvAdd [_TargetTv, (format ["New Tab%1",(_TabCount+1)])];
};
_NewSubTvPath pushback _AddSubTv;

//Visualy/Technical classify Tab
_CtrlTreeView tvSetData [_NewSubTVPath, "tvtab"];
_CtrlTreeView tvSetValue [_NewSubTVPath, -2];
_CtrlTreeView tvSetPicture [_NewSubTVPath, "\VANA_LoadoutManagement\UI\Data_Icons\icon_ca.paa"];

_CtrlTreeView tvExpand _TargetTv;

if (_this select 3) then {(_CtrlTreeView setvariable ["VANA_fnc_TreeViewLoadData_Count", (_CtrlTreeView getvariable ["VANA_fnc_TreeViewLoadData_Count", 0])+1])};

_NewSubTvPath
