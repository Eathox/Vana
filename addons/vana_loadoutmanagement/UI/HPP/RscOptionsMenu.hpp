#define true 1
#define false 0

class VANA_OptionsMenuControlGroup: RscControlsGroup
{
  idc=980000;
  show=false;
  x="10 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
  y="0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
  w="20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
  h="22.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
  class controls
  {
    class Title: RscTitle
    {
      idc=-980001;
      style=0;
      colorBackground[]=
      {
        "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
      };
      text="Options Menu";
      x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class TitlePicture: RscPictureKeepAspect
    {
      idc=-1;
      text="\vana_LoadoutManagement\UI\Data_Icons\Vana (Small) - WhiteText NoBackground.paa";
      x="18.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="0.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="1.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="0.80 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class MainBackground: RscBackgroundGUI
    {
      idc=-1;
      x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="1.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="20 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]={0,0,0,0.8};
    };
    class SecondaryBackground: RscBackgroundGUI
    {
      idc=-1;
      x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="16 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]={1,1,1,0.2};
    };
    class TextField: RscStructuredText
    {
      text="Theres room for some text here<br/>Yep<br/>Wo, wo";
      idc=980002;
      x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="18.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      size="0.82 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]={0,0,0,0.4};
    };
    class ButtonOK: RscButtonMenu
    {
      idc=980003;
      text="Apply";
      x="15 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class ButtonCancel: RscButtonMenu
    {
      idc=980004;
      text="$STR_DISP_CANCEL";
      x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };

    class OptionsList: RscControlsGroupNoScrollbars
    {
      idc=981000;
      x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="16 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

      class VScrollbar: ScrollBar
      {
        width=0.02;
        autoScrollEnabled=1;
      };

      class controls
      {
        class TextField1: RscStructuredText
        {
          text="Theres room for some text here<br/>Yep<br/>Wo, wo";
          idc=-1;
          x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          h="22 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          size="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
      };
    };
  };
};
