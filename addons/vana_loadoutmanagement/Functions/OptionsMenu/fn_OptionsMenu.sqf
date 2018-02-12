disableserialization;

#include "\vana_LoadoutManagement\UI\defineDIKCodes.inc"
#include "\vana_LoadoutManagement\UI\defineResinclDesign.inc"

#define ShowTemplateUI(BOOL)\
  Private _CtrlTemplate = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;\
  _CtrlTemplate ctrlsetfade ([1, 0] select BOOL);\
  _CtrlTemplate ctrlcommit 0;\
  _CtrlTemplate ctrlenable BOOL;\
  private _ctrlMouseBlock = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;\
  _ctrlMouseBlock ctrlenable BOOL;

params
[
  ["_ArsenalDisplay", displaynull, [displaynull]],
  ["_Mode", "", [""]]
];

switch tolower _mode do
{
  ///////////////////////////////////////////////////////////////////////////////////////////
  case "init":
  {

    True
  };

  ///////////////////////////////////////////////////////////////////////////////////////////
  case "open":
  {
    params ["_CtrlOptionsMenu", "_CtrlTemplate"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenuControlGroup;
    _CtrlOptionsMenu ctrlshow true;

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
    params ["_CtrlOptionsMenu", "_CtrlTemplate"];

    _CtrlOptionsMenu = _ArsenalDisplay displayctrl IDC_RSCDISPLAYARSENAL_VANA_OPTIONS_OptionsMenuControlGroup;
    _CtrlOptionsMenu ctrlshow False;

    if (_CtrlOptionsMenu getvariable ["TemplateWasOpen", False]) then
    {
      ShowTemplateUI(True)
    };

    True
  };
};
