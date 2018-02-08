disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_VANAData", (profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]]), [[]]],
	//Form wich data is saved in is [["Name",[Position],"DataType"],["Name",[Position],"DataType"],["Name",[Position],"DataType"]] ect.
	"_LoadoutData",
	"_LoadoutNames"
];

_VANAData = +_VANAData;
_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];
_LoadoutNames = [];

//Create all loadouts if there is no saved data
if (_VANAData isequalto []) exitwith
{
	[_CtrlTreeView] call VANA_fnc_TvCreateLoadout;

	False
};

diag_log text "[VANA_fnc_TvLoadData]: Loading Data...";

//Send data to co responding create fucntions
{
	params ["_TvName","_TvPosition","_TvData"];

	_TvName = _x select 0;
	_TvPosition = +_x select 1;
	_TvData = tolower (_x select 2);

	_TvPosition resize (Count _TvPosition) - 1;

	call
	{
		if (_TvData isequalto "tvtab") exitwith {[_CtrlTreeView, _TvPosition, _TvName] call VANA_fnc_TvCreateTab;};
		if (_TvData isequalto "tvloadout") exitwith
		{
			_LoadoutNames set [(Count _LoadoutNames), _TvName];
			[_CtrlTreeView, _TvPosition, _TvName] call VANA_fnc_TvCreateLoadout;
		};
	};
} foreach _VANAData;

//Create loadouts that werent created
{
	if !(_x in _LoadoutNames) then
	{
		[_CtrlTreeView, [], _x] call VANA_fnc_TvCreateLoadout;
	};
} foreach (_LoadoutData select {_x isequaltype ""});

diag_log text "[VANA_fnc_TvLoadData]: Data loaded.";

True
