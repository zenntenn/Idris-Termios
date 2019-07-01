#include "termios_helper.h"

uint16_t width;
uint16_t height;

void resize(int i) {
	// spurious argument needed so that the
	// function signature matches what signal(3) expects

	struct winsize ws;
	ioctl(1, TIOCGWINSZ, &ws);
	width = ws.ws_col;
	height = ws.ws_row;

	// from here, call a function to repaint the screen
	// (probably starting with "\x1b[2J")
}

void initialize()
{
    signal(SIGWINCH, resize);
	resize(0);
}
