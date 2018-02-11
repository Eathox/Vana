disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]],
	["_Name", "", [""]],
	["_TargetTv", (tvCurSel (_this select 0)), [[]]],
	"_TvData",
	"_TvName",
	"_LoadoutData",
	"_DataPosistion"
];

_TvData = tolower (_CtrlTreeView tvData _TargetTv);
_TvName = _CtrlTreeView tvText _TargetTv;

_CtrlTreeView tvSetText [_TargetTv, _Name];
if (_TvData isequalto "tvloadout") then
{
	//rename loadout in profile data
	_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];
	_DataPosistion = _LoadoutData find _TvName;

	_LoadoutData set [_DataPosistion, _Name];
	saveProfileNamespace;
};

True
