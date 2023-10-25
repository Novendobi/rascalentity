module Syntax
extend Lexical;

start syntax Program 
        = program: "module" Id name Entity* entities
        ;
syntax Entity
        = entityrpr: "entity" Id ename Attributes* attributes Repr rpname "end"
        | entityWrpr: "entity" Id ename Attributes* attributes "end"
        ;
syntax Attributes
        = attribute: Id aname ":" Types typename
        | attributeAssoc: Id aname "-\>" Types typename
        ;
syntax Types
	    = integer : "integer"
	    | string : "string"
	    | boolean : "boolean"
	    | entityname : Id name
	    ;
syntax Repr
        = repr: "repr" Id rname
        ;