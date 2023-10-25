module Lexical

layout WS = [\t-\n\r\ ]*;

lexical Id
            = ([a-z A-Z 0-9 _] !<< [a-z A-Z_][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keywords
	        ;
lexical Integer = [0-9]+;
lexical String = [\"] String_Char* [\"];
lexical String_Char = ![\\ \" \n] | "\\" [\\ \"];
lexical Boolean = "true" | "false";

keyword Keywords
	= "integer"
	| "string"
	| "boolean"
	| "entity"
	| "end"
	| "module"
    | "repr"
	| "class"
	;