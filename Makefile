all: test test_rename

test: a/test.o b/test.o c/test.o test.o
	gcc -o test a/test.o b/test.o c/test.o test.o -g

test_rename: a/test.o b/test.o c/test.o test_rename.o
	gcc -o test_rename a/test.o b/test.o c/test.o test_rename.o -g

a/test.o: a/test.c
	gcc -c a/test.c -o a/test.o -g

b/test.o: b/test.c
	gcc -c b/test.c -o b/test.o -g

c/test.o: c/test.c
	gcc -c c/test.c -o c/test.o -g

test.o: test.c
	gcc -c test.c -o test.o -g

test_rename.o: test_rename.c
	gcc -c test_rename.c -o test_rename.o -g

clean:
	rm a/test.o b/test.o c/test.o test test_rename