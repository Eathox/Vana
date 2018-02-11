disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_Arguments", [], [[]]],
	["_Behavior", "", [""]],
	"_TvData",
	"_NewSubTvPath",
	"_TabCount",
	"_AddSubTv"
];

_Arguments params
[
	["_TargetTv", (tvCurSel _CtrlTreeView), [[]]],
	["_TabName", "", [""]]
];

_TargetTv = +_TargetTv;
_Behavior = tolower _Behavior;
_TvData = tolower (_CtrlTreeView tvData _TargetTv);

//Get parent
if (!(_TvData isEqualto "tvtab") && !(_TargetTv isequalto [])) then
{
  _TargetTv resize (Count _TargetTv -1);
};

//Create Tab in treeview
_NewSubTvPath = +_TargetTv;
if !(_TabName isequalto "") then
{
	_AddSubTv = _CtrlTreeView tvAdd [_TargetTv, _TabName];
} else {
	_TabCount = [_CtrlTreeView, [_TargetTv, "tvtab"], False] call VANA_fnc_TvCount;
	_AddSubTv = _CtrlTreeView tvAdd [_TargetTv, (format ["New Tab%1",(_TabCount+1)])];
};
_NewSubTvPath pushback _AddSubTv;

//Visualy/Technical classify Tab
_CtrlTreeView tvSetData [_NewSubTVPath, "tvtab"];
_CtrlTreeView tvSetPicture [_NewSubTVPath, "\vana_LoadoutManagement\UI\Data_Icons\icon_ca.paa"];

if !(_Behavior in ["firsttimesetup", "dragdrop"]) then {_CtrlTreeView tvExpand _TargetTv;};

_NewSubTvPath
