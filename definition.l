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

CREATE		CREATE|create
ADD			ADD|add
VERTEX		VERTEX|vertex
EDGE		EDGE|edge
INTO		INTO|into
WITH		WITH|with
FROM		FROM|from
TO			TO|to
DIRECTED 	DIRECTED|directed
UNDIRECTED	UNDIRECTED|undirected

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

{CREATE}			return(CREATE); 
{ADD}				return(ADD);
{VERTEX}			return(VERTEX);
{EDGE}				return(EDGE);
{INTO}				return(INTO);
{WITH}				return(WITH);
{FROM}				return(FROM);
{TO}				return(TO);
{DIRECTED} 			return(DIRECTED);
{UNDIRECTED}		return(UNDIRECTED);
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

