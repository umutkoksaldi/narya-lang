%glr-parser
%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}
%token EQUAL SEMICOLON COLON COMMA LEFTBRACKET RIGHTBRACKET LEFTCURLYBRACKET RIGHTCURLYBRACKET
%token IDENTIFIER COMMENT INT FLOAT STRING DASH LEFTSQUAREBRACKET
%token RIGHTSQUAREBRACKET CREATE ADD VERTEX EDGE INTO WITH FROM TO DIRECTED UNDIRECTED GETPATH
%token PLENGTH EXISTS SUM MIN MAX AVG SUBSTR VB VE IN PLUS MINUS MULTIPLICATION DIVISION REMAINDER
%token AND OR ALTERNATION CONCAT REPETITION NOT ISEQUAL NOTEQUAL LESSTHAN GREATERTHAN LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL

%left AND OR PLUS MINUS MULTIPLICATION DIVISION REMAINDER
%nonassoc ISEQUAL NOTEQUAL LESSTHAN LESS_THAN_EQUAL GREATERTHAN GREATER_THAN_EQUAL

%%

program : stmt | stmt program_tail ;

program_tail : stmt | stmt program_tail ;

stmt : GETPATH LEFTBRACKET path_query RIGHTBRACKET IN IDENTIFIER SEMICOLON ;

path_query : query query_tail ;

query_tail : COMMA query | COMMA query query_tail | epsilon ;

query : bool_query | logic_query | function_query | squery | LEFTBRACKET query RIGHTBRACKET 
		| IDENTIFIER ;

logic_query : query logic_op query ;

logic_op: AND | OR ;

function_query : MIN LEFTBRACKET STRING COMMA INT RIGHTBRACKET 
				| MAX LEFTBRACKET STRING COMMA INT RIGHTBRACKET
				| SUM LEFTBRACKET STRING COMMA INT RIGHTBRACKET
				| AVG LEFTBRACKET STRING COMMA INT RIGHTBRACKET
				| EXISTS LEFTBRACKET STRING graph_element RIGHTBRACKET 
				| SUBSTR LEFTBRACKET STRING COMMA INT COMMA INT RIGHTBRACKET;
				
bool_query : bool_element bool_op value | NOT LEFTBRACKET query RIGHTBRACKET;

bool_op : ISEQUAL | NOTEQUAL | LESSTHAN | GREATERTHAN | LESS_THAN_EQUAL | GREATER_THAN_EQUAL ;

value : INT | STRING | FLOAT | collection ;

bool_element : graph_element | arithmetic_element | LEFTBRACKET bool_element RIGHTBRACKET ;

arithmetic_element : arithmetic_value arithmetic_op arithmetic_value ;
					
arithmetic_value : INT | FLOAT ;

arithmetic_op : PLUS | MINUS | MULTIPLICATION | DIVISION | REMAINDER ; 
					
graph_element : PLENGTH 
				| EDGE LEFTSQUAREBRACKET INT RIGHTSQUAREBRACKET '.' edge_element ;
				
edge_element : vertex_element '.' IDENTIFIER | IDENTIFIER ;

vertex_element : VE | VB ;

squery : query ALTERNATION query 
		| query CONCAT query 
		| LEFTBRACKET path_query RIGHTBRACKET REPETITION ;

assignment : IDENTIFIER EQUAL assigned_value SEMICOLON ;

assigned_value : IDENTIFIER | INT | STRING | FLOAT | collection | query 
				| LEFTBRACKET path_query RIGHTBRACKET ;


collection : map | list | set ;


map : LEFTCURLYBRACKET map_unit RIGHTCURLYBRACKET 
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


prop_list : prop_element | prop_element COMMA prop_list ;

prop_element : LEFTBRACKET STRING COMMA prop_value RIGHTBRACKET ;

prop_value : INT | FLOAT | STRING | collection ;

epsilon : ; 

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

