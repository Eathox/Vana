disableserialization;

//WIP go through all fucntions and make sure they are compatibale with the new UIPopup Params/Return Values

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

params [
	["_ArsenalDisplay", displaynull, [displaynull]],
	["_AllText", [], [[]]],
	["_CheckboxInfo", [], [[]]],
	["_EditFieldInfo", [], [[]]],
	["_Mode", "Defualt", [""]],
	"_ShowUI"
];

_AllText params [
	["_TitleText", "", [""]],
	["_MessageText", "", [""]],
	["_HintText", "", [""]]
];
_CheckboxInfo params [
	["_ShowcheckBox", False, [False]],
	["_CheckBoxChecked", False, [False]],
	["_CheckBoxText", "", [""]]
];
_EditFieldInfo params [
	["_ShowEditField", False, [False]],
	["_EditFieldText", "", [""]]
];

_ShowUI = {
	Params ["_CtrlTvUIPopup","_CtrlVanaMouseBlock","_CtrlRenameEdit","_CtrlPopupCheckBox"];
	_CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;
	_CtrlVanaMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_Mouseblock;
	_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
	_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CheckBox;

	{_x ctrlshow _this; _x ctrlenable _this} Count [_CtrlTvUIPopup, _CtrlVanaMouseBlock];
	if (_this) then {{_x ctrlshow False} Count [_CtrlRenameEdit, _CtrlPopupCheckBox]};
};

switch (toLower _Mode) do {
	case "init": {
		params ["_CtrlRenameEdit","_CtrlButtonCancel","_CtrlButtonOk","_CtrlPopupCheckBox"];

		//Hide Vana dint init popup
		False call _ShowUI;

		//Apply Event handlers
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
		_CtrlRenameEdit ctrladdeventhandler ["KeyDown","[ctrlparent (_this select 0),[],[],[],'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];
		_CtrlRenameEdit ctrladdeventhandler ["char","[ctrlparent (_this select 0),[],[],[],'CheckNameTaken'] spawn VANA_fnc_UIPopup;"];

		_CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonCancel;
		_CtrlButtonCancel ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 979000) setvariable ['UIPopup_Status', false]"];

		_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
		_CtrlButtonOk ctrladdeventhandler ["buttonclick","(ctrlParent (_this select 0) displayctrl 979000) setvariable ['UIPopup_Status', true]"];

		_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CheckBox;
		{_x ctrladdeventhandler ["killFocus","[ctrlparent (_this select 0),[],[],[],'KeepFocus'] spawn VANA_fnc_UIPopup;"]} foreach [_CtrlRenameEdit,_CtrlButtonOk,_CtrlPopupCheckBox];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "checknametaken": {
		params ["_CtrlTreeView","_CtrlRenameEdit","_CtrlButtonOk","_SavedLoadouts","_EditName","_TargetTv","_TvName","_TvData","_Duplicate"];

		_CtrlTreeView = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
		_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;
		_SavedLoadouts = (profilenamespace getvariable ["bis_fnc_saveInventory_Data",[]]) select {_x isequaltype ""};

		_EditName = ctrltext _CtrlRenameEdit;
		_TargetTv = tvCurSel _CtrlTreeView;
		_TvName = _CtrlTreeView tvtext _TargetTv;
		_TvData = tolower (_CtrlTreeView tvData _TargetTv);

		//Check if name duplicate and color edit field accordingly
		_Duplicate = [False, _EditName in _SavedLoadouts] select (_TvData isequalto "tvloadout");
		_CtrlButtonOk ctrlenable ([True, False] select (_Duplicate || _EditName isequalto "" || _EditName isequalto _TvName));

		_Duplicate
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "waituntilstatus": {
		params ["_CtrlTemplate","_CtrlTvUIPopup","_CtrlPopupCheckBox","_CtrlRenameEdit","_Status"];

		_CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;
		_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CheckBox;
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;

		//Waituntil Confirm or cancel button was pressed
		waituntil {!isnil {_CtrlTvUIPopup getvariable "UIPopup_Status"}};
		_Status = (_CtrlTvUIPopup getvariable "UIPopup_Status");

		False call _ShowUI;

		_CtrlTvUIPopup setvariable ["UIPopup_Status",nil];
		ctrlsetfocus _CtrlTemplate;

		[_Status, (cbchecked _CtrlPopupCheckBox), (ctrltext _CtrlRenameEdit)]
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "keepfocus": {
		params ["_CtrlTvUIPopup","_CtrlPopupCheckBox","_CtrlRenameEdit","_CtrlButtonOk"];

		_CtrlTvUIPopup = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_UIPopup;
		_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CheckBox;
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
		_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;

		if !(ctrlshown _CtrlTvUIPopup) exitwith {};

		//Keep focus on Popup UI
		if !(ctrlshown _CtrlRenameEdit) then {
			if !(ctrlshown _CtrlPopupCheckBox) then {
				ctrlSetFocus _CtrlButtonOk;
			} else {ctrlSetFocus _CtrlPopupCheckBox};
		} else {ctrlSetFocus _CtrlRenameEdit};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "defualt": {
		params ["_CtrlTitle","_CtrlTextMessage","_CtrlHintText","_CtrlCheckBoxText","_CtrlPopupCheckBox","_CtrlRenameEdit","_CtrlButtonOk"];

		True call _ShowUI;

		_CtrlTitle = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Title;
		_CtrlTextMessage = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_Text;
		_CtrlHintText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_HintText;
		_CtrlCheckBoxText = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CheckBoxText;
		_CtrlPopupCheckBox = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_CheckBox;
		_CtrlRenameEdit = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_RenameEdit;
		_CtrlButtonOk = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_UIPOPUP_ButtonOK;

		//_AllText
		_CtrlTitle ctrlsettext _TitleText;
		_CtrlTextMessage ctrlsetstructuredtext parsetext _MessageText;
		_CtrlHintText ctrlSetText _HintText;

		//_CheckboxInfo
		if !(_ShowEditField) then {
			_CtrlPopupCheckBox ctrlshow _ShowcheckBox;
			_CtrlPopupCheckBox cbSetChecked _CheckBoxChecked;
			_CtrlCheckBoxText ctrlSetText _CheckBoxText;
		} else {_CtrlCheckBoxText ctrlSetText ""};

		//_EditFieldInfo
		_CtrlRenameEdit ctrlshow _ShowEditField;
		_CtrlRenameEdit ctrlSetText _EditFieldText;

		if !(_ShowEditField) then {
			if !(_ShowcheckBox) then {
				ctrlSetFocus _CtrlButtonOk;
			} else {ctrlSetFocus _CtrlPopupCheckBox};
		} else {ctrlSetFocus _CtrlRenameEdit};

		_CtrlButtonOk ctrlenable True;
		if (_ShowEditField) then {[_ArsenalDisplay,[],[],[],"CheckNameTaken"] call VANA_fnc_UIPopup};
		[_ArsenalDisplay,[],[],[],"WaituntilStatus"] call VANA_fnc_UIPopup;
	};
};
