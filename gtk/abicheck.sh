#! /bin/sh

cpp -P -DG_OS_UNIX -DGDK_WINDOWING_X11 ${srcdir:-.}/gtk.symbols | sed -e '/^$/d' -e 's/ G_GNUC.*$//' -e 's/ PRIVATE//' | sort > expected-abi
nm -D -g --defined-only .libs/libgtk-3.so | cut -d ' ' -f 3 | egrep -v '^(__bss_start|_edata|_end)' | sort > actual-abi
diff -u expected-abi actual-abi && rm -f expected-abi actual-abi
