/* See LICENSE file for copyright and license details. */

/* appearance */
static unsigned int borderpx  = 3;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static unsigned int gappih    = 10;       /* horiz inner gap between windows */
static unsigned int gappiv    = 10;       /* vert inner gap between windows */
static unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static int smartgaps          = 1;        /* 1 means no outer gap when there is only one window */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 0;        /* 0 means bottom bar */
static int user_bh            = 32;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const char *fonts[]    = { "SFNS Display:style=Regular:size=11:antialias=true:autohint=true", "FontAwesome:style=Regular:size=11:antialias=true:autohint=true", "Font awesome 5 Free Solid:style=Solid:size=11:antialias=true:autohint=true" };
static char dmenufont[]       = "SFNS Display:style=Regular:size=11:antialias=true:autohint=true";
static char normbgcolor[]     = "#222222";
static char normbordercolor[] = "#444444";
static char normfgcolor[]     = "#bbbbbb";
static char selfgcolor[]      = "#eeeeee";
static char selbordercolor[]  = "#005577";
static char selbgcolor[]      = "#005577";
static char urgbordercolor[]  = "#ff0000";
static const unsigned int baralpha = 100;
static const unsigned int borderalpha = OPAQUE;
static char *colors[][3] = {
	/*               fg           bg           border   */
	[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
	[SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
	[SchemeUrg]  = { selfgcolor,  selbgcolor,  urgbordercolor  },
};

static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};
 
/* tagging */
static const char *tags[] = { "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  " };

/* rules */
static const Rule rules[] = {
	/* xprop(1):
	 * WM_CLASS(STRING) = instance, class
	 * WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "Gimp",    NULL,     NULL,           1 << 5,    0,          0,           0,        -1 },
	{ "firefox", NULL,     NULL,           1 << 4,    0,          0,          -1,        -1 },
	{ "St",      NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ "URxvt",   NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ "st-256color", NULL, NULL,           0,         0,          1,           0,        -1 },
	{ "Thunar",  NULL,     NULL,           0,         1,          0,           0,        -1 },
	{ "Galculator",  NULL, NULL,           0,         1,          0,           0,        -1 },
	{ "Dragon-drag-and-drop",  NULL, NULL, 0,         1,          0,           0,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static int attachdirection = 0; /* 0 default, 1 above, 2 aside, 3 below, 4 bottom, 5 top */

/* Xresources preferences to load at startup */
ResourcePref resources[] = {
	{ "borderpx",           INTEGER, &borderpx },
	{ "snap",               INTEGER, &snap },
	{ "swallowfloating",    INTEGER, &swallowfloating },
	{ "gappih",             INTEGER, &gappih },
	{ "gappiv",             INTEGER, &gappiv },
	{ "gappoh",             INTEGER, &gappoh },
	{ "gappov",             INTEGER, &gappov },
	{ "smartgaps",          INTEGER, &smartgaps },
	{ "showbar",            INTEGER, &showbar },
	{ "topbar",             INTEGER, &topbar },
	{ "user_bh",            INTEGER, &user_bh },
	{ "color0",             STRING,  &normbordercolor },
	{ "color7",             STRING,  &selbordercolor },
	{ "color0",             STRING,  &normbgcolor },
	{ "color4",             STRING,  &normfgcolor },
	{ "color0",             STRING,  &selfgcolor },
	{ "color4",             STRING,  &selbgcolor },
	{ "color1",             STRING,  &urgbordercolor },
	{ "mfact",              FLOAT,   &mfact },
	{ "nmaster",            INTEGER, &nmaster },
	{ "resizehints",        INTEGER, &resizehints },
	{ "lockfullscreen",     INTEGER, &lockfullscreen },
	{ "attachdirection",    INTEGER, &attachdirection },
};

#define FORCE_VSPLIT 1 /* nrowgrid layout: force two clients to always split vertically */

#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",     tile }, /* first entry is default */
	{ "[M]",     monocle },
	{ "[@]",     spiral },
	{ "[\\]",    dwindle },
	{ "H[]",     deck },
	{ "TTT",     bstack },
	{ "===",     bstackhoriz },
	{ "HHH",     grid },
	{ "###",     nrowgrid },
	{ "---",     horizgrid },
	{ ":::",     gaplessgrid },
	{ "|M|",     centeredmaster },
	{ ">M>",     centeredfloatingmaster },
	{ "><>",     NULL }, /* no layout function means floating behavior */
	{ NULL,      NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#include <X11/XF86keysym.h>

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]       = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-l", "10", "-p", "Lancer", NULL };
static const char *dmenuwdcmd[]     = { "dmenu-show-opened-windows", dmenufont, NULL };
static const char *dmenucpcmd[]     = { "clipmenu", "-fn", dmenufont, "-l", "5", "-p", "Copier", NULL };
static const char *dmenustcmd[]     = { "dmenu-stop", dmenufont, NULL };
static const char *dmenusearchcmd[] = { "dmenu-search", dmenufont, NULL };
static const char *dmenukillcmd[]   = { "dmenu-kill", dmenufont, NULL };
static const char *termcmd[]        = { "st", NULL };

static Key keys[] = {
	/* modifier                     key             function              argument */
	{ MODKEY,                       XK_d,           spawn,                {.v = dmenucmd } },
	{ MODKEY,                       XK_x,           spawn,                {.v = dmenukillcmd } },
	{ MODKEY,                       XK_w,           spawn,                {.v = dmenuwdcmd } },
	{ MODKEY,                       XK_c,           spawn,                {.v = dmenucpcmd } },
	{ MODKEY,                       XK_r,           spawn,                {.v = dmenusearchcmd } },
	{ MODKEY,                       XK_Return,      spawn,                {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_h,           spawn,                {.v = dmenustcmd } },
	{ MODKEY,                       XK_b,           togglebar,            {0} },
	{ MODKEY,                       XK_k,           focusstack,           {.i = +1 } },
	{ MODKEY,                       XK_j,           focusstack,           {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_k,           pushdown,             {0} },
	{ MODKEY|ShiftMask,             XK_j,           pushup,               {0} },
	{ MODKEY,                       XK_i,           incnmaster,           {.i = +1 } },
	{ MODKEY,                       XK_o,           incnmaster,           {.i = -1 } },
	{ MODKEY,                       XK_h,           setmfact,             {.f = -0.05} },
	{ MODKEY,                       XK_l,           setmfact,             {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return,      zoom,                 {0} },
	{ MODKEY|Mod1Mask,              XK_u,           incrgaps,             {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_u,           incrgaps,             {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_i,           incrigaps,            {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_i,           incrigaps,            {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_o,           incrogaps,            {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_o,           incrogaps,            {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_h,           incrihgaps,           {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_h,           incrihgaps,           {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_v,           incrivgaps,           {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_v,           incrivgaps,           {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_j,           incrohgaps,           {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_j,           incrohgaps,           {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_b,           incrovgaps,           {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_b,           incrovgaps,           {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_g,           togglegaps,           {0} }, 
	{ MODKEY|Mod1Mask|ShiftMask,    XK_g,           defaultgaps,          {0} },
	{ MODKEY,                       XK_Tab,         view,                 {0} },
	{ MODKEY|ControlMask,           XK_Right,       shiftviewclients,     { .i = +1 } },
	{ MODKEY|ControlMask,           XK_Left,        shiftviewclients,     { .i = -1 } },
	{ MODKEY|ShiftMask,             XK_a,           killclient,           {0} },
	{ MODKEY,                       XK_t,           setlayout,            {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,           setlayout,            {.v = &layouts[11]} },
	{ MODKEY,                       XK_f,           setlayout,            {.v = &layouts[1]} },
	{ MODKEY,                       XK_s,           setlayout,            {.v = &layouts[2]} },
	{ MODKEY,                       XK_g,           setlayout,            {.v = &layouts[7]} },
	{ MODKEY,                       XK_space,       setlayout,            {0} },
	{ MODKEY|ShiftMask,             XK_space,       togglefloating,       {0} },
	{ MODKEY|ShiftMask,             XK_f,           togglefullscr,        {0} },
	{ MODKEY|ShiftMask,             XK_y,           togglefakefullscreen, {0} },
	{ MODKEY,                       XK_agrave,      view,                 {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_agrave,      tag,                  {.ui = ~0 } },
	{ MODKEY,                       XK_Left,        focusmon,             {.i = -1 } },
	{ MODKEY,                       XK_Right,       focusmon,             {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Left,        tagmon,               {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Right,       tagmon,               {.i = +1 } },
	TAGKEYS(                        XK_ampersand,                         0)
	TAGKEYS(                        XK_eacute,                            1)
	TAGKEYS(                        XK_quotedbl,                          2)
	TAGKEYS(                        XK_apostrophe,                        3)
	TAGKEYS(                        XK_parenleft,                         4)
	TAGKEYS(                        XK_minus,                             5)
	TAGKEYS(                        XK_egrave,                            6)
	TAGKEYS(                        XK_underscore,                        7)
	TAGKEYS(                        XK_ccedilla,                          8)
	{ MODKEY|ShiftMask,             XK_r,           spawn,                SHCMD("kill -HUP $(pidof dwm)") },
	{ MODKEY|ShiftMask,             XK_e,           quit,                 {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_e,           quit,                 {1} },
	{ 0, XF86XK_MonBrightnessDown,                  spawn,                SHCMD("thinkpad-backlight down") },
	{ 0, XF86XK_MonBrightnessUp,                    spawn,                SHCMD("thinkpad-backlight up") },
	{ 0, XF86XK_AudioRaiseVolume,                   spawn,                SHCMD("thinkpad-setvolume up") },
	{ 0, XF86XK_AudioLowerVolume,                   spawn,                SHCMD("thinkpad-setvolume down") },
	{ 0, XF86XK_AudioMute,                          spawn,                SHCMD("pactl set-sink-mute 0 toggle") },
	{ 0, XF86XK_AudioMicMute,                       spawn,                SHCMD("pactl set-source-mute alsa_input.pci-0000_00_1f.3.analog-stereo toggle") },
	{ 0, XK_Caps_Lock,                              spawn,                SHCMD("kill -40 $(pidof dwmblocks)") },
	{ 0, XK_Print,                                  spawn,                SHCMD("scrot -e 'mv $f ~/Images/Screenshots' && sleep 2 && notify-send Screenshot!!!") },
	{ 0, XF86XK_Launch1,                            spawn,                SHCMD("thinkpad-touchpad-toggle ; kill -49 $(pidof dwmblocks)") },
	{ MODKEY|Mod1Mask,              XK_n,           spawn,                SHCMD("mpc next") },
	{ MODKEY|Mod1Mask,              XK_p,           spawn,                SHCMD("mpc prev") },
	{ MODKEY|Mod1Mask,              XK_t,           spawn,                SHCMD("mpc toggle ; kill -34 $(pidof dwmblocks)") },
	{ MODKEY|ShiftMask,             XK_b,           spawn,                SHCMD("firefox") },
	{ MODKEY|ShiftMask,             XK_c,           spawn,                SHCMD("st -n Config -e nvim ~/.cache/suckless/dwm/config.def.h") },
	{ MODKEY|ShiftMask,             XK_m,           spawn,                SHCMD("st -n Mutt -e neomutt") },
	{ MODKEY|ShiftMask,             XK_g,           spawn,                SHCMD("st -n Ranger -e ranger") },
	{ MODKEY|ShiftMask,             XK_t,           spawn,                SHCMD("thunar") },
	{ MODKEY|ShiftMask,             XK_n,           spawn,                SHCMD("start-ncmpcpp") },
	{ MODKEY|ShiftMask,             XK_s,           spawn,                SHCMD("tabbed surf -e") },
	{ MODKEY,                       XK_F1,          spawn,                SHCMD("surf ~/.local/share/dwm/shortcuts.html") },
	{ MODKEY,                       XK_y,           spawn,                SHCMD("dmenu-yt") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
