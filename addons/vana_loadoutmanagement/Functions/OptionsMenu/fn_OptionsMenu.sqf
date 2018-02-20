disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define IDCS_Lists\
  [\
    IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_VissualOptions_BackGroundList,\
    981201\
  ]

#define ListFade(LIST,FADE)\
  LIST ctrlsetfade FADE;\
  LIST ctrlcommit 0;

#define ListBlink(LIST,FADE)\
  LIST ctrlsetfade FADE;\
  LIST ctrlcommit 1.2;\
  if(CtrlFade LIST == 1) exitwith {ListFade(LIST,1)};\
  UiSleep 1.2;

#define ShowTemplateUI(BOOL)\
  params ["_CtrlTemplate","_ctrlMouseBlock"];\
  _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;\
  if(BOOL)then{ctrlsetfocus _CtrlTemplate};\
  _CtrlTemplate ctrlsetfade ([1, 0] select BOOL);\
  _CtrlTemplate ctrlcommit 0;\
  _CtrlTemplate ctrlenable BOOL;\
  _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;\
  _ctrlMouseBlock ctrlenable BOOL;\
  _ctrlMouseBlock ctrlshow BOOL;

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "", [""]],
  ["_Arguments", [], [[]]]
];

switch tolower _mode do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  case "init":
  {
    params ["_CtrlButtonApply","_CtrlButtonCancel"];

    _CtrlButtonApply = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonApply;
    _CtrlButtonApply ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Apply'] call VANA_fnc_OptionsMenu;"];

    _CtrlButtonCancel = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_ButtonCancel;
    _CtrlButtonCancel ctrladdeventhandler ["buttonclick","[ctrlparent (_this select 0), 'Cancel'] call VANA_fnc_OptionsMenu;"];

    {
      private _CtrlList = _ArsenalDisplay displayctrl _x;
      _CtrlList ctrladdeventhandler ["LBSelChanged", "[ctrlparent (_this select 0), 'ListCurSelChanged', [(_this select 0)]] call VANA_fnc_OptionsMenu;"];

      if (_x isequalto (IDCS_Lists select 0)) then
      {
        _CtrlList lbsetcursel 0;
      };
    } foreach IDCS_Lists;

    //Porting over old Varibale to new system
    if !(isnil {Profilenamespace getvariable "TEMP_Popup_Value"}) then
    {
      ["DeleteConfirmation", (Profilenamespace getvariable "TEMP_Popup_Value")] call VANA_fnc_SetOptionValue;
      Profilenamespace setvariable ["TEMP_Popup_Value", nil];
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "apply":
  {


    [_ArsenalDisplay, "Close"] call VANA_fnc_OptionsMenu;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "cancel":
  {


    [_ArsenalDisplay, "Close"] call VANA_fnc_OptionsMenu;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "open":
  {
    params ["_CtrlOptionsMenu","_ctrlMouseBlock","_CtrlTemplate"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    _CtrlOptionsMenu ctrlenable True;
    _CtrlOptionsMenu ctrlshow True;

    _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
    _ctrlMouseBlock ctrlenable True;

    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    _InTemplate = ctrlFade _CtrlTemplate == 0;

    _CtrlOptionsMenu setvariable ["TemplateWasOpen", ([False, True] select _InTemplate)];
    if _InTemplate then {ShowTemplateUI(False)};

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "close":
  {
    params ["_CtrlOptionsMenu", "_CtrlCONTROLBAR"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    _CtrlOptionsMenu ctrlenable False;
    _CtrlOptionsMenu ctrlshow False;

    if (_CtrlOptionsMenu getvariable ["TemplateWasOpen", False] && !(_ArsenalDisplay getvariable ["ControlIsBeingHeld", False])) then
    {
      ShowTemplateUI(True)
    } else {
      _CtrlCONTROLBAR = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_CONTROLBAR;
      ctrlsetfocus _CtrlCONTROLBAR;
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "toupper":
  {
    //this is called from RscVANAOptionCategoryTitle and RscVANAOptionText 'Onload'
    _Arguments params [["_Control", controlnull, [controlnull]]];

    _Control ctrlSetText (toUpper (CtrlText _Control));
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "populatelist":
  {
    //this is called from RscVANABackGroundList 'Onload'
    _Arguments params
    [
      ["_CtrlList", controlnull, [controlnull]],
      ["_CurrentConfig", confignull, [confignull]],
      "_ConfigParent",
      "_AllOptionTexts"
    ];

    _ConfigParent = (configHierarchy _CurrentConfig) select 7;
    _AllOptionTexts = "!isnil {(_x >> 'optiondescription') call BIS_fnc_getCfgData}" configClasses (_ConfigParent >> "controls");

    {
      params ["_OptionDescription", "_OptioButtonIdc", "_Index"];

      _OptionDescription = gettext (_x >> "optiondescription");
      _OptioButtonIdc = getnumber (_x >> "optionbuttonidc");
      _Index = _CtrlList lbadd "";

      _CtrlList lbsetdata [_index, _OptionDescription];
      _CtrlList lbsetvalue [_index, _OptioButtonIdc];
    } foreach _AllOptionTexts;

    (ctrlposition _CtrlList) params ["_x","_y","_w","_h"];
    _CtrlList ctrlsetposition [_x,_y,_w,(_h * lbSize _CtrlList)];
    _CtrlList ctrlcommit 0;
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "listcurselchanged":
  {
    _Arguments params
    [
      ["_CtrlList", controlnull, [controlnull]],
      "_CtrlDescription"
    ];

    _CtrlOptionButton = _ArsenalDisplay displayctrl (_CtrlList lbvalue lbcursel _CtrlList);
    ctrlsetfocus _CtrlOptionButton;

    _CtrlDescription = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_Description;
    _CtrlDescription ctrlSetStructuredText parseText (_CtrlList lbdata lbcursel _CtrlList);

    ListFade(_CtrlList, 0)
    [_ArsenalDisplay, "ListBlink", [_CtrlList]] spawn VANA_fnc_OptionsMenu;

    {
      private _Ctrl = _ArsenalDisplay displayctrl _x;
      if !(_Ctrl isequalto _CtrlList) then {ListFade(_Ctrl, 1)};
    } foreach IDCS_Lists;
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
      ListBlink(_CtrlList, 0.20)
    };
  };
};
