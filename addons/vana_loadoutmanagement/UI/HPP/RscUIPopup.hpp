#define true 1
#define false 0

class VANA_UIPopupControlGroup: RscControlsGroupNoScrollbars
{
  idc=979000;
  x="10.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
  y="7 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
  w="18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
  h="5.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
  class Controls
  {
    class VANA_Title: RscVANATitleBar
    {
      idc=979001;
      text=$STR_VANA_Title_Text;
      x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]=
      {
        "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_A',1.21])"
      };
    };
    class VANA_Picture: RscPictureKeepAspect
    {
      idc=979002;
      text="\vana_LoadoutManagement\UI\Data_Icons\Vana (Small) - WhiteText NoBackground.paa";
      x="17.0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="0.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="1.6 *					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="0.80 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class VANA_BackGround: RscBackgroundGUI
    {
      idc=979003;
      x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="1.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="2.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]={0,0,0,1.21};
    };
    class VANA_Text: RscStructuredText
    {
      text=$STR_VANA_Text_Text;
      idc=979004;
      x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="1.3 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      sizeEx="0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class VANA_ButtonCancel: RscButtonMenuCancel
    {
      onButtonClick="Private _Display = ctrlparent (_this select 0); If !(_Display getvariable ['Vana_Initialised', false]) then {_Display displayctrl 979000 ctrlshow false;}";
      idc=979005;
      colorBackground[]={0,0,0,1.21};
      x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="3.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class VANA_BackgroundButtonMiddle: BackgroundButtonOK
    {
      idc=979006;
      x="6.3 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="3.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]={0,0,0,1.21};
    };
    class VANA_ButtonOK: RscButtonMenuOk
    {
      onButtonClick="Private _Display = ctrlparent (_this select 0); If !(_Display getvariable ['Vana_Initialised', false]) then {_Display displayctrl 979000 ctrlshow false;}";
      text=$STR_VANA_ButtonOK_Text;
      idc=979007;
      colorBackground[]={0,0,0,1.21};
      x="12.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="3.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class VANA_TogglePopup: RscCheckbox
    {
      show=false;
      default=0;
      idc=979008;
      x="0.1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="2.65 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]={0,0,0,1.21};
    };
    class VANA_CheckboxText: RscText
    {
      show=false;
      idc=979009;
      text=$STR_VANA_CheckboxText_Text;
      x="0.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="2.66 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="3.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      sizeEx="0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class VANA_HintText: RscText
    {
      show=false;
      idc=979010;
      style=1;
      text=$STR_VANA_HintText_Text;
      x="9.25 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="2.66 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="9.55 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      sizeEx="0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class VANA_RenameEdit: RscEdit
    {
      show=false;
      idc=979011;
      x="0.3 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="2.45 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="18.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      sizeEx="0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
  };
};
