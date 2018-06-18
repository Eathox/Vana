disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define TvInfo\
	_TargetTv = tvCurSel _CtrlTreeView;\
	_TvName = _CtrlTreeView tvtext _TargetTv;\
	_TvData = tolower (_CtrlTreeView tvData _TargetTv);\
	_TvDataString = ["Tab", "Loadout"] select (_TvData isequalto "tvloadout");

#define ToggleUI(BOOL)\
	{_x ctrlshow BOOL; _x ctrlenable BOOL} foreach [_CtrlTvUIPopup,_CtrlVanaMouseBlock];\
	if BOOL then {{_x ctrlshow False} foreach [_CtrlRenameEdit, _CtrlPopupCheckBox, _CtrlCheckBoxText, _CtrlHintText, _CtrlCopyBackup]};

params
[
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_Mode", "", [""]],
	["_Arguments", [], [[]]],
	"_ShowUI"
];

_ShowUI =
{
	Params ["_CtrlTvUIPopup","_CtrlVanaMouseBlock","_CtrlRenameEdit","_CtrlPopupCheckBox","_CtrlCheckBoxText","_CtrlHintText","_CtrlCopyBackup"];

	_CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;
	_CtrlVanaMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;
	_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
	_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_TogglePopup;
	_CtrlCheckBoxText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CheckBoxText;
	_CtrlHintText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_HintText;
	_CtrlCopyBackup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CopyBackup;

	switch tolower _This do
	{
		case "hide": {ToggleUI(False)};
		case "rename": {ToggleUI(True) _CtrlRenameEdit ctrlshow True; ctrlSetFocus _CtrlRenameEdit};
		case "delete":
		{
			ToggleUI(True)
			{_x ctrlshow True} foreach [_CtrlPopupCheckBox, _CtrlCheckBoxText, _CtrlHintText];

			_CtrlCheckBoxText ctrlsettext localize "STR_VANA_TogglePopupText_Text";

			ctrlSetFocus _CtrlPopupCheckBox
		};
		case "import/wipedata":
		{
			ToggleUI(True)
			{_x ctrlshow True} foreach [_CtrlCopyBackup, _CtrlCheckBoxText];
			_CtrlCopyBackup cbSetChecked false;

			_CtrlCheckBoxText ctrlsettext "Copy backup to clipboard."; //LOCALIZE

			ctrlSetFocus _CtrlCopyBackup
		};
	};
};

