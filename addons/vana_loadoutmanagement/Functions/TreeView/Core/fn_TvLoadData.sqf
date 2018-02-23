disableserialization;

#define EndSegment(BOOL)\
	[_CtrlTreeView, ([_CtrlTreeView, [[], "TvLoadout"]] call VANA_fnc_TvGetData)] call VANA_fnc_TvValidateLoadouts;\
	diag_log text "[VANA_fnc_TvLoadData]: Data loaded.";\
	BOOL

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_VANAData", (profilenamespace getvariable ["VANA_fnc_TreeViewSave_Data",[]]), [[]]],
	//Form wich data is saved in is [["Name",[Position],"DataType",Value],["Name",[Position],"DataType",Value],["Name",[Position],"DataType",Value]] ect.
	"_SavedLoadouts",
	"_LoadoutNames",
	"_NonExsistandLoadouts"
];

_VANAData = +_VANAData;
_SavedLoadouts = (profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]]) select {_x isequaltype ""};
_LoadoutNames = [];
_NonExsistandLoadouts = [];

diag_log text "[VANA_fnc_TvLoadData]: Loading Data...";

//Create all loadouts if there is no saved data
if (_VANAData isequalto []) exitwith
{
	{
		private _Return = [_CtrlTreeView, [[], _x], "FirstTimeSetup"] call VANA_fnc_TvCreateLoadout;
		_Return isequaltype []
	} count (_SavedLoadouts);

	EndSegment(False)
};

//Send data to co responding create fucntions
{
	params ["_Return","_TvName","_TvPosition","_TvData"];

	_Return = false;
	_TvName = _x select 0;
	_TvPosition = _x select 1;
	_TvData = tolower (_x select 2);

	_TvPosition resize (Count _TvPosition-1);

	if (_TvData isequalto "tvtab") then {_Return = [_CtrlTreeView, [_TvPosition, _TvName], "FirstTimeSetup"] call VANA_fnc_TvCreateTab;};
	if (_TvData isequalto "tvloadout") then
	{
		_Return = [_CtrlTreeView, [_TvPosition, _TvName], "FirstTimeSetup"] call VANA_fnc_TvCreateLoadout;
		call ([{_LoadoutNames pushback _TvName}, {_NonExsistandLoadouts pushback (_Return select 0)}] select !(_TvName in _SavedLoadouts));
	};

	_Return isequaltype []
} count _VANAData;

//Remove nonexsistand
reverse _NonExsistandLoadouts;
{_CtrlTreeView tvdelete _x; true} count _NonExsistandLoadouts;

//Create loadouts that werent created
{
	private _Return = [_CtrlTreeView, [[], _x]] call VANA_fnc_TvCreateLoadout;
	_Return isequaltype []
} count (_SavedLoadouts select {!(_x in _LoadoutNames)});

EndSegment(True)
