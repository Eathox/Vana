disableserialization;

params
[
	["_CtrlTreeView", controlnull, [controlnull]], //Gets Treeview control
	["_Name", "", [""]],
	["_TargetTab", [-1], [[]]], //Gets given targettab (Defualt is selected tab)
	//Makes more private varibales but does not define em
	"_TvData",
	"_TvName",
	"_LoadoutData",
	"_DataPosistion"
];

if (isnull _CtrlTreeView) exitwith //Checks if Required value is empty
{
	diag_log text "[VANA_fnc_TvRenameTab]: No TreeView Control Was Given, Aborting Function.";
	False; //Returns false meaning the function dint execute
};

if (_TargetTab isEqualto [-1]) then //Checks if defualt should be used
{
	_TargetTab = tvCurSel _CtrlTreeView; //Gets Selected tab
};

_TvData = tolower (_CtrlTreeView tvData _TargetTab); //Gets Data assigned to sellected SubTv
_TvName = _CtrlTreeView tvText _TargetTab;

if !(_Name isequalto _TvName) then
{
	switch _TvData do
	{
	  case "tvtab": //Checks if selected SubTv is a Tab
	  {
			if !(_Name isequalto "") then
			{
				_CtrlTreeView tvSetText [_TargetTab, _Name];
				_TargetTab; //Returns Renamed Tab meaning function was successfully executed
			} else {
				False; //Returns false meaning the function dint execute
			};
	  };
		case "tvloadout":
		{
			if !(_Name isequalto "") then
			{
				_LoadoutData = profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]];
				if (_LoadoutData find _Name >= 0) then
				{
					playsound "3DEN_notificationWarning";
					with uinamespace do {['showMessage',[ctrlparent (_this select 0),"Rename canceled, that name is allready used by an other loadout. (Loadouts require unique names)"]] call bis_fnc_arsenal;};
					False; //Returns false meaning the function dint execute
				} else {
					_DataPosistion = _LoadoutData find _TvName;
					_LoadoutData set [_DataPosistion, _Name];

					saveProfileNamespace;

					_CtrlTreeView tvSetText [_TargetTab, _Name];
					_TargetTab; //Returns Renamed Tab meaning function was successfully executed
				};
			} else {
				False; //Returns false meaning the function dint execute
			};
		};
	};
} else {
	False; //Returns false meaning the function dint execute
};
