#include <sys/termios.h>
#include <signal.h>

void initialize();

size_t textsz(const char* str);

void restore(void);

void restore_die(int i);

void repaint(void);

void resize(int i);

void initterm(void);
