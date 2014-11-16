all: tests

tests:
	clang -framework Foundation -lffi -std=c99 -g -fobjc-arc main.m MABlockClosure.m

clean:
	rm -f a.out
