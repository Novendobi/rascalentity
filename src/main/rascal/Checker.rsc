module Checker

import Ast;
import Syntax;
extend analysis::typepal::TypePal;

data AType
	= integer()
	| string()
	| boolean()
	| entityname(str name);

data IdRole 
	    = attributeId()
	    | entityId()
        ;
str prettyType(integer()) = "integer";
str prettyType(string()) = "string";
str prettyType(boolean()) = "boolean";
str prettyType(entityname(str name)) = name;

default tuple[list[str] typeNames, set[IdRole] idRoles] smallGetTypeNamesAndRole(AType t){
    return <[], {}>;
}

TypePalConfig smallConfig() =
    tconfig(getTypeNamesAndRole = smallGetTypeNamesAndRole);

void collect(
	current: (Program) `module <Id name> <Entity* entities>`, Collector c
){
	collect(entities, c);
}

void collect(
	current: (Entity) `entity <Id ename> <Attributes* attributes> <Repr rpname> end`, Collector c
){
	c.define("<ename>", entityId(), current, defType(entityname("<ename>")));
	c.enterScope(current);
		collect(attributes, rpname, c);
    c.leaveScope(current);
}

void collect(
	current: (Entity) `entity <Id ename> <Attributes* attributes> end`, Collector c
){
	c.define("<ename>", entityId(), current, defType(entityname("<ename>")));
	c.enterScope(current);
		collect(attributes, c);
    c.leaveScope(current);
}

void collect(
	current: (Attributes) `<Id aname> : <Types typename>`, Collector c
){
	c.define("<aname>", attributeId(), aname, defType(typename));
	c.fact(current, typename);
	collect(typename, c);
}

void collect(
	current: (Attributes) `<Id aname> -\> <Types typename>`, Collector c
){
	c.define("<aname>", attributeId(), aname, defType(typename));
	c.fact(current, typename);
	collect(typename, c);
}

void collect(current:(Types) `integer`, Collector c){
    c.fact(current, integer());
}

void collect(current:(Types) `string`, Collector c){
    c.fact(current, string());
}
void collect(current:(Types) `boolean`, Collector c){
    c.fact(current, boolean());
}

void collect(current:(Types) `<Id name>`, Collector c){
   c.use(name, {entityId()});
}

void collect(
	current: (Repr) `repr <Id rname>`, Collector c
){
	c.use(rname, {attributeId()});
}
