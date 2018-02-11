disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_TargetTv", (tvCurSel (_this select 0)), [[]]],
	"_TvName",
	"_TvData",
	"_TargetTvParent",
	"_TargetTvChildren",
	"_Center",
	"_TvDataString",
	"_AboveTab",
	"_LastNumber"
];

_TvName = _CtrlTreeView TvText _TargetTv;
_TvData = tolower (_CtrlTreeView tvData _TargetTv);
_TargetTvParent = _TargetTv call VANA_fnc_TvGetParent;

switch _TvData do
{
	case "tvtab":
	{
		//Recreates all loadouts under tab
		_TargetTvChildren = [_CtrlTreeView, _TargetTv] call VANA_fnc_TvGetData;

		{
			if (tolower (_x select 2) isEqualto "tvloadout") then
			{
				[_CtrlTreeView, _TargetTvParent, _x select 0] call VANA_fnc_TvCreateLoadout;
			};
		} foreach _TargetTvChildren;
	};

	case "tvloadout":
	{
		//Delete loadout from profiledata
		_Center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		[_Center, [profilenamespace,_TvName],nil,True] call BIS_fnc_saveInventory;
	};
};

_TvDataString = ["Tab", "Loadout"] select (_TvData isequalto "tvloadout");
["showMessage",[(ctrlparent _CtrlTreeView), (format ["%1: ""%2"" Deleted", _TvDataString, _TvName])]] spawn BIS_fnc_arsenal;

_CtrlTreeView tvDelete _TargetTv;

//Select next subtv
_AboveTab = +_TargetTv;
_LastNumber = _AboveTab select (count _AboveTab-1);

if !(_LastNumber isequalto 0) then
{
	_AboveTab set [(Count _AboveTab -1), (_LastNumber -1)];
};

if ([_CtrlTreeView, _TargetTv] call VANA_fnc_TvExists) then
{
	_CtrlTreeview tvsetcursel _TargetTv;
} else {
	if ([_CtrlTreeView, _AboveTab] call VANA_fnc_TvExists) then
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
