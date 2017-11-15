%glr-parser
%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

%token EQUAL SEMICOLON COLON COMMA LEFTBRACKET RIGHTBRACKET LEFTCURLYBRACKET RIGHTCURLYBRACKET
%token LEFTSQUAREBRACKET RIGHTSQUAREBRACKET IDENTIFIER COMMENT INT FLOAT STRING DASH 
%token CREATE ADD VERTEX EDGE INTO WITH FROM TO DIRECTED UNDIRECTED GETPATH
%token PLENGTH EXISTS SUM MIN MAX AVG SUBSTR VB VE IN PLUS MINUS MULTIPLICATION DIVISION REMAINDER
%token AND OR ALTERNATION CONCAT REPETITION NOT ISEQUAL NOTEQUAL LESSTHAN GREATERTHAN LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL

%left AND OR PLUS MINUS MULTIPLICATION DIVISION REMAINDER
%nonassoc ISEQUAL NOTEQUAL LESSTHAN LESS_THAN_EQUAL GREATERTHAN GREATER_THAN_EQUAL

%%

program : stmt | stmt program_tail ;

program_tail : stmt | stmt program_tail ;

stmt : graph_def | vertex_def | edge_def | assignment ;

graph_def : CREATE DIRECTED IDENTIFIER SEMICOLON 
			| CREATE UNDIRECTED IDENTIFIER SEMICOLON ;
vertex_def : ADD VERTEX IDENTIFIER INTO IDENTIFIER WITH LEFTBRACKET prop_list RIGHTBRACKET SEMICOLON;
edge_def : ADD EDGE IDENTIFIER FROM IDENTIFIER TO IDENTIFIER INTO IDENTIFIER WITH LEFTBRACKET prop_list RIGHTBRACKET SEMICOLON;

assignment : IDENTIFIER EQUAL assigned_value SEMICOLON ;
assigned_value : IDENTIFIER | INT | STRING | FLOAT | collection ;


collection : map | list | set ;


map : LEFTCURLYBRACKET map_unit RIGHTCURLYBRACKET ; 
	| LEFTCURLYBRACKET map_unit COMMA map_tail ;

map_tail : map_unit COMMA map_tail | map_unit RIGHTCURLYBRACKET ; 	

map_unit : map_index COLON map_element ;

map_index : STRING | INT | FLOAT ;
map_element : STRING | INT | FLOAT | collection ;


list : LEFTSQUAREBRACKET list_unit RIGHTSQUAREBRACKET |  LEFTSQUAREBRACKET list_unit COMMA list_tail ;

list_unit : INT | FLOAT | STRING | collection ;

list_tail : list_unit COMMA list_tail | list_unit RIGHTSQUAREBRACKET ;


set : LEFTBRACKET list_unit RIGHTBRACKET |  LEFTBRACKET list_unit COMMA list_tail ;

set_unit : INT | FLOAT | STRING ;

set_tail : set_unit COMMA set_tail | set_unit RIGHTBRACKET ;

prop_list : prop_element | prop_element COMMA prop_list | ;

prop_element : LEFTBRACKET STRING COMMA prop_value RIGHTBRACKET ;

prop_value : INT | FLOAT | STRING | collection ;

%% 
void yyerror(char *s) {
	fprintf(stdout, "%d-%s\n", yylineno,s);
}

int main(void){
 yyparse();
if(yynerrs < 1){
		printf("Parsing is successful\n");
	}
 return 0;
}
