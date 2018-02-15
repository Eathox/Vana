// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_LINEBREAK        98
#define CT_OBJECT_CONT_ANIM 83
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_GROUP_BOX       96
#define ST_GROUP_BOX2      112
#define ST_ROUNDED_CORNER  ST_GROUP_BOX + ST_CENTER
#define ST_ROUNDED_CORNER2 ST_GROUP_BOX2 + ST_CENTER
#undef ST_GROUP_BOX
#undef ST_GROUP_BOX2

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

// Import from editor defines
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

// Forward declare the default base classes.
class IGUIBack;
class RscFrame;
class RscEdit;
class RscText;
class RscCombo;
class RscMessageBox;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscStructuredText;
class RscSlider;
class ScrollBar;
class RscXSliderH;
class RscListNBox;
class RscListBox;
class RscTree;
class RscTitle;
class RscPicture;
class RscPictureKeepAspect;
class ctrlDefault;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscBackgroundGUI;
class RscBackgroundGUITop;
class BackgroundButtonOK;
class RscShortcutButton;
class RscButtonMenu;
class RscCheckBox;

class RscVANAPictureButton:	RscButtonMenu
{
	type=1;
	style="0x02 + 0x30 + 0x800";
	colorBackground[]={0,0,0,0};
	colorBackgroundDisabled[]={0,0,0,0};
	colorBackgroundActive[]={1,1,1,0.7};
	colorFocused[]={1,1,1,0.7};
	borderSize=0;
	colorBorder[]={0,0,0,0};
	colorShadow[]={0,0,0,0};
	offsetX=0;
	offsetY=0;
	offsetPressedX="pixelW";
	offsetPressedY="pixelH";
};

class RscVANABackGroundList: RscListBox
{
	idc=-1;
	colorselectBackground[]={1,1,1,0.5};
	colorBackground[]={0,0,0,0};
	canDrag=false;
	onload="[ctrlparent (_this select 0), 'PopulateList', _this] call VANA_fnc_OptionsMenu"
	rowHeight="1* 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	x="0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	y="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w="19.1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};

class RscVANAOptionCategoryTitle: RscText
{
	idc=-1;
	shadow=0;
	Text="DUMMY";
	font="RobotoCondensedBold";
	w="19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	sizeEx="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};

class RscVANAOptionText: RscText
{
	idc=-1;
	shadow=0;
	Text="DUMMY OPTION";
	optiondescription="Dummy";
	y="(1* 1.35) * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	x="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w="18 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	h="1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	sizeEx="0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};

class RscVANAOptionGroup: RscControlsGroupNoScrollbars
{
	idc=-1;
	w="19.1 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	h="16 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};
