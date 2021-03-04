//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{"",            "dwm-song",             0,                      14 },
	{"",            "dwm-cpuload",          3,                      1  },
	{"",            "dwm-temp",             5,                      2  },
	{"",            "dwm-fan",              5,                      3  },
	{"",            "dwm-mem",              20,                     4  },
	{"",            "dwm-disks",            30,                     7  },
	{"",            "dwm-packages",         60,                     8  },
	{"",            "dwm-battery",          5,                      10 },
	{"",            "dwm-brightness",       0,                      5  },
	{"",            "dwm-volume",           0,                      11 },
	{"",            "dwm-touchpad",         0,                      15 },
	{"",            "dwm-wireless",         5,                      9  },
	{"",            "dwm-date",             60,                     12 },
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "   ";
static unsigned int delimLen = 5;
