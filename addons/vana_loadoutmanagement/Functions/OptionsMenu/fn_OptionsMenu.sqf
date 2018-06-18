disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define IDCS_Lists\
	[\
		IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_BackGroundList\
	]

#define ListFade(LIST,FADE)\
	LIST ctrlsetfade FADE;\
	LIST ctrlcommit 0;

#define ListBlink(LIST,FADE)\
	LIST ctrlsetfade FADE;\
	LIST ctrlcommit 1.2;\
	if(CtrlFade LIST == 1) exitwith {ListFade(LIST,1)};\
	UiSleep 1.2;

params
[
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Mode", "", [""]],
	["_Arguments", [], [[]]],
	"_ShowTemplateUI"
];

_ShowTemplateUI =
{
	params ["_CtrlTemplate","_ctrlMouseBlock"];

	_CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
	_ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;

	if (_This) then {ctrlsetfocus _CtrlTemplate};

	_CtrlTemplate ctrlsetfade ([1, 0] select _This);
	_CtrlTemplate ctrlcommit 0;
	_CtrlTemplate ctrlenable _This;

	_ctrlMouseBlock ctrlenable _This;
	_ctrlMouseBlock ctrlshow _This;
};

switch (tolower _mode) do
{
	///////////////////////////////////////////////////////////////////////////////////////////
	case "init":
	{
		params ["_CtrlOptionsMenu","_CtrlButtonApply","_CtrlButtonCancel","_CtrlButtonDefault","_CtrlMiscOptions_ButtonExport","_CtrlMiscOptions_ButtonImport","_CtrlMiscOptions_ButtonWipeData","_CtrlMiscOptions_ButtonRestoreBackup"];

		[_ArsenalDisplay, "Init"] call VANA_fnc_DropDownMenu;
		[_ArsenalDisplay, "ToUpper"] Spawn VANA_fnc_OptionsMenu;
		[_ArsenalDisplay, "PopulateBackGroundLists"] call VANA_fnc_OptionsMenu;

		_CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
		_CtrlOptionsMenu ctrladdeventhandler ["MouseButtonDown","Private _CtrlList = (_this select 0) getvariable 'BlinkingList'; ctrlsetfocus ((ctrlparent _CtrlList) displayctrl (_CtrlList lbvalue lbcursel _CtrlList));"];

		_CtrlButtonApply = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonApply;
		_CtrlButtonApply ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonApply'] call VANA_fnc_OptionsMenu;"];

		_CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonCancel;
		_CtrlButtonCancel ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonCancel'] call VANA_fnc_OptionsMenu;"];

		_CtrlButtonDefault = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonDefault;
		_CtrlButtonDefault ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonDefault'] call VANA_fnc_OptionsMenu;"];

		_CtrlMiscOptions_ButtonExport = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_ButtonExport;
		_CtrlMiscOptions_ButtonExport ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonExport'] call VANA_fnc_OptionsMenu;"];

		_CtrlMiscOptions_ButtonImport = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_ButtonImport;
		_CtrlMiscOptions_ButtonImport ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonImport', [(_this select 0)]] spawn VANA_fnc_OptionsMenu;"];

		_CtrlMiscOptions_ButtonWipeData = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_ButtonWipeData;
		_CtrlMiscOptions_ButtonWipeData ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonWipeData', [(_this select 0)]] spawn VANA_fnc_OptionsMenu;"];

		_CtrlMiscOptions_ButtonRestoreBackup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_ButtonRestoreBackup;
		_CtrlMiscOptions_ButtonRestoreBackup ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'ButtonRestoreBackup', ['Pressed']] spawn VANA_fnc_OptionsMenu;"];
		_CtrlMiscOptions_ButtonRestoreBackup ctrlenable !((uinamespace Getvariable ["VANA_fnc_TreeViewSave_Backup", []]) isequalto []); //WIP DONT use CtrlEnable

		{
			Private _CtrlList = _ArsenalDisplay displayctrl _x;
			_CtrlList ctrladdeventhandler ["LBSelChanged", "[ctrlparent (_this select 0), 'ListCurSelChanged', [(_this select 0)]] call VANA_fnc_OptionsMenu;"];
			_CtrlList ctrladdeventhandler ["MouseButtonDown", "Private _CtrlList = _this select 0; ctrlsetfocus ((ctrlparent _CtrlList) displayctrl (_CtrlList lbvalue lbcursel _CtrlList));"];

			_CtrlList ctrladdeventhandler ["LBSelChanged", "Private _CtrlDropDownMenu = ctrlParent (_this select 0) displayctrl 981150; if (ctrlenabled _CtrlDropDownMenu) then {_CtrlDropDownMenu setvariable ['DropDownMenu_Status', 'false']}"]; //Closes DropDownMenu

			if (_x isequalto (IDCS_Lists select 0)) then
			{
				_CtrlList lbsetcursel 0;
				[_ArsenalDisplay, "ListBlink", [_CtrlList]] spawn VANA_fnc_OptionsMenu;
			};
		} foreach IDCS_Lists;

		//Porting over old Varibale to new system
		if !(isnil {Profilenamespace getvariable "TEMP_Popup_Value"}) then
		{
			["DeleteConfirmation", (Profilenamespace getvariable "TEMP_Popup_Value")] call VANA_fnc_SetOptionValue;
			Profilenamespace setvariable ["TEMP_Popup_Value", nil];
		};

		//Make sure Data is saved with TvValue
		if (isnil {profilenamespace getvariable "VANA_fnc_TreeViewSave_Data"}) then {[_ArsenalDisplay] Spawn VANA_fnc_TvSaveData} else
		{
			private _VANAData = profilenamespace getvariable "VANA_fnc_TreeViewSave_Data";
			if (count _VANAData > 0) then {if (Count (_VANAData select 1) < 4) then {[_ArsenalDisplay] Spawn VANA_fnc_TvSaveData}};
		};

		True
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "toupper":
	{
		{
			Private _Ctrl = _x select 0;
			_Ctrl ctrlSetText (toUpper CtrlText _Ctrl);
		} foreach (UiNameSpace getvariable "VANA_OptionsMenu_ToUpper"); //Elements are added to this array from RscVANAOptionCategoryTitle, RscVANAOptionText and RscVANAOptionButton 'Onload'

		UiNameSpace setvariable ["VANA_OptionsMenu_ToUpper", nil];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "populatebackgroundlists":
	{
		{
			_x params
			[
				["_CtrlList", controlnull, [controlnull]],
				["_CurrentConfig", confignull, [confignull]],
				"_ConfigParent",
				"_AllOptionTexts",
				"_AllOptionButtons",
				"_Script"
			];

			_ConfigParent = (configHierarchy _CurrentConfig) select 7;
			_AllOptionTexts = "!isnil {(_x >> 'optiondescription') call BIS_fnc_getCfgData}" configClasses (_ConfigParent >> "controls");
			_AllOptionButtons = "!isnil {(_x >> 'index') call BIS_fnc_getCfgData}" configClasses (_ConfigParent >> "controls");

			{
				params ["_OptionDescription", "_OptionButtonIdc", "_Index"];

				_OptionDescription = gettext (_x >> "optiondescription");
				_OptionButtonIdc = getnumber (_x >> "optionbuttonidc");
				_Index = _CtrlList lbadd "";

				_CtrlList lbsetdata [_index, _OptionDescription];
				_CtrlList lbsetvalue [_index, _OptionButtonIdc];
			} foreach _AllOptionTexts;

			(ctrlposition _CtrlList) params ["_X","_Y","_W","_H"];
			_CtrlList ctrlsetposition [_X,_Y,_W,(_H * lbSize _CtrlList)];
			_CtrlList ctrlcommit 0;

			_Script =
			{
				params ["_Arguments","_CtrlList","_Index","_CtrlOptionsMenu","_CtrlBlinkingList"];

				_Arguments = (_this select 0) getvariable "_Arguments";
				_CtrlList = _Arguments select 0;
				_Index = _Arguments Select 1;

				_CtrlOptionsMenu = (Ctrlparent _CtrlList) displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
				_CtrlBlinkingList = _CtrlOptionsMenu getvariable "BlinkingList";

				If (_CtrlBlinkingList isequalto _CtrlList && lbcursel _CtrlBlinkingList isequalto _Index) exitwith {};
				_CtrlList lbsetcursel _Index;
			};

			{
				Private _Ctrl = _ArsenalDisplay displayctrl ((_x >> "idc") call BIS_fnc_getCfgData);
				_Ctrl setvariable ["_Arguments", [_CtrlList, ((_x >> "index") call BIS_fnc_getCfgData)]];

				_Ctrl ctrladdeventhandler ["ButtonDown", _Script];
			} foreach _AllOptionButtons;
		} foreach (UiNameSpace getvariable "VANA_OptionsMenu_PopulateBackgroundLists"); //Elements are added to this array from RscVANABackGroundList 'Onload'
		UiNameSpace setvariable ["VANA_OptionsMenu_PopulateBackgroundLists", nil];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "listcurselchanged":
	{
		_Arguments params
		[
			["_CtrlList", controlnull, [controlnull]],
			"_CtrlOptionButton",
			"_CtrlDescription",
			"_CtrlOptionsMenu"
		];

		_CtrlOptionButton = _ArsenalDisplay displayctrl (_CtrlList lbvalue lbcursel _CtrlList);
		ctrlsetfocus _CtrlOptionButton;

		_CtrlDescription = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_Description;
		_CtrlDescription ctrlSetStructuredText parseText (_CtrlList lbdata lbcursel _CtrlList);

		_CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
		if !((_CtrlOptionsMenu getvariable "BlinkingList") isequalto _CtrlList) then
		{
			ListFade(_CtrlList, 0)
			[_ArsenalDisplay, "ListBlink", [_CtrlList]] spawn VANA_fnc_OptionsMenu;

			{
				private _Ctrl = _ArsenalDisplay displayctrl _x;
				if !(_Ctrl isequalto _CtrlList) then {ListFade(_Ctrl, 1)};
			} foreach IDCS_Lists;
		};

		True
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "listblink":
	{
		_Arguments params
		[
			["_CtrlList", controlnull, [controlnull]],
			"_CtrlOptionsMenu"
		];

		_CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;

		if ((_CtrlOptionsMenu getvariable "BlinkingList") isequalto _CtrlList) exitwith {};
		_CtrlOptionsMenu setvariable ["BlinkingList", _CtrlList];

		while {CtrlFade _CtrlList < 1} do
		{
			ListBlink(_CtrlList, 0.55)
			ListBlink(_CtrlList, 0.150)
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "open":
	{
		params ["_CtrlOptionsMenu","_ctrlMouseBlock","_CtrlTemplate","_InTemplate"];

		_CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
		_CtrlOptionsMenu ctrlenable True;
		_CtrlOptionsMenu ctrlshow True;

		_CtrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		_CtrlMouseBlock ctrlenable True;

		_CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_InTemplate = ctrlFade _CtrlTemplate == 0;

		_CtrlOptionsMenu setvariable ["TemplateWasOpen", ([False, True] select _InTemplate)];
		if _InTemplate then {False call _ShowTemplateUI};

		True
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "close":
	{
		params ["_CtrlOptionsMenu","_CtrlBUTTONOK","_GoToTemplate"];

		[_ArsenalDisplay , "Toggle", [controlnull, True]] spawn VANA_fnc_DropDownMenu;

		_CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
		_CtrlOptionsMenu ctrlenable False;
		_CtrlOptionsMenu ctrlshow False;

		_GoToTemplate = _CtrlOptionsMenu getvariable ["TemplateWasOpen", False];
		if (_ArsenalDisplay getvariable ["ControlIsBeingHeld", False]) then {_GoToTemplate = !_GoToTemplate};

		if _GoToTemplate then
		{
			True call _ShowTemplateUI;
		} else {
			_CtrlBUTTONOK = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
			ctrlsetfocus _CtrlBUTTONOK;
		};

		True
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonapply":
	{


		[_ArsenalDisplay, "Close"] call VANA_fnc_OptionsMenu;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttoncancel":
	{


		[_ArsenalDisplay, "Close"] call VANA_fnc_OptionsMenu;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttondefault":
	{

	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonexport": {[_ArsenalDisplay] call VANA_fnc_TvExport};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonimport":
	{
		params ["_CtrlDropDownMenu"];

		_CtrlDropDownMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenu;

		if !(ctrlenabled _CtrlDropDownMenu) then
		{
			if ismultiplayer exitwith {["showMessage",[_ArsenalDisplay, "Data import disabled when in multiplayer"]] spawn BIS_fnc_arsenal}; //LOCALIZE
			[_ArsenalDisplay, "Import", _Arguments] call VANA_fnc_DropDownMenu;
		} else {
			_CtrlDropDownMenu setvariable ["DropDownMenu_Status", "false"];
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonwipedata":
	{
		params ["_CtrlTreeView","_CtrlDropDownMenu","_CtrlCopyBackup","_SelectedOption"];

		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_CtrlDropDownMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_DropDownMenu;
		_CtrlCopyBackup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CopyBackup;

		if !(ctrlenabled _CtrlDropDownMenu) then
		{
			_SelectedOption = [_ArsenalDisplay, "Defualt", _Arguments] call VANA_fnc_DropDownMenu;
			if !(_SelectedOption isequalto "false") then
			{
				if ([_ArsenalDisplay, "Import/Wipedata", ["wipedata", _SelectedOption]] call VANA_fnc_UIPopup) then
				{
					TvClear _CtrlTreeView;
					UInamespace Setvariable ["VANA_fnc_TreeViewSave_Backup", ([_ArsenalDisplay, False, cbChecked _CtrlCopyBackup] Call VANA_fnc_TvExport)];

					switch _SelectedOption do
					{
						case "layout": {profilenamespace setvariable ["VANA_fnc_TreeViewSave_Data", nil]};
						case "loadout": {profilenamespace setvariable ["bis_fnc_saveInventory_Data", nil]};
						case "both": {profilenamespace setvariable ["VANA_fnc_TreeViewSave_Data", nil]; profilenamespace setvariable ["bis_fnc_saveInventory_Data", nil]};
					};
				};
			};
		} else {
			_CtrlDropDownMenu setvariable ["DropDownMenu_Status", "false"];
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonrestorebackup":
	{
		params ["_CtrlMiscOptions_ButtonRestoreBackup"];

		_CtrlMiscOptions_ButtonRestoreBackup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_MiscOptions_ButtonRestoreBackup;
		switch (Tolower (_Arguments select 0)) do
		{
			case "update": {_CtrlMiscOptions_ButtonRestoreBackup ctrlenable !((uinamespace Getvariable ["VANA_fnc_TreeViewSave_Backup", []]) isequalto [])}; //WIP DONT use CtrlEnable
		};
	};
};
