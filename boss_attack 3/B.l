%{
    #include "y.tab.h"
    #include <stdio.h>
    void yyerror(const char *error_msg);
%}
%option noyywrap

int_num         0|[1-9][0-9]*|-[1-9][0-9]*
int             {int_num}

space           [ \t]+
eol             \n

operator        "+"|"-"|"*"|"/"

%%

{int}           {
    yylval.ival = atoi(yytext);
    return INUMBER;
}

{operator}      {
    return yytext[0];
}

{space}         {
    ;
}

{eol}           {
    return yytext[0];
}

.               {
    return yytext[0];
}

%%
