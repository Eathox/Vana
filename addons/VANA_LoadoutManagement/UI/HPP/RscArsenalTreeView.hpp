#define true 1
#define false 0

class RscDisplayArsenal //Path to add code to allready exsisting Rsc class
{
  scriptName="fn_Vana_Init";
  scriptPath="VANACoreFNC";
  onLoad="['onLoad',_this,'fn_Vana_Init','VANACoreFNC'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
  onUnload="['onUnload',_this,'fn_Vana_Init','VANACoreFNC'] call (uinamespace getvariable 'BIS_fnc_initDisplay')"; // calls VANA Script instead of A3
  class controls //Path to add code to allready exsisting Rsc class
  {
    class Template: RscControlsGroup //Path to add code to allready exsisting Rsc class
    {
      class controls //Path to add code to allready exsisting Rsc class
      {
        class ValueName: RscTree //Changing the loadout list to a treeview UI type
				{
					idc=35119;
					x="0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y="1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx="0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          style=16;
        	shadow=0;
        	font="RobotoCondensed";
        	color[]={0.94999999,0.94999999,0.94999999,1};
        	colorText[]={1,1,1,1};
        	colorDisabled[]={1,1,1,0.25};
        	colorPicture[]={1,1,1,1};
        	colorPictureSelected[]={1,1,1,1};
        	colorPictureDisabled[]={1,1,1,1};
          disableKeyboardSearch = false;
          multiselectEnabled = 0;

          class ScrollBar: ScrollBar
    			{
    				color[] = {0.94999999,0.94999999,0.94999999,1};
    		  };
				};
        class TextName: RscText //Relocationg of Vanila UI
				{
					style=1;
					idc=34621;
					text=$STR_VANA_TextName_Text;
					x="-2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y="19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w="5.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[]={0,0,0,0.2};
					sizeEx="0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class EditName: RscEdit //Relocationg of Vanila UI
				{
					idc=35020;
					x="3.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y="19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w="13.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx="0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
        class VANA_TitlePicture: RscVANAPictureButton
        {
          type=0;
          idc=978000;
          x="18.19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          y="0.05 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          w="1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          text="\VANA_LoadoutManagement\UI\Data_Icons\Vana (Small) - WhiteText NoBackground.paa";
        };
        class VANA_DecorativeBar: RscBackgroundGUI
        {
          show=false;
          idc=978001;
          x="17 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y="19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w="3 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          colorBackground[]={0,0,0,0.2};
        };
        class VANA_ButtonCreate: RscVANAPictureButton
        {
        	idc=978002;
          text="\VANA_LoadoutManagement\UI\Data_Icons\entityList_layer_ca.paa";
          tooltip=$STR_VANA_ButtonCreate_ToolTip;
          x="18.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y="19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class VANA_ButtonRename: RscVANAPictureButton
        {
          idc=978003;
          text="\VANA_LoadoutManagement\UI\Data_Icons\portraitMissionName_ca.paa";
          tooltip=$STR_VANA_ButtonRename_ToolTip;
          x="17.3  * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          y="19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };
        class VANA_DelConfirmToggle: RscCheckbox
        {
          default=0;
          idc=978004;
          tooltip=$STR_VANA_TempCheckbox_ToolTip;
          x="5.1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          y="21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          colorBackground[]={0,0,0,0.80000001};
          colorBackgroundFocused[] ={0,0,0,0.80000001};
          colorBackgroundHover[] ={0,0,0,0.80000001};
          colorBackgroundPressed[] ={0,0,0,0.80000001};
          colorBackgroundDisabled[] ={0,0,0,0.80000001};
        };
      };
    };

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
          text=$STR_VANA_Title_Text;
          idc=979001;
          x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          y="0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          w="18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          colorBackground[]=
          {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
            1
          };
        };
        class VANA_Picture: RscVANAPictureButton
        {
          type=0;
          idc=979002;
          x="16.99 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y="0.05 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				  w="1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          text="\VANA_LoadoutManagement\UI\Data_Icons\Vana (Small) - WhiteText NoBackground.paa";
        };
        class VANA_BackGround: RscBackgroundGUI
        {
          idc=979003;
          x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          y="1.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          w="18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
          h="2.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
          colorBackground[]={0,0,0,1};
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
          onButtonClick="with uinamespace do {If !((ctrlparent (_this select 0)) getvariable ['Vana_Initialised', False]) then {(ctrlparent (_this select 0) displayctrl 979000) ctrlshow False;}}";
          idc=979005;
          colorBackground[]={0,0,0,1};
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
        };
        class VANA_ButtonOK: RscButtonMenuOk
        {
          onButtonClick="with uinamespace do {If !((ctrlparent (_this select 0)) getvariable ['Vana_Initialised', False]) then {(ctrlparent (_this select 0) displayctrl 979000) ctrlshow False;}}";
          text=$STR_VANA_ButtonOK_Text;
          idc=979007;
          colorBackground[]={0,0,0,1};
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

    class VANA_Mouseblock: RscBackgroundGUI
    {
      show=false;
      idc=978090;
      style=16;
      x="safezoneX";
      y="safezoneY";
      w="safezoneW";
      h="safezoneH";
      colorBackground[]={0,0,0,0.35};
    };
  };
};
