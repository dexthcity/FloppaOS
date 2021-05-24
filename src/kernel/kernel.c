#include "print.h"

void kernel_main() {
    print_clear(); // нихуя очистка
    print_set_color(PRINT_COLOR_WHITE, PRINT_COLOR_BLACK);
    print_str("Welcome to FloppaOS!\n"); // нихуя вывод
    print_set_color(PRINT_COLOR_GREEN, PRINT_COLOR_BLACK);
    print_str("Now it's an 64-bits kernel!\n");
    print_set_color(PRINT_COLOR_YELLOW, PRINT_COLOR_BLACK);
    print_str("Built by iamlolz\nYeah.. That's all!"); // change this, @device
}