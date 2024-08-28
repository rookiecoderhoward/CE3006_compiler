bison -d -o y.tab.c B.y
gcc -c -g -I.. y.tab.c
flex -o lex.yy.c B.l
gcc -c -g -I.. lex.yy.c
gcc -o B y.tab.o lex.yy.o -ll