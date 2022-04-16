/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static double opacity = 1.0;                /* -o  option; defines alpha translucency        */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 700;                    /* minimum width when centered */

/* -fn option overrides fonts[0]; default X11 font or font set */
static char *fonts[] = {
	"SFNS Display:style=Regular:size=9:antialias=true:autohint=true",
	"JoyPixels:pixelsize=8:antialias=true:autohint=true"
};

static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

/* static const unsigned int baralpha = 0xd0; */
static const unsigned int baralpha = 100;
static const unsigned int borderalpha = OPAQUE;

static const unsigned int alphas[SchemeLast][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, OPAQUE, borderalpha },
};

static char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#bbbbbb", "#222222" },
	[SchemeSel] = { "#eeeeee", "#005577" },
	[SchemeOut] = { "#000000", "#00ffff" },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 1;
static unsigned int maxhist    = 64;
static int histnodup           = 0;	/* if 0, record repeated histories */

/* -h option; minimum height of a menu line */
static unsigned int lineheight = 32;
static unsigned int min_lineheight = 8;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 2;
