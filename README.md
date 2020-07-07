I think there's some kind of bug in GDB maybe

```
me@um20main:~/a_dev/multifile_gdb$ gdb test
GNU gdb (Ubuntu 9.1-0ubuntu1) 9.1
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from test...
(gdb) b /home/me/a_dev/multifile_gdb/test.c:5
No source file named /home/me/a_dev/multifile_gdb/test.c.
Make breakpoint pending on future shared library load? (y or [n]) n
(gdb) b ./test.c:5
No source file named ./test.c.
Make breakpoint pending on future shared library load? (y or [n]) n
(gdb) b test.c:5
Breakpoint 1 at 0x1151: test.c:5. (3 locations)
(gdb) r
Starting program: /home/me/a_dev/multifile_gdb/test 

Breakpoint 1, test_a () at a/test.c:5
5	    printf("Hello from test_a!\n");
(gdb) c
Continuing.
Hello from test_a!

Breakpoint 1, test_b () at b/test.c:5
5	    printf("Hello from test_b!\n");
(gdb) c
Continuing.
Hello from test_b!

Breakpoint 1, test_c () at c/test.c:5
5	    printf("Hello from test_c!\n");
(gdb) c
Continuing.
Hello from test_c!
Hello from main()!
[Inferior 1 (process 9406) exited normally]
(gdb) 
```
- Note how I could not specify test.c as a file for the breakpoint, either using ./test.c, or (full path to)/test.c
- Note how when I specified b test.c:5 did not stop in ./test.c:5, it stopped in ./a/test.c:5, ./b/test.c:5, ./c/test.c:5

It does work, though, if I rename ./test.c to ./test_rename.c

```
me@um20main:~/a_dev/multifile_gdb$ gdb test_rename
GNU gdb (Ubuntu 9.1-0ubuntu1) 9.1
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from test_rename...
(gdb) b test_rename.c:10
Breakpoint 1 at 0x119b: file test_rename.c, line 10.
(gdb) b /home/me/a_dev/multifile_gdb/test_rename.c:11
Breakpoint 2 at 0x11a0: file test_rename.c, line 11.
(gdb) r
Starting program: /home/me/a_dev/multifile_gdb/test_rename 
Hello from test_a!

Breakpoint 1, main () at test_rename.c:10
10	    test_b();
(gdb) c
Continuing.
Hello from test_b!

Breakpoint 2, main () at test_rename.c:11
11	    test_c();
(gdb) c
Continuing.
Hello from test_c!
Hello from main()!
[Inferior 1 (process 9597) exited normally]
(gdb) 
```