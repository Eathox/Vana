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
  sleep 1.2;

#define ShowTemplateUI(BOOL)\
  Private _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;\
  _CtrlTemplate ctrlsetfade ([1, 0] select BOOL);\
  _CtrlTemplate ctrlcommit 0;\
  _CtrlTemplate ctrlenable BOOL;\

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "", [""]],
  ["_Arguments", [], [[]]]
];

//dont forget to port over "TEMP_Popup_Value" to the new options system

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

        Private _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
        _CtrlOptionsMenu setvariable ["CurrentList", [_CtrlList, (lbcursel _CtrlList)]];
      };
    } foreach IDCS_Lists;

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

    (_CtrlOptionsMenu getvariable ["CurrentList", [controlnull]]) params
    [
      ["_CtrlList", controlnull, [controlnull]],
      ["_selected", 0, [0]]
    ];
    _CtrlList lbsetcursel _selected;

    _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;\
    _ctrlMouseBlock ctrlenable True;

    _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
    if (CtrlFade _CtrlTemplate < 1) then
    {
      _CtrlOptionsMenu setvariable ["TemplateWasOpen", True];

      ShowTemplateUI(False)
    };

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "close":
  {
    params ["_CtrlOptionsMenu"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    _CtrlOptionsMenu ctrlenable False;
    _CtrlOptionsMenu ctrlshow False;

    if (_CtrlOptionsMenu getvariable ["TemplateWasOpen", False]) then
    {
      ShowTemplateUI(True)
    };

    True
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
      params ["_OptionDescription", "_Index"];

      _OptionDescription = gettext (_x >> "optiondescription");
      _Index = _CtrlList lbadd "";

      _CtrlList lbsetdata [_index, _OptionDescription];
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
      "_CtrlOptionsMenu",
      "_CtrlDescription"
    ];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenu;
    _CtrlOptionsMenu setvariable ["CurrentList", [_CtrlList, (lbcursel _CtrlList)]];

    _CtrlDescription = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_Description;
    _CtrlDescription ctrlsettext (_CtrlList lbdata lbcursel _CtrlList);

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
    _Arguments params [["_CtrlList", controlnull, [controlnull]]];

    while {CtrlFade _CtrlList < 1} do
    {
      ListBlink(_CtrlList, 0.7)
      ListBlink(_CtrlList, 0)
    };
  };
};
