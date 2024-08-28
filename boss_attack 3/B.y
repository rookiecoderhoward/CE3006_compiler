%{
    #define STACK_SIZE 10
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdbool.h>
    #include <math.h>
    int stack[STACK_SIZE];
    int top = -1;
    int a, b;
    extern int yylex(void);
    void yyerror(const char *error_msg);

    int isEmpty(); // to check if the stack is empty
    // int isFull(); // to check if the stack is full
    // void push(int n);
    // int pop();
    void error_pop();
    void error_push();
    void print_stack(); // to dump (or print) all the data in stack
%}

%code requires {
    ;
}

%union {
    int ival;
}

%start programs
%token <ival> INUMBER
%type <ival> lines line exp primary


%%
programs : lines '\n'   {return 0;}
        ;

lines : line lines
      | line
      ;

line : exp          {$$ = $1;}
     ;

exp : primary       {$$ = $1;}
    | '+'           {
                        if (isEmpty()) {
                            error_pop();
                            exit(0);
                        }
                        else {
                            a = stack[top];
                            top--;
                        }
                        if (isEmpty()) {
                            error_pop();
                            exit(0);
                        }
                        else {
                            b = stack[top];
                            top--;
                        }
                        $$ = b + a;
                        stack[++top] = b + a;
                        print_stack();
                    }
    | '-'           {
                        if (isEmpty()) {
                            error_pop();
                            exit(0);
                        }
                        else {
                            a = stack[top];
                            top--;
                        }
                        if (isEmpty()) {
                            error_pop();
                            exit(0);
                        }
                        else {
                            b = stack[top];
                            top--;
                        }
                        $$ = b - a;
                        stack[++top] = b - a;
                        print_stack();
                    }
    | '*'           {
                        if (isEmpty()) {
                            error_pop();
                            exit(0);
                        }
                        else {
                            a = stack[top];
                            top--;
                        }
                        if (isEmpty()) {
                            error_pop();
                            exit(0);
                        }
                        else {
                            b = stack[top];
                            top--;
                        }
                        $$ = b * a;
                        stack[++top] = b * a;
                        print_stack();
                    }
    | '/'           {
                        if (isEmpty()) {
                            error_pop();
                            exit(0);
                        }
                        else {
                            a = stack[top];
                            top--;
                        }
                        if (isEmpty()) {
                            error_pop();
                            exit(0);
                        }
                        else {
                            b = stack[top];
                            top--;
                        }
                        $$ = b / a;
                        stack[++top] = b / a;
                        print_stack();
                    }
    ;

primary : INUMBER   {   $$ = $1;
                        top++;
                        if (top >= STACK_SIZE) {
                            error_push();
                            exit(0);
                        }
                        else {
                            stack[top] = $1;
                            print_stack();
                        }
                    } 
        ;


%%

int isEmpty() {
    if (top == -1) return 1;
    else return 0;
}

void error_push() {
    printf("Runtime Error: The push will lead to stack overflow.\n");
}

void error_pop() {
    printf("Runtime Error: The pop will lead to stack underflow.\n");
}

void print_stack() {
    int j;
    printf("The contents of the stack are:");
    for (j = 0; j <= top; j++) {
        printf(" %d", stack[j]);
    }
    printf("\n");
}

void yyerror(const char *error_msg) {
    fprintf (stderr, "%s\n", error_msg);
}

int main() {
    yyparse();
    return 0;
}
