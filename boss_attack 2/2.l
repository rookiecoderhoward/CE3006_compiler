%{
#include<stdio.h>
int i = 0;
%}
%option noyywrap

book_data       [A-Z][a-z]+(([_][A-Z][a-z]+))*
book            {book_data}

author_data     [A-Z]+[,][ ][A-Z][a-z]+[-][A-Z][a-z]+
author          {author_data}

big_date        [0-9]{4}[\/](0[13578]|10|12)[\/](0[1-9]|[1-2][0-9]|3[01])
small_date      [0-9]{4}[\/](0[469]|11)[\/](0[1-9]|[1-2][0-9]|30)
Feb_data        [0-9]{4}[\/]02[\/](0[1-9]|[1-2][0-9])
Date            {big_date}|{small_date}|{Feb_data}

ISBN_data       978[-][0-9][-][0-9]{6}[-][0-9]{2}[-][0-9]
ISBN            {ISBN_data}

%%

{book}         {
    if (i == 0) {printf("Book name:"); ECHO; printf("\n"); i = i + 1;}
}
{author}       {printf("Author:"); ECHO; printf("\n"); }
{Date}         {printf("Publication date:"); ECHO; printf("\n"); }
{ISBN}         {printf("ISBN:"); ECHO; printf("\n"); }

.              ;
\n             {i = 0;}

%%

int main() {
    yylex();
    return 0;
}
