//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	
	{"", "dwm-song", 0, 14},
	{"", "dwm-cpuload", 2, 1},
	{"", "dwm-temp", 3, 2},
	{"", "dwm-fan", 3, 3},
	{"", "dwm-mem", 20, 4},
	{"", "dwm-disks", 30, 7},
	{"", "dwm-packages", 60, 8},
	{"", "dwm-battery", 3, 10},
	{"", "dwm-brightness", 0, 5},
	{"", "dwm-volume", 0, 11},
	{"", "dwm-caplock", 3, 6},
/*	{"", "dwm-mail", 300, 13},  */
	{"", "dwm-wireless", 5, 9},
	{"", "dwm-date", 60, 12},

};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "    ";
static unsigned int delimLen = 5;
