//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	
	{" ", "dwm-song", 5, 0},
	{" ", "dwm-cpuload", 10, 1},
	{" ", "dwm-temp", 2, 2},
	{"", "dwm-fan", 2, 3},
	{"Mem ", "dwm-mem", 5, 4},
	{" ", "dwm-brightness", 30, 5},
	{"", "dwm-caplock", 2, 6},
	{" ", "dwm-disks", 10, 7},
	{" ", "dwm-packages", 10, 8},
	{" ", "dwm-wireless", 5, 9},
	{"", "dwm-battery", 3, 10},
	{" ", "dwm-volume", 30, 11},
	{"", "dwm-date", 10, 12},

};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