switch (toLower _Mode) do
{
	///////////////////////////////////////////////////////////////////////////////////////////
	case "init":
	{
		params ["_CtrlRenameEdit","_CtrlButtonCancel","_CtrlButtonOk","_CtrlPopupCheckBox","_CtrlCopyBackup"];

		//Hide Vana dint init popup
		"Hide" call _ShowUI;

		//Apply Event handlers
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
		_CtrlRenameEdit ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
		_CtrlRenameEdit ctrladdeventhandler ["KeyDown","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];
		_CtrlRenameEdit ctrladdeventhandler ["char","[ctrlparent (_this select 0),'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];

		_CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonCancel;
		_CtrlButtonCancel ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 979000) setvariable ['UIPopup_Status', false]"];

		_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
		_CtrlButtonOk ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 979000) setvariable ['UIPopup_Status', true]"];

		_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_TogglePopup;
		_CtrlPopupCheckBox ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0), 'KeepFocus'] spawn VANA_fnc_UIPopup;"];
		_CtrlPopupCheckBox ctrladdeventhandler ["CheckedChanged","['DeleteConfirmation', !(['DeleteConfirmation', True] call VANA_fnc_GetOptionValue)] call VANA_fnc_SetOptionValue; [ctrlparent (_this select 0),'UpDateCheckBox'] call VANA_fnc_ArsenalTreeView;"];

		_CtrlCopyBackup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CopyBackup;
		_CtrlCopyBackup ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0),'KeepFocus'] spawn VANA_fnc_UIPopup;"];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "waituntilstatus":
	{
		params ["_CtrlTemplate","_CtrlTvUIPopup","_CtrlRenameEdit","_Status"];

		_CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;

		//Waituntil Confirm or cancel button was pressed
		waituntil {!isnil {_CtrlTvUIPopup getvariable "UIPopup_Status"}};
		_Status = (_CtrlTvUIPopup getvariable "UIPopup_Status");

		"Hide" call _ShowUI;

		_CtrlTvUIPopup setvariable ["UIPopup_Status",nil];
		ctrlsetfocus _CtrlTemplate;

		_Status
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "keepfocus":
	{
		params ["_CtrlTvUIPopup","_CtrlPopupCheckBox","_CtrlRenameEdit","_CtrlCopyBackup"];

		_CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;
		_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_TogglePopup;
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
		_CtrlCopyBackup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CopyBackup;

		//Keep focus on Popup UI
		if (ctrlshown _CtrlTvUIPopup) then {{ctrlSetFocus _x} foreach [_CtrlRenameEdit, _CtrlPopupCheckBox, _CtrlCopyBackup]};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "delete":
	{
		params ["_CtrlTreeView","_CtrlTitle","_CtrlTextMessage","_CtrlButtonOk","_CtrlPopupCheckBox","_TargetTv","_TvName","_TvData","_TvDataString"];

		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		"Delete" call _ShowUI;
		TvInfo

		//Apply header and Message text
		_CtrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Title;
		_CtrlTitle ctrlsettext "Delete Confirmation"; //LOCALIZE

		_CtrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Text;
		_CtrlTextMessage ctrlsetstructuredtext parsetext format ["Delete %1: '%2'",_TvDataString, _TvName]; //LOCALIZE

		_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
		_CtrlButtonOk ctrlenable True;

		//Set checkbox state
		_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_TogglePopup;
		_CtrlPopupCheckBox cbSetChecked !(["DeleteConfirmation", True] call VANA_fnc_GetOptionValue);
		ctrlSetFocus _CtrlPopupCheckBox;

		[_ArsenalDisplay, "WaituntilStatus"] call VANA_fnc_UIPopup;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "rename":
	{
		params ["_CtrlTreeView","_CtrlTitle","_CtrlRenameEdit","_CtrlTextMessage","_TargetTv","_TvName","_TvData","_TvDataString"];

		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		"Rename" call _ShowUI;
		TvInfo

		//Apply header, Message text and clear Rename field
		_CtrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Title;
		_CtrlTitle ctrlsettext "Rename Confirmation"; //LOCALIZE

		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
		_CtrlRenameEdit ctrlsettext "";
		_CtrlRenameEdit ctrlsettext _TvName;

		_CtrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Text;
		_CtrlTextMessage ctrlsetstructuredtext parsetext format ["Rename %1: '%2'", _TvDataString, _TvName]; //LOCALIZE

		[_ArsenalDisplay,"CheckNameTaken"] call VANA_fnc_UIPopup;
		[_ArsenalDisplay,"WaituntilStatus"] call VANA_fnc_UIPopup;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "import/wipedata":
	{
		_Arguments params
		[
			["_Mode", "", [""]],
			["_SelectedOption", "", [""]],
			"_Message",
			"_CtrlTitle",
			"_CtrlTextMessage",
			"_CtrlButtonOk"
		];

		_Message = (["Wipe Data: ", "Overwrite Data: "] select (_Mode isequalto "import")); //LOCALIZE

		"Import/Wipedata" call _ShowUI;
		switch _SelectedOption do
		{
			case "layout": {_Message = _Message + "Layout"}; //LOCALIZE
			case "loadout": {_Message = _Message + "Loadout"}; //LOCALIZE
			case "both": {_Message = _Message + "Layout and Loadout"}; //LOCALIZE
		};

		//Apply header and Message text
		_CtrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Title;
		_CtrlTitle ctrlsettext (["Wipe Data Confirmation", "Import Confirmation"] select (_Mode isequalto "import")); //LOCALIZE

		_CtrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Text;
		_CtrlTextMessage ctrlsetstructuredtext parsetext _Message;

		_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
		_CtrlButtonOk ctrlenable True;

		[_ArsenalDisplay, "WaituntilStatus"] call VANA_fnc_UIPopup;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "checknametaken":
	{
		params ["_CtrlTreeView","_CtrlRenameEdit","_CtrlButtonOk","_SavedLoadouts","_Name","_TargetTv","_TvName","_TvData","_TvDataString","_Duplicate"];

		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
		_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
		_SavedLoadouts = (profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]]) select {_x isequaltype ""};

		_Name = ctrltext _CtrlRenameEdit;
		TvInfo

		//Check if name duplicate and color edit field accordingly
		_Duplicate = [False, _Name in _SavedLoadouts] select (_TvData isequalto "tvloadout");
		_CtrlButtonOk ctrlenable ([True, False] select (_Duplicate || _Name isequalto "" || _Name isequalto _TvName));

		_Duplicate
	};
};
