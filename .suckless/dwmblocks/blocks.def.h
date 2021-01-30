//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	
	{"", "dwm-song", 5, 0},
	{"", "dwm-cpuload", 30, 1},
	{"", "dwm-temp", 3, 2},
	{"", "dwm-fan", 3, 3},
	{"", "dwm-mem", 10, 4},
	{"", "dwm-disks", 30, 7},
	{"", "dwm-packages", 15, 8},
	{"", "dwm-battery", 3, 10},
	{"", "dwm-brightness", 60, 5},
	{"", "dwm-volume", 60, 11},
	{"", "dwm-caplock", 2, 6},
/*	{"", "dwm-mail", 30, 13},  */
	{"", "dwm-wireless", 5, 9},
	{"", "dwm-date", 60, 12},

};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
