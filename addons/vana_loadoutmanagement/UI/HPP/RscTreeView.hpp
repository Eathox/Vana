#define true 1
#define false 0

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
      color[]={0.95,0.95,0.95,1};
      colorText[]={1,1,1,1};
      colorDisabled[]={1,1,1,0.25};
      colorPicture[]={1,1,1,1};
      colorPictureSelected[]={1,1,1,1};
      colorPictureDisabled[]={1,1,1,1};
      disableKeyboardSearch = false;
      multiselectEnabled = 0;
      expandOnDoubleclick = 0;

      class ScrollBar: ScrollBar
      {
        color[] = {0.95,0.95,0.95,1};
      };
    };
    class TextName: RscText //Relocation of Vanila UI
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
    class VANA_TitlePicture: RscPictureKeepAspect
    {
      idc=978000;
      text="\vana_LoadoutManagement\UI\Data_Icons\Vana (Small) - WhiteText NoBackground.paa";
      x="18.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="0.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="1.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="0.80 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
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
      text="\vana_LoadoutManagement\UI\Data_Icons\ButtonTabCreate.paa";
      tooltip=$STR_VANA_ButtonCreate_ToolTip;
      x="18.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      y="19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
      w="1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
      h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };
    class VANA_ButtonRename: RscVANAPictureButton
    {
      idc=978003;
      text="\vana_LoadoutManagement\UI\Data_Icons\ButtonRename.paa";
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
      colorBackground[]={0,0,0,0.8};
      colorBackgroundFocused[] ={0,0,0,0.8};
      colorBackgroundHover[] ={0,0,0,0.8};
      colorBackgroundPressed[] ={0,0,0,0.8};
      colorBackgroundDisabled[] ={0,0,0,0.8};
    };
  };
};
