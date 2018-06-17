disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"


#define IDCS_MiscOptions_DropDownMenu\
	[\
		IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenu,\
		IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenuButtonLayout,\
		IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenuButtonLoadout,\
		IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenuButtonBoth,\
		IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenuBackground\
	]

#define IDCS_Lists\
	[\
		IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_BackGroundList\
	]

params
[
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Mode", "", [""]],
	["_Arguments", [], [[]]]
];

switch (tolower _mode) do
{
	///////////////////////////////////////////////////////////////////////////////////////////
	case "init":
	{
		_Arguments params ["_CtrlDropDownMenuButtonLayout","_CtrlDropDownMenuButtonLoadout","_CtrlDropDownMenuButtonBoth","_CtrlDropDownMenu"];

		_CtrlDropDownMenuButtonLayout = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenuButtonLayout;
		_CtrlDropDownMenuButtonLayout ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 981150) setvariable ['DropDownMenu_Status', 'layout']"];

		_CtrlDropDownMenuButtonLoadout = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenuButtonLoadout;
		_CtrlDropDownMenuButtonLoadout ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 981150) setvariable ['DropDownMenu_Status', 'loadout']"];

		_CtrlDropDownMenuButtonBoth = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenuButtonBoth;
		_CtrlDropDownMenuButtonBoth ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 981150) setvariable ['DropDownMenu_Status', 'both']"];

		_CtrlDropDownMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenu;
		(ctrlposition _CtrlDropDownMenu) params ["_X","_Y","_W","_H"];

		_CtrlDropDownMenu setvariable ["OrignalHeight", _H];
		_CtrlDropDownMenu	ctrlsetposition [_X,_Y,_W,0];
		_CtrlDropDownMenu ctrlcommit 0;

		{(_ArsenalDisplay displayctrl _x) ctrlenable false} foreach IDCS_MiscOptions_DropDownMenu;
	};


	///////////////////////////////////////////////////////////////////////////////////////////
	case "toggle":
	{
		_Arguments params
		[
			["_CtrlPressedButton", controlnull, [controlnull]],
			["_ForceClose", false, [false]],
			"_CtrlDropDownMenu",
			"_Close",
			"_Height"
		];

		_CtrlDropDownMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenu;
		(ctrlposition _CtrlDropDownMenu) + (ctrlposition _CtrlPressedButton) params ["_X","_Y","_W","_H","_ButtonX","_ButtonY","_ButtonW","_ButtonH"];

		_Close = (ctrlenabled _CtrlDropDownMenu && (_ButtonY+_ButtonH) isequalto _Y || _ForceClose);

		_CtrlDropDownMenu	ctrlsetposition ([[_X,(_ButtonY+_ButtonH),_W,0], [_X,(_ButtonY+_ButtonH)]] select ctrlenabled _CtrlDropDownMenu);
		_CtrlDropDownMenu Ctrlcommit ([0, 0.01] select ctrlenabled _CtrlDropDownMenu);

		_Height = [(_CtrlDropDownMenu getvariable "OrignalHeight"), 0] select _Close;
		_CtrlDropDownMenu	ctrlsetposition [_X,([(_ButtonY+_ButtonH), _Y] select _Close),_W,_Height];
		_CtrlDropDownMenu Ctrlcommit 0.12;

		{(_ArsenalDisplay displayctrl _x) ctrlenable ([true, false] select _Close)} foreach IDCS_MiscOptions_DropDownMenu;
		if !_Close then {ctrlsetfocus _CtrlDropDownMenu};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "waituntilstatus":
	{
		params ["_CtrlDropDownMenu","_Status"];

		_CtrlDropDownMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenu;

		waituntil {!isnil {_CtrlDropDownMenu getvariable "DropDownMenu_Status"} || !ctrlenabled _CtrlDropDownMenu};

		_Status = (_CtrlDropDownMenu getvariable "DropDownMenu_Status");
		if !(ctrlenabled _CtrlDropDownMenu) then {_Status = "false"};

		[_ArsenalDisplay, "Toggle", [controlnull, true]] call VANA_fnc_DropDownMenu;
		_CtrlDropDownMenu setvariable ["DropDownMenu_Status",nil];

		_Status
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "defualt":
	{
		[_ArsenalDisplay, "Toggle", _Arguments] call VANA_fnc_DropDownMenu;
		[_ArsenalDisplay, "WaitUntilStatus"] call VANA_fnc_DropDownMenu;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "import":
	{
		params ["_CtrlOptionsMenu","_ValidatedData","_DataType","_ImportData","_SelectedOption"];

		_CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;

		[_ArsenalDisplay, "Toggle", _Arguments] call VANA_fnc_DropDownMenu;
		{(_ArsenalDisplay displayctrl _x) ctrlenable false} foreach (IDCS_MiscOptions_DropDownMenu - [IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenu,IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenuBackground]);

		_ValidatedData = [copyfromclipboard] call VANA_fnc_ValidateImportData;
		_DataTypes = _ValidatedData select 0;
		_ImportData = _ValidatedData select 1;

		{_ArsenalDisplay displayctrl (IDCS_MiscOptions_DropDownMenu select ((["layout","loadout","both"] find tolower _x) + 1)) ctrlenable true} foreach _DataTypes;

		_SelectedOption = [_ArsenalDisplay, "WaitUntilStatus"] call VANA_fnc_DropDownMenu;
		if !(_SelectedOption isequalto "false") then {[_ArsenalDisplay, _ImportData, _SelectedOption] call VANA_fnc_TvImport};
	};
};
