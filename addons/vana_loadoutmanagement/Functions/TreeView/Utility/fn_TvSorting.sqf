disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_ParentTv", [], [[]]],
	["_CheckSubTv", True, [True]],
	"_CtrlTreeView",
	"_TargetTvChildren",
	"_TargetTvLoadouts",
	"_TvName",
	"_TvPosition"
];

_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
if (_ParentTv isequalto [-1]) exitwith {False};

//Add ! to all loadouts
_TargetTvLoadouts = [_ArsenalDisplay, [_ParentTv, "Tvloadout"], [], False] call VANA_fnc_TvGetData;
{
	_CtrlTreeView tvsettext [_x select 1, (Format ["!!!!!!!!!!%1", _x select 0])];
} count _TargetTvLoadouts;

//Sort treeview (All loadouts will be above)
_CtrlTreeView tvsort [_ParentTv, True];
_CtrlTreeView tvsort [_ParentTv, False];

_TargetTvChildren = [_ArsenalDisplay, [_ParentTv, "All"], [], False] call VANA_fnc_TvGetData;
{
	_TvName = _x select 0;
	_TvPosition = _x select 1;

	switch (tolower (_x select 2)) do {
		case "tvloadout": {
			_CtrlTreeView tvsettext [_TvPosition, (_TvName select [10, (Count _TvName-10)])];
		};
		case "tvtab": {
			if (_CheckSubTv && _CtrlTreeView tvCount _TvPosition > 0) then {
				[_ArsenalDisplay, _TvPosition] call VANA_fnc_TvSorting;
			};
		};
	};
	True
} count _TargetTvChildren;

True
