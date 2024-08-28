%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdbool.h>
    #include <math.h>
    extern int yylex(void);
    void print_invalid();
    void yyerror(const char *error_msg);
%}

%code requires {
    ;
}

%union {
    float fval;
}

%start line
%token <fval> FLOAT
%type <fval> line exp

%left '+' '-'
%left '*' '/'

%%

line : exp          {printf("%.3f\n", $1); return 0;}
     ;

exp : exp '+' exp   {$$ = $1 + $3;}
    | exp '-' exp   {$$ = $1 - $3;}
    | exp '*' exp   {$$ = $1 * $3;}
    | exp '/' exp   {
        if ($3 == 0.0) {
            print_invalid();
            exit(0);
        }
        else {
            $$ = $1 / $3;
        }
    }
    | FLOAT         {$$ = $1;}
    ;

%%

void yyerror(const char *error_msg) {
    if (!strcmp(error_msg, "syntax error")) {
        printf("Invalid Value\n");
    }
    else {
        fprintf (stderr, "%s\n", error_msg);
    }
}

void print_invalid() {
    printf("Invalid Value\n");
}

int main() {
    yyparse();
    return 0;
}

