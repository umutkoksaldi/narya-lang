%{
	#include <stdlib.h>
	#include <stdio.h>
	#include "y.tab.h"
%}

EQUAL             	"="
SEMICOLON         	";"
COLON				":"
COMMA             	","
LEFTBRACKET       	"("
RIGHTBRACKET      	")"
LEFTCURLYBRACKET  	"{"
RIGHTCURLYBRACKET 	"}"
LEFTSQUAREBRACKET 	"["
RIGHTSQUAREBRACKET 	"]"
DASH				"-"
IDENTIFIER    	([a-zA-Z_][a-zA-Z0-9_]*)

EDGE		EDGE|edge
GETPATH		GET_PATH|get_path
PLENGTH		P_LENGTH|p_length
EXISTS		EXISTS
SUM			SUM
MIN			MIN
MAX			MAX
AVG			AVG
SUBSTR		SUBSTR
VB			v_b|V_B
VE			v_e|V_E
IN			IN|in

COMMENT		("//".*(\n|0))|("/"\*([^\*]|\*+[^\*/])*\*+"/")

INT          	[0-9]+
FLOAT         	[0-9]*("."[0-9]|[0-9]".")[0-9]*
STRING        	\"(\\.|[^"'])*\"|'(\\.|[^"'])*'


PLUS			"+"
MINUS			"-"
MULTIPLICATION 	"*"
DIVISION		"/"
REMAINDER		"%"

AND           		"&&"
OR            		"||"
ALTERNATION			"|"
CONCAT				"&"
REPETITION			"#"
NOT           		"!"
ISEQUAL       		"=="
NOTEQUAL      		"!="
LESSTHAN			"<"
GREATERTHAN			">"
LESS_THAN_EQUAL		"<="
GREATER_THAN_EQUAL 	"=>"

%%
	
{EQUAL}					return(EQUAL);
{SEMICOLON}				return(SEMICOLON);
{COMMA}					return(COMMA);
{COLON}					return(COLON);
{LEFTSQUAREBRACKET} 	return(LEFTSQUAREBRACKET);
{RIGHTSQUAREBRACKET} 	return(RIGHTSQUAREBRACKET);
{LEFTBRACKET} 			return(LEFTBRACKET);
{RIGHTBRACKET}			return(RIGHTBRACKET);
{LEFTCURLYBRACKET} 		return(LEFTCURLYBRACKET);
{RIGHTCURLYBRACKET} 	return(RIGHTCURLYBRACKET);;


{COMMENT}			return(COMMENT);

{EDGE}				return(EDGE);
{GETPATH}			return(GETPATH);
{PLENGTH}			return(PLENGTH);
{EXISTS}			return(EXISTS);
{SUM}				return(SUM);
{MIN}				return(MIN);
{MAX}				return(MAX);
{AVG}				return(AVG);
{SUBSTR}			return(SUBSTR);
{VB}				return(VB);
{VE}				return(VE);
{IN}				return(IN);

{IDENTIFIER}	    return(IDENTIFIER);

{INT}			return(INT);
{FLOAT}			return(FLOAT);
{STRING}		return(STRING);


{PLUS}				return(PLUS);
{MINUS}				return(MINUS);
{MULTIPLICATION}	return(MULTIPLICATION);
{DIVISION}			return(DIVISION);
{REMAINDER}			return(REMAINDER);

{AND}					return(AND);
{OR}					return(OR);
{NOT}					return(NOT);
{ISEQUAL}				return(ISEQUAL);
{NOTEQUAL}				return(NOTEQUAL);
{LESSTHAN}				return(LESSTHAN);
{GREATERTHAN}			return(GREATERTHAN);
{LESS_THAN_EQUAL}		return(LESS_THAN_EQUAL);
{GREATER_THAN_EQUAL}	return(GREATER_THAN_EQUAL);
{ALTERNATION}			return(ALTERNATION);
{CONCAT}				return(CONCAT);
{REPETITION}			return(REPETITION);


%%

int yywrap(void){
	return 1;
}

