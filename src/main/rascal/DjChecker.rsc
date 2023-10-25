module DjChecker

import DjangoSyntax;
extend analysis::typepal::TypePal;

data AType
        = charfield(str name)
        | foreignkey(str name)
        | entityType(str name)
        ;

data IdRole 
	    = attributeId()
	    | entityId()
        | methodId()
        ;
str prettyType(charfield(name)) = "CharField";
str prettyType(foreignkey(name)) = "ForeignKey";
str prettyType(entityType(name)) = "entity";

default tuple[list[str] typeNames, set[IdRole] idRoles] getTypeNamesAndRole(AType t){
    return <[], {}>;
}

TypePalConfig config() =
    tconfig(getTypeNamesAndRole = getTypeNamesAndRole);

void collect(
	current: (DJangoProgram) `from django.db import models <DjangoEntity* djentites>`, Collector c
){
	collect(djentites, c);
}

void collect(
	current: (DjangoEntity) `class <Id name> (models.Model): <DjAttributes* djattribs> <Methods+ methods>`, Collector c
){
	c.define("<name>", entityId(), current, defType(entityType("<name>")));
	c.enterScope(current);
		collect(djattribs, c);
		collect(methods, c);
    c.leaveScope(current);
}

void collect(
	current: (DjangoEntity) `class <Id name> (models.Model): <DjAttributes* djattribs>`, Collector c
){
	c.define("<name>", entityId(), current, defType(entityType("<name>")));
	c.enterScope(current);
		collect(djattribs, c);
    c.leaveScope(current);
}

void collect(
	current: (DjAttributes) `<Id name> = models.CharField(max_length=256)`, Collector c
){
	c.define("<name>", attributeId(), current, defType(charfield("<name>")));
}

void collect(
	current: (DjAttributes) `<Id name> = models.ForeignKey (<Id fkname>)`, Collector c
){
	c.define("<name>", attributeId(), current, defType(foreignkey("<name>")));
	c.use(fkname, {entityId()});
}

void collect(
	current: (Methods) `def <Id mname> (self) : return <String rstr> .format(self. <Id sfname>)`, Collector c
){
	c.define("<mname>", methodId(), current, defType(mname));
	c.use(sfname, {attributeId()});
}