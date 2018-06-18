disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params
[
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_TargetTv", (tvCurSel (_this select 0 displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME)), [[]]],
	"_CtrlTreeView",
	"_TvName",
	"_TvData",
	"_TargetTvParent",
	"_TargetTvChildren",
	"_Center",
	"_TvDataString",
	"_AboveTab",
	"_LastNumber"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_TvName = _CtrlTreeView TvText _TargetTv;
_TvData = tolower (_CtrlTreeView tvData _TargetTv);
_TargetTvParent = _TargetTv call VANA_fnc_TvGetParent;

switch _TvData do
{
	case "tvtab":
	{
		//Recreates all loadouts under tab
		_TargetTvChildren = [_ArsenalDisplay, [_TargetTv]] call VANA_fnc_TvGetData;

		{
			if (tolower (_x select 2) isEqualto "tvloadout") then
			{
				private _Return = [_ArsenalDisplay, [_TargetTvParent, _x select 0]] call VANA_fnc_TvCreateLoadout;
				_Return isequaltype []
			};
		} count _TargetTvChildren;
	};

	case "tvloadout":
	{
		//Delete loadout from profiledata
		_Center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		[_center, [profilenamespace,_TvName], nil, true] call BIS_fnc_saveInventory;
	};
};

_TvDataString = ["Tab", "Loadout"] select (_TvData isequalto "tvloadout");
["showMessage",[(ctrlparent _CtrlTreeView), (format ["%1: ""%2"" Deleted", _TvDataString, _TvName])]] spawn BIS_fnc_arsenal; //LOCALIZE

_CtrlTreeView tvDelete _TargetTv;

//Select next subtv
_AboveTab = +_TargetTv;
_LastNumber = _AboveTab select (count _AboveTab-1);

if !(_LastNumber isequalto 0) then
{
	_AboveTab set [(Count _AboveTab -1), (_LastNumber -1)];
};

if ([_ArsenalDisplay, _TargetTv] call VANA_fnc_TvExists) then
{
	_CtrlTreeview tvsetcursel _TargetTv;
} else {
	if ([_ArsenalDisplay, _AboveTab] call VANA_fnc_TvExists) then
	{
		_CtrlTreeview tvsetcursel _AboveTab;
	} else {
		if !(_TargetTvParent isequalto []) then
		{
			_CtrlTreeview tvsetcursel _TargetTvParent;
		};
	};
};

_TargetTv
