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
      text="Options";
      x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class VANA_TitlePicture: RscPictureKeepAspect
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
    class Description: RscStructuredText
    {
      text="Theres room for some text here<br/>Yep<br/>Wo, wo";
      idc=980002;
      x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="18.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      size="0.82 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]={0,0,0,0.3};
    };
    class ButtonApply: RscButtonMenu
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
    class OptionsListBackground: RscBackgroundGUI
    {
      idc=-1;
      x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="16 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      colorBackground[]={1,1,1,0.2};
    };

    class OptionsList: RscControlsGroupNoScrollbars
    {
      idc=981000;
      x="0.45 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="19.1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="16 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

      class VScrollbar: ScrollBar
      {
        width=0.019;
        autoScrollEnabled=1;
      };

      class controls
      {
        class VissualOptions: RscVANAOptionGroup
        {
        	idc=981100;
          x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          h="(3* 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

        	class controls
        	{
            class BackGroundList: RscVANABackGroundList
            {
              idc=981101;
            };
            class VissualOptionsTitle: RscVANAOptionCategoryTitle
            {
              idc=-1;
              text="Vissual";
              x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            };
            class LoadoutIcontext: RscVANAOptionText
            {
              idc=-1;
              text="Loadout Icon";
              optiondescription="Lets you select the icon";
              y="(1.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class ColorCoding: RscVANAOptionText
            {
              idc=-1;
              text="Color Coding For";
              optiondescription="Color code tabs and loadouts";
              y="(2.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
          };
        };

        class MiscOptions: RscVANAOptionGroup
        {
          idc=981200;
          x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          y="4 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          h="(4* 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

          class controls
          {
            class BackGroundList: RscVANABackGroundList
            {
              idc=981201;
            };
            class MiscOptionsTitle: RscVANAOptionCategoryTitle
            {
              idc=-1;
              text="Miscellaneous";
              x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
            };
            class LayoutText: RscVANAOptionText
            {
              idc=-1;
              text="TreeView Layout";
              optiondescription="Dummy";
              optionbuttonidc=981202;
              y="(1.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class ExportButton: RscVANAPictureButton
            {
              idc=981202;
              text="\vana_LoadoutManagement\UI\Data_Icons\ButtonExport.paa";
              index=1;
              periodFocus=0;
              period=0;
              y="(1.08 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
              x="16.85 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
              w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
              h="1* 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
              colorBackground[]={0,0,0,0.8};
              colorBackgroundFocused[] ={0,0,0,0.8};
              colorBackgroundHover[] ={0,0,0,0.8};
              colorBackgroundPressed[] ={0,0,0,0.8};
              colorBackgroundDisabled[] ={0,0,0,0.8};
            };
            class ImportButton: RscVANAPictureButton
            {
              idc=981203;
              text="\vana_LoadoutManagement\UI\Data_Icons\ButtonImport.paa";
              index=1;
              periodFocus=0;
              period=0;
              y="(1.08 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
              x="17.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
              w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
              h="1* 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
              colorBackground[]={0,0,0,0.8};
              colorBackgroundFocused[] ={0,0,0,0.8};
              colorBackgroundHover[] ={0,0,0,0.8};
              colorBackgroundPressed[] ={0,0,0,0.8};
              colorBackgroundDisabled[] ={0,0,0,0.8};
            };
            class ResetText: RscVANAOptionText
            {
              idc=-1;
              text="Reset TreeView";
              optiondescription="Dummy";
              optionbuttonidc=981204;
              y="(2.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class ResetButton: RscVANAOptionButton
            {
              idc=981204;
              text="Reset";
              index=2;
              y="(2.07 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
              x="14.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
              w="4 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
              h="1* 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class WipeDataText: RscVANAOptionText
            {
              idc=-1;
              text="Wipe Data";
              optiondescription="Dummy";
              optionbuttonidc=981205;
              y="(3.1 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
            class WipeDataButton: RscVANAOptionButton
            {
              idc=981205;
              text="WIPE";
              index=3;
              y="(3.07 * 1.2) * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
              x="14.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
              w="4 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
              h="1* 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
            };
          };
        };
      };
    };
  };
};
